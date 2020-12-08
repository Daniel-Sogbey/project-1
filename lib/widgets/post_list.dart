import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../providers/posts.dart';
import '../widgets/post_item.dart';

class QuestionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<Posts>(context).posts;
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
                QuestionItem(
                  posts: posts[i],
                ),
              ],
            ),
          );
  }
}
