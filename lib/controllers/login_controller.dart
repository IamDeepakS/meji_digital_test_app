import 'dart:developer';

import 'package:demo_test/model/login_response_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

const storage = FlutterSecureStorage();

Future<LoginResponse> login(String email, String password) async {
  try {
    final url = Uri.parse('https://api.lyfcon.com/auth/demo/login');

    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );
    return LoginResponse(response.statusCode, response.body);
  } on Exception catch (e) {
    log('Exception is $e');
    return LoginResponse(500, '');
  }
}

void storeTokenAndData(email, firstName, lastName) async {
  await storage.write(key: "emailToken", value: email.toString());
  await storage.write(key: "firstNameToken", value: firstName.toString());
  await storage.write(key: "lastNameToken", value: lastName.toString());
}

Future<String?> getEmailToken() async {
  return await storage.read(key: "emailToken");
}

Future<String?> getFirstNameToken() async {
  return await storage.read(key: "firstNameToken");
}

Future<String?> getLastNameToken() async {
  return await storage.read(key: "lastNameToken");
}
