import 'package:flutter/foundation.dart';

class Question {
  @required
  final String questionId;
  @required
  final String questionText;

  Question({this.questionId, this.questionText});
}
