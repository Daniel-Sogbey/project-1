import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../providers/answers.dart';
import '../providers/posts.dart';
import '../screens/create_post_screen.dart';
import '../widgets/app-drawer.dart';
import '../widgets/app_header.dart';
import '../widgets/trending_list.dart';

class TrendingScreen extends StatefulWidget {
  static const routeName = '/trending';

  @override
  _TrendingScreenState createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Posts>(context).fetchPosts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });

      Provider.of<Answers>(context).fetchAnswers();

      // Provider.of<NewsTrends>(context).fetchTopHeadlines();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
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
            Card(
              elevation: 7.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      // Colors.pinkAccent,
                      // Colors.amber,
                      // Colors.blue,
                      Color.fromRGBO(215, 17, 225, 1).withOpacity(0.8),
                      Color.fromRGBO(255, 188, 17, 1).withOpacity(1.0),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0, 1],
                  ),
                ),
                alignment: Alignment.centerLeft,
                // margin: EdgeInsets.only(
                //   left: 5.0,
                //   right: 5.0,
                // ),
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'Discover',
                  style: kTrendingText,
                ),
              ),
            ),
            Divider(),
            // Expanded(
            //   flex: 1,
            //   child: NewsTrendsList(),
            // ),
            Divider(),
            _isLoading
                ? Column(
                    children: [
                      Center(
                        heightFactor: 1.0,
                        widthFactor: 4,
                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          child: LoadingIndicator(
                            indicatorType: Indicator.orbit,
                            color: Colors.pinkAccent,
                          ),
                        ),
                      ),
                    ],
                  )
                : Expanded(
                    flex: 2,
                    child: TrendingList(),
                  ),
            // Container(
            //   height: 15.0,
            //   color: Colors.amber,
            // ),
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
    builder: (context) => Container(
      margin: EdgeInsets.only(left: 20.0, right: 10.0),
      child: GestureDetector(
        // borderRadius: BorderRadius.circular(20),
        onTap: () {
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
    ),
  );
}
