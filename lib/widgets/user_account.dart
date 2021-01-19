import 'package:flutter/material.dart';
import '../screens/profile_screen.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Scaffold.of(context).openDrawer();
        Navigator.of(context).pushNamed(ProfileScreen.routeName);
      },
      child: Container(
        margin: EdgeInsets.only(top: 20.0),
        child: CircleAvatar(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Icon(
              FontAwesomeIcons.user,
              size: 30,
            ),
            // Image.asset(
            // 'images/user.png',
            // width: 100,
            // height: 100,
            // fit: BoxFit.fitHeight,
            // ),
          ),
        ),
      ),
    );
  }
}
