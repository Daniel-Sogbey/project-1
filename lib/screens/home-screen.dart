import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';

import '../widgets/app-drawer.dart';
import '../widgets/question-list.dart';
import '../widgets/search-bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildMenuBar(),
                Container(
                  margin: EdgeInsets.only(top: 3.0),
                  child: Text(
                    'SolveShare',
                    style: kTitleStyle,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.0, right: 5.0),
                  child: CircleAvatar(
                    radius: 50,
                    child: Text(
                      'DS',
                      style: kUserInitStyle,
                    ),
                  ),
                ),
              ],
            ),
            SearchBar(),
            Expanded(
              child: QuestionList(),
            ),
            Container(
              height: 15.0,
              color: Colors.amber,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildMenuBar() {
  return Builder(
    builder: (context) => FlatButton(
      splashColor: Colors.red,
      // borderRadius: BorderRadius.circular(20),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  // margin: EdgeInsets.only(left: 5.0),
                  height: 1.5,
                  width: 20.0,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Container(
                  width: 8.0,
                  child: CircleAvatar(
                    radius: 3.0,
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4.0,
            ),
            Container(
              height: 1.5,
              width: 25.0,
              color: Colors.black,
            ),
            SizedBox(
              height: 4.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 8.0,
                  child: CircleAvatar(
                    radius: 3.0,
                    backgroundColor: Colors.red,
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Container(
                  height: 1.5,
                  width: 20.0,
                  color: Colors.black,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
