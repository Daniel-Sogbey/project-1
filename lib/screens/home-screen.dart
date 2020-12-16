import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../providers/answers.dart';
import '../providers/auth.dart';
import '../providers/posts.dart';
import '../screens/create_post_screen.dart';
import '../widgets/app-drawer.dart';
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
  var _isInit = true;

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

  // @override
  // void didChangeDependencies() async {
  //   if (_isInit) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //
  //     try {
  //       await Provider.of<Posts>(context, listen: false)
  //           .fetchPosts()
  //           .then((_) async {
  //         await Provider.of<Answers>(context).fetchAnswers();
  //       });
  //
  //       // print('$auth   auth');
  //     } catch (error) {
  //       // _showErrorDialog('Connection to server failed');
  //
  //       // print('$error autttthh 3');
  //     }
  //   }
  //
  //   setState(() {
  //     _isLoading = false;
  //   });
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    try {
      Future.delayed(Duration(seconds: 5)).then((_) async {
        await Provider.of<Posts>(context, listen: false)
            .fetchPosts()
            .then((_) async {
          await Provider.of<Answers>(context, listen: false).fetchAnswers();
        });
        setState(() {
          _isLoading = false;
        });
      });
    } catch (error) {
      _showErrorDialog('No Internet Connection');
    }

    super.initState();
  }

  //
  // Future<void> _refresh() async {
  //   await Provider.of<Posts>(context, listen: false).fetchPosts();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
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
                ? Column(
                    children: [
                      Center(
                        heightFactor: 1.0,
                        widthFactor: 2,
                        child: Container(
                          width: 70.0,
                          height: 70.0,
                          child: LoadingIndicator(
                            indicatorType: Indicator.orbit,
                            color: Colors.pinkAccent,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: 30.0,
                          horizontal: 30.0,
                        ),
                        child: Text(
                          'Make sure you are connected to the internet',
                          style: kTrendingText,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
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
