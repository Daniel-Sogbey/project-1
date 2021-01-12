import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/auth.dart';
import '../screens/update_profile_screen.dart';
import '../widgets/app_header.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  @override
  Widget build(BuildContext context) {
    final userDetails = Provider.of<Auth>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AppHeader(),
              ],
            ),
            Divider(),
            Consumer<User>(
              builder: (ctx, user, _) => Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.0),
                child: CircleAvatar(
                  radius: 80.0,
                  child: user.getUsername == null
                      ? Text(
                          userDetails.userId.replaceRange(
                            2,
                            userDetails.userId.length,
                            '...',
                          ),
                        )
                      : Text(
                          user.getUsername,
                        ),
                ),
              ),
            ),
            UserDetails(userDetails: userDetails),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      print(userDetails);
                      Navigator.of(context).pushNamed(
                        UpdateProfileScreen.routeName,
                      );
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
            ),
          ],
        ),
      ),
    );
  }
}

class UserDetails extends StatelessWidget {
  final Auth userDetails;
  const UserDetails({
    @required this.userDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 100.0,
      color: Colors.amber,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      shadowColor: Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 50.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    'User Id: '.toUpperCase(),
                    style: kUserProfileId,
                  ),
                ),
                Container(
                  child: Text(
                    userDetails.userId.toUpperCase(),
                    style: kUserProfileId,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    'Email: '.toUpperCase(),
                    style: kUserProfileId,
                  ),
                ),
                Container(
                  child: Text(
                    userDetails.email == null
                        ? ''
                        : userDetails.email.toUpperCase(),
                    style: kUserProfileId,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
