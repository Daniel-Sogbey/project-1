import 'package:flutter/material.dart';

import '../constants/constants.dart';

class AnswerCount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2.0),
      padding: EdgeInsets.all(5.0),
      child: CircleAvatar(
        backgroundColor: Colors.pinkAccent,
        radius: 20.0,
        child: Text(
          '200',
          style: kAnswerCountStyle,
          softWrap: true,
        ),
      ),
    );
  }
}
