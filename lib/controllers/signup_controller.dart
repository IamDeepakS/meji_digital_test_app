import 'dart:developer';

import 'package:demo_test/model/signup_response_model.dart';
import 'package:http/http.dart' as http;

Future<SignupResponse> signup(firstname, lastname, email, password) async {
  try {
    final url = Uri.parse('https://api.lyfcon.com/auth/demo/create-user');

    final response = await http.post(
      url,
      body: {
        'firstName': firstname,
        'lastName': lastname,
        'email': email,
        'password': password,
      },
    );
    return SignupResponse(response.statusCode, response.body);
  } on Exception catch (e) {
    log('exception is $e');
    return SignupResponse(500, '');
  }
}
