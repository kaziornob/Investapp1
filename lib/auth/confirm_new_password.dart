import 'package:animator/animator.dart';
import 'package:auroim/auth/signInScreen.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/provider_abhinav/forgot_password_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

// import 'forgotPasswordScreen.dart';

class ConfirmNewPassword extends StatefulWidget {
  final String email;
  final otp;

  const ConfirmNewPassword({Key key, this.email, this.otp}) : super(key: key);

  @override
  _ConfirmNewPasswordState createState() => _ConfirmNewPasswordState();
}

class _ConfirmNewPasswordState extends State<ConfirmNewPassword> {
  bool _isInProgress = false;
  bool _visible = false;
  TextEditingController _newPassController = TextEditingController();
  TextEditingController _confirmPassController = TextEditingController();
  var myScreenFocusNode = FocusNode();

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

  @override
  void dispose() {
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  final _forgotFormKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();
    double appBarheight = appBar.preferredSize.height;
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: AllCoustomTheme.getBodyContainerThemeColor(),
          body: ModalProgressHUD(
            inAsyncCall: _isInProgress,
            opacity: 0,
            progressIndicator: SizedBox(),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: appBarheight,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 16, left: 16, bottom: 20),
                        child: Row(
                          children: <Widget>[
                            InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Animator(
                                tween: Tween<Offset>(
                                    begin: Offset(0, 0), end: Offset(0.2, 0)),
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
                          ],
                        ),
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
                                  'Forgot password',
                                  style: TextStyle(
                                      color:
                                          AllCoustomTheme.getTextThemeColor(),
                                      fontSize: ConstanceData.SIZE_TITLE20,
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.bold),
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
                        padding: const EdgeInsets.only(
                          left: 16,
                        ),
                        child: _visible
                            ? Container(
                                padding: EdgeInsets.only(bottom: 30),
                                /*decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20)),
                                  color: AllCoustomTheme.boxColor(),
                                ),*/
                                child: Form(
                                  key: _forgotFormKey,
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
                                          ))),
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 14, top: 4, right: 20),
                                              child: TextFormField(
                                                controller: _newPassController,
                                                validator: _validatePassword,
                                                cursorColor: AllCoustomTheme
                                                    .getTextThemeColor(),
                                                style: AllCoustomTheme
                                                    .getTextFormFieldBaseStyleTheme(),
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: new InputDecoration(
                                                    focusColor: AllCoustomTheme
                                                        .getTextThemeColor(),
                                                    fillColor: AllCoustomTheme
                                                        .getTextThemeColor(),
                                                    hintText:
                                                        'Enter New Password',
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: ConstanceData
                                                            .SIZE_TITLE14),
                                                    labelText:
                                                        'Enter New Password',
                                                    labelStyle: AllCoustomTheme
                                                        .getTextFormFieldLabelStyleTheme()),
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
                                              padding: EdgeInsets.only(
                                                  left: 14, top: 4, right: 20),
                                              child: TextFormField(
                                                controller:
                                                    _confirmPassController,
                                                validator: _validatePassword,
                                                cursorColor: AllCoustomTheme
                                                    .getTextThemeColor(),
                                                style: AllCoustomTheme
                                                    .getTextFormFieldBaseStyleTheme(),
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: new InputDecoration(
                                                    focusColor: AllCoustomTheme
                                                        .getTextThemeColor(),
                                                    fillColor: AllCoustomTheme
                                                        .getTextThemeColor(),
                                                    hintText:
                                                        'Confirm Password ',
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: ConstanceData
                                                            .SIZE_TITLE14),
                                                    labelText:
                                                        'Confirm Password ',
                                                    labelStyle: AllCoustomTheme
                                                        .getTextFormFieldLabelStyleTheme()),
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
                                      !_isInProgress
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10, left: 10, top: 20),
                                              child: FlatButton(
                                                padding: EdgeInsets.all(0),
                                                child: new Container(
                                                  height: 35.0,
                                                  width: 150,
                                                  alignment:
                                                      FractionalOffset.center,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    border: new Border.all(
                                                        color:
                                                            Color(0xFFD8AF4F),
                                                        width: 1.5),
                                                    color: Color(0xFFD8AF4F),
                                                  ),
                                                  child: new Text(
                                                    "Send Email",
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getTextThemeColors(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE14,
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  _submit();
                                                },
                                              ),
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 44),
                                              child: CupertinoActivityIndicator(
                                                radius: 12,
                                              ),
                                            )
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(),
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

  void getDialog(text, goToNextScreen) {
    showDialog(
        context: context,
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
              "$text",
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
                  if (goToNextScreen) {
                    Navigator.of(context, rootNavigator: true)
                        .push(
                      CupertinoPageRoute<void>(
                        builder: (BuildContext context) => SignInScreen(),
                      ),
                    )
                        .then((onValue) {
                      setState(() {
                        _isInProgress = false;
                      });
                    });
                  } else {
                    print("Unable to Create New Pass");
                  }
                },
              ),
            ],
          );
        });
  }

  String _validatePassword(value) {
    if (value.isEmpty) {
      return "Password cannot be empty";
    } else {
      /*String pattern = r'(^(?:[A-Za-z])?[A-Za-z]{6,12}$)';
      RegExp regExp = new RegExp(pattern);
      if(!regExp.hasMatch(value))
        {
          return "Only six character";
        }
      return null;*/

      String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
      RegExp regExp = new RegExp(pattern);
      if (!regExp.hasMatch(value)) {
        return "Minimum six characters, at least one upper,lower and number";
      }
      return null;
    }
  }

  _submit() async {
    setState(() {
      _isInProgress = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));

    FocusScope.of(context).requestFocus(myScreenFocusNode);
    if (_forgotFormKey.currentState.validate() == false) {
      setState(() {
        _isInProgress = false;
      });
      return;
    }
    _forgotFormKey.currentState.save();

    await Future.delayed(const Duration(seconds: 1));

    String message =
        await Provider.of<ForgotPasswordProvider>(context, listen: false)
            .resetPassword(widget.email, widget.otp, _newPassController.text);

    if (message == "Password updated Successfully!") {
      getDialog(message, true);
    } else {
      getDialog(message, false);
    }

    Navigator.of(context)
        .push(
      CupertinoPageRoute<void>(
        builder: (BuildContext context) => SignInScreen(),
      ),
    )
        .then((onValue) {
      setState(() {
        _isInProgress = false;
      });
    });
  }
}
