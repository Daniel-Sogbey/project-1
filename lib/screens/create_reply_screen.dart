import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../models/reply.dart';
import '../providers/replies.dart';

class CreateReplyScreen extends StatefulWidget {
  static const routeName = '/create-reply';

  @override
  _CreateReplyScreenState createState() => _CreateReplyScreenState();
}

class _CreateReplyScreenState extends State<CreateReplyScreen> {
  var _isInit = true;
  String answerId;
  Reply _editedReply = Reply(replyId: null, answerReplyId: '', replyText: '');
  final _form = GlobalKey<FormState>();
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      answerId = ModalRoute.of(context).settings.arguments as String;
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _saveForm() async {
    FocusScope.of(context).requestFocus(FocusNode());
    final _isValid = _form.currentState.validate();
    if (_isValid) {
      _form.currentState.save();
      Provider.of<Replies>(context, listen: false).addReply(_editedReply);
      Navigator.of(context).pop();
      print(_editedReply.replyId);
      print(_editedReply.answerReplyId);
      print(_editedReply.replyText);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(215, 17, 225, 1).withOpacity(0.6),
              Color.fromRGBO(255, 188, 17, 1).withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 1],
          ),
        ),
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
                    'Waiting for your incredible reply',
                    style: kWaitingForAnswerTextStyle,
                  ),
                ),
                _isLoading
                    ? Center(
                        heightFactor: 4.0,
                        widthFactor: 4,
                        child: Container(
                          width: 150.0,
                          height: 130.0,
                          child: LoadingIndicator(
                            indicatorType: Indicator.orbit,
                            color: Colors.pinkAccent,
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
                                          labelText: 'reply',
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
                                        onEditingComplete: () {
                                          _saveForm();
                                        },
                                        keyboardType: TextInputType.multiline,
                                        onSaved: (value) {
                                          _editedReply = Reply(
                                            replyId: _editedReply.replyId,
                                            replyText: value,
                                            answerReplyId: answerId,
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
                                          Text('Reply',
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
