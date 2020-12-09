import 'package:flutter/foundation.dart';

import '../models/answer.dart';

class Answers with ChangeNotifier {
  List<Answer> _answers = [];

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

  void addAnswer(Answer answer) {
    final newAnswer = Answer(
      answerId: DateTime.now().toString(),
      questionAnswerId: answer.questionAnswerId,
      answerText: answer.answerText,
    );

    _answers.add(newAnswer);
    notifyListeners();
  }
}
