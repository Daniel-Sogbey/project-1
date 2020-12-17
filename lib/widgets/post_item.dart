import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../models/post.dart';
import '../providers/answers.dart';
import '../providers/auth.dart';
import '../screens/answers_screen.dart';
import '../screens/create_answer_screen.dart';
import '../widgets/countBadge.dart';

class PostItem extends StatelessWidget {
  final Post posts;
  final answersCount;

  PostItem({this.posts, this.answersCount});
  @override
  Widget build(BuildContext context) {
    final answersCount = Provider.of<Answers>(context)
        .findAnswersByQuestionId(posts.postId)
        .length;

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
                    'DS',
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
                      'Uni. of Cape Coast',
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
                    // decoration: BoxDecoration(
                    //   color: Colors.greenAccent,
                    //   borderRadius: BorderRadius.circular(5.0),
                    //   border: Border.all(
                    //     width: 1.0,

                    //     style: BorderStyle.solid,
                    //   ),
                    // ),
                    child: Text(
                      posts.category.toUpperCase(),
                      style: kCategoryInfoStyle,
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 8.0, left: 60.0, right: 60.0),
              child: Text(
                posts.postText,
                style: kPostTextStyle,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 24.0,
                right: 24.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.amber,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: IconButton(
                        splashColor: Colors.lightBlue,
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Card(
                        color: Colors.greenAccent,
                        elevation: 7.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Container(
                          child: CountBadge(
                            number: answersCount,
                          ),
                        ),
                      ),
                      // Container(
                      //   child: Text(answersCount.toString()),
                      // ),
                      InkWell(
                        borderRadius: BorderRadius.circular(15.0),
                        splashColor: Colors.lightBlue,
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            AnswersScreen.routeName,
                            arguments: posts.postId,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Comments',
                            style: kAnswerTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Consumer<Auth>(
                    builder: (ctx, auth, _) => InkWell(
                      borderRadius: BorderRadius.circular(15.0),
                      splashColor: Colors.lightBlue,
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          CreateAnswerScreen.routeName,
                          arguments: posts.postId,
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
                          // Text(
                          //   'Answer',
                          //   style: kAnswerTextStyle,
                          // ),
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
