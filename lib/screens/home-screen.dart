import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../screens/create_post_screen.dart';
import '../widgets/app_header.dart';
import '../widgets/post_list.dart';
import '../widgets/search-bar.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isLoading = false;

  void _showLittleMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => CreatePostScreen(),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.white,
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'An Error Occurred',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w900,
            fontSize: 25.0,
          ),
        ),
        content: Text(
          message,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Okay',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: <Widget>[
                _buildMenuBar(),
                SizedBox(
                  width: 15.0,
                ),
                AppHeader(),
              ],
            ),
            Divider(),
            SearchBar(),
            _isLoading
                ? Container(
                    child: Center(
                      heightFactor: 2.0,
                      widthFactor: 2,
                      child: Container(
                        width: 50.0,
                        child: LoadingIndicator(
                          indicatorType: Indicator.ballPulse,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: PostList(),
                  ),
            // Container(
            //   height: 15.0,
            //   color: Colors.amber,
            // ),
          ],
        ),
      ),
      floatingActionButton: Consumer<Auth>(
        builder: (ctx, auth, _) => FloatingActionButton(
          elevation: 30.0,
          splashColor: Colors.pinkAccent,
          backgroundColor: Colors.amber,
          onPressed: () {
            Navigator.of(context).pushNamed(CreatePostScreen.routeName);
          },
          child: Icon(
            Icons.add,
            size: 35.0,
          ),
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
        Scaffold.of(context).showBottomSheet<void>(
          (BuildContext context) {
            return Card(
              elevation: 10,
              child: Container(
                height: 150,
                color: Colors.white,
                width: double.infinity,
                child: Column(
                  children: <Widget>[],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 20),
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
