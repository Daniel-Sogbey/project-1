import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../providers/posts.dart';
import '../screens/create_post_screen.dart';
import '../widgets/app_header.dart';
import '../widgets/user_activity_item.dart';

class UserActivityScreen extends StatefulWidget {
  static const routeName = '/activity';

  @override
  _UserActivityScreenState createState() => _UserActivityScreenState();
}

class _UserActivityScreenState extends State<UserActivityScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     Future.delayed(Duration.zero).then((_) async {
  //       await Provider.of<Posts>(context, listen: false)
  //           .fetchPosts(true)
  //           .then((_) async {
  //         await Provider.of<Answers>(context, listen: false)
  //             .fetchAnswers()
  //             .then((_) {
  //           setState(() {
  //             _isLoading = false;
  //           });
  //         });
  //       });
  //     });
  //
  //     // Future.delayed(Duration(seconds: 0), () {
  //     //
  //     // });
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final postsData = Provider.of<Posts>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
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
            Card(
              color: Colors.purpleAccent,
              elevation: 7.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      // Colors.pinkAccent,
                      // Colors.amber,
                      // Colors.blue,
                      Color.fromRGBO(255, 188, 17, 1).withOpacity(1.0),
                      Color.fromRGBO(215, 17, 225, 1).withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0, 1],
                  ),
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                width: double.infinity,
                child: Text(
                  'All Your Activities',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontSize: 16.0,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
            Divider(),
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
                : postsData.posts.length == 0
                    ? Container(
                        child: Center(
                          child: Text(
                            'Lets Get Started by asking your first question.',
                            style: kOnStartTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : Container(
                        child: Expanded(
                          child: ListView.builder(
                            itemCount: postsData.posts.length,
                            itemBuilder: (ctx, i) => UserActivityItem(
                              post: postsData.posts[i],
                              postId: postsData.posts[i].postId,
                            ),
                          ),
                        ),
                      ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
        margin: EdgeInsets.only(top: 20.0),
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
