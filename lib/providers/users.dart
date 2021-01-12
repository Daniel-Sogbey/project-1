// import 'dart:convert';
//
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
//
// import '../models/user.dart';
//
// class Users with ChangeNotifier {
//   String userId;
//   String _username;
//
//   Users({this.userId});
//
//   String get username {
//     return _username;
//   }
//
//   Future<void> updateUserProfile(User user, String authToken) async {
//     final url =
//         'https://solveshare-7acaf-default-rtdb.firebaseio.com/users.json?auth=$authToken';
//     print('$userId userId');
//     try {
//       final response = await http.patch(
//         url,
//         body: json.encode({
//           'userId': user.userId,
//           'username': user.username,
//         }),
//       );
//
//       final userResponseData = json.decode(response.body);
//
//       _username = userResponseData['username'];
//
//       print('$_username username from updateUserProfile');
//
//       print('$userResponseData userResponseData');
//     } catch (error) {
//       print(error);
//     }
//   }

// Future<void> fetchUser(String authToken) async {
//   final url =
//       'https://solveshare-7acaf-default-rtdb.firebaseio.com/users.json?auth=$authToken';
//
//   try {
//     final response = await http.get(url);
//     final userResponseData =
//         json.decode(response.body) as Map<String, dynamic>;
//
//     userResponseData.forEach((id, userResponseDetails) {
//       if (userId == userResponseDetails['userId']) {
//         _username = userResponseDetails['username'];
//       }
//     });
//
//     print('$_username username now');
//     print('$userResponseData user Data');
//   } catch (error) {
//     print('$error error from fetch users');
//   }
// }
// }
