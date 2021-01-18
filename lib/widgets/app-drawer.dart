import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../screens/auth_screen.dart';
import '../screens/update_profile_screen.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../providers/auth.dart';
import '../screens/interests_screen.dart';
import '../screens/trending_screen.dart';
import '../widgets/countBadge.dart';
import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  final String username;
  final String email;

  AppDrawer({this.username, this.email});

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
                    username,
                    style: kUserInitStyle,
                  ),
                ),
              ),
            ),
            // Container(
            // child: Text(email),
            // ),

            SizedBox(
              height: 20.0,
            ),
            InkWell(
              splashColor: Colors.black12,
              onTap: () {
                Navigator.of(context).pushNamed(UpdateProfileScreen.routeName);
              },
              child: Container(
                margin: EdgeInsets.all(2.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 8.0),
                      // decoration: BoxDecoration(
                      // shape: BoxShape.circle,
                      // border: Border.all(
                      // width: 2.5,
                      // color: Colors.purpleAccent,
                      // ),
                      // ),
                      child: Icon(
                        FontAwesomeIcons.user,
                        size: 18.0,
                        color: Colors.pink,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Edit Profile',
                      style: kAppBarTextStyle,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/');
              },
              child: Container(
                margin: EdgeInsets.all(2.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 5.0),
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
            // InkWell(
            // onTap: () {
            // Navigator.of(context).pushNamed(TrendingScreen.routeName);
            // },
            // child: Container(
            // margin: EdgeInsets.only(left: 10.0),
            // padding: EdgeInsets.all(10.0),
            // child: Row(
            // children: <Widget>[
            // Container(
            // padding: EdgeInsets.all(10.0),
            // decoration: BoxDecoration(
            // shape: BoxShape.circle,
            // border: Border.all(
            // width: 2.5,
            // color: Colors.purpleAccent,
            // ),
            // ),
            // child: Icon(
            // FontAwesomeIcons.globe,
            // size: 25.0,
            // color: Colors.pink,
            // ),
            // ),
            // SizedBox(width: 5.0),
            // Text(
            // 'Discover',
            // style: kAppBarTextStyle,
            // ),
            // SizedBox(width: 2.0),
            // Icon(
            // Icons.whatshot,
            // size: 25.0,
            // color: Colors.pink,
            // ),
            // SizedBox(width: 2.0),
            // CountBadge(
            // number: 20,
            // ),
            // ],
            // ),
            // ),
            // ),
            // SizedBox(
            // height: 5.0,
            // ),
            // InkWell(
            // onTap: () {
            // Navigator.of(context).pushNamed(InterestsScreen.routeName);
            // },
            // child: Container(
            // margin: EdgeInsets.only(left: 10.0),
            // padding: EdgeInsets.all(10.0),
            // child: Row(
            // children: <Widget>[
            // Container(
            // padding: EdgeInsets.all(10.0),
            // decoration: BoxDecoration(
            // shape: BoxShape.circle,
            // border: Border.all(
            // width: 2.5,
            // color: Colors.purpleAccent,
            // ),
            // ),
            // child: Icon(
            // Icons.category,
            // size: 25.0,
            // color: Colors.pink,
            // ),
            // ),
            // SizedBox(width: 5.0),
            // Text(
            // 'Interests',
            // style: kAppBarTextStyle,
            // ),
            // ],
            // ),
            // ),
            // ),
            // SizedBox(
            // height: 5.0,
            // ),
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

            SizedBox(
              height: 5.0,
            ),
            InkWell(
              splashColor: Colors.black12,
              onTap: () {
                Navigator.of(context).pop();
                Provider.of<Auth>(context, listen: false).logout();
              },
              child: Container(
                margin: EdgeInsets.all(2.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Icon(
                        Icons.exit_to_app,
                        size: 25.0,
                        color: Colors.pink,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Logout',
                      style: kAppBarTextStyle,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Consumer<Auth>(
              builder: (ctx, auth, _) => InkWell(
                onTap: () {
                  auth.deleteAccount;
                  Navigator.of(context).pushNamed(AuthScreen.routeName);
                },
                child: Container(
                  margin: EdgeInsets.all(2.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Icon(
                          Icons.unarchive,
                          size: 25.0,
                          color: Colors.pink,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        'Delete Account',
                        style: kAppBarTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
          ],
        ),
      ),
    );
  }
}
