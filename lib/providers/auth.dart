import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:product_shop/models/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  String _userId;
  DateTime _expiryDate;
  Timer _logoutTimer;

  bool get isAuthorized {
    return token != null;
  }

  get token {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  String get userId => _userId;

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
      _token = responseBody['idToken'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseBody['expiresIn'])));
      _userId = responseBody['localId'];

      _setAutoLogoutTimer();
      _saveCredentialsLocally();

      notifyListeners();
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

  Future<void> logout() async {
    this._token = null;
    this._expiryDate = null;
    this._userId = null;
    if (_logoutTimer != null) {
      _logoutTimer.cancel();
      _logoutTimer = null;
    }
    notifyListeners();

    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();

  }

  void _setAutoLogoutTimer() {
    if (this._logoutTimer != null) {
      this._logoutTimer.cancel();
    }
    var logoutIn = _expiryDate.difference(DateTime.now()).inSeconds;
    _logoutTimer = Timer(Duration(seconds: logoutIn), logout);
  }

  void _saveCredentialsLocally() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('userData', _toJson());
  }

  Object _toJson() {
    return json.encode({
      'token': _token,
      'expiryDate': _expiryDate.toIso8601String(),
      'userId': userId
    });
  }

  Future<bool> tryToAutoLogin() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    if (!sharedPreferences.containsKey('userData')) {
      return false;
    }
    var savedUserData = json.decode(sharedPreferences.getString('userData'))
        as Map<String, Object>;

    var expiryDate = DateTime.parse(savedUserData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _userId = savedUserData['userId'];
    _token = savedUserData['token'];
    _expiryDate = expiryDate;

    _setAutoLogoutTimer();

    notifyListeners();
    return true;
  }
}
