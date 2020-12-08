import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CountBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2.0),
      padding: EdgeInsets.all(5.0),
      child: Container(
        padding: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.purpleAccent,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
        child: Text(
          '200',
          style: kCountBadgeStyle,
          softWrap: true,
        ),
      ),
    );
  }
}
