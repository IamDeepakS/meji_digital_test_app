import 'package:demo_test/controllers/login_controller.dart';
import 'package:demo_test/view/login_screen.dart';
import 'package:demo_test/view/profile_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'navigate',
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(60),
            child: Image.asset('assets/logo.webp'),
          ),
        ),
      ),
    );
  }

  checkLogin() async {
    String? emailToken = await getEmailToken();
    String? firstNameToken = await getFirstNameToken();
    String? lastNameToken = await getLastNameToken();
    if (emailToken != null && firstNameToken != null && lastNameToken != null) {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(
                email: emailToken,
                firstName: firstNameToken,
                lastName: lastNameToken,
              ),
            ),
          );
        },
      );
    } else {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        },
      );
    }
  }
}
