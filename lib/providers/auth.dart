import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../http_exception/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  String _email;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get userId {
    return _userId;
  }

  String get email {
    return _email;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
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
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      _userId = responseData['localId'];
      _email = responseData['email'];

      print(
          '$_email  eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeemmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmiiiiiiiiiiiiiiiiiiiiilllllllllll');

      _autoLogout();
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'expiryDate': _expiryDate.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);

      // final MailOptions mailOptions = MailOptions(
      //   body: 'a long body for the email <br> with a subset of HTML',
      //   subject: 'the Email Subject',
      //   recipients: [email],
      //   isHTML: true,
      // );
      //
      // await FlutterMailer.send(mailOptions);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAnds_2pZvb6cdqfitU4BB2z3GhaLBsy78';

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

      var ran = new Random().nextInt(200);
      final confirmEmailVerificationUrl =
          'https://identitytoolkit.googleapis.com/v1/accounts:update?key=AIzaSyAnds_2pZvb6cdqfitU4BB2z3GhaLBsy78';

      final confirmEmailVerificationResponse = await http.post(
        confirmEmailVerificationUrl,
        body: json.encode(
          {
            "oobCode": ran.toString(),
            "idToken": _token,
          },
        ),
      );

      final confirmEmailVerificationResponseData =
          json.decode(confirmEmailVerificationResponse.body);

      final check = confirmEmailVerificationResponseData['emailVerified'];

      print('$check confirmEmailVerificationResponseData');

      _token = responseData['idToken'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      _userId = responseData['localId'];
      _email = responseData['email'];

      print(
          '$_email  eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeemmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmiiiiiiiiiiiiiiiiiiiiilllllllllll');

      _autoLogout();
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'expiryDate': _expiryDate.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);

      // final MailOptions mailOptions = MailOptions(
      //   body: 'a long body for the email <br> with a subset of HTML',
      //   subject: 'the Email Subject',
      //   recipients: [email],
      //   isHTML: true,
      // );
      //
      // await FlutterMailer.send(mailOptions);

      final verifyEmailUrl =
          'https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=AIzaSyAnds_2pZvb6cdqfitU4BB2z3GhaLBsy78';

      final verificationResponse = await http.post(verifyEmailUrl,
          body: json.encode({
            'requestType': "VERIFY_EMAIL",
            'idToken': _token,
          }));

      final verificationResponseData = json.decode(verificationResponse.body);

      print('$verificationResponseData verificationResponseData');
    } catch (error) {
      //throw error;
      print('$error confirmMail');
    }
  }

  Future<void> verify() async {
    try {
      final verifyEmailUrl =
          'https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=AIzaSyAnds_2pZvb6cdqfitU4BB2z3GhaLBsy78';

      final verificationResponse = await http.post(verifyEmailUrl,
          body: json.encode({
            'requestType': "VERIFY_EMAIL",
            'idToken': _token,
          }));

      final verificationResponseData = json.decode(verificationResponse.body);

      print('$verificationResponseData verificationResponseData');
    } catch (error) {
      print('$error from verify');
    }
  }

  Future<void> confirm() async {
    var ran = new Random().nextInt(200);
    try {
      final confirmEmailVerificationUrl =
          'https://identitytoolkit.googleapis.com/v1/accounts:update?key=AIzaSyAnds_2pZvb6cdqfitU4BB2z3GhaLBsy78';

      final confirmEmailVerificationResponse = await http.post(
        confirmEmailVerificationUrl,
        body: json.encode(
          {
            "oobCode": ran.toString(),
            "idToken": _token,
          },
        ),
      );

      final confirmEmailVerificationResponseData =
          json.decode(confirmEmailVerificationResponse.body);

      final check = confirmEmailVerificationResponseData['emailVerified'];

      if (!check) {
        throw Error.safeToString('Error');
      }

      print('$check confirmEmailVerificationResponseData');
    } catch (error) {
      print('$error from confirm');
    }
  }

  Future<void> signin(String email, String password) async {
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
    print(_expiryDate);
    _autoLogout();
    notifyListeners();

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
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }

    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  Future<void> deleteAccount() async {
    final deleteAccountUrl =
        'https://identitytoolkit.googleapis.com/v1/accounts:delete?key=AIzaSyAnds_2pZvb6cdqfitU4BB2z3GhaLBsy78';

    try {
      final response = await http.post(
        deleteAccountUrl,
        body: json.encode(
          {
            'idToken': _token,
          },
        ),
      );
    } catch (error) {
      print(error);
    }
  }
}
