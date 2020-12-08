import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/home-screen.dart';
import '../screens/user_activity_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Widget> _pages = [
    HomeScreen(),
    UserActivityScreen(),
    HomeScreen(),
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blue,
        onTap: _selectPage,
        items: <Widget>[
          Icon(
            // Icons.home,
            FontAwesomeIcons.home,
            color: Colors.pinkAccent,
          ),
          Icon(
            FontAwesomeIcons.chartBar,
            color: Colors.pinkAccent,
          ),
          Icon(
            Icons.trending_up,
            color: Colors.pinkAccent,
          ),
        ],
      ),
    );
  }
}
