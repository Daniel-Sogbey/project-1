import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/constants.dart';
import '../screens/create-question-screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.black12,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 30.0),
                  child: CircleAvatar(
                    radius: 80.0,
                    child: Text(
                      'DS',
                      style: kUserInitStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          InkWell(
            splashColor: Colors.pinkAccent,
            onTap: () {
              Navigator.of(context).pushNamed(CreateQuestionScreen.routeName);
            },
            child: Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(left: 10.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.question,
                    size: 18.0,
                    color: Colors.pink,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Ask a Question',
                    style: kAppBarTextStyle,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          InkWell(
            splashColor: Colors.pinkAccent,
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(left: 10.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.user,
                    size: 18.0,
                    color: Colors.pink,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'My Questions',
                    style: kAppBarTextStyle,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          InkWell(
            splashColor: Colors.pinkAccent,
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(left: 10.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.settings,
                    size: 18.0,
                    color: Colors.pink,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Settings',
                    style: kAppBarTextStyle,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
