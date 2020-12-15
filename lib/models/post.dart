import 'package:flutter/foundation.dart';

class Post {
  @required
  final String postId;
  @required
  String category;
  @required
  final String postText;
  final String creator;

  Post({this.postId, this.postText, this.category, this.creator});
}
