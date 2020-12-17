import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/post.dart';

class Posts with ChangeNotifier {
  List<Post> _posts = [
    // Post(
    //   postId: 'q1',
    //   postText:
    //       'A particle has mass 10kg. Calculate the force'
    //           ' on the particle assuming it is at rest? '
    //           'Take g= 10m/s/s.',
    //   category: 'science',
    // ),
    // Post(
    //   postId: 'q2',
    //   postText:
    //       'If there is an increase in the open sourcing of AI and Machine Learning tools by giant companies like Google, do you think this fields of technology will be taken for granted by the future generation?',
    //   category: 'technology',
    // ),
    // Post(
    //   postId: 'q3',
    //   postText:
    //       'What will happen if the two major parties in Ghana get the same '
    //       'number of votes in the general elections'
    //       ' on the 7th of December this year?',
    //   category: 'politics',
    // ),
    // Post(
    //   postId: 'q3',
    //   postText: 'With the rise in hip hop and dance hall music '
    //       'do you think this generation is forgetting about'
    //       ' our local music and how to effectively practise '
    //       'our cultural songs and dances?',
    //   category: 'society',
    // ),
  ];

  String authToken;
  String userId;
  String email;

  Posts(this.authToken, this.userId, this._posts, this.email);

  //

  List<Post> get posts {
    return [..._posts];
  }

  Post findPostById(String postId) {
    return _posts.firstWhere((post) => post.postId == postId);
  }

  Map<String, dynamic> filters = {
    'science': false,
    'life': false,
    'technology': false,
    'music': false,
    'politics': false,
    'religion': false,
    'society': false,
    'art': false,
    'sports': false,
    'entertainment': false,
    'movies': false,
    'engineering': false,
    'education': false,
  };

  Future<void> getSearchForPosts(String searchTerm) async {
    final url =
        'https://solveshare-7acaf-default-rtdb.firebaseio.com/posts.json?auth=$authToken';

    if (searchTerm == '' || searchTerm == null) {
      fetchPosts();
      print('$searchTerm   searchTerm empty');
      print(_posts);
      return _posts;
    }

    try {
      final response = await http.get(url);

      final data = json.decode(response.body) as Map<String, dynamic>;
      List<Post> searchedPosts = [];

      data.forEach((postId, searchedPost) {
        if ((searchedPost['category'] as String)
                .toLowerCase()
                .contains(searchTerm.toLowerCase()) ||
            (searchedPost['postText'] as String)
                .toLowerCase()
                .contains(searchTerm)) {
          searchedPosts.insert(
            0,
            Post(
              postId: postId,
              category: searchedPost['category'],
              postText: searchedPost['postText'],
              creator: searchedPost['creator'],
            ),
          );
        }
      });

      _posts = searchedPosts;
      notifyListeners();
      print('$_posts  from getSearchForPosts');
    } catch (error) {
      throw error;
    }

    // searchedPosts = _posts.where((post) {
    //   return post.category.toLowerCase().contains(searchTerm.toLowerCase());
    // }).toList();
  }

  Future<void> fetchPosts([bool userPosts = false]) async {
    //&orderBy="creatorId"&equalTo="$userId"
    final appendedString =
        userPosts ? 'orderBy="creatorId"&equalTo="$userId"' : '';

    final url =
        'https://solveshare-7acaf-default-rtdb.firebaseio.com/posts.json?auth=$authToken&$appendedString';

    try {
      final response = await http.get(url);
      // print('${json.decode(response.body)} auuutththt  1');
      final postsData = json.decode(response.body) as Map<String, dynamic>;
      // print('$postsData auutttttttttttthhhhhhhhh 2');
      if (postsData == null) {
        return;
      }
      final List<Post> loadedPosts = [];
      postsData.forEach((postId, singlePostData) {
        loadedPosts.insert(
          0,
          Post(
            postId: postId,
            postText: singlePostData['postText'],
            category: singlePostData['category'],
            creator: singlePostData['creatorId'],
          ),
        );
      });

      _posts = loadedPosts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchPostsBasedOnFilters() async {
    final urlI =
        'https://solveshare-7acaf-default-rtdb.firebaseio.com/filters/filterId/filters.json?auth=$authToken';

    final response = await http.get(urlI);
    // List<Post> availablePosts = [];

    filters = json.decode(response.body) as Map<String, dynamic>;
    final url =
        'https://solveshare-7acaf-default-rtdb.firebaseio.com/posts.json?auth=$authToken';

    try {
      final response = await http.get(url);
      final postsData = json.decode(response.body) as Map<String, dynamic>;

      if (postsData == null) {
        return;
      }
      final List<Post> loadedPosts = [];
      postsData.forEach(
        (postId, singlePostData) {
          if (singlePostData['category'] == 'science' && filters['science']) {
            loadedPosts.insert(
              0,
              Post(
                postId: postId,
                postText: singlePostData['postText'],
                category: singlePostData['category'],
              ),
            );
            // http.post(
            //   urlForInterests,
            //   body: json.encode(
            //     {
            //       'postId': post.postId,
            //       'category': post.category,
            //       'postText': post.postText,
            //     },
            //   ),
            // );
            return true;
          }
          if (singlePostData['category'] == 'technology' &&
              filters['technology']) {
            loadedPosts.insert(
              0,
              Post(
                postId: postId,
                postText: singlePostData['postText'],
                category: singlePostData['category'],
              ),
            );
            // http.post(
            //   urlForInterests,
            //   body: json.encode(
            //     {
            //       'postId': post.postId,
            //       'category': post.category,
            //       'postText': post.postText,
            //     },
            //   ),
            // );
            return true;
          }
          if (singlePostData['category'] == 'politics' && filters['politics']) {
            loadedPosts.insert(
              0,
              Post(
                postId: postId,
                postText: singlePostData['postText'],
                category: singlePostData['category'],
              ),
            );
            // http.post(
            //   urlForInterests,
            //   body: json.encode(
            //     {
            //       'postId': post.postId,
            //       'category': post.category,
            //       'postText': post.postText,
            //     },
            //   ),
            // );
            return true;
          }
          if (singlePostData['category'] == 'life' && filters['life']) {
            loadedPosts.insert(
              0,
              Post(
                postId: postId,
                postText: singlePostData['postText'],
                category: singlePostData['category'],
              ),
            );
            // http.post(
            //   urlForInterests,
            //   body: json.encode(
            //     {
            //       'postId': post.postId,
            //       'category': post.category,
            //       'postText': post.postText,
            //     },
            //   ),
            // );
            return true;
          }
          if (singlePostData['category'] == 'religion' && filters['religion']) {
            loadedPosts.insert(
              0,
              Post(
                postId: postId,
                postText: singlePostData['postText'],
                category: singlePostData['category'],
              ),
            );
            // http.post(
            //   urlForInterests,
            //   body: json.encode(
            //     {
            //       'postId': post.postId,
            //       'category': post.category,
            //       'postText': post.postText,
            //     },
            //   ),
            // );
            return true;
          }
          if (singlePostData['category'] == 'music' && filters['music']) {
            loadedPosts.insert(
              0,
              Post(
                postId: postId,
                postText: singlePostData['postText'],
                category: singlePostData['category'],
              ),
            );
            // http.post(
            //   urlForInterests,
            //   body: json.encode(
            //     {
            //       'postId': post.postId,
            //       'category': post.category,
            //       'postText': post.postText,
            //     },
            //   ),
            // );
            return true;
          }
          if (singlePostData['category'] == 'art' && filters['art']) {
            loadedPosts.insert(
              0,
              Post(
                postId: postId,
                postText: singlePostData['postText'],
                category: singlePostData['category'],
              ),
            );
            // http.post(
            //   urlForInterests,
            //   body: json.encode(
            //     {
            //       'postId': post.postId,
            //       'category': post.category,
            //       'postText': post.postText,
            //     },
            //   ),
            // );
            return true;
          }
          if (singlePostData['category'] == 'entertainment' &&
              filters['entertainment']) {
            loadedPosts.insert(
              0,
              Post(
                postId: postId,
                postText: singlePostData['postText'],
                category: singlePostData['category'],
              ),
            );
            // http.post(
            //   urlForInterests,
            //   body: json.encode(
            //     {
            //       'postId': post.postId,
            //       'category': post.category,
            //       'postText': post.postText,
            //     },
            //   ),
            // );
            return true;
          }
          if (singlePostData['category'] == 'sports' && filters['sports']) {
            loadedPosts.insert(
              0,
              Post(
                postId: postId,
                postText: singlePostData['postText'],
                category: singlePostData['category'],
              ),
            );
            // http.post(
            //   urlForInterests,
            //   body: json.encode(
            //     {
            //       'postId': post.postId,
            //       'category': post.category,
            //       'postText': post.postText,
            //     },
            //   ),
            // );
            return true;
          }
          if (singlePostData['category'] == 'society' && filters['society']) {
            loadedPosts.insert(
              0,
              Post(
                postId: postId,
                postText: singlePostData['postText'],
                category: singlePostData['category'],
              ),
            );
            // http.post(
            //   urlForInterests,
            //   body: json.encode(
            //     {
            //       'postId': post.postId,
            //       'category': post.category,
            //       'postText': post.postText,
            //     },
            //   ),
            // );
            return true;
          }
          if (singlePostData['category'] == 'movies' && filters['movies']) {
            loadedPosts.insert(
              0,
              Post(
                postId: postId,
                postText: singlePostData['postText'],
                category: singlePostData['category'],
              ),
            );
            // http.post(
            //   urlForInterests,
            //   body: json.encode(
            //     {
            //       'postId': post.postId,
            //       'category': post.category,
            //       'postText': post.postText,
            //     },
            //   ),
            // );
            return true;
          }
          if (singlePostData['category'] == 'education' &&
              filters['education']) {
            loadedPosts.insert(
              0,
              Post(
                postId: postId,
                postText: singlePostData['postText'],
                category: singlePostData['category'],
              ),
            );
            // http.post(
            //   urlForInterests,
            //   body: json.encode(
            //     {
            //       'postId': post.postId,
            //       'category': post.category,
            //       'postText': post.postText,
            //     },
            //   ),
            // );
            return true;
          }
          if (singlePostData['category'] == 'engineering' &&
              filters['engineering']) {
            loadedPosts.insert(
              0,
              Post(
                postId: postId,
                postText: singlePostData['postText'],
                category: singlePostData['category'],
              ),
            );
            // http.post(
            //   urlForInterests,
            //   body: json.encode(
            //     {
            //       'postId': post.postId,
            //       'category': post.category,
            //       'postText': post.postText,
            //     },
            //   ),
            // );
            return true;
          }

          // print(post);
          // http.post(
          //   urlForInterests,
          //   body:json.encode()
          // );

          return false;
        },
      );
      _posts = loadedPosts;
      notifyListeners();
      print(json.decode(response.body));
      print(loadedPosts);
    } catch (error) {
      throw error;
    }
  }

  Future<void> addPost(Post post) async {
    final url =
        'https://solveshare-7acaf-default-rtdb.firebaseio.com/posts.json?auth=$authToken';

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'postId': post.postId,
            'category': post.category,
            'postText': post.postText,
            'creatorId': userId,
          },
        ),
      );
      final newPost = Post(
        postId: json.decode(response.body)['name'],
        category: post.category,
        postText: post.postText,
        creator: email,
      );
      _posts.insert(0, newPost);
      print(newPost.postId);
      print(post.category);
      print(post.postText);
      print(newPost.creator);

      print('$email email');
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updatePost(String postId, Post newPost) async {
    final postIndex = _posts.indexWhere((post) => post.postId == postId);
    final url =
        'https://solveshare-7acaf-default-rtdb.firebaseio.com/posts/$postId.json?auth=$authToken';
    if (postIndex >= 0) {
      try {
        await http.patch(
          url,
          body: json.encode(
            {
              'postId': newPost.postId,
              'category': newPost.category,
              'postText': newPost.postText,
            },
          ),
        );
        _posts[postIndex] = newPost;
        notifyListeners();
        print(postIndex);
      } catch (error) {
        throw error;
      }
    }
  }

  Future<void> deletePost(String postId) async {
    final url =
        'https://solveshare-7acaf-default-rtdb.firebaseio.com/posts/$postId.json?auth=$authToken';

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        _posts.removeWhere((post) => post.postId == postId);
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  List<Post> availablePosts = [];

  // Map<String, dynamic> filters = {
  //   'science': false,
  //   'life': false,
  //   'technology': false,
  //   'music': false,
  //   'politics': false,
  //   'religion': false,
  //   'society': false,
  //   'art': false,
  //   'sports': false,
  //   'entertainment': false,
  //   'movies': false,
  //   'engineering': false,
  //   'education': false,
  // };

  // Future<void> fetchInterests() async {
  //   // Map<String, dynamic> filters = {
  //   //   'science': false,
  //   //   'life': false,
  //   //   'technology': false,
  //   //   'music': false,
  //   //   'politics': false,
  //   //   'religion': false,
  //   //   'society': false,
  //   //   'art': false,
  //   //   'sports': false,
  //   //   'entertainment': false,
  //   //   'movies': false,
  //   //   'engineering': false,
  //   //   'education': false,
  //   // };
  //   const url =
  //       'https://solveshare-7acaf-default-rtdb.firebaseio.com/filters.json';
  //
  //   final response = await http.get(url);
  //   // List<Post> availablePosts = [];
  //
  //   filters = json.decode(response.body) as Map<String, dynamic>;
  //
  //   // _posts.forEach((post) { });
  //
  //   availablePosts = _posts.where((post) {
  //     if (post.category == 'science' && filters['science']) {
  //       // http.post(
  //       //   urlForInterests,
  //       //   body: json.encode(
  //       //     {
  //       //       'postId': post.postId,
  //       //       'category': post.category,
  //       //       'postText': post.postText,
  //       //     },
  //       //   ),
  //       // );
  //       return true;
  //     }
  //     if (post.category == 'technology' && filters['technology']) {
  //       // http.post(
  //       //   urlForInterests,
  //       //   body: json.encode(
  //       //     {
  //       //       'postId': post.postId,
  //       //       'category': post.category,
  //       //       'postText': post.postText,
  //       //     },
  //       //   ),
  //       // );
  //       return true;
  //     }
  //     if (post.category == 'politics' && filters['politics']) {
  //       // http.post(
  //       //   urlForInterests,
  //       //   body: json.encode(
  //       //     {
  //       //       'postId': post.postId,
  //       //       'category': post.category,
  //       //       'postText': post.postText,
  //       //     },
  //       //   ),
  //       // );
  //       return true;
  //     }
  //     if (post.category == 'life' && filters['life']) {
  //       // http.post(
  //       //   urlForInterests,
  //       //   body: json.encode(
  //       //     {
  //       //       'postId': post.postId,
  //       //       'category': post.category,
  //       //       'postText': post.postText,
  //       //     },
  //       //   ),
  //       // );
  //       return true;
  //     }
  //     if (post.category == 'religion' && filters['religion']) {
  //       // http.post(
  //       //   urlForInterests,
  //       //   body: json.encode(
  //       //     {
  //       //       'postId': post.postId,
  //       //       'category': post.category,
  //       //       'postText': post.postText,
  //       //     },
  //       //   ),
  //       // );
  //       return true;
  //     }
  //     if (post.category == 'music' && filters['music']) {
  //       // http.post(
  //       //   urlForInterests,
  //       //   body: json.encode(
  //       //     {
  //       //       'postId': post.postId,
  //       //       'category': post.category,
  //       //       'postText': post.postText,
  //       //     },
  //       //   ),
  //       // );
  //       return true;
  //     }
  //     if (post.category == 'art' && filters['art']) {
  //       // http.post(
  //       //   urlForInterests,
  //       //   body: json.encode(
  //       //     {
  //       //       'postId': post.postId,
  //       //       'category': post.category,
  //       //       'postText': post.postText,
  //       //     },
  //       //   ),
  //       // );
  //       return true;
  //     }
  //     if (post.category == 'entertainment' && filters['entertainment']) {
  //       // http.post(
  //       //   urlForInterests,
  //       //   body: json.encode(
  //       //     {
  //       //       'postId': post.postId,
  //       //       'category': post.category,
  //       //       'postText': post.postText,
  //       //     },
  //       //   ),
  //       // );
  //       return true;
  //     }
  //     if (post.category == 'sports' && filters['sports']) {
  //       // http.post(
  //       //   urlForInterests,
  //       //   body: json.encode(
  //       //     {
  //       //       'postId': post.postId,
  //       //       'category': post.category,
  //       //       'postText': post.postText,
  //       //     },
  //       //   ),
  //       // );
  //       return true;
  //     }
  //     if (post.category == 'society' && filters['society']) {
  //       // http.post(
  //       //   urlForInterests,
  //       //   body: json.encode(
  //       //     {
  //       //       'postId': post.postId,
  //       //       'category': post.category,
  //       //       'postText': post.postText,
  //       //     },
  //       //   ),
  //       // );
  //       return true;
  //     }
  //     if (post.category == 'movies' && filters['movies']) {
  //       // http.post(
  //       //   urlForInterests,
  //       //   body: json.encode(
  //       //     {
  //       //       'postId': post.postId,
  //       //       'category': post.category,
  //       //       'postText': post.postText,
  //       //     },
  //       //   ),
  //       // );
  //       return true;
  //     }
  //     if (post.category == 'education' && filters['education']) {
  //       // http.post(
  //       //   urlForInterests,
  //       //   body: json.encode(
  //       //     {
  //       //       'postId': post.postId,
  //       //       'category': post.category,
  //       //       'postText': post.postText,
  //       //     },
  //       //   ),
  //       // );
  //       return true;
  //     }
  //     if (post.category == 'engineering' && filters['engineering']) {
  //       // http.post(
  //       //   urlForInterests,
  //       //   body: json.encode(
  //       //     {
  //       //       'postId': post.postId,
  //       //       'category': post.category,
  //       //       'postText': post.postText,
  //       //     },
  //       //   ),
  //       // );
  //       return true;
  //     }
  //
  //     // print(post);
  //     // http.post(
  //     //   urlForInterests,
  //     //   body:json.encode()
  //     // );
  //
  //     return false;
  //   }).toList();
  //
  //   // availablePosts = _posts;
  //   // _posts = availablePosts;
  //   notifyListeners();
  //   // print(availablePosts);
  // }

  Future<void> saveFilters(Map<String, bool> filterData) async {
    final url =
        'https://solveshare-7acaf-default-rtdb.firebaseio.com/filters/filterId/filters.json?auth=$authToken';

    const urlForInterests =
        'https://solveshare-7acaf-default-rtdb.firebaseio.com/interests.json';

    // filters = filterData;
    // filterData = filters;
    http.patch(
      url,
      body: json.encode(
        {
          'science': filterData['science'],
          'life': filterData['life'],
          'technology': filterData['technology'],
          'music': filterData['music'],
          'politics': filterData['politics'],
          'religion': filterData['religion'],
          'society': filterData['society'],
          'art': filterData['art'],
          'sports': filterData['sports'],
          'entertainment': filterData['entertainment'],
          'movies': filterData['movies'],
          'engineering': filterData['engineering'],
          'education': filterData['education'],
        },
      ),
    );

    // print(filters);
    notifyListeners();
  }
}
