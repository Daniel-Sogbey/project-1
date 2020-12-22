import 'package:flutter/material.dart';

import '../constants/constants.dart';

class AppHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 3.0, left: 5.0),
          child: Text(
            'ShareSpace',
            style: kTitleStyle,
          ),
        ),
        // SizedBox(
        //   height: 5.0,
        // ),
        // Container(
        //   margin: EdgeInsets.only(top: 5.0, right: 5.0),
        //   child: CircleAvatar(
        //     radius: 35,
        //     child: Text(
        //       'DS',
        //       style: kUserInitStyle,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
