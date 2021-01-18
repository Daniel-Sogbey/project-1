import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../models/answer.dart';
import '../providers/answers.dart';

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
    votes: 0,
  );
  final _form = GlobalKey<FormState>();
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      postId = ModalRoute.of(context).settings.arguments as String;
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _saveForm() async {
    final _isValid = _form.currentState.validate();
    if (_isValid) {
      _form.currentState.save();
      // print('${_editedAnswer.answerId} from answer');
      // print(_editedAnswer.questionAnswerId);
      // print(_editedAnswer.answerText);
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<Answers>(context, listen: false)
            .addAnswer(_editedAnswer);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(
              'Ooooopps error occurred',
              style: kErrorOccurredTextStyle,
            ),
            content: Text(
              'Make your you are connected to the internet',
              style: kErrorOccurredContentTextStyle,
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  'Okay',
                  style: kOkayDismissTextStyle,
                ),
                splashColor: Colors.amber,
                padding: EdgeInsets.all(10.0),
              ),
            ],
          ),
        );
      } finally {
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).pop();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        // decoration: BoxDecoration(
        // gradient: LinearGradient(
        // colors: [
        // Colors.pinkAccent,
        // Colors.amber,
        // Colors.blue,
        // Color.fromRGBO(215, 17, 225, 1).withOpacity(0.6),
        // Color.fromRGBO(255, 188, 17, 1).withOpacity(0.9),
        // ],
        // begin: Alignment.topLeft,
        // end: Alignment.bottomRight,
        // stops: [0, 1],
        // ),
        // ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 30.0,
                ),
                Container(
                  margin: EdgeInsets.only(top: 30.0),
                  padding: EdgeInsets.only(left: 30.0),
                  child: Text(
                    'Waiting for your incredible comment',
                    style: kWaitingForAnswerTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                _isLoading
                    ? Center(
                        heightFactor: 4.0,
                        child: Container(
                          height: 50.0,
                          child: LoadingIndicator(
                            indicatorType: Indicator.ballBeat,
                            color: Colors.amber,
                          ),
                        ),
                      )
                    : Card(
                        elevation: 10.0,
                        margin: EdgeInsets.all(5.0),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            children: <Widget>[
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
                                          labelText: 'comment',
                                          labelStyle: kAnswerLabelTextStyle,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
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
                                            votes: _editedAnswer.votes,
                                          );
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please type in an answer before sending.';
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
                              Card(
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                margin: EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10.0,
                                ),
                                color: Colors.greenAccent,
                                child: Container(
                                  width: 300,
                                  child: InkWell(
                                    onTap: _saveForm,
                                    splashColor: Colors.black12,
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        left: 5.0,
                                        right: 0.0,
                                        top: 5.0,
                                      ),
                                      padding: EdgeInsets.only(
                                          left: 10.0,
                                          right: 10.0,
                                          top: 10.0,
                                          bottom: 15.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            // Icons.send,
                                            FontAwesomeIcons.rocket,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text('Comment',
                                              style: kSubmitQuestionTextStyle),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
