import 'package:flutter/material.dart';

class CreateQuestionScreen extends StatefulWidget {
  static const routeName = '/create-question';
  @override
  _CreateQuestionScreenState createState() => _CreateQuestionScreenState();
}

class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Question'),
      ),
      body: Center(
        child: Text('Create Question Screen'),
      ),
    );
  }
}
