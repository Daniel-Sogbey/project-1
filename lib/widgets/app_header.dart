import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  final Color color;

  AppHeader({this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0, left: 5.0),
      child: Text(
        'ShareSpace',
        style: TextStyle(
          color: color,
          fontSize: 35.0,
          letterSpacing: 1.0,
          fontWeight: FontWeight.w900,
          fontFamily: 'Sacramento',
        ),
      ),
    );
  }
}
