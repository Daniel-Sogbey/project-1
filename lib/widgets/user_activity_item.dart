import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../models/post.dart';
import '../providers/posts.dart';
import '../screens/answers_screen.dart';
import '../screens/create_post_screen.dart';

class UserActivityItem extends StatefulWidget {
  final Post post;
  final String postId;

  UserActivityItem({this.post, this.postId});

  @override
  _UserActivityItemState createState() => _UserActivityItemState();
}

class _UserActivityItemState extends State<UserActivityItem> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 0.0,
        bottom: 10.0,
      ),
      color: Colors.white,
      elevation: 6.0,
      child: Container(
        padding: EdgeInsets.only(top: 5.0),
        child: ListTile(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                CreatePostScreen.routeName,
                arguments: widget.postId,
              );
            },
            icon: Icon(
              Icons.update,
              color: Colors.blue,
            ),
          ),
          title: Container(
            width: double.infinity,
            child: Text(
              widget.post.postText,
              style: kUpdatePostTextStyle,
            ),
          ),
          subtitle: Container(
            child: InkWell(
              hoverColor: Colors.blue,
              borderRadius: BorderRadius.circular(10.0),
              onTap: () {
                Navigator.of(context).pushNamed(
                  AnswersScreen.routeName,
                  arguments: widget.postId,
                );
              },
              splashColor: Colors.blue,
              enableFeedback: true,
              child: Card(
                margin: EdgeInsets.all(10),
                elevation: 5.0,
                color: Colors.greenAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Comments',
                    style: kUpdatePostAnswerTextStyle,
                  ),
                ),
              ),
            ),
          ),
          trailing: IconButton(
            icon: _isLoading
                ? Container(
                    child: Center(
                      heightFactor: 2.0,
                      widthFactor: 2,
                      child: Container(
                        width: 30.0,
                        child: LoadingIndicator(
                          indicatorType: Indicator.ballPulse,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  )
                : Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
            onPressed: () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Posts>(context, listen: false)
                  .deletePost(widget.postId)
                  .then((_) {
                setState(() {
                  _isLoading = false;
                });
              });
            },
          ),
        ),
      ),
    );
  }
}
