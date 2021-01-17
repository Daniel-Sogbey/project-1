import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../http_exception/http_exception.dart';
import '../providers/auth.dart';
import '../widgets/app_header.dart';
import '../widgets/separator.dart';

enum AuthMode {
  Signup,
  Login,
}

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  AuthMode _authMode = AuthMode.Login;

  final _passwordController = TextEditingController();

  var _isLoading = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'An Error Occurred',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w900,
            fontSize: 25.0,
          ),
        ),
        content: Text(
          message,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Okay',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (!_form.currentState.validate()) {
      return;
    }

    _form.currentState.save();

    setState(() {
      _isLoading = true;
    });

    try {
      if (_authMode == AuthMode.Login) {
        //login in user
        await Provider.of<Auth>(context, listen: false).signin(
          _authData['email'],
          _authData['password'],
        );
        //     .then((_) {
        //   final isAuth = Provider.of<Auth>(context, listen: false).isAuth;
        //   if (isAuth) {
        //     Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        //   }
        // });
      } else {
        //signup user
        await Provider.of<Auth>(context, listen: false).signup(
          _authData['email'],
          _authData['password'],
        );
        //     .then((_) {
        //   final isAuth = Provider.of<Auth>(context, listen: false).isAuth;
        //   if (isAuth) {
        //     Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        //   }
        // });
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This email address is not valid';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Password is invalid';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'Could not authenticate you. Please try again later';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });

    print(_authData['email']);
    print(_authData['password']);
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.lightBlue,
          height: MediaQuery.of(context).size.height,
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     colors: [
          //       // Colors.pinkAccent,
          //       // Colors.amber,
          //       // Colors.blue,
          //       Color.fromRGBO(215, 17, 225, 1).withOpacity(0.8),
          //       Color.fromRGBO(255, 188, 17, 1).withOpacity(1.0),
          //     ],
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight,
          //     stops: [0, 1],
          //   ),
          // ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AppHeader(color: Colors.white),
                  ],
                ),
                Separator(color: Colors.white),
                // Container(
                //   child: Text(
                //     'hello sharer!',
                //     style: TextStyle(
                //       color: Colors.white70,
                //       fontSize: 17.0,
                //       fontFamily: 'Montserrat',
                //       letterSpacing: 3.0,
                //       fontStyle: FontStyle.italic,
                //       fontWeight: FontWeight.w900,
                //       wordSpacing: 2.0,
                //     ),
                //   ),
                // ),
                // Separator(color: Colors.white),
                // Container(
                //
                //   padding: EdgeInsets.only(
                //     left: 10.0,
                //     right: 10.0,
                //   ),
                //   child: Image.asset(
                //     'images/welcome.png',
                //     // color: Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                //   ),
                // ),
                // _authMode == AuthMode.Login
                //     ? Container(
                //         margin: EdgeInsets.only(top: 20.0),
                //         child: Text(
                //           'Login',
                //           style: TextStyle(
                //             fontWeight: FontWeight.w900,
                //             fontSize: 30.0,
                //             fontFamily: 'Montserrat',
                //             color: Colors.white,
                //           ),
                //         ),
                //       )
                //     : Container(
                //         width: double.infinity,
                //         margin: EdgeInsets.only(top: 10.0),
                //         child: Text(
                //           'Create An Account Now',
                //           style: TextStyle(
                //             fontWeight: FontWeight.w900,
                //             fontSize: 30.0,
                //             fontFamily: 'Montserrat',
                //             color: Colors.white,
                //           ),
                //           textAlign: TextAlign.center,
                //         ),
                //       ),
                Card(
                  elevation: 100.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  shadowColor: Colors.lightBlue,
                  margin: EdgeInsets.only(
                    top: 30,
                    left: 5.0,
                    right: 5.0,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Form(
                      key: _form,
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          bottom: 5.0,
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                bottom: 15.0,
                                top: 10.0,
                              ),
                              margin: EdgeInsets.only(top: 10.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    // Icons.email,
                                    FontAwesomeIcons.envelope,
                                    color: Colors.blue,
                                  ),
                                  labelText: 'Enter your email',
                                  labelStyle: TextStyle(
                                    color: FocusNode().hasFocus
                                        ? Colors.black26
                                        : Colors.blue,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                                style: kPostTextFieldStyle,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter an email';
                                  }
                                  if (!value.contains('@')) {
                                    return 'Enter a valid email';
                                  }

                                  if (!EmailValidator.validate(value)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _authData['email'] = value;
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                bottom: 20.0,
                                top: 15.0,
                              ),
                              child: TextFormField(
                                obscureText: true,
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: Colors.blue,
                                  ),
                                  labelText: 'Enter your password',
                                  labelStyle: TextStyle(
                                    color: FocusNode().hasFocus
                                        ? Colors.black26
                                        : Colors.blue,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                                style: kPostTextFieldStyle,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter a password';
                                  }
                                  if (value.length < 5) {
                                    return 'Password must include more than 5 characters';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _authData['password'] =
                                      _passwordController.text;
                                },
                                // onEditingComplete: () {
                                //   _submit();
                                // },
                              ),
                            ),
                            if (_authMode == AuthMode.Signup)
                              Container(
                                padding: EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                  bottom: 20.0,
                                  top: 15.0,
                                ),
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      // Icons.confirmation_number,
                                      FontAwesomeIcons.lock,
                                      color: Colors.blue,
                                    ),
                                    labelText: 'Confirm your password',
                                    labelStyle: TextStyle(
                                      color: FocusNode().hasFocus
                                          ? Colors.black26
                                          : Colors.blue,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                  style: kPostTextFieldStyle,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter a password to confirm';
                                    }
                                    if (value != _passwordController.text) {
                                      return 'Passwords do not much';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                _isLoading
                    ? Container(
                        margin: EdgeInsets.all(20),
                        child: CircularProgressIndicator(),
                      )
                    : Card(
                        elevation: 10,
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        margin: EdgeInsets.only(top: 20),
                        child: InkWell(
                          onTap: _submit,
                          splashColor: Colors.pink,
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              _authMode == AuthMode.Login ? 'LOGIN' : 'SIGNUP',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),

                // Container(
                //   child: Text(
                //     'OR',
                //     style: TextStyle(
                //       fontFamily: 'Montserrat',
                //       fontSize: 18.0,
                //       fontWeight: FontWeight.w900,
                //     ),
                //   ),
                // ),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: <Widget>[
                //     Container(
                //       margin: EdgeInsets.only(left: 10.0),
                //       color: Colors.black26,
                //       width: MediaQuery.of(context).size.width * 0.2,
                //       height: 1.0,
                //     ),
                //     SizedBox(
                //       width: 10.0,
                //     ),
                //     Container(
                //       child: Text(
                //         'OR',
                //         style: TextStyle(
                //           fontFamily: 'Montserrat',
                //           fontSize: 18.0,
                //           fontWeight: FontWeight.w900,
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       width: 10.0,
                //     ),
                //     Container(
                //       margin: EdgeInsets.only(right: 10.0),
                //       color: Colors.black26,
                //       width: MediaQuery.of(context).size.width * 0.2,
                //       height: 1.0,
                //     ),
                //   ],
                // ),

                InkWell(
                  onTap: _switchAuthMode,
                  splashColor: Colors.pink,
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    child: Text(
                      '${_authMode == AuthMode.Login ? 'SIGNUP' : ' LOGIN'} INSTEAD',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  // splashColor: Colors.amber,
                  child: Container(
                    child: Text(
                      'forgot password?',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
