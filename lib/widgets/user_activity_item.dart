import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../models/post.dart';
import '../providers/posts.dart';
import '../screens/answers-screen.dart';
import '../screens/create_post_screen.dart';

class UserActivityItem extends StatelessWidget {
  final Post post;
  final String postId;

  UserActivityItem({this.post, this.postId});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(0.0),
      child: ListTile(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              CreatePostScreen.routeName,
              arguments: postId,
            );
          },
          icon: Icon(
            Icons.update,
          ),
        ),
        title: Text(
          post.postText,
          style: kUpdatePostTextStyle,
        ),
        subtitle: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(AnswersScreen.routeName);
          },
          splashColor: Colors.blue,
          enableFeedback: true,
          child: Container(
            margin: EdgeInsets.only(top: 5.0),
            child: Text(
              'Answers',
              style: kUpdatePostAnswerTextStyle,
            ),
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.close,
          ),
          onPressed: () {
            Provider.of<Posts>(context, listen: false).deletePost(postId);
          },
        ),
      ),
    );
  }
}
