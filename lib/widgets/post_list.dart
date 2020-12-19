import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../providers/answers.dart';
import '../providers/posts.dart';
import '../widgets/post_item.dart';

class PostList extends StatelessWidget {
  Future<void> _refresh(BuildContext context) async {
    await Provider.of<Posts>(context, listen: false)
        .fetchPostsBasedOnFilters()
        .then((_) async {
      await Provider.of<Answers>(context, listen: false).fetchAnswers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<Posts>(context).posts;
    final answers = Provider.of<Answers>(context).answersCount;
    return posts.length == 0
        ? Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: EdgeInsets.all(7.0),
            child: Center(
              child: Text(
                'No Content Found.'
                'Consider choosing an interest or searching for questions.',
                style: kOnStartTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          )
        : RefreshIndicator(
            onRefresh: () => _refresh(context),
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (ctx, i) => Column(
                children: [
                  PostItem(
                    posts: posts[i],
                    answersCount: answers,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 2.0),
                    child: Text(
                      '...',
                      style: kDotsTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
