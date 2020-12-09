import 'package:flutter/material.dart';
import 'package:project_1/constants/constants.dart';
import 'package:provider/provider.dart';

import '../models/answer.dart';
import '../providers/answers.dart';
import '../widgets/app-drawer.dart';
import '../widgets/app_header.dart';

class CreateAnswerScreen extends StatefulWidget {
  static const routeName = '/create-answers';

  @override
  _CreateAnswerScreenState createState() => _CreateAnswerScreenState();
}

class _CreateAnswerScreenState extends State<CreateAnswerScreen> {
  var _isInit = true;
  String postId;
  Answer _editedAnswer = Answer(
    answerId: null,
    answerText: '',
    questionAnswerId: '',
  );
  final _form = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    if (_isInit) {
      postId = ModalRoute.of(context).settings.arguments as String;
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  void _saveForm() {
    final _isValid = _form.currentState.validate();
    if (_isValid) {
      _form.currentState.save();
      // print('${_editedAnswer.answerId} from answer');
      // print(_editedAnswer.questionAnswerId);
      // print(_editedAnswer.answerText);
      Provider.of<Answers>(context, listen: false).addAnswer(_editedAnswer);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  _buildMenuBar(),
                  AppHeader(),
                ],
              ),
              Divider(),
              Container(
                margin: EdgeInsets.only(top: 30.0),
                padding: EdgeInsets.only(left: 30.0),
                child: Text(
                  'Waiting for your incredible answer',
                  style: kWaitingForAnswerTextStyle,
                ),
              ),
              Form(
                key: _form,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      padding: EdgeInsets.all(30.0),
                      child: TextFormField(
                        style: kAnswerTextInputStyle,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Provide an answer',
                          labelStyle: kAnswerLabelTextStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                              color: Colors.black26,
                              width: 1.5,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                        onSaved: (value) {
                          _editedAnswer = Answer(
                            answerId: _editedAnswer.answerId,
                            questionAnswerId: postId,
                            answerText: value,
                          );
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter an answer before sending.';
                          }

                          if (value.length <= 0) {
                            return 'Answer too short';
                          }

                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 30.0),
                child: InkWell(
                  onTap: _saveForm,
                  child: Text(
                    'Send',
                    style: kSendAnswerTextStyle,
                  ),
                ),
              ),
            ],
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
