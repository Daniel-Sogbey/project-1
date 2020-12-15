import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../models/answer.dart';
import '../providers/auth.dart';

class AnswerItem extends StatefulWidget {
  @override
  _AnswerItemState createState() => _AnswerItemState();
}

class _AnswerItemState extends State<AnswerItem> {
  var _isChecked = false;
  var _isInit = true;
  var _isLoading = false;

  // @override
  // void didChangeDependencies() async {
  //   if (_isInit) {
  //     final authToken = Provider.of<Auth>(context, listen: false).token;
  //
  //     await Provider.of<Answer>(context, listen: false).getVotes(authToken);
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }
  // @override
  // void initState() {
  //   // setState(() {
  //   //   _isLoading = true;
  //   // });
  //   Future.delayed(Duration(seconds: 5)).then((_) async {
  //     final authToken = Provider.of<Auth>(context, listen: false).token;
  //
  //       await Provider.of<Answer>(context, listen: false).getVotes(authToken);
  //     // setState(() {
  //     //   _isLoading = false;
  //     // });
  //   });
  //   super.initState();
  // }

  // @override
  // void initState() {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   Future.delayed(Duration.zero).then((_) async {
  //     final authToken = Provider.of<Auth>(context, listen: false).token;
  //     await Provider.of<Answer>(context).getVotes(authToken);
  //
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   });
  //   super.initState();
  // }

  var authToken;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Future.delayed(Duration.zero).then((_) async {
        authToken = Provider.of<Auth>(context, listen: false).token;
        await Provider.of<Answer>(context, listen: false).getVotes(authToken);

        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  // Future<void> _refreshVotes() async {
  //   await Provider.of<Answer>(context).getVotes(authToken);
  // }

  @override
  Widget build(BuildContext context) {
    final answer = Provider.of<Answer>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return _isLoading
        ? Center(
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
          )
        : Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.black12,
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
                bottom: BorderSide(
                  color: Colors.black26,
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 5.0, top: 5.0, right: 5.0),
                      child: CircleAvatar(
                        radius: 30.0,
                        child: Text(
                          'DS',
                          style: kNameTextStyle,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Uni. of Cape Coast',
                        style: kInfoStyle,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          child: IconButton(
                            onPressed: () async {
                              await Provider.of<Answer>(context, listen: false)
                                  .upVote(authData.token);
                              // answer.acceptAnswer();
                              // answer.upVote();
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_up,
                              size: 30.0,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        Consumer<Answer>(
                          builder: (ctx, answer, _) => Container(
                            child: Text(
                              answer.votes.toString(),
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 12.0,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: IconButton(
                            onPressed: () async {
                              await Provider.of<Answer>(context, listen: false)
                                  .downVote(authData.token);
                              // answer.acceptAnswer();
                              // answer.upVote();
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              size: 30.0,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 60.0, right: 60.0, bottom: 10.0),
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        width: 1.0,
                        color: Colors.black12,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Text(
                      answer.answerText,
                      style: kPostTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
