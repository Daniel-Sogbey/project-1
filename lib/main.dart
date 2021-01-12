import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import './providers/answers.dart';
import './providers/auth.dart';
import './providers/newsTrends.dart';
import './providers/posts.dart';
import './screens/answers_screen.dart';
import './screens/auth_screen.dart';
import './screens/create_answer_screen.dart';
import './screens/create_post_screen.dart';
import './screens/interests_screen.dart';
import './screens/loading_screen.dart';
import './screens/profile_screen.dart';
import './screens/tabs_screen.dart';
import './screens/trending_screen.dart';
import './screens/update_profile_screen.dart';
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
          create: (context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Posts>(
          update: (ctx, auth, previousPosts) => Posts(
            auth.token,
            auth.userId,
            previousPosts == null ? [] : previousPosts.posts,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Answers>(
          update: (ctx, auth, previousAnswers) => Answers(
            auth.token,
            auth.userId,
            previousAnswers == null ? [] : previousAnswers.answers,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => NewsTrends(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SolveShare',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: auth.isAuth
              ? LoadingScreen()
              :
              // auth.tryAutoLogin() != null ? LoadingScreen() : AuthScreen(),
              FutureBuilder(
                  future: Future.delayed(Duration.zero, auth.tryAutoLogin),
                  builder: (ctx, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? LoadingScreen()
                          : AuthScreen(),
                ),
          routes: {
            CreatePostScreen.routeName: (context) => CreatePostScreen(),
            CreateAnswerScreen.routeName: (context) => CreateAnswerScreen(),
            UserActivityScreen.routeName: (context) => UserActivityScreen(),
            AnswersScreen.routeName: (context) => AnswersScreen(),
            InterestsScreen.routeName: (context) => InterestsScreen(),
            TrendingScreen.routeName: (context) => TrendingScreen(),
            TabsScreen.routeName: (context) => TabsScreen(),
            AuthScreen.routeName: (context) => AuthScreen(),
            ProfileScreen.routeName: (context) => ProfileScreen(),
            UpdateProfileScreen.routeName: (context) => UpdateProfileScreen(),
          },
        ),
      ),
    );
  }
}
