import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  final Color color;

  Separator({this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 3.0, bottom: 5.0),
      height: 1.0,
      width: MediaQuery.of(context).size.width * 0.7,
      color: color == null ? Colors.black12 : color,
    );
  }
}
