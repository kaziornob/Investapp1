import 'dart:convert';

import 'package:animator/animator.dart';
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/auth/otp.dart';
import 'package:auroim/auth/signInScreen.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isInProgress = false;
  bool _isClickonSignIn = false;
  bool _visible = false;

  ApiProvider request = new ApiProvider();

  TextEditingController emailController = new TextEditingController();
  TextEditingController signUpPasswordController = new TextEditingController();
  TextEditingController signUpConfirmPasswordController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();


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

  final _formKey = new GlobalKey<FormState>();

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
                height: MediaQuery.of(context).size.height*1.32,
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Column(
                          children: [
                            SizedBox(
                              height: appBarheight,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: true).pop();
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
                                !_isClickonSignIn
                                    ? GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      _isClickonSignIn = true;
                                    });
                                    await Future.delayed(const Duration(milliseconds: 700));

                                    Navigator.of(context, rootNavigator: true)
                                        .push(
                                      CupertinoPageRoute<void>(
                                        builder: (BuildContext context) => SignInScreen(),
                                      ),
                                    )
                                        .then((onValue) {
                                      setState(() {
                                        _isClickonSignIn = false;
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
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          color: AllCoustomTheme.getTextThemeColor(),
                                          fontSize: ConstanceData.SIZE_TITLE20,
                                          fontFamily: "Roboto",
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            _visible
                                ? Container(
/*                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30)),
                                color: AllCoustomTheme.boxColor(),
                              ),*/
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 0.5,
                                    ),
                                    Container(
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
                                    /* Container(
                                        height: 60,
                                        color: AllCoustomTheme.getsecoundTextThemeColor(),
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          children: <Widget>[
                                            Image.asset(
                                              ConstanceData.userImage,
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              'Select photo',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 14, top: 4),
                                              child: TextFormField(
                                                validator: _validateName,
                                                cursorColor: AllCoustomTheme.getTextThemeColors(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: ConstanceData.SIZE_TITLE16,
                                                  color: AllCoustomTheme.getTextThemeColors(),
                                                ),
                                                keyboardType: TextInputType.text,
                                                decoration: new InputDecoration(
                                                  focusColor: AllCoustomTheme.getTextThemeColors(),
                                                  fillColor: AllCoustomTheme.getTextThemeColors(),
                                                  hintText: 'Enter name here...',
                                                  hintStyle: TextStyle(color: Colors.grey[600], fontSize: ConstanceData.SIZE_TITLE14),
                                                  labelText: 'Name',
                                                  labelStyle: TextStyle(
                                                    fontSize: ConstanceData.SIZE_TITLE16,
                                                    color: AllCoustomTheme.getTextThemeColors(),
                                                  ),
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
                                      ),*/
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 14, top: 4),
                                            child: TextFormField(
                                              controller: emailController,
                                              validator: _validateEmail,
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
                                            padding: EdgeInsets.only(left: 14, bottom: 10),
                                            child: TextFormField(
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
                                              controller: signUpPasswordController,
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
                                            padding: EdgeInsets.only(left: 14, bottom: 10),
                                            child: TextFormField(
                                              cursorColor: AllCoustomTheme.getTextThemeColor(),
                                              style: AllCoustomTheme.getTextFormFieldBaseStyleTheme(),
                                              keyboardType: TextInputType.text,
                                              obscureText: true,
                                              decoration: new InputDecoration(
                                                focusColor: AllCoustomTheme.getTextThemeColor(),
                                                fillColor: AllCoustomTheme.getTextThemeColor(),
                                                hintText: 'Re-Enter password here...',
                                                hintStyle: TextStyle(color: Colors.grey[600], fontSize: ConstanceData.SIZE_TITLE14),
                                                labelText: 'Confirm Password',
                                                labelStyle: AllCoustomTheme.getTextFormFieldLabelStyleTheme()
                                              ),
                                              validator: _validatePassword,
                                              controller: signUpConfirmPasswordController,
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
                                            padding: EdgeInsets.only(left: 14, bottom: 10),
                                            child: TextFormField(
                                              controller: phoneController,
                                              cursorColor: AllCoustomTheme.getTextThemeColor(),
                                              style: AllCoustomTheme.getTextFormFieldBaseStyleTheme(),
                                              keyboardType: TextInputType.number,
                                              validator: _validatePhone,
                                              decoration: new InputDecoration(
                                                focusColor: AllCoustomTheme.getTextThemeColor(),
                                                fillColor: AllCoustomTheme.getTextThemeColor(),
                                                hintText: 'Enter Phone here...',
                                                hintStyle: TextStyle(color: Colors.grey[600], fontSize: ConstanceData.SIZE_TITLE14),
                                                labelText: 'Phone',
                                                labelStyle: AllCoustomTheme.getTextFormFieldLabelStyleTheme()
                                              ),
                                              // validator: _validatePassword,
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
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          SizedBox(
                                              height: 50,
                                              child: GestureDetector(
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
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                                : SizedBox(),
                          ],
                        ),
                      ),
                      //social media buttons
                      Container(
                        height: 45.0,
                        alignment: FractionalOffset.center,
                        child: Text(
                          "OR",
                          style: TextStyle(
                            color: AllCoustomTheme.getTextThemeColor(),
                            letterSpacing: 0.3,
                            fontSize: ConstanceData.SIZE_TITLE18,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      AnimatedOpacity(
                        duration: Duration(milliseconds: 500),
                        opacity: 1.0,
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          child: Container(
                            height: 45.0,
                            width: 320.0,
                            alignment: FractionalOffset.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 1.5),
                              borderRadius: BorderRadius.circular(30),
                                color: Color(0xFFD8AF4F)
                            ),
                            child: Text(
                              "Sign Up With E-Mail",
                              style: TextStyle(
                                color: AllCoustomTheme.getReBlackAndWhiteThemeColors(),
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                          onPressed: () async {
/*
                              setState(() {
                                _isInProgress = true;
                              });
                              await Future.delayed(const Duration(milliseconds: 500));
*/

                          },
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      AnimatedOpacity(
                        duration: Duration(milliseconds: 500),
                        opacity: 1.0,
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          child: new Container(
                            height: 45.0,
                            width: 320.0,

                            alignment: FractionalOffset.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 1.5),
                              borderRadius: BorderRadius.circular(30),
                                color: Color(0xFFD8AF4F)
                            ),
                            child: Text(
                              "Facebook",
                              style: TextStyle(
                                color: AllCoustomTheme.getReBlackAndWhiteThemeColors(),
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                          onPressed: () async {
/*                              setState(() {
                                _isInProgress = true;
                              });
                              await Future.delayed(const Duration(milliseconds: 500));*/
                          },
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      AnimatedOpacity(
                        duration: Duration(milliseconds: 500),
                        opacity: 1.0,
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          child: new Container(
                            height: 45.0,
                            width: 320.0,
                            alignment: FractionalOffset.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 1.5),
                              borderRadius: BorderRadius.circular(30),
                                color: Color(0xFFD8AF4F)
                            ),
                            child: Text(
                              "Apple",
                              style: TextStyle(
                                color: AllCoustomTheme.getReBlackAndWhiteThemeColors(),
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                          onPressed: () async {
/*                              setState(() {
                                _isInProgress = true;
                              });
                              await Future.delayed(const Duration(milliseconds: 500));*/
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  var myScreenFocusNode = FocusNode();

  _submit() async {

    if(signUpPasswordController.text.trim() == signUpConfirmPasswordController.text.trim())
      {
        setState(() {
          _isInProgress = true;
        });
        await Future.delayed(const Duration(milliseconds: 700));
        FocusScope.of(context).requestFocus(myScreenFocusNode);
        if (_formKey.currentState.validate() == false) {
          setState(() {
            _isInProgress = false;
          });
          return;
        }

        var email = emailController.text.trim();
        var password = signUpPasswordController.text.trim();
        var phone = phoneController.text.trim();

        // String jsonReq = "users/authenticate/new?email=$email&password=$password&phone=$phone";

        var tempJsonReq = {"email":"$email","password":"$password","phone":"$phone"};
        String jsonReq = json.encode(tempJsonReq);

        var response = await request.signUp('users/authenticate/new',jsonReq);
        print("signup response: $response");
        if (response!=null)
        {
            if(response.containsKey('auth') && response['auth']==true)
            {
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('Session_token', response['token']);

              getDialog("$email");
            }
            else
              {
                setState(() {
                  _isInProgress = false;
                });
                Toast.show("Already Exist!", context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.BOTTOM);
              }
        }
        else{
          setState(() {
            _isInProgress = false;
          });
          Toast.show("Something went wrong!", context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.BOTTOM);
        }
      }
    else {
      PasswordNotMatched(context);
    }
  }

  void getDialog(otp) {
    showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
            title: Text(
                "",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AllCoustomTheme.getTextThemeColors(),
                fontWeight: FontWeight.bold,
                fontSize: ConstanceData.SIZE_TITLE18,
              ),
            ),
            content: Text(
                "OTP sent to your email",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AllCoustomTheme.getTextThemeColors(),
                fontWeight: FontWeight.bold,
                fontSize: ConstanceData.SIZE_TITLE18,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                    'Ok',
                  style: TextStyle(
                    color: AllCoustomTheme.getTextThemeColors(),
                    fontWeight: FontWeight.bold,
                    fontSize: ConstanceData.SIZE_TITLE18,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context, rootNavigator: true).push(
                    CupertinoPageRoute<void>(
                      builder: (BuildContext context) =>
                          Otp(encodedOtp: "$otp"),
                    ),
                  ).then((onValue) {
                    setState(() {
                      _isInProgress = false;
                    });
                  });
                },
              ),
            ],);
        }
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> PasswordNotMatched(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
          title: Text(
              "Confirm password didn't match",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AllCoustomTheme.getTextThemeColors(),
              fontWeight: FontWeight.bold,
              fontSize: ConstanceData.SIZE_TITLE18,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                  'Ok',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AllCoustomTheme.getTextThemeColors(),
                  fontWeight: FontWeight.bold,
                  fontSize: ConstanceData.SIZE_TITLE18,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  String _validateEmail(value) {
    if (value.isEmpty) {
      return "Email cannot be empty";
    } else if (Validators.validateEmail(value) == false) {
      return "Please enter valid email";
    }
    return null;
  }

  String _validatePhone(value) {
    if (value.isEmpty) {
      return "Phone cannot be empty";
    } else {
      return null;
    }
  }

  String _validatePassword(value) {
    if (value.isEmpty) {
      return "Password cannot be empty";
    } else {

/*      String  pattern = '/^[A-Za-z]{6}/';
      RegExp regExp = new RegExp(pattern);
      if(!regExp.hasMatch(value))
        {
          return "Minimum 6 character";
        }
      return null;*/

      if(value.length!=6)
        {
          return "Min 6 length character";
        }
      return null;

/*      String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
      RegExp regExp = new RegExp(pattern);
      if(!regExp.hasMatch(value))
        {
          return "Minimum 1 UC, LC, Num, spl. character(! @ # '\$' & * ~)";
        }
      return null;*/
    }
  }
}
