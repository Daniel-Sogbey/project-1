import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/answers.dart';
import '../widgets/answer_item.dart';
import '../widgets/app-drawer.dart';
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
      drawer: AppDrawer(),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _buildMenuBar(),
                    AppHeader(),
                  ],
                ),
                // ListView.builder(
                //   itemCount: answers.length,
                //   itemBuilder: (ctx, i) => Text(answers[i].answerText),
                // ),
                Divider(),
                answers.length == 0
                    ? Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 60.0),
                            child: Center(
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
                                  child: Container(
                                    child: AnswerItem(),
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
