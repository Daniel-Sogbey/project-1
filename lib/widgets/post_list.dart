import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../providers/posts.dart';
import '../widgets/post_item.dart';

class PostList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<Posts>(context).posts;
    return posts.length == 0
        ? Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: EdgeInsets.all(7.0),
            child: Center(
              child: Text(
                'No Content Found,'
                'For Your Search.',
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
          );
  }
}
