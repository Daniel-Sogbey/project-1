import 'package:flutter/foundation.dart';

import '../models/question.dart';

class Questions with ChangeNotifier {
  List<Question> _questions = [
    Question(
      questionId: 'q1',
      questionText:
          'A particle has mass 10kg. Calculate the force on the particle assuming it is at rest? Take g= 10m/s/s.',
    ),
    Question(
      questionId: 'q1',
      questionText:
          'A particle has mass 10kg. Calculate the force on the particle assuming it is at rest? Take g= 10m/s/s.',
    ),
    Question(
      questionId: 'q1',
      questionText:
          'A particle has mass 10kg. Calculate the force on the particle assuming it is at rest? Take g= 10m/s/s.',
    ),
    Question(
      questionId: 'q1',
      questionText:
          'A particle has mass 10kg. Calculate the force on the particle assuming it is at rest? Take g= 10m/s/s.',
    ),
    Question(
      questionId: 'q1',
      questionText:
          'A particle has mass 10kg. Calculate the force on the particle assuming it is at rest? Take g= 10m/s/s.',
    ),
    Question(
      questionId: 'q1',
      questionText:
          'A particle has mass 10kg. Calculate the force on the particle assuming it is at rest? Take g= 10m/s/s.',
    ),
  ];

  List<Question> get questions {
    return [..._questions];
  }
}
