import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/home-screen.dart';
import '../screens/interests_screen.dart';
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
    InterestsScreen(),
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
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.black45,
        selectedFontSize: 20,
        unselectedFontSize: 18,
        backgroundColor: Colors.white,
        elevation: 10.0,
        currentIndex: _selectedPageIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('Home'),
            icon: Icon(
              FontAwesomeIcons.home,
              color: Colors.amber,
            ),
          ),
          BottomNavigationBarItem(
            title: Text('My Posts'),
            icon: Icon(
              FontAwesomeIcons.solidEdit,
              color: Colors.greenAccent,
            ),
          ),
          BottomNavigationBarItem(
            title: Text('Explore'),
            icon: Icon(
              FontAwesomeIcons.globe,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}

// CurvedNavigationBar(
//   backgroundColor: Colors.blue,
//   onTap: _selectPage,
//   items: <Widget>[
//     Icon(
//       Icons.home,
//       // FontAwesomeIcons.home,
//       color: Colors.pink,
//     ),
//     Icon(
//       FontAwesomeIcons.chartBar,
//       color: Colors.pink,
//     ),
//     Icon(
//       FontAwesomeIcons.globe,
//       color: Colors.pink,
//     ),
//   ],
// ),
