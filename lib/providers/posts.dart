import 'package:flutter/foundation.dart';

import '../models/post.dart';

class Posts with ChangeNotifier {
  List<Post> _posts = [
    Post(
      postId: 'q1',
      postText: 'A particle has mass 10kg. Calculate the force on the'
          ' particle assuming it is at rest? Take g= 10m/s/s.',
      category: 'science',
    ),
    Post(
      postId: 'q2',
      postText: 'If there is an increase in the open sourcing of AI'
          ' and Machine Learning tools by giant companies like Google, do you think this'
          ' fields of technology will be taken for granted by the future generation?',
      category: 'technology',
    ),
    Post(
      postId: 'q3',
      postText:
          'What will happen if the two major parties in Ghana get the same number '
          'of votes in the general elections on the 7th of December this year?',
      category: 'politics',
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

  List<Post> availablePosts = [];
  Map<String, bool> filters = {
    'science': false,
    'life': false,
    'technology': false,
    'music': false,
    'politics': false,
    'religion': false,
    'society': false,
    'art': false,
    'sport': false,
    'entertainment': false,
  };

  void saveFilters(Map<String, bool> filterData) {
    filters = filterData;
    availablePosts = _posts.where((post) {
      if (post.category == 'science' && filterData['science']) {
        return true;
      }
      if (post.category == 'technology' && filterData['technology']) {
        return true;
      }
      if (post.category == 'politics' && filterData['politics']) {
        return true;
      }
      if (post.category == 'life' && filterData['life']) {
        return true;
      }
      if (post.category == 'religion' && filterData['religion']) {
        return true;
      }
      if (post.category == 'music' && filterData['music']) {
        return true;
      }
      if (post.category == 'art' && filterData['art']) {
        return true;
      }
      if (post.category == 'entertainment' && filterData['entertainment']) {
        return true;
      }
      if (post.category == 'sports' && filterData['sports']) {
        return true;
      }
      if (post.category == 'society' && filterData['society']) {
        return true;
      }
      return false;
    }).toList();
    print(filterData);
    notifyListeners();
  }
}
