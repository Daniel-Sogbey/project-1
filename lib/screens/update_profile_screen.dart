import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../constants/constants.dart';
import '../models/user.dart';
import '../providers/auth.dart';
import '../widgets/app_header.dart';
import '../widgets/separator.dart';

class UpdateProfileScreen extends StatefulWidget {
  static const routeName = '/update-profile';

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  File _pickedImage;

  void _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    setState(() {
      _pickedImage = image;
    });
  }

  var _isLoading = false;

  var _formKey = GlobalKey<FormState>();

  User _updatedUser = User(userId: '', username: '', photoUrl: '');

  TextEditingController username = TextEditingController();

  void _saveForm(BuildContext context) async {
    var _isValid = _formKey.currentState.validate();
    if (!_isValid) {
      return;
    }

    _formKey.currentState.save();

    FocusScope.of(context).unfocus();
    try {
      setState(() {
        _isLoading = true;
      });
      final authToken = Provider.of<Auth>(context, listen: false).token;

      await Provider.of<User>(context, listen: false)
          .updateUserProfile(
        _updatedUser,
        authToken,
      )
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
      // print(username.text);

      // await Provider.of<Users>(context, listen: false).fetchUser(authToken);

      Navigator.of(context).pop();
    } catch (error) {
      print('$error error from update user');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<Auth>(context, listen: false).userId;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AppHeader(),
                ],
              ),
              Separator(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    // child: Icon(
                    // Icons.verified_user,
                    // size: 80.0,
                    // ),
                    child: _pickedImage == null
                        ? Text('')
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              _pickedImage,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                  ),
                  Container(
                    child: IconButton(
                      onPressed: _imgFromCamera,
                      icon: Icon(
                        Icons.linked_camera,
                        color: Colors.black26,
                        size: 50.0,
                      ),
                    ),
                  ),
                ],
              ),
              _isLoading
                  ? Container(
                      width: 50.0,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballPulseSync,
                      ),
                    )
                  : Form(
                      key: _formKey,
                      child: Container(
                        padding: EdgeInsets.all(30.0),
                        child: Column(
                          children: [
                            TextFormField(
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                labelText: 'username',
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
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                              style: kPostTextFieldStyle,

                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'username field cannot be empty';
                                }
                                if (value.length < 4) {
                                  return 'username too short';
                                }
                                return null;
                              },
                              controller: username,
                              onSaved: (value) {
                                _updatedUser = User(
                                  userId: userId,
                                  username: value,
                                  photoUrl: _pickedImage == null
                                      ? ''
                                      : _pickedImage.toString(),
                                );
                              },
                              // controller: postController,
                            ),
                            Card(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              margin: EdgeInsets.only(
                                top: 10.0,
                                bottom: 10.0,
                              ),
                              color: Colors.greenAccent,
                              child: InkWell(
                                onTap: () => _saveForm(context),
                                splashColor: Colors.black12,
                                borderRadius: BorderRadius.circular(20.0),
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: 5.0,
                                    right: 0.0,
                                    top: 5.0,
                                  ),
                                  padding: EdgeInsets.only(
                                      left: 10.0,
                                      right: 10.0,
                                      top: 10.0,
                                      bottom: 15.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Update Profile',
                                        style: kSubmitQuestionTextStyle,
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Icon(
                                        // Icons.send,
                                        FontAwesomeIcons.userClock,
                                        color: Colors.white,
                                        size: 20.0,
                                      ),
                                    ],
                                  ),
                                ),
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
