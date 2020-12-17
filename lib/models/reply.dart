import 'package:flutter/foundation.dart';

class Reply {
  @required
  final String replyId;
  @required
  final String answerReplyId;
  @required
  final String replyText;

  Reply({this.replyId, this.answerReplyId, this.replyText});
}
