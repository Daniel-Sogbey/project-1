import 'package:flutter/foundation.dart';

class Post {
  @required
  final String postId;
  @required
  String category;
  @required
  final String postText;

  Post({this.postId, this.postText, this.category});
}
