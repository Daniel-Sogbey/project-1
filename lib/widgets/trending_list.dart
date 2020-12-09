import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../providers/answers.dart';
import '../providers/posts.dart';
import '../widgets/trending_item.dart';

class TrendingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<Posts>(context).posts;
    final answers = Provider.of<Answers>(context).answersCount;
    return posts.length == 0
        ? Center(
            child: Text(
              'No Shares Available Yet!',
              style: kAppBarTextStyle,
            ),
          )
        : ListView.builder(
            itemCount: posts.length,
            itemBuilder: (ctx, i) => Column(
              children: [
                TrendingItem(
                  posts: posts[i],
                  answersCount: answers,
                ),
              ],
            ),
          );
  }
}
