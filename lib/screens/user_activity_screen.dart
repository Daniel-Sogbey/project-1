import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../providers/posts.dart';
import '../screens/create_post_screen.dart';
import '../widgets/app-drawer.dart';
import '../widgets/app_header.dart';
import '../widgets/user_activity_item.dart';

class UserActivityScreen extends StatelessWidget {
  static const routeName = '/activity';
  @override
  Widget build(BuildContext context) {
    final postsData = Provider.of<Posts>(context);
    return Scaffold(
      drawer: AppDrawer(),
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
            Container(
              child: Text(
                'All Your Activities',
                style: kUpdatePostTextStyle,
              ),
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: postsData.posts.length,
                itemBuilder: (ctx, i) => UserActivityItem(
                  post: postsData.posts[i],
                  postId: postsData.posts[i].postId,
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
