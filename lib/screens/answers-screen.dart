import 'package:flutter/material.dart';

class AnswersScreen extends StatelessWidget {
  static const routeName = '/answers';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Answers'),
      ),
      body: Center(
        child: Text('Answers Screen'),
      ),
    );
  }
}
