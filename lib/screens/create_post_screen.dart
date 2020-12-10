import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../models/post.dart';
import '../providers/posts.dart';
import '../widgets/app-drawer.dart';
import '../widgets/app_header.dart';

class CreatePostScreen extends StatefulWidget {
  static const routeName = '/create-post';

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  // var _post = Post(
  //   postId: null,
  //   postText: '',
  //   category: '',
  // );

  var category = 'science';

  var _categories = <String>[
    'science',
    'education'
        'technology',
    'life',
    'religion',
    'engineering',
    'music',
    'society',
    'art',
    'movies',
    'entertainment',
    'sports',
    'politics',
  ];

  Post _editedPost = Post(
    postId: null,
    postText: '',
    category: '',
  );
  final _form = GlobalKey<FormState>();
  var _isInit = true;
  var _initValues = {'category': '', 'postText': ''};
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final postId = ModalRoute.of(context).settings.arguments as String;
      if (postId != null) {
        _editedPost =
            Provider.of<Posts>(context, listen: false).findPostById(postId);
        _initValues = {
          'category': _editedPost.category,
          'postText': _editedPost.postText,
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    // print('${_editedPost.postId} from post');
    setState(() {
      _isLoading = true;
    });

    if (_editedPost.postId != null) {
      Provider.of<Posts>(context, listen: false).updatePost(
        _editedPost.postId,
        _editedPost,
      );
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });

        Navigator.of(context).pop();
      });
    } else {
      try {
        await Provider.of<Posts>(context, listen: false).addPost(_editedPost);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(
              'Ooooppps error occurred',
              style: kErrorOccurredTextStyle,
            ),
            content: Text('Kindly make sure you are connected to the internet'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  'Okay',
                  style: kOkayDismissTextStyle,
                ),
                splashColor: Colors.amber,
                padding: EdgeInsets.all(10.0),
              ),
            ],
          ),
        );
      } finally {
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _isLoading = false;
          });

          Navigator.of(context).pop();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  _buildMenuBar(),
                  AppHeader(),
                ],
              ),
              Divider(),
              _isLoading
                  ? Center(
                      heightFactor: 4.0,
                      widthFactor: 2,
                      child: Container(
                        width: 150.0,
                        height: 130.0,
                        child: LoadingIndicator(
                          indicatorType: Indicator.orbit,
                          color: Colors.pinkAccent,
                        ),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.all(30.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(bottom: 5.0),
                              child: Text(
                                'Kindly select a category :',
                                style: kSelectCategoryTextStyle,
                              ),
                            ),
                            Form(
                              key: _form,
                              child: Column(
                                children: [
                                  DropdownButtonFormField(
                                    value: category,
                                    onSaved: (selectedCategory) {
                                      _editedPost = Post(
                                        category: selectedCategory,
                                        postText: _editedPost.postText,
                                        postId: _editedPost.postId,
                                      );
                                    },
                                    onChanged: (selectedCategory) {
                                      setState(() {
                                        category = selectedCategory;
                                        print(category);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.arrow_downward,
                                      color: Colors.black54,
                                    ),
                                    // style: TextStyle(
                                    //   color: Colors.deepPurple,
                                    //   fontSize: 25.0,
                                    // ),
                                    // decoration: InputDecoration(
                                    //   border: UnderlineInputBorder(
                                    //     borderSide: BorderSide(
                                    //       width: 1.0,
                                    //       color: Colors.pinkAccent,
                                    //     ),
                                    //   ),
                                    // ),
                                    // underline: Container(
                                    //   height: 2.0,
                                    //   color: Colors.black26,
                                    // ),
                                    iconSize: 20.0,
                                    items: _categories
                                        .map(
                                          (category) => DropdownMenuItem(
                                            value: category,
                                            child: Container(
                                              margin: EdgeInsets.all(0.0),
                                              child: Text(
                                                category,
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  TextFormField(
                                    initialValue: _initValues['postText'],
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      labelText: 'Make your question simply.',
                                      labelStyle: TextStyle(
                                        color: FocusNode().hasFocus
                                            ? Colors.black26
                                            : Colors.black26,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black26,
                                          width: 1.5,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                    ),
                                    style: kPostTextFieldStyle,

                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please provide a value';
                                      }
                                      if (value.length < 5) {
                                        return 'Question too short';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _editedPost = Post(
                                        postId: _editedPost.postId,
                                        category: _editedPost.category,
                                        postText: value,
                                      );
                                    },
                                    // controller: postController,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: _saveForm,
                              splashColor: Colors.black12,
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                margin: EdgeInsets.only(right: 0.0, top: 20.0),
                                padding: EdgeInsets.only(
                                    right: 10.0, top: 10.0, bottom: 20.0),
                                child: Text('Ask Your Question',
                                    style: kSubmitQuestionTextStyle),
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
    );
  }
}

Widget _buildMenuBar() {
  return Builder(
    builder: (context) => FlatButton(
      splashColor: Colors.red,
      // borderRadius: BorderRadius.circular(20),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  // margin: EdgeInsets.only(left: 5.0),
                  height: 1.5,
                  width: 20.0,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Container(
                  width: 8.0,
                  child: CircleAvatar(
                    radius: 3.0,
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4.0,
            ),
            Container(
              height: 1.5,
              width: 25.0,
              color: Colors.black,
            ),
            SizedBox(
              height: 4.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 8.0,
                  child: CircleAvatar(
                    radius: 3.0,
                    backgroundColor: Colors.red,
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Container(
                  height: 1.5,
                  width: 20.0,
                  color: Colors.black,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
