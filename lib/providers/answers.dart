import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/answer.dart';

class Answers with ChangeNotifier {
  List<Answer> _answers = [];

  String authToken;
  String userId;

  Answers(this.authToken, this.userId, this._answers);

  List<Answer> get answers {
    return [..._answers];
  }

  int get answersCount {
    return _answers.length;
  }

  List<Answer> findAnswersByQuestionId(String questionAnswerId) {
    return _answers
        .where((answer) => answer.questionAnswerId == questionAnswerId)
        .toList();
  }

  Future<void> fetchAnswers() async {
    var url =
        'https://solveshare-7acaf-default-rtdb.firebaseio.com/answers.json?auth=$authToken';

    try {
      final response = await http.get(url);

      print('${json.decode(response.body)} aauuhththt');

      final answersData = json.decode(response.body) as Map<String, dynamic>;

      print('$answersData auuuuutt');

      if (answersData == null) {
        return;
      }

      url =
          'https://solveshare-7acaf-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken';

      final favoriteResponse = await http.get(url);

      final favoriteResponseData = json.decode(favoriteResponse.body);

      url =
          'https://solveshare-7acaf-default-rtdb.firebaseio.com/usersVotes.json?auth=$authToken';

      final voteResponse = await http.get(url);

      final voteResponseData = json.decode(voteResponse.body);

      print('$voteResponseData vote Data');

      print('$favoriteResponseData fav dATA');
      print('$answersData answers DATAAAT');

      final List<Answer> loadedAnswers = [];
      answersData.forEach((answerId, singleAnswerData) {
        print('${singleAnswerData['creatorId']}  CI');
        loadedAnswers.insert(
          0,
          Answer(
            answerId: answerId,
            answerText: singleAnswerData['answerText'],
            questionAnswerId: singleAnswerData['questionAnswerId'],
            creator: singleAnswerData['creatorId'],
            isFav: favoriteResponseData == null
                ? false
                : favoriteResponseData[answerId] ?? false,
            votes:
                voteResponseData == null ? 0 : voteResponseData[answerId] ?? 0,
            // isAccepted: singleAnswerData['isAccepted'],
          ),
        );
      });
      _answers = loadedAnswers;
      // print(json.decode(response.body));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addAnswer(Answer answer) async {
    final url =
        'https://solveshare-7acaf-default-rtdb.firebaseio.com/answers.json?auth=$authToken';

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'questionAnswerId': answer.questionAnswerId,
            'answerText': answer.answerText,
            "creatorId": userId,
          },
        ),
      );
      print('$userId userId');
      final newAnswer = Answer(
        answerId: json.decode(response.body)['name'],
        questionAnswerId: answer.questionAnswerId,
        answerText: answer.answerText,
        // isAccepted: answer.isAccepted,
      );

      _answers.insert(0, newAnswer);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
