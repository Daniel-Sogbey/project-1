import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<Auth>(context).userId;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              child: CircleAvatar(
                radius: 80.0,
                child: Text(
                  userId.replaceRange(
                    2,
                    userId.length,
                    '...',
                  ),
                ),
              ),
            ),
            Card(
              elevation: 100.0,
              color: Colors.amber,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              shadowColor: Colors.white,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'User Id : '.toUpperCase(),
                        style: kUserProfileId,
                      ),
                    ),
                    Container(
                      child: Text(
                        userId.toUpperCase(),
                        style: kUserProfileId,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: InkWell(
                    splashColor: Colors.amber,
                    onTap: () {
                      print(userId);
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Edit Profile',
                        style: kEditUserProfile,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
