import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:product_shop/models/http_exception.dart';

class Auth with ChangeNotifier {
  Future<void> authenticate(
      String email, String password, String signUpOrLoginUrl) async {
    final String _authUrl =
        'https://identitytoolkit.googleapis.com/v1/accounts:$signUpOrLoginUrl?key=AIzaSyBaTCOB9U6d9KWAGjfLDFm88FKYDRyc-Mo';

    try {
      final response = await http.post(_authUrl,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final responseBody = json.decode(response.body);
      print(responseBody);
      if (responseBody['error'] != null) {
        throw HttpException(responseBody['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(String email, String password) async {
    return authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return authenticate(email, password, 'signInWithPassword');
  }
}
