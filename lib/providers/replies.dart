import 'package:flutter/foundation.dart';

import '../models/reply.dart';

class Replies with ChangeNotifier {
  List<Reply> _replies = [
    Reply(replyId: 'r1', answerReplyId: 'ar1', replyText: 'Reply 1'),
    Reply(replyId: 'r2', answerReplyId: 'ar2', replyText: 'Reply 2'),
    Reply(replyId: 'r3', answerReplyId: 'ar3', replyText: 'Reply 3'),
    Reply(replyId: 'r4', answerReplyId: 'ar4', replyText: 'Reply 4'),
  ];

  List<Reply> get replies {
    return [..._replies];
  }

  List<Reply> findReplyToQuestion(String answerReplyId) {
    return _replies
        .where((reply) => reply.answerReplyId == answerReplyId)
        .toList();
  }

  void addReply(Reply reply) {
    final newReply = Reply(
      replyId: reply.replyId,
      answerReplyId: reply.answerReplyId,
      replyText: reply.replyText,
    );

    _replies.insert(0, newReply);
    notifyListeners();
  }
}
