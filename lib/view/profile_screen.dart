// ignore_for_file: use_build_context_synchronously

import 'package:demo_test/view/helpers/colors.dart';
import 'package:demo_test/view/helpers/heading_widget.dart';
import 'package:demo_test/view/helpers/responsive_size_helper.dart';
import 'package:demo_test/view/helpers/scaffold_dialog.dart';
import 'package:demo_test/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  final String firstName, lastName, email;
  const ProfileScreen({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.8,
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/logo.webp',
          width: 80,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My profile',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 20),
            profileDataTile(context, 'First Name', widget.firstName),
            const SizedBox(height: 20),
            profileDataTile(context, 'Last Name', widget.lastName),
            const SizedBox(height: 20),
            profileDataTile(context, 'Email Address', widget.email),
            const SizedBox(height: 20),
            MaterialButton(
              minWidth: displayWidth(context),
              padding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              color: mainColor,
              onPressed: () async {},
              child: Text(
                'UPDATE MY ACCOUNT',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              minWidth: displayWidth(context),
              padding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              color: mainColor.withOpacity(0.8),
              onPressed: () async {
                await storage.delete(key: 'emailToken');
                await storage.delete(key: 'firstNameToken');
                await storage.delete(key: 'lastNameToken');
                alertDialogWidget(context, Colors.green, 'Logout successful');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: Text(
                'LOGOUT',
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
    );
  }

  profileDataTile(BuildContext context, heading, data) {
    return Container(
      width: displayWidth(context),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: mainColor.withOpacity(0.05),
        border: Border(
          left: BorderSide(
            color: mainColor,
            width: 5,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headingWidget(heading),
          const SizedBox(height: 5),
          headingDataWidget(data),
        ],
      ),
    );
  }
}
