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
  var _isLiking = false;
  var _showReplies = false;
  var _isLiked = false;

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
  // var answerId;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Future.delayed(Duration.zero).then((_) async {
        authToken = Provider.of<Auth>(context, listen: false).token;
        // await Provider.of<Answer>(context, listen: false).getVotes(authToken);
        // answerId = Provider.of<Answer>(context).answerId;
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

  // void _addNewReply(BuildContext context, answer) {
  //   Navigator.of(context).pushNamed(
  //     RepliesScreen.routeName,
  //     arguments: answer.answerId,
  //   );
  //
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (_) => RepliesScreen(),
  //     // isScrollControlled: true,
  //     isDismissible: true,
  //     enableDrag: true,
  //     backgroundColor: Colors.white,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final answer = Provider.of<Answer>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return _isLoading
        ? Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
              heightFactor: 1.0,
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
        : Container(
            width: double.infinity,
            // decoration: BoxDecoration(
            //   border: Border(
            //     bottom: BorderSide(
            //       color: Colors.black26,
            //       width: 1.0,
            //       style: BorderStyle.solid,
            //     ),
            //   ),
            // ),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 5.0, top: 5.0),
                      width: 60.0,
                      height: 60.0,
                      alignment: Alignment.center,
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
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.only(left: 5.0, top: 5.0, right: 5.0),
                      child: Text(
                        answer.creator == null
                            ? 'A'
                            : answer.creator
                                .replaceRange(10, answer.creator.length, '...'),
                        style: kNameTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        answer.creator == null
                            ? 'Anonymous'
                            : answer.creator
                                .replaceRange(10, answer.creator.length, '...'),
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.blue,
                          fontWeight: FontWeight.w900,
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[],
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    answer.answerText,
                    style: kPostTextStyle,
                  ),
                ),
                Center(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Consumer<Answer>(
                          builder: (ctx, answer, _) => Container(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              answer.votes == 1
                                  ? '${answer.votes.toString()} like'
                                  : '${answer.votes.toString()} likes',
                              style: kLikeTextStyle,
                            ),
                            // Text(
                            //   answer.votes.toString(),
                            //   style: TextStyle(
                            //     fontFamily: 'Montserrat',
                            //     fontSize: 10.0,
                            //     fontWeight: FontWeight.w900,
                            //     letterSpacing: 1.0,
                            //     color: Colors.white,
                            //   ),
                            // ),
                          ),
                        ),
                        Card(
                          elevation: 2.0,
                          margin:
                              EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0),
                          child: Container(
                            child: IconButton(
                              onPressed: _isLiking
                                  ? null
                                  : () async {
                                      setState(() {
                                        _isLiking = true;
                                      });
                                      answer.isFav == false
                                          ? await Provider.of<Answer>(context,
                                                  listen: false)
                                              .upVote(authData.token,
                                                  authData.userId)
                                              .then((_) {
                                              setState(() {
                                                _isLiking = false;
                                              });
                                            })
                                          : await Provider.of<Answer>(context,
                                                  listen: false)
                                              .downVote(authData.token,
                                                  authData.userId)
                                              .then((_) {
                                              setState(() {
                                                _isLiking = false;
                                              });
                                            });
                                      // answer.acceptAnswer();
                                      // answer.upVote();
                                    },
                              icon: Consumer<Answer>(
                                builder: (ctx, answer, _) => answer.isFav
                                    ? _isLiking
                                        ? Container(
                                            child: Center(
                                              heightFactor: 2.0,
                                              widthFactor: 2,
                                              child: Container(
                                                width: 30.0,
                                                child: LoadingIndicator(
                                                  indicatorType:
                                                      Indicator.ballPulse,
                                                  color: Colors.amber,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Icon(
                                            Icons.favorite,
                                            size: 20.0,
                                            color: Colors.greenAccent,
                                          )
                                    : Icon(
                                        Icons.favorite_border,
                                        size: 20.0,
                                        color: Colors.black26,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // if (_showReplies)
                //   Container(
                //     child: Column(
                //       children: replies
                //           .map((reply) => Text(reply.replyText))
                //           .toList(),
                //     ),
                //   ),
              ],
            ),
          );
  }
}
