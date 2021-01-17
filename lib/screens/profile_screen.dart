import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_1/constants/constants.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/auth.dart';
import '../screens/update_profile_screen.dart';
import '../widgets/app_header.dart';
import '../widgets/separator.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File _pickedImage;

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
            Separator(),
            Consumer<User>(
              builder: (ctx, user, _) => Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  left: 10.0,
                  right: 10,
                  bottom: 20.0,
                  top: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage:
                          _pickedImage == null ? null : FileImage(_pickedImage),
                      // user.getUsername == null
                      //     ? Text(
                      //   userDetails.userId.replaceRange(
                      //     2,
                      //     userDetails.userId.length,
                      //     '...',
                      //   ),
                      // )
                      //     : Text(
                      //   user.getUsername,
                      // ):
                    ),
                    Container(
                      child: IconButton(
                        onPressed: () async {
                          final picker = ImagePicker();
                          final pickedImageFile = await picker.getImage(
                            source: ImageSource.gallery,
                          );

                          setState(() {
                            _pickedImage = pickedImageFile as File;
                          });
                        },
                        icon: Icon(
                          Icons.linked_camera,
                          color: Colors.black26,
                          size: 50.0,
                        ),
                      ),
                    ),
                  ],
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
      shadowColor: Colors.white,
      elevation: 100.0,
      color: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
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
                  child: userDetails.userId == null
                      ? Text('')
                      : Text(
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
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    'username: '.toUpperCase(),
                    style: kUserProfileId,
                  ),
                ),
                Consumer<User>(
                  builder: (ctx, user, _) => Container(
                    child: Text(
                      user.getUsername == null
                          ? ''
                          : user.getUsername.toUpperCase(),
                      style: kUserProfileId,
                    ),
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
