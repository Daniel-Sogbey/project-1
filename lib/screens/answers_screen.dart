import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/answers.dart';
import '../widgets/answer_item.dart';
import '../widgets/app_header.dart';

class AnswersScreen extends StatefulWidget {
  static const routeName = '/answers';

  @override
  _AnswersScreenState createState() => _AnswersScreenState();
}

class _AnswersScreenState extends State<AnswersScreen> {
  @override
  Widget build(BuildContext context) {
    final questionAnswerId =
        ModalRoute.of(context).settings.arguments as String;
    final answers =
        Provider.of<Answers>(context).findAnswersByQuestionId(questionAnswerId);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    AppHeader(),
                  ],
                ),
                // ListView.builder(
                //   itemCount: answers.length,
                //   itemBuilder: (ctx, i) => Text(answers[i].answerText),
                // ),
                Card(
                  margin: EdgeInsets.only(
                    top: 5.0,
                    left: 5.0,
                    right: 5.0,
                    bottom: 5.0,
                  ),
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          // Colors.pinkAccent,
                          // Colors.amber,
                          // Colors.blue,
                          Color.fromRGBO(215, 17, 225, 1).withOpacity(0.6),
                          Color.fromRGBO(255, 188, 17, 1).withOpacity(0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0, 1],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Comments',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Divider(),
                answers.length == 0
                    ? Column(
                        children: [
                          Card(
                            elevation: 6.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(30.0),
                              child: Text(
                                'Wait a little , answers are on their way.',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w900,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          // Container(
                          //   width: double.infinity,
                          //   margin: EdgeInsets.all(30),
                          //   child: Image.asset(
                          //     'images/wait.png',
                          //     fit: BoxFit.cover,
                          //     // color: Colors.transparent,
                          //   ),
                          // ),
                        ],
                      )
                    : Container(
                        child: Column(
                          children: answers
                              .map(
                                (answer) => ChangeNotifierProvider.value(
                                  value: answer,
                                  child: Column(
                                    children: [
                                      Divider(),
                                      AnswerItem(),
                                      Divider(),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      )
              ],
            ),
          ),
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
