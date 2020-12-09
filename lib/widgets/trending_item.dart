import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../models/post.dart';
import '../providers/answers.dart';
import '../screens/answers_screen.dart';
import '../screens/create_answer_screen.dart';
import '../widgets/countBadge.dart';

class TrendingItem extends StatelessWidget {
  final Post posts;
  final answersCount;

  TrendingItem({this.posts, this.answersCount});
  @override
  Widget build(BuildContext context) {
    final answersCount = Provider.of<Answers>(context)
        .findAnswersByQuestionId(posts.postId)
        .length;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 0.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.black12,
            width: 0.2,
            style: BorderStyle.solid,
          ),
          bottom: BorderSide(
            color: Colors.black26,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 40,
                child: Text(
                  'DS',
                  style: kNameTextStyle,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Text(
                  'Uni. of Cape Coast',
                  style: kInfoStyle,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0),
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    width: 1.0,
                    color: Colors.purpleAccent,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Text(
                  posts.category,
                  style: kInfoStyle,
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
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: IconButton(
                    splashColor: Colors.lightBlue,
                    onPressed: () {},
                    icon: Icon(
                      Icons.save_alt,
                      color: Colors.black26,
                      size: 22.0,
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    CountBadge(
                      number: answersCount,
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
                          'Answers',
                          style: kAnswerTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(15.0),
                  splashColor: Colors.lightBlue,
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      CreateAnswerScreen.routeName,
                      arguments: posts.postId,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Answer',
                      style: kAnswerTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
