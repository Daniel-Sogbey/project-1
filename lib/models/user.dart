import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class User with ChangeNotifier {
  @required
  final userId;
  @required
  final String username;

  User({
    this.userId,
    this.username,
  });

  String _username;

  String get getUsername {
    return _username;
  }

  Future<void> updateUserProfile(User user, String authToken) async {
    final url =
        'https://solveshare-7acaf-default-rtdb.firebaseio.com/users.json?auth=$authToken';
    print('$userId userId');
    try {
      final response = await http.patch(
        url,
        body: json.encode({
          'userId': user.userId,
          'username': user.username,
        }),
      );

      final userResponseData = json.decode(response.body);

      _username = userResponseData['username'];

      print('$_username username from updateUserProfile');

      print('$userResponseData userResponseData');
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
