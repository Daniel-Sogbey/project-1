import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/replies.dart';

class RepliesScreen extends StatelessWidget {
  static const routeName = '/replies';

  @override
  Widget build(BuildContext context) {
    final answerId = ModalRoute.of(context).settings.arguments as String;

    final replies = Provider.of<Replies>(context).findReplyToQuestion(answerId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Replies Screen'),
      ),
      body: ListView.builder(
        itemCount: replies.length,
        itemBuilder: (ctx, i) => Text(replies[i].replyText),
      ),
    );
  }
}
