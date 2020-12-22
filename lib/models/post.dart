import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Post with ChangeNotifier {
  @required
  final String postId;
  @required
  String category;
  @required
  final String postText;
  final String creator;
  bool isFav;
  int likes;

  Post({
    this.postId,
    this.postText,
    this.category,
    this.creator,
    this.isFav = false,
    this.likes = 0,
  });

  Future<void> like(String userId, String authToken) async {
    isFav = !isFav;
    final like = ++likes;

    print(like);

    notifyListeners();

    var url =
        'https://solveshare-7acaf-default-rtdb.firebaseio.com/userFavoritesPosts/$userId/$postId.json?auth=$authToken';
    final response = await http.put(
      url,
      body: json.encode(
        isFav,
      ),
    );

    url =
        'https://solveshare-7acaf-default-rtdb.firebaseio.com/usersLikesForPost/$postId.json?auth=$authToken';
    await http.put(
      url,
      body: json.encode(
        like,
      ),
    );

    print(json.decode(response.body));
  }

  Future<void> unlike(String userId, String authToken) async {
    isFav = !isFav;

    final like = --likes;

    print(like);

    notifyListeners();

    var url =
        'https://solveshare-7acaf-default-rtdb.firebaseio.com/userFavoritesPosts/$userId/$postId.json?auth=$authToken';
    final response = await http.put(
      url,
      body: json.encode(
        isFav,
      ),
    );

    url =
        'https://solveshare-7acaf-default-rtdb.firebaseio.com/usersLikesForPost/$postId.json?auth=$authToken';
    await http.put(
      url,
      body: json.encode(
        like,
      ),
    );

    print(json.decode(response.body));
  }
}
