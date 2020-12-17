import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../http_exception/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  String _userId;
  String _email;
  Timer _authTimer;
  DateTime _expiryDate;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  String get email {
    return _email;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyAnds_2pZvb6cdqfitU4BB2z3GhaLBsy78';

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );

      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(message: responseData['error']['message']);
      }

      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );

      print('${responseData['expiresIn']} expiresIn time');
      _autoLogout();
      notifyListeners();
      print(isAuth);

      final prefs = await SharedPreferences.getInstance();

      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate.toIso8601String(),
      });

      prefs.setString('userData', userData);

      // print(json.decode(response.body));
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchUserData() async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:lookup?key=AIzaSyAnds_2pZvb6cdqfitU4BB2z3GhaLBsy78';

    final response = await http.post(
      url,
      body: json.encode(
        {
          'idToken': _token,
        },
      ),
    );

    notifyListeners();
    print('${json.decode(response.body)} userData');
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('userData')) {
      return false;
    }

    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;

    print('$expiryDate null auth');

    notifyListeners();
    _autoLogout();

    return true;
  }

  void logout() {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();

    print('$_token null auth from logout');
    print('$_expiryDate null auth from logout');
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }

    final _timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: _timeToExpiry), logout);
    print('$_timeToExpiry tttt');
    notifyListeners();
  }
}
