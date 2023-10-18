// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:demo_test/controllers/login_controller.dart';
import 'package:demo_test/controllers/signup_controller.dart';
import 'package:demo_test/model/signup_response_model.dart';
import 'package:demo_test/view/helpers/colors.dart';
import 'package:demo_test/view/helpers/heading_widget.dart';
import 'package:demo_test/view/helpers/responsive_size_helper.dart';
import 'package:demo_test/view/helpers/scaffold_dialog.dart';
import 'package:demo_test/view/login_screen.dart';
import 'package:demo_test/view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController familyNameController = TextEditingController();
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
              Image.asset(
                'assets/logo.webp',
                width: displayWidth(context) / 2.5,
              ),
              const SizedBox(height: 20),
              Text(
                'Sign Up With Your Email Address',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 40),
              form(
                'First Name',
                firstNameController,
                'Enter first name here',
              ),
              const SizedBox(height: 30),
              form(
                'Family Name',
                familyNameController,
                'Enter family name here',
              ),
              const SizedBox(height: 30),
              form(
                'Email Address',
                emailController,
                'Enter email here',
              ),
              const SizedBox(height: 30),
              form(
                'Password',
                passwordController,
                'Enter password here',
              ),
              const SizedBox(height: 30),
              MaterialButton(
                minWidth: displayWidth(context),
                padding: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: mainColor,
                onPressed: () async {
                  SignupResponse signupResponse = await signup(
                    firstNameController.text,
                    familyNameController.text,
                    emailController.text,
                    passwordController.text,
                  );
                  Map<String, dynamic> responseMap =
                      json.decode(signupResponse.body);
                  if (signupResponse.statusCode == 200) {
                    print('POST request successful ${signupResponse.body}');
                    alertDialogWidget(
                      context,
                      Colors.green,
                      'Account created successfully',
                    );
                    storeTokenAndData(
                      responseMap['email'],
                      responseMap['firstName'],
                      responseMap['lastName'],
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                          firstName: responseMap['firstName'],
                          lastName: responseMap['lastName'],
                          email: responseMap['email'],
                        ),
                      ),
                    );
                  } else {
                    log('POST request failed ${signupResponse.body}');
                    alertDialogWidget(
                      context,
                      Colors.red,
                      'Something wrong!!!',
                    );
                  }
                },
                child: Text(
                  'CREATE ACCOUNT',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 17,
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
            suffixIcon: hint.toString().contains('password')
                ? IconButton(
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
                  )
                : const Icon(
                    Icons.visibility,
                    color: Colors.white,
                  ),
          ),
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
          ),
          obscureText: hint.toString().contains('password') ? obsecure : false,
        ),
      ],
    );
  }
}
