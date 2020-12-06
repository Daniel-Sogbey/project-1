import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/questions.dart';
import './screens/answers-screen.dart';
import './screens/create-question-screen.dart';
import './screens/home-screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Questions(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
        routes: {
          CreateQuestionScreen.routeName: (context) => CreateQuestionScreen(),
          AnswersScreen.routeName: (context) => AnswersScreen(),
        },
      ),
    );
  }
}
