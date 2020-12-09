import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/constants.dart';
import '../screens/interests_screen.dart';
import '../widgets/countBadge.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.black12,
              child: Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(top: 30.0, bottom: 5.0),
                child: CircleAvatar(
                  backgroundColor: Colors.pinkAccent,
                  radius: 50.0,
                  child: Text(
                    'DS',
                    style: kUserInitStyle,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 5.0,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/');
              },
              child: Container(
                margin: EdgeInsets.only(left: 10.0),
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2.5,
                          color: Colors.purpleAccent,
                        ),
                      ),
                      child: Icon(
                        Icons.home,
                        size: 25.0,
                        color: Colors.pink,
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      'Home',
                      style: kAppBarTextStyle,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/');
              },
              child: Container(
                margin: EdgeInsets.only(left: 10.0),
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2.5,
                          color: Colors.purpleAccent,
                        ),
                      ),
                      child: Icon(
                        Icons.trending_up,
                        size: 25.0,
                        color: Colors.pink,
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      'Trending',
                      style: kAppBarTextStyle,
                    ),
                    SizedBox(width: 2.0),
                    Icon(
                      Icons.whatshot,
                      size: 25.0,
                      color: Colors.pink,
                    ),
                    SizedBox(width: 2.0),
                    CountBadge(
                      number: 20,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(InterestsScreen.routeName);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10.0),
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2.5,
                          color: Colors.purpleAccent,
                        ),
                      ),
                      child: Icon(
                        Icons.category,
                        size: 25.0,
                        color: Colors.pink,
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      'Interests',
                      style: kAppBarTextStyle,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            // InkWell(
            //   splashColor: Colors.black12,
            //   onTap: () {
            //     Navigator.of(context).pushNamed(CreatePostScreen.routeName);
            //   },
            //   child: Container(
            //     padding: EdgeInsets.all(10.0),
            //     margin: EdgeInsets.only(left: 10.0),
            //     child: Row(
            //       children: <Widget>[
            //         Container(
            //           padding: EdgeInsets.all(10.0),
            //           decoration: BoxDecoration(
            //             shape: BoxShape.circle,
            //             border: Border.all(
            //               width: 2.5,
            //               color: Colors.purpleAccent,
            //             ),
            //           ),
            //           child: Icon(
            //             FontAwesomeIcons.question,
            //             size: 25.0,
            //             color: Colors.pink,
            //           ),
            //         ),
            //         SizedBox(
            //           width: 5.0,
            //         ),
            //         Text(
            //           'Ask a Question',
            //           style: kAppBarTextStyle,
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 5.0,
            // ),
            InkWell(
              splashColor: Colors.black12,
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(left: 10.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2.5,
                          color: Colors.purpleAccent,
                        ),
                      ),
                      child: Icon(
                        FontAwesomeIcons.chartBar,
                        size: 25.0,
                        color: Colors.pink,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Activity',
                      style: kAppBarTextStyle,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            InkWell(
              splashColor: Colors.black12,
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(left: 10.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2.5,
                          color: Colors.purpleAccent,
                        ),
                      ),
                      child: Icon(
                        Icons.settings,
                        size: 25.0,
                        color: Colors.pink,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
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
      ),
    );
  }
}
