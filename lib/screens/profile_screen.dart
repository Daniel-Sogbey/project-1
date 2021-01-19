import 'dart:io';
import '../widgets/app-drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_1/constants/constants.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/auth.dart';
import '../screens/update_profile_screen.dart';
import '../widgets/app_header.dart';
import '../widgets/separator.dart';
import '../providers/posts.dart';
import '../providers/answers.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

  @override
  Widget build(BuildContext context) {
    final userDetails = Provider.of<Auth>(context);
    final userPosts = Provider.of<Posts>(context).userPosts;
    final myAnswers = Provider.of<Answers>(context).myAnswers;
    return Scaffold(
      drawer: Consumer<User>(
        builder: (ctx, user, _) => AppDrawer(
          username: user.getUsername,
          email: user.getEmail,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildMenuBar(),
                AppHeader(),
              ],
            ),
            Separator(),
            Consumer<User>(
              builder: (ctx, user, _) => Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  left: 10.0,
                  right: 10,
                  bottom: 20.0,
                  top: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      // child: Icon(
                      // Icons.verified_user,
                      // size: 80.0,
                      // ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                            // user.getUserPhoto == null
                            // ?
                            'https://previews.123rf.com/images/asmati/asmati1603/asmati160301350/53564482-user-line-vector-icon-on-transparent-background.jpg'
                            // : user.getUserPhoto,
                            ),
                      ),
                    ),

                    // user.getUsername == null
                    //     ? Text(
                    //   userDetails.userId.replaceRange(
                    //     2,
                    //     userDetails.userId.length,
                    //     '...',
                    //   ),
                    // )
                    //     : Text(
                    //   user.getUsername,
                    // ):

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
              ),
            ),
            Card(
              child: Container(
                height: 200,
                padding:
                    EdgeInsets.only(top: 30, bottom: 30, left: 5, right: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(children: <Widget>[
                          Text('Questions'),
                          Text(userPosts.length.toString()),
                          Container(
                            child: Text('View'),
                          ),
                        ]),
                        Column(children: <Widget>[
                          Text('Answers'),
                          Text(myAnswers.length.toString()),
                          Container(
                            child: Text('View'),
                          ),
                        ]),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            //UserDetails(userDetails: userDetails),
            // Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            // children: <Widget>[
            // Container(
            // padding: EdgeInsets.all(10),
            // child: GestureDetector(
            // onTap: () {
            // print(userDetails);
            // Navigator.of(context).pushNamed(
            // UpdateProfileScreen.routeName,
            // );
            // },
            // child: Container(
            // padding: EdgeInsets.only(top: 10.0),
            // child: Text(
            // 'Edit Profile',
            // style: kEditUserProfile,
            // ),
            // ),
            // ),
            // )
            // ],
            // ),
          ],
        ),
      ),
    );
  }
}

class UserDetails extends StatelessWidget {
  final Auth userDetails;
  const UserDetails({
    @required this.userDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.white,
      elevation: 100.0,
      color: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 50.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    'User Id: '.toUpperCase(),
                    style: kUserProfileId,
                  ),
                ),
                Container(
                  child: userDetails.userId == null
                      ? Text('')
                      : Text(
                          userDetails.userId.toUpperCase(),
                          style: kUserProfileId,
                        ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    'Email: '.toUpperCase(),
                    style: kUserProfileId,
                  ),
                ),
                Container(
                  child: Text(
                    userDetails.email == null
                        ? ''
                        : userDetails.email.toUpperCase(),
                    style: kUserProfileId,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    'username: '.toUpperCase(),
                    style: kUserProfileId,
                  ),
                ),
                Consumer<User>(
                  builder: (ctx, user, _) => Container(
                    child: Text(
                      user.getUsername == null
                          ? ''
                          : user.getUsername.toUpperCase(),
                      style: kUserProfileId,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildMenuBar() {
  return Builder(
    builder: (context) => Container(
      margin: EdgeInsets.only(left: 20.0, right: 10.0),
      child: InkWell(
        onTap: () {
          Scaffold.of(context).openDrawer();
        },
        child: Container(
          margin: EdgeInsets.only(top: 20),
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
    ),
  );
}
