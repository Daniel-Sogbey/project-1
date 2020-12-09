import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../models/answer.dart';

class AnswerItem extends StatefulWidget {
  @override
  _AnswerItemState createState() => _AnswerItemState();
}

class _AnswerItemState extends State<AnswerItem> {
  var _isChecked = false;

  @override
  Widget build(BuildContext context) {
    final answer = Provider.of<Answer>(context);
    return Container(
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
                      onPressed: () {
                        answer.acceptAnswer();
                      },
                      icon: Icon(
                        answer.isAccepted
                            ? Icons.check_circle
                            : Icons.check_circle_outline,
                        size: 30.0,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  // Consumer<Answer>(
                  //   builder: (ctx, answer, child) => Container(
                  //     child: Text(
                  //       answer.count.toString(),
                  //       style: kCheckCountTextStyle,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 60.0, right: 60.0, bottom: 10.0),
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
