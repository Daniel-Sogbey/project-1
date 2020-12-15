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

  Future<void> upVote(String authToken) async {
    var vote = ++votes;

    print(vote);

    notifyListeners();
    final url =
        'https://solveshare-7acaf-default-rtdb.firebaseio.com/answers/$answerId.json?auth=$authToken';
    final response = await http.patch(
      url,
      body: json.encode(
        {
          'votes': vote,
        },
      ),
    );

    vote = json.decode(response.body)['votes'];
  }

  Future<void> downVote(String authToken) async {
    final vote = --votes;

    print(vote);

    notifyListeners();
    final url =
        'https://solveshare-7acaf-default-rtdb.firebaseio.com/answers/$answerId.json?auth=$authToken';
    await http.patch(
      url,
      body: json.encode(
        {
          'votes': vote,
        },
      ),
    );
  }
}
