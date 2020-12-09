import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../providers/answers.dart';
import '../providers/posts.dart';
import '../widgets/post_item.dart';

class PostList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<Posts>(context).availablePosts;
    final answers = Provider.of<Answers>(context).answersCount;
    return posts.length == 0
        ? Container(
            width: double.infinity,
            padding: EdgeInsets.all(7.0),
            child: Center(
              child: Text(
                'Lets Get Started by selecting your interests. '
                'Get your home feed customized by selecting your interests.',
                style: kOnStartTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          )
        : ListView.builder(
            itemCount: posts.length,
            itemBuilder: (ctx, i) => Column(
              children: [
                PostItem(
                  posts: posts[i],
                  answersCount: answers,
                ),
              ],
            ),
          );
  }
}
