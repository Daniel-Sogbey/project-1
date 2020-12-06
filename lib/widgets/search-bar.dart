import 'package:flutter/material.dart';

import '../constants/constants.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 30.0, bottom: 15.0),
      child: TextField(
        style: kInputTextStyle,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          labelText: 'Search only by KEYWORDS',
          labelStyle: kLabelStyle,
          border: OutlineInputBorder(),
          prefixIcon: Icon(
            Icons.search,
            size: 30.0,
            color: Colors.pink,
          ),
        ),
      ),
    );
  }
}
