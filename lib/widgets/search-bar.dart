import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../providers/answers.dart';
import '../providers/posts.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _searchTerm = TextEditingController();
  var _isLoading = false;

  void _save() async {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _isLoading = true;
    });
    await Provider.of<Posts>(context, listen: false)
        .getSearchForPosts(_searchTerm.text)
        .then((_) {
      Provider.of<Answers>(context, listen: false).fetchAnswers();
    }).then((_) {
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
      });
    });
    FocusScope.of(context).requestFocus(FocusNode());
    _searchTerm.text = '';
    print(_searchTerm.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Card(
        elevation: 6.0,
        margin:
            EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0, top: 15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
          child: TextField(
            style: kInputTextStyle,
            maxLines: null,
            keyboardType: TextInputType.text,
            onEditingComplete: () {
              _save();
            },
            controller: _searchTerm,
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'CATEGORY or KEYWORD',
                labelStyle: kLabelStyle,
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(10.0),
                // ),
                prefixIcon: Icon(
                  Icons.search,
                  size: 30.0,
                  color: Colors.greenAccent,
                ),
                suffixIcon: _isLoading
                    ? Container(
                        child: Center(
                          heightFactor: 2.0,
                          widthFactor: 2,
                          child: Container(
                            width: 30.0,
                            child: LoadingIndicator(
                              indicatorType: Indicator.ballPulse,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        child: IconButton(
                          splashColor: Colors.purpleAccent,
                          onPressed: () async {
                            _save();
                          },
                          icon: Icon(
                            Icons.send,
                            size: 30.0,
                            color: Colors.greenAccent,
                          ),
                        ),
                      )),
          ),
        ),
      ),
    );
  }
}
