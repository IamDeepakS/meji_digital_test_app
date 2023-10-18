// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'package:demo_test/controllers/login_controller.dart';
import 'package:demo_test/model/login_response_model.dart';
import 'package:demo_test/view/helpers/colors.dart';
import 'package:demo_test/view/helpers/heading_widget.dart';
import 'package:demo_test/view/helpers/responsive_size_helper.dart';
import 'package:demo_test/view/helpers/scaffold_dialog.dart';
import 'package:demo_test/view/profile_screen.dart';
import 'package:demo_test/view/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obsecure = true;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'navigate',
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          height: displayHeight(context),
          width: displayWidth(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 10),
              Image.asset(
                'assets/logo.webp',
                width: displayWidth(context) / 2.5,
              ),
              const SizedBox(height: 40),
              form(
                'Email Address',
                emailController,
                'Enter email here',
              ),
              const SizedBox(height: 40),
              form(
                'Password',
                passwordController,
                'Enter password here',
              ),
              const SizedBox(height: 40),
              MaterialButton(
                minWidth: displayWidth(context),
                padding: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: mainColor,
                onPressed: () async {
                  LoginResponse loginResponse = await login(
                    emailController.text,
                    passwordController.text,
                  );
                  Map<String, dynamic> responseMap =
                      json.decode(loginResponse.body);
                  if (loginResponse.statusCode == 200 &&
                      responseMap['statusCode'] != 400) {
                    print('POST request successful ${loginResponse.body}');
                    alertDialogWidget(
                      context,
                      Colors.green,
                      'Login Successful',
                    );
                    storeTokenAndData(
                      responseMap['email'],
                      responseMap['firstName'],
                      responseMap['lastName'],
                    );
                    Future.delayed(
                      const Duration(seconds: 2),
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                            firstName: responseMap['firstName'],
                            lastName: responseMap['lastName'],
                            email: responseMap['email'],
                          ),
                        ),
                      ),
                    );
                  } else if (loginResponse.statusCode == 400 ||
                      responseMap['statusCode'] == 400) {
                    alertDialogWidget(
                      context,
                      Colors.red,
                      'Wrong Credential',
                    );
                    print('POST request failed ${loginResponse.body}');
                    setState(() {
                      passwordController.clear();
                    });
                  } else {
                    print('POST request failed ${loginResponse.body}');
                    alertDialogWidget(
                      context,
                      Colors.red,
                      'Something wrong!!!',
                    );
                  }
                },
                child: Text(
                  'LOGIN',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignupScreen(),
                    ),
                  ),
                  child: Text(
                    'Create new account',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  form(heading, controller, hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headingWidget(heading),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.4),
              fontSize: 13,
            ),
            suffixIcon: hint.toString().contains('email')
                ? const Icon(
                    Icons.visibility,
                    color: Colors.white,
                  )
                : IconButton(
                    onPressed: () {
                      setState(() {
                        obsecure = !obsecure;
                      });
                    },
                    icon: Icon(
                      obsecure
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      color: Colors.black,
                    ),
                  ),
          ),
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
          ),
          obscureText: hint.toString().contains('email') ? false : obsecure,
        ),
      ],
    );
  }
}
