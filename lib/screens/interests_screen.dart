import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../providers/auth.dart';
import '../providers/posts.dart';
import '../screens/tabs_screen.dart';
import '../widgets/app-drawer.dart';
import '../widgets/app_header.dart';

class InterestsScreen extends StatefulWidget {
  static const routeName = '/interests';

  @override
  _InterestsScreenState createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  var _science = false;
  var _life = false;
  var _movies = false;
  var _engineering = false;
  var _education = false;
  var _technology = false;
  var _music = false;
  var _politics = false;
  var _religion = false;
  var _society = false;
  var _art = false;
  var _sports = false;
  var _entertainment = false;

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final currentState = Provider.of<Posts>(context, listen: false).filters;

      if (currentState == null) {
        return;
      }

      print('$currentState current State');
      _science = currentState['science'];
      _life = currentState['life'];
      _technology = currentState['technology'];
      _music = currentState['music'];
      _education = currentState['education'];
      _engineering = currentState['engineering'];
      _movies = currentState['movies'];
      _politics = currentState['politics'];
      _religion = currentState['religion'];
      _society = currentState['society'];
      _art = currentState['art'];
      _sports = currentState['sports'];
      _entertainment = currentState['entertainment'];
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  // @override
  // void initState() {
  //   Provider.of<Posts>(context, listen: false).fetchFilters();
  //   final currentState = Provider.of<Posts>(context).filters;
  //   _science = currentState['science'];
  //   _life = currentState['life'];
  //   _technology = currentState['technology'];
  //   _music = currentState['music'];
  //   _education = currentState['education'];
  //   _engineering = currentState['engineering'];
  //   _movies = currentState['movies'];
  //   _politics = currentState['politics'];
  //   _religion = currentState['religion'];
  //   _society = currentState['society'];
  //   _art = currentState['art'];
  //   _sports = currentState['sports'];
  //   _entertainment = currentState['entertainment'];
  //
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    Map<String, bool> _filters = {
      'science': _science,
      'life': _life,
      'technology': _technology,
      'music': _music,
      'politics': _politics,
      'religion': _religion,
      'society': _society,
      'art': _art,
      'sports': _sports,
      'movies': _movies,
      'engineering': _engineering,
      'education': _education,
      'entertainment': _entertainment,
    };
    final posts = Provider.of<Posts>(context);
    return Scaffold(
      drawer: AppDrawer(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                _buildMenuBar(),
                AppHeader(),
              ],
            ),
            Divider(),
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 5.0),
                  child: Text(
                    'Pick your Interests',
                    style: kPickInterestTextStyle,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 5.0,
                    bottom: 15.0,
                    top: 2.0,
                  ),
                  child: Text(
                    'Don\'t forget to save your interests',
                    style: kPickInterestSubTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Consumer<Auth>(
              builder: (ctx, auth, _) => InkWell(
                child: IconButton(
                  onPressed: () {
                    posts.saveFilters(_filters);
                    Navigator.of(context).pushNamed(TabsScreen.routeName);
                  },
                  icon: Icon(
                    Icons.save_alt,
                    color: Colors.pinkAccent,
                    size: 30.0,
                  ),
                ),
              ),
            ),
            Divider(),
            Expanded(
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
                child: ListView(
                  children: <Widget>[
                    _buildSwitchListTile(
                      'Science',
                      'Only topics related to Science',
                      (newValue) {
                        setState(() {
                          _science = newValue;
                        });
                      },
                      _science,
                    ),
                    Divider(),
                    _buildSwitchListTile(
                      'Life',
                      'Only topics related to daily life experiences',
                      (newValue) {
                        setState(() {
                          _life = newValue;
                        });
                      },
                      _life,
                    ),
                    Divider(),
                    _buildSwitchListTile(
                      'Technology',
                      'Only topics related to Technology',
                      (newValue) {
                        setState(() {
                          _technology = newValue;
                        });
                      },
                      _technology,
                    ),
                    Divider(),
                    _buildSwitchListTile(
                      'Religion',
                      'Only topics related to Religion',
                      (newValue) {
                        setState(() {
                          _religion = newValue;
                        });
                      },
                      _religion,
                    ),
                    Divider(),
                    _buildSwitchListTile(
                      'Music',
                      'Only topics related to Music',
                      (newValue) {
                        setState(() {
                          _music = newValue;
                        });
                      },
                      _music,
                    ),
                    Divider(),
                    _buildSwitchListTile(
                      'Society',
                      'Only topics related to Society',
                      (newValue) {
                        setState(() {
                          _society = newValue;
                        });
                      },
                      _society,
                    ),
                    Divider(),
                    _buildSwitchListTile(
                      'Art',
                      'Only topics related to Art',
                      (newValue) {
                        setState(() {
                          _art = newValue;
                        });
                      },
                      _art,
                    ),
                    Divider(),
                    _buildSwitchListTile(
                      'Entertainment',
                      'Only topics related to Entertainment',
                      (newValue) {
                        setState(() {
                          _entertainment = newValue;
                        });
                      },
                      _entertainment,
                    ),
                    Divider(),
                    _buildSwitchListTile(
                      'Sports',
                      'Only topics related to Sports',
                      (newValue) {
                        setState(() {
                          _sports = newValue;
                        });
                      },
                      _sports,
                    ),
                    Divider(),
                    _buildSwitchListTile(
                      'Politics',
                      'Only topics related to Politics',
                      (newValue) {
                        setState(() {
                          _politics = newValue;
                        });
                      },
                      _politics,
                    ),
                    Divider(),
                    _buildSwitchListTile(
                      'Education',
                      'Only topics related to Education',
                      (newValue) {
                        setState(() {
                          _education = newValue;
                        });
                      },
                      _education,
                    ),
                    Divider(),
                    _buildSwitchListTile(
                      'Engineering',
                      'Only topics related to Engineering',
                      (newValue) {
                        setState(() {
                          _engineering = newValue;
                        });
                      },
                      _engineering,
                    ),
                    Divider(),
                    _buildSwitchListTile(
                      'Movies',
                      'Only topics related to Movies',
                      (newValue) {
                        setState(() {
                          _movies = newValue;
                        });
                      },
                      _movies,
                    ),
                    Divider(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildSwitchListTile(
    String title, String subtitle, Function onChangedHandler, bool interest) {
  return Card(
    elevation: 6.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Container(
      padding: EdgeInsets.all(8.0),
      child: SwitchListTile(
        activeColor: Colors.pinkAccent,
        activeTrackColor: Colors.amber,
        inactiveThumbColor: Colors.amber,
        inactiveTrackColor: Colors.pinkAccent,
        title: Text(
          title,
          style: kSwitchTitleTextStyle,
        ),
        subtitle: Text(
          subtitle,
          style: kSwitchSubtitleTextStyle,
        ),
        onChanged: onChangedHandler,
        value: interest,
      ),
    ),
  );
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
