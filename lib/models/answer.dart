import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Answer with ChangeNotifier {
  @required
  final String answerId;
  @required
  final String questionAnswerId;
  @required
  final String answerText;
  int votes;

  Answer({
    this.answerId,
    this.questionAnswerId,
    this.answerText,
    this.votes = 0,
  });

  // void acceptAnswer() {
  //   isAccepted = !isAccepted;
  //
  //   print('$isAccepted hello');
  //   notifyListeners();
  // }

  Future<void> getVotes(String authToken) async {
    notifyListeners();
    final url =
        'https://solveshare-7acaf-default-rtdb.firebaseio.com/answers/$answerId.json?auth=$authToken';
    final response = await http.get(url);

    votes = json.decode(response.body)['votes'];
  }

  int get numOfVotes {
    return votes;
  }

  Future<void> upVote(String authToken, String userId) async {
    var vote = ++votes;
    // if (vote > 1) {
    //   return;
    // }
    print(vote);

    notifyListeners();
    final url =
        'https://solveshare-7acaf-default-rtdb.firebaseio.com/userFavorites/$userId/$answerId.json?auth=$authToken';
    final response = await http.put(
      url,
      body: json.encode(vote),
    );

    print(json.decode(response.body));
    // vote = json.decode(response.body);
  }

  Future<void> downVote(String authToken, String userId) async {
    final vote = --votes;

    print(vote);

    notifyListeners();
    final url =
        'https://solveshare-7acaf-default-rtdb.firebaseio.com/userFavorites/$userId/$answerId.json?auth=$authToken';
    await http.put(
      url,
      body: json.encode(vote),
    );
  }
}
