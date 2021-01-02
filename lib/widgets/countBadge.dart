import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CountBadge extends StatelessWidget {
  final int number;

  CountBadge({this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2.0),
      padding: EdgeInsets.all(5.0),
      child: Container(
        child: Text(
          number.toString(),
          style: kCountBadgeStyle,
          softWrap: true,
        ),
      ),
    );
  }
}
