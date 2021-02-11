import 'package:animator/animator.dart';
import 'package:auroim/auth/signInScreen.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool _isInProgress = false;
  bool _visible = false;

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
                                  key: _formKey,
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
                                              padding: EdgeInsets.only(
                                                  left: 14, top: 4,right: 20),
                                              child: TextFormField(
                                                validator: _validateEmail,
                                                cursorColor: AllCoustomTheme
                                                    .getTextThemeColor(),
                                                style: AllCoustomTheme.getTextFormFieldBaseStyleTheme(),
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: new InputDecoration(
                                                  focusColor: AllCoustomTheme
                                                      .getTextThemeColor(),
                                                  fillColor: AllCoustomTheme
                                                      .getTextThemeColor(),
                                                  hintText:
                                                      'Enter email here...',
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
                                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                                    border: new Border.all(color: Color(0xFFD8AF4F), width: 1.5),
                                                    color: Color(0xFFD8AF4F),
                                                  ),
                                                  child: new Text(
                                                    "Send Email",
                                                    style: TextStyle(
                                                      color: AllCoustomTheme.getTextThemeColors(),
                                                      fontSize: ConstanceData.SIZE_TITLE14,
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

  var myScreenFocusNode = FocusNode();

  _submit() async {
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
    _formKey.currentState.save();

    await Future.delayed(const Duration(seconds: 1));
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

  String _validateEmail(value) {
    if (value.isEmpty) {
      return "Email cannot be empty";
    } else if (Validators.validateEmail(value) == false) {
      return "Please enter valid email";
    }
    return null;
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
