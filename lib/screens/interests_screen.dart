import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InterestsScreen extends StatefulWidget {
  static const routeName = '/interests';

  @override
  _InterestsScreenState createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  var _science = false;
  var _life = false;
  var _technology = false;
  var _music = false;
  var _politics = false;
  var _religion = false;
  var _society = false;
  var _art = false;
  var _sport = false;
  var _entertainment = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Interests'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Text('Pick your Interests'),
          ),
          Expanded(
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
                _buildSwitchListTile(
                  'Sport',
                  'Only topics related to Sport',
                  (newValue) {
                    setState(() {
                      _sport = newValue;
                    });
                  },
                  _sport,
                ),
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
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildSwitchListTile(
    String title, String subtitle, Function onChangedHandler, bool interest) {
  return SwitchListTile(
    activeColor: Colors.pinkAccent,
    activeTrackColor: Colors.amber,
    inactiveThumbColor: Colors.amber,
    inactiveTrackColor: Colors.pinkAccent,
    title: Text(
      title,
      style: TextStyle(
        fontSize: 20.0,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w900,
      ),
    ),
    subtitle: Text(
      subtitle,
      style: TextStyle(
        fontSize: 16.0,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w900,
        color: Colors.black45,
      ),
    ),
    onChanged: onChangedHandler,
    value: interest,
  );
}
