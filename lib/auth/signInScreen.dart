import 'dart:convert';

import 'package:animator/animator.dart';
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/auth/forgotPasswordScreen.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/home/homeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

import 'signUpScreen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _visible = false;
  bool _isInProgress = false;
  bool _isClickonSignUp = false;
  bool _isClickonForgotPassword = false;

  ApiProvider request = new ApiProvider();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  animation() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _visible = true;
    });
  }

  @override
  void initState() {
    super.initState();
    animation();
  }

  final _signInFormKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();
    double appBarheight = appBar.preferredSize.height;
    return Stack(
      children: <Widget>[
        Scaffold(
          // backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
          backgroundColor: AllCoustomTheme.getBodyContainerThemeColor(),
          body: ModalProgressHUD(
            inAsyncCall: _isInProgress,
            opacity: 0,
            progressIndicator: SizedBox(),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height*1.0,
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: appBarheight,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Animator(
                              tween: Tween<Offset>(begin: Offset(0, 0), end: Offset(0.2, 0)),
                              duration: Duration(milliseconds: 500),
                              cycles: 0,
                              builder: (anim) => FractionalTranslation(
                                translation: anim.value,
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: AllCoustomTheme.getTextThemeColor(),
                                ),
                              ),
                            ),
                          ),
                          !_isClickonSignUp
                              ? GestureDetector(
                            onTap: () async {
                              setState(() {
                                _isClickonSignUp = true;
                              });
                              await Future.delayed(const Duration(milliseconds: 700));

                              Navigator.of(context, rootNavigator: true)
                                  .push(
                                CupertinoPageRoute<void>(
                                  builder: (BuildContext context) => SignUpScreen(),
                                ),
                              )
                                  .then((onValue) {
                                setState(() {
                                  _isClickonSignUp = false;
                                });
                              });
                            },
                            child: Animator(
                              tween: Tween<double>(begin: 0.8, end: 1.1),
                              curve: Curves.easeInToLinear,
                              cycles: 0,
                              builder: (anim) => Transform.scale(
                                scale: anim.value,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(
                                      color: AllCoustomTheme.getTextThemeColor(),
                                        fontSize: ConstanceData.SIZE_TITLE20,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                              : Padding(
                            padding: EdgeInsets.only(right: 14),
                            child: CupertinoActivityIndicator(
                              radius: 12,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: <Widget>[
                          Animator(
                            tween: Tween<double>(begin: 0, end: 1),
                            duration: Duration(milliseconds: 500),
                            cycles: 1,
                            builder: (anim) => SizeTransition(
                              sizeFactor: anim,
                              axis: Axis.horizontal,
                              axisAlignment: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: AllCoustomTheme.getTextThemeColor(),
                                    fontSize: ConstanceData.SIZE_TITLE20,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: _visible
                            ? Container(
/*                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30)),
                            color: AllCoustomTheme.boxColor(),
                          ),*/
                          child: Form(
                            key: _signInFormKey,
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 0.5,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Container(
                                    height: 3,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                              color: Color(0xFFD8AF4F),
                                              width: 1.6, // Underline width
                                            )
                                        )
                                    ),
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 14, top: 4,right: 20),
                                        child: TextFormField(
                                          validator: _validateEmail,
                                          controller: emailController,
                                          cursorColor: AllCoustomTheme.getTextThemeColor(),
                                          style: AllCoustomTheme.getTextFormFieldBaseStyleTheme(),
                                          keyboardType: TextInputType.emailAddress,
                                          decoration: new InputDecoration(
                                            focusColor: AllCoustomTheme.getTextThemeColor(),
                                            fillColor: AllCoustomTheme.getTextThemeColor(),
                                            hintText: 'Enter email here...',
                                            hintStyle: TextStyle(color: Colors.grey[600], fontSize: ConstanceData.SIZE_TITLE14),
                                            labelText: 'E-mail',
                                            labelStyle: AllCoustomTheme.getTextFormFieldLabelStyleTheme()
                                          ),
                                          //controller: lastnameController,
                                          onSaved: (value) {
                                            setState(() {
                                              //lastnamesearchText = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 14, bottom: 10,right: 20),
                                        child: TextFormField(
                                          controller: passwordController,
                                          cursorColor: AllCoustomTheme.getTextThemeColor(),
                                          style: AllCoustomTheme.getTextFormFieldBaseStyleTheme(),
                                          keyboardType: TextInputType.text,
                                          obscureText: true,
                                          decoration: new InputDecoration(
                                            focusColor: AllCoustomTheme.getTextThemeColor(),
                                            fillColor: AllCoustomTheme.getTextThemeColor(),
                                            hintText: 'Enter password here...',
                                            hintStyle: TextStyle(color: Colors.grey[600], fontSize: ConstanceData.SIZE_TITLE14),
                                            labelText: 'Password',
                                            labelStyle: AllCoustomTheme.getTextFormFieldLabelStyleTheme()
                                          ),
                                          validator: _validatePassword,
                                          //controller: lastnameController,
                                          onSaved: (value) {
                                            setState(() {
                                              //lastnamesearchText = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20, left: 14, right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      !_isClickonForgotPassword
                                          ? GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            _isClickonForgotPassword = true;
                                          });
                                          await Future.delayed(const Duration(milliseconds: 700));

                                          Navigator.of(context, rootNavigator: true)
                                              .push(
                                            CupertinoPageRoute<void>(
                                              builder: (BuildContext context) => ForgotPasswordScreen(),
                                            ),
                                          )
                                              .then((onValue) {
                                            setState(() {
                                              _isClickonForgotPassword = false;
                                            });
                                          });
                                        },
                                        child: Text(
                                          'Forgot Password?',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Roboto",
                                            color: AllCoustomTheme.getTextThemeColor(),
                                          ),
                                        ),
                                      )
                                          : Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: CupertinoActivityIndicator(
                                          radius: 12,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50,
                                        child: !_isInProgress
                                            ? GestureDetector(
                                          onTap: () {
                                            _submit();
                                          },
                                          child: Animator(
                                            tween: Tween<double>(begin: 0.8, end: 1.1),
                                            curve: Curves.easeInToLinear,
                                            cycles: 0,
                                            builder: (anim) => Transform.scale(
                                              scale: anim.value,
                                              child: Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  border: new Border.all(color: Colors.white, width: 1.5),
                                                  shape: BoxShape.circle,
                                                  color: Color(0xFFD8AF4F)
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 3),
                                                  child: Icon(
                                                    Icons.arrow_forward_ios,
                                                    size: 20,
                                                    color: AllCoustomTheme.getTextThemeColors(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                            : Padding(
                                          padding: EdgeInsets.only(right: 14),
                                          child: CupertinoActivityIndicator(
                                            radius: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                            : SizedBox(),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ),
        )
      ],
    );
  }

  var myScreenFocusNode = FocusNode();

  _submit() async {
    setState(() {
      _isInProgress = true;
    });
    await Future.delayed(const Duration(milliseconds: 500));

    FocusScope.of(context).requestFocus(myScreenFocusNode);
    if (_signInFormKey.currentState.validate() == false) {
      setState(() {
        _isInProgress = false;
      });
      return;
    }

    // Navigator.pushNamedAndRemoveUntil(context, Routes.Home, (Route<dynamic> route) => false);

    var email = emailController.text.trim();
    var password = passwordController.text.trim();
    // set up POST request arguments

    var tempJsonReq = {"email":"$email","password":"$password"};
    String jsonReq = json.encode(tempJsonReq);

    var response = await request.login('users/authenticate/me',jsonReq);

/*    String jsonReq = 'users/authenticate/me?email=$email&password=$password';

    var response = await request.login(jsonReq);*/

    print("login response: $response");
    if (response == true) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen()
        ),
        ModalRoute.withName("/Home")
    );

    } else {
      setState(() {
        _isInProgress = false;
      });
      Toast.show("Wrong Email OR Password", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM);
    }
  }

  String _validateEmail(value) {
    if (value.isEmpty) {
      return "Email cannot be empty";
    } else if (Validators.validateEmail(value) == false) {
      return "Please enter valid email";
    }
    return null;
  }

  String _validatePassword(value) {
    // if (value.isEmpty) {
    //   return "Password cannot be empty";
    // }
    // else if (value.length < 5) {
    //   return 'Password must contains ${5} characters';
    // }
    // else {
    // return null;
    //   }

    if (value.isEmpty) {
      return "Password cannot be empty";
    } else {
      return null;
    }
  }
}

class Validators {
  static const Pattern _pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static RegExp _regex = new RegExp(_pattern);

  static bool validateEmail(String value) {
    return _regex.hasMatch(value);
  }
}
