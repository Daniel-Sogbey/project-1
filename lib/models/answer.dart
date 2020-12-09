import 'package:flutter/foundation.dart';

class Answer with ChangeNotifier {
  @required
  final String answerId;
  @required
  final String questionAnswerId;
  @required
  final String answerText;
  bool isAccepted;

  Answer({
    this.answerId,
    this.questionAnswerId,
    this.answerText,
    this.isAccepted = false,
  });

  void acceptAnswer() {
    isAccepted = !isAccepted;

    print('$isAccepted hello');
    notifyListeners();
  }
}
