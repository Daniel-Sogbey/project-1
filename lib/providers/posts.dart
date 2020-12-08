import 'package:flutter/foundation.dart';

import '../models/post.dart';

class Posts with ChangeNotifier {
  List<Post> _posts = [
    Post(
      postId: 'q1',
      postText: 'A particle has mass 10kg. Calculate the force on the'
          ' particle assuming it is at rest? Take g= 10m/s/s.',
      category: 'Science',
    ),
    Post(
      postId: 'q2',
      postText: 'If there is an increase in the open sourcing of AI'
          ' and Machine Learning tools by giant companies like Google, do you think this'
          ' fields of technology will be taken for granted by the future generation?',
      category: 'Technology',
    ),
    Post(
      postId: 'q3',
      postText:
          'What will happen if the two major parties in Ghana get the same number '
          'of votes in the general elections on the 7th of December this year?',
      category: 'Politics',
    ),
  ];

  //

  List<Post> get posts {
    return [..._posts];
  }

  Post findPostById(String postId) {
    return _posts.firstWhere((post) => post.postId == postId);
  }

  void addPost(Post post) {
    final newPost = Post(
      postId: DateTime.now().toString(),
      category: post.category,
      postText: post.postText,
    );
    _posts.insert(0, newPost);
    print(post.postId);
    print(post.category);
    print(post.postText);
    notifyListeners();
  }

  void updatePost(String postId, Post newPost) {
    final postIndex = _posts.indexWhere((post) => post.postId == postId);
    if (postIndex >= 0) {
      _posts[postIndex] = newPost;
      notifyListeners();
      print(postIndex);
    }
  }

  void deletePost(String postId) {
    _posts.removeWhere((post) => post.postId == postId);
    notifyListeners();
  }
}
