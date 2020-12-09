import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import './providers/answers.dart';
import './providers/posts.dart';
import './screens/answers_screen.dart';
import './screens/create_answer_screen.dart';
import './screens/create_post_screen.dart';
import './screens/interests_screen.dart';
import './screens/tabs_screen.dart';
import './screens/user_activity_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider(
          create: (context) => Posts(),
        ),
        ChangeNotifierProvider(
          create: (context) => Answers(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SolveShare',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TabsScreen(),
        routes: {
          CreatePostScreen.routeName: (context) => CreatePostScreen(),
          CreateAnswerScreen.routeName: (context) => CreateAnswerScreen(),
          UserActivityScreen.routeName: (context) => UserActivityScreen(),
          AnswersScreen.routeName: (context) => AnswersScreen(),
          InterestsScreen.routeName: (context) => InterestsScreen(),
        },
      ),
    );
  }
}
