import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../constants/constants.dart';
import '../models/post.dart';
import '../providers/answers.dart';
import '../providers/auth.dart';
import '../providers/posts.dart';
import '../screens/answers_screen.dart';
import '../screens/create_answer_screen.dart';
import '../widgets/countBadge.dart';

class PostItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final post = Provider.of<Post>(context, listen: false);
    final answersCount = Provider.of<Answers>(context)
        .findAnswersByQuestionId(post.postId)
        .length;

    final auth = Provider.of<Auth>(context);
    final posts = Provider.of<Posts>(context);

    return Card(
      color: Colors.white,
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        // decoration: BoxDecoration(
        //   border: Border(
        //     top: BorderSide(
        //       color: Colors.black12,
        //       width: 0.2,
        //       style: BorderStyle.solid,
        //     ),
        //     bottom: BorderSide(
        //       color: Colors.black26,
        //       width: 1.0,
        //       style: BorderStyle.solid,
        //     ),
        //   ),
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: 60.0,
                  height: 60.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        // Colors.pinkAccent,
                        // Colors.amber,
                        // Colors.blue,
                        Color.fromRGBO(215, 17, 225, 1).withOpacity(0.8),
                        Color.fromRGBO(255, 188, 17, 1).withOpacity(1.0),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0, 1],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    post.creator == null
                        ? 'A'
                        : post.creator
                            .replaceRange(2, post.creator.length, '...'),
                    // 'DS',
                    // auth.token.replaceRange(3, auth.token.length, 'fs'),
                    // posts.creatorId
                    //     .replaceRange(5, posts.creatorId.length, 'fs'),
                    // auth.userId.replaceRange(7, auth.userId.length, 'fs'),
                    style: kNameTextStyle,
                  ),
                ),
                Card(
                  elevation: 6.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  margin: EdgeInsets.only(left: 10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      post.creator == null
                          ? 'Anonymous'
                          : post.creator
                              .replaceRange(3, post.creator.length, '...'),
                      style: kInfoStyle,
                    ),
                  ),
                ),
                Card(
                  elevation: 4,
                  margin: EdgeInsets.only(left: 20.0),
                  color: Colors.greenAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      post.category.toUpperCase(),
                      style: kCategoryInfoStyle,
                      softWrap: true,
                    ),
                  ),
                ),
                Text(
                  DateFormat('dd/MM').format(post.timeStamp),
                  style: kTimeTextStyle,
                ),
                // Text(
                //   '${DateFormat.H().format(posts.timeStamp)} Hrs ago',
                //   style: kTimeTextStyle,
                // ),
                Text(
                  '${timeago.format(post.timeStamp, locale: 'en_short')}',
                  style: kTimeTextStyle,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 8.0, left: 60.0, right: 60.0),
              child: Text(
                post.postText,
                style: kPostTextStyle,
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: [
                      Consumer<Post>(
                        builder: (ctx, post, _) => Container(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            post.likes == 1
                                ? '${post.likes.toString()} like'
                                : '${post.likes.toString()} likes',
                            style: kLikeTextStyle,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Consumer<Post>(
                          builder: (ctx, post, _) => IconButton(
                            splashColor: Colors.greenAccent,
                            onPressed: () {
                              post.isFav
                                  ? post.unlike(auth.userId, auth.token)
                                  : post.like(auth.userId, auth.token);
                            },
                            icon: post.isFav
                                ? Icon(
                                    // Icons.arrow_downward,
                                    FontAwesomeIcons.solidArrowAltCircleDown,
                                    color: Colors.black12,
                                    size: 30.0,
                                  )
                                : Icon(
                                    FontAwesomeIcons.solidArrowAltCircleUp,
                                    color: Colors.blue,
                                    size: 30.0,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(
                    //     width: 1.0,
                    //     color: Colors.black12,
                    //   ),
                    //   color: Colors.black12,
                    //   borderRadius: BorderRadius.circular(5.0),
                    // ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 3.0, right: 3.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black12,
                            ),
                            padding: EdgeInsets.all(5.0),
                            child: CountBadge(
                              number: answersCount,
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(15.0),
                            splashColor: Colors.lightBlue,
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                AnswersScreen.routeName,
                                arguments: post.postId,
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(6.0),
                              child: Text(
                                'Comments',
                                style: kAnswerTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Consumer<Auth>(
                    builder: (ctx, auth, _) => InkWell(
                      borderRadius: BorderRadius.circular(15.0),
                      splashColor: Colors.lightBlue,
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          CreateAnswerScreen.routeName,
                          arguments: post.postId,
                        );
                      },
                      child: Card(
                        elevation: 10,
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 22.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
