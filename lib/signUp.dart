import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
// import 'package:auro/emailVerify.dart';
import 'package:auro/main.dart';
import 'package:auro/style/theme.dart' as Theme;
import 'package:auro/shared/dialog_helper.dart';
import 'package:auro/serverConfigRequest/AllRequest.dart';
import 'package:toast/toast.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'otpScreen.dart';



class SignUp extends StatefulWidget {
  static bool signUpKeyboardVisible=false;
  static bool signUpPressed=false;
  
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => new _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  AllHttpRequest request = new AllHttpRequest();
   final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();


  DialogHelper helper = new DialogHelper();

  final FocusNode myFocusNodeEmailSignUp = FocusNode();
  final FocusNode myFocusNodePasswordSignUp = FocusNode();

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();
  
  bool _obscureTextSignUp = true;

  TextEditingController signUpPhoneController = new TextEditingController();
  TextEditingController signUpNameController = new TextEditingController();
  TextEditingController signUpPasswordController = new TextEditingController();
  TextEditingController signUpConfirmPasswordController = new TextEditingController();
  TextEditingController signUpEmailController = new TextEditingController();

  PageController _signUpPageController;

  Color left = Colors.black;
  Color right = Colors.white;

  bool _saving;
  @override
  void dispose() {
    myFocusNodePassword.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodeName.dispose();
    _signUpPageController?.dispose();
    _saving = false;
    super.dispose();
  }

  ScrollController _loginPageScrollController = new ScrollController();

  @override
  void initState() {

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {

        setState(() {
          SignUp.signUpKeyboardVisible = visible;
        });

        if(visible==true)
        {
          _loginPageScrollController.animateTo(_loginPageScrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 700), curve: Curves.linear);
        }
        else
        {
          _loginPageScrollController.animateTo(_loginPageScrollController.position.minScrollExtent,
              duration: Duration(milliseconds: 700), curve: Curves.linear);
        }
      },
    );
    super.initState();
    _saving = false;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _signUpPageController = PageController();
  }

  List<Widget> _signUpBuildForm(BuildContext context) {
    Form form = new Form(

        child: new ListView(
          controller: _loginPageScrollController,
          children: <Widget>[

            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*1.1,
              decoration: new BoxDecoration(
                color: Theme.Colors.backgroundColor,
              ),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0,bottom: 10.0),
                    child: new Image(
                        width: 280.0,
                        fit: BoxFit.fill,
                        image: new AssetImage('assets/login_logo.png')),
                  ),

                  Padding(
                      padding: EdgeInsets.only(top: 30.0,left: 10.0,right: 10.0,bottom: 10.0),
                      child: Text(
                        'SIGN UP',
                        style: new TextStyle(
                            fontFamily: "WorkSansBold",
                            color: Color(0xFFFFFFFF),
                            fontSize: 25.0,
                            letterSpacing: 0.2
                        ),
                      )
                  ),

                  Expanded(
                    flex: 2,
                    child: PageView(
                      controller: _signUpPageController,
                      children: <Widget>[
                        new ConstrainedBox(
                          constraints: const BoxConstraints.expand(),
                           child: new Form(
                             key: _signUpFormKey,
                             // autovalidate: _autoSignUpValidate,
                             child: _buildSignUp(context),
                           ),
                        ),
/*                        new ConstrainedBox(
                          constraints: const BoxConstraints.expand(),

                          child: _buildSignUp(context),
                        ),*/
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );

    var l = new List<Widget>();
    l.add(form);

    if (_saving) {
      var modal = new Stack(
        children: [
          new Opacity(
            opacity: 0.3,
            child: const ModalBarrier(dismissible: false, color: Colors.grey),
          ),
          new Center(
            child: new CircularProgressIndicator(),
          ),
        ],
      );
      l.add(modal);
    }

    return l;
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: new Stack(
        children: _signUpBuildForm(context),
      ),
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 310.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 0.0, left: 25.0, right: 25.0),
                        child: TextFormField(
                          focusNode: myFocusNodeEmail,
                          controller: signUpEmailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: validateEmail,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.black,
                            ),
                            hintText: "Email",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 0.0, left: 25.0, right: 25.0),
                        child: TextFormField(
                          focusNode: myFocusNodePassword,
                          controller: signUpPasswordController,
                          obscureText: _obscureTextSignUp,
                          validator: validatePassword,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.lock,
                              color: Colors.black,
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleSignUp,
                              child: Icon(
                                _obscureTextSignUp
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 0.0, left: 25.0, right: 25.0),
                        child: TextFormField(
                          controller: signUpConfirmPasswordController,
                          obscureText: _obscureTextSignUp,
                          validator: validatePassword,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.lock,
                              color: Colors.black,
                            ),
                            hintText: "Confirm password",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleSignUp,
                              child: Icon(
                                _obscureTextSignUp
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeEmailSignUp,
                          controller: signUpPhoneController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.phoneSquare,
                              color: Colors.black,
                              size: 22.0,
                            ),
                            hintText: "Phone",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                          ),
                          onSubmitted: (v) {

                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 380.0),
                decoration: new BoxDecoration(
                  color: Color(0xFFfec20f),
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                child: MaterialButton(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 42.0),
                    child: Text(
                      "NEXT",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontFamily: "WorkSansBold"),
                    ),
                  ),
                  onPressed: () async {
                    if (_signUpFormKey.currentState.validate()) //    If all data are correct then save data to out variables
                      {
                          _signUpFormKey.currentState.save();
                          newSignUpSubmit();
                      }
                  },
                ),
              ),
            ],
          ),
/*          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: FlatButton(
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 16.0,
                      fontFamily: "WorkSansMedium"),
                )),
          ),*/

        ],
      ),
    );
  }

  void getPopUp() {
    showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Warning..."),
            content: Text("InProgress..."),
            actions: <Widget>[IconButton(
                icon: Icon(Icons.check), onPressed: () {
              Navigator.of(context).pop();
            })
            ],);
        }
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) && value!='' && value!=null)
      return 'Enter Valid Email';
    else
      return null;
  }

  String validateName(String value)
  {
    Pattern pattern =
        r'^[A-Za-z _]*[A-Za-z][A-Za-z _]*$';
    RegExp regex = new RegExp(pattern);

    if(value!='' && value!=null)
    {
      if (!regex.hasMatch(value))
        return 'Name Consist Only Alphabets';
      else
        return null;
    }
    else
    {
      return 'Enter Name';
    }
  }

  String validateInst(String value)
  {
    Pattern pattern =
        r'^[A-Za-z _]*[A-Za-z][A-Za-z _ 0-9]*$';
    RegExp regex = new RegExp(pattern);

    if(value!='' && value!=null)
    {
      if (!regex.hasMatch(value))
        return 'Institute Consist Only Alphanumeric';
      else
        return null;
    }
    else
    {
      return 'Enter Institute';
    }
  }

  String validatePassword(String value) {
    if(value!='' && value!=null)
    {
      if(!value.startsWith(' '))
        return null;
      else
        return 'Enter Valid Password';
    }
    else
    {
      return 'Enter Password';
    }

  }



  // sign up process
  Future signUpSubmit() async {

    setState(() {
      _saving = true;
      SignUp.signUpPressed = false;
    });

    var name = signUpNameController.text;
    var email = signUpEmailController.text;
    var phone = signUpPhoneController.text;
    var password = signUpPasswordController.text;
    var confirmPassword = signUpConfirmPasswordController.text;
    // set up POST request arguments
    String json =
        '{"email":"$email","username":"$name","password":"$password","confirmPassword":"$confirmPassword","phone":"$phone"}';
    var response = await request.submitSignUp(json);
    return response;
  }


  Future newSignUpSubmit() async {

    FocusScope.of(context).requestFocus(FocusNode());

    if (signUpPasswordController.text ==
        signUpConfirmPasswordController.text)
    {

      setState(() {
        _saving = false;

      });

      getDialog('9090');

/*      var value = await signUpSubmit();

      if (value == true) {
        new Future.delayed(new Duration(seconds: 2), () {
          setState(() {
            _saving = false;
            signUpPasswordController.text = '';
            signUpConfirmPasswordController.text = '';
            signUpPhoneController.text = '';
            signUpNameController.text = '';
            signUpEmailController.text = '';
          });
        });
        getDialog(value['otp']);
      }

      else
      {

        setState(() {
          _saving = false;

        });

        Toast.show("Already Exist", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.CENTER);
      }*/


    } else {
      helper.PasswordNotMatched(context);
    }
  }

  void getDialog(otp) {
    showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text("Otp sent to your entered email."),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          OtpPage(email: signUpEmailController.text, encodedOtp: "$otp" )));
                },
              ),
            ],);
        }
    );
  }

  void _toggleSignUp() {
    setState(() {
      _obscureTextSignUp = !_obscureTextSignUp;
    });
  }
}
