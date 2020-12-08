import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../models/post.dart';
import '../screens/answers-screen.dart';
import '../widgets/countBadge.dart';

class QuestionItem extends StatelessWidget {
  final Post posts;

  QuestionItem({this.posts});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          width: 0.2,
          color: Colors.black12,
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
            margin:
                EdgeInsets.only(top: 20.0, left: 5.0, right: 5.0, bottom: 5.0),
            child: Text(
              posts.postText,
              style: kPostTextStyle,
            ),
          ),
          Row(
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
                  CountBadge(),
                  InkWell(
                    borderRadius: BorderRadius.circular(15.0),
                    splashColor: Colors.lightBlue,
                    onTap: () {
                      Navigator.of(context).pushNamed(AnswersScreen.routeName);
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
                onTap: () {},
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
        ],
      ),
    );
  }
}
