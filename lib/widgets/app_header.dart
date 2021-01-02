import 'package:flutter/material.dart';

import '../constants/constants.dart';

class AppHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0, left: 5.0),
      child: Text(
        'ShareSpace',
        style: kTitleStyle,
      ),
    );
  }
}
