import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/questions.dart';
import '../widgets/question-item.dart';

class QuestionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final questions = Provider.of<Questions>(context).questions;
    return ListView.builder(
      itemCount: questions.length,
      itemBuilder: (ctx, i) => Column(
        children: [
          QuestionItem(
            questions: questions[i],
          ),
        ],
      ),
    );
  }
}
