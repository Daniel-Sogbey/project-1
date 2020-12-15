import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/home-screen.dart';
import '../screens/trending_screen.dart';
import '../screens/user_activity_screen.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs';

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Widget> _pages = [
    HomeScreen(),
    UserActivityScreen(),
    TrendingScreen(),
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  // var _isInit = true;
  // var _isLoading = false;
  //
  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     Provider.of<Posts>(context, listen: false).fetchPostsBasedOnFilters().then((_) {
  //       Provider.of<Answers>(context, listen: false).fetchAnswers().then((_) {
  //         setState(() {
  //           _isLoading = false;
  //         });
  //       });
  //     });
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blue,
        onTap: _selectPage,
        items: <Widget>[
          Icon(
            Icons.home,
            // FontAwesomeIcons.home,
            color: Colors.pink,
          ),
          Icon(
            FontAwesomeIcons.chartBar,
            color: Colors.pink,
          ),
          Icon(
            Icons.trending_up,
            color: Colors.pink,
          ),
        ],
      ),
    );
  }
}
