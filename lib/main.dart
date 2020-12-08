import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/posts.dart';
import './screens/answers-screen.dart';
import './screens/create_post_screen.dart';
import './screens/tabs_screen.dart';
import './screens/user_activity_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Posts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SolveShare',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TabsScreen(),
        routes: {
          CreatePostScreen.routeName: (context) => CreatePostScreen(),
          AnswersScreen.routeName: (context) => AnswersScreen(),
          UserActivityScreen.routeName: (context) => UserActivityScreen(),
        },
      ),
    );
  }
}
