import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class User with ChangeNotifier {
  @required
  String userId;
  @required
  String username;
  String _email;
  String photoUrl;

  User({
    this.userId,
    this.username,
    this.photoUrl,
  });

  String _username;
  File _photoUrl;

  String get getUsername {
    return _username;
  }

  String get getEmail {
    return _email;
  }

  String get getUserPhoto {
    return _photoUrl.toString();
  }

  Future<void> updateUserProfile(User user, String authToken) async {
    var url =
        'https://identitytoolkit.googleapis.com/v1/accounts:update?key=AIzaSyAnds_2pZvb6cdqfitU4BB2z3GhaLBsy78';
    print('$userId userId');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'idToken': authToken,
          'displayName': user.username,
          'photoUrl': user.getUserPhoto,
          'returnSecureToken': true,
        }),
      );

      final userResponseData = json.decode(response.body);

      // _username = userResponseData['displayName'];

      // print('$_username username from updateUserProfile');

      print('$userResponseData userResponseData');

      // url =
      // 'https://identitytoolkit.googleapis.com/v1/accounts:lookup?key=AIzaSyAnds_2pZvb6cdqfitU4BB2z3GhaLBsy78';
//
      // final userRes = await http.post(
      // url,
      // body: json.encode(
      // {'idToken': authToken},
      // ),
      // );
//
      // final userResData = json.decode(userRes.body)['users'][0]['displayName'];
//
      // _username = userResData;
//
      // print('$userResData userResData');

      _photoUrl = userResponseData['photoUrl'];

      print('$_photoUrl userPhoto');

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchUser(String authToken) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:lookup?key=AIzaSyAnds_2pZvb6cdqfitU4BB2z3GhaLBsy78';

    try {
      final userRes = await http.post(
        url,
        body: json.encode(
          {'idToken': authToken},
        ),
      );

      final userResData = json.decode(userRes.body);

      _username = userResData['users'][0]['displayName'];

      _email = userResData['email'];

      _photoUrl = userResData['photoUrl'] as File;

      print('$userResData userResData');
      print('$_photoUrl userPhoto');
    } catch (e) {
      print('$e from fetchUser');
    }
  }
}
