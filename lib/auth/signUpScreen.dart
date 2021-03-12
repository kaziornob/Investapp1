import 'dart:convert';
import 'package:animator/animator.dart';
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/auth/otp.dart';
import 'package:auroim/auth/signInScreen.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isInProgress = false;
  bool _isClickonSignIn = false;
  bool _visible = false;
  bool phoneError = true;
  ApiProvider request = new ApiProvider();
  final internationalPhoneInput = InternationalPhoneInput();
  //  //facebook sign in
  FacebookLogin fbLogin   =  new FacebookLogin();


  String phoneNumber;
  String phoneIsoCode;
  bool visible = false;
  String confirmedNumber = '';

  TextEditingController emailController = new TextEditingController();
  TextEditingController signUpPasswordController = new TextEditingController();
  TextEditingController signUpConfirmPasswordController = new TextEditingController();
  TextEditingController loginProviderController = new TextEditingController();
  TextEditingController loginAccessTokenController = new TextEditingController();


  animation() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _visible = true;
    });
  }

  @override
  void initState() {
    phoneIsoCode = '+852';
    super.initState();
    animation();
  }

  final _signUpFormKey = new GlobalKey<FormState>();

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
                // height: MediaQuery.of(context).size.height*1.37,
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
                                key: _signUpFormKey,
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
                                            padding: EdgeInsets.only(left: 14, top: 4,right: 20),
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
                                            padding: EdgeInsets.only(left: 14, bottom: 10,right: 20),
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
                                            padding: EdgeInsets.only(left: 14, bottom: 10,right: 20),
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
                                              padding: EdgeInsets.only(left: 10, bottom: 0,right: 20),
                                              child: InternationalPhoneInput(
                                                // decoration: InputDecoration(),
                                                labelText: 'Phone',
                                                labelStyle: AllCoustomTheme.getTextFormFieldLabelStyleTheme(),

                                                // style: AllCoustomTheme.getTextFormFieldBaseStyleTheme(),
                                                onPhoneNumberChange: onPhoneNumberChange,
                                                initialPhoneNumber: phoneNumber,
                                                initialSelection: phoneIsoCode,
                                                enabledCountries: ['+852', '+1', '+233', '+91'],
                                                showCountryCodes: true,
                                                showCountryFlags: true,
                                              ),
                                            ),
                                        ),
/*                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 0, bottom: 0,right: 20),
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
                                        ),*/
                                      ],
                                    ),
                                    Visibility(
                                      visible: phoneError==false  ? true : false,
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                              padding: EdgeInsets.only(left: 14, top: 4),
                                              child: Text(
                                                "Phone cannot be empty",
                                                style: TextStyle(
                                                  fontSize: ConstanceData.SIZE_TITLE12,
                                                  color: Color(0xFFC70039),
                                                ),
                                              )
                                          ),
                                        ],
                                      ),
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
                                            child: !_isInProgress
                                                ? GestureDetector(
                                              onTap: () {
                                                _submit('');
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
                              "Sign Up With Gmail",
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

                            fbLogin.logInWithReadPermissions(['email', 'public_profile']).then((result) async {
                              switch(result.status) {
                                case FacebookLoginStatus.loggedIn:
                                  final token = result.accessToken.token;
                                  final graphResponse = await http.get(
                                      'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token');
                                  final profile = json.decode(graphResponse.body);


                                  setState(() {
                                    loginProviderController.text = 'facebook';
                                    loginAccessTokenController.text = token;
                                  });

                                  if (loginProviderController.text != '' &&
                                       loginAccessTokenController.text != '') {
                                     _submit('facebook');
                                   }
                                  break;
                                case FacebookLoginStatus.cancelledByUser:
                                // TODO: Handle this case.
                                  break;
                                case FacebookLoginStatus.error:
                                // TODO: Handle this case.
                                  break;
                              }
                            })
                                .catchError((e) {
                            });
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

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    print(number);
    setState(() {
      phoneError = true;
      phoneNumber = number;
      phoneIsoCode = isoCode;
      confirmedNumber = internationalizedPhoneNumber;
      print("internationalNum $confirmedNumber");

    });
  }

  onValidPhoneNumber(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      visible = true;
      confirmedNumber = internationalizedPhoneNumber;
    });
  }

  var myScreenFocusNode = FocusNode();

  _submit(from) async {

    if(signUpPasswordController.text.trim() == signUpConfirmPasswordController.text.trim())
    {
      setState(() {
        _isInProgress = true;
      });
      await Future.delayed(const Duration(milliseconds: 700));
      FocusScope.of(context).requestFocus(myScreenFocusNode);
      print("phone number: $phoneNumber");
      print("phoneIsoCode: $phoneIsoCode");

      // || phoneNumber=="" || phoneNumber==null || phoneIsoCode=="" || phoneIsoCode==null
      if (_signUpFormKey.currentState.validate() == false || phoneNumber=="" || phoneNumber==null) {
        setState(() {
          _isInProgress = false;
/*            internationalPhoneInput.hasError = true;
            internationalPhoneInput.errorText = "Phone can not be empty";*/
          // internationalPhoneInput.onValidatePhoneNumber();
          print("form or phone no not valid");
          // phoneError = false;
        });
        return;
      }

      var email = emailController.text.trim();
      var password = signUpPasswordController.text.trim();
      var phone = confirmedNumber;
      var tempJsonReq ;var provider ;var token;
      if(from == 'facebook' || from == 'google')
       {
         provider = loginProviderController.text;
         token = loginAccessTokenController.text;
         tempJsonReq = {"email":"$email","password":"$password","phone":"$phone","provider":"$provider","access_token":"$token"};
       }
       else
       {
         tempJsonReq = {"email":"$email","password":"$password","phone":"$phone","provider":"","access_token":""};
       }


      String jsonReq = json.encode(tempJsonReq);

      var jsonReqResp = await request.signUp('users/authenticate/new',jsonReq);

      var result = json.decode(jsonReqResp.body);
      print("signup response: $result");

      if(jsonReqResp.statusCode == 200 || jsonReqResp.statusCode == 201)
      {

        if (result!=null && result.containsKey('auth') && result['auth']==true)
        {
          setState(() {
            _isInProgress = false;
          });

          var tempField = {
            "email": "$email",
            "password": "$password",
            "phone": "$phone",
            "provider":"$provider",
            "access_token":"$token"
          };
          getDialog(tempField);
        }
      }
      else if(result!=null && result.containsKey('auth') && result['auth']!=true)
      {

        Toast.show("${result['message']}", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM);

        setState(() {
          _isInProgress = false;
        });
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

  void getDialog(tempField) {
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

/*                  var tempField = {
                    "email": "$email",
                    "password": "$password",
                    "phone": "$phone"
                  };*/

                  Navigator.of(context).pop();
                  Navigator.of(context, rootNavigator: true).push(
                    CupertinoPageRoute<void>(
                      builder: (BuildContext context) =>
                          Otp(allParams: tempField),
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

  /*String _validatePhone(value) {
    // String pattern = r'(^(?:[+0]9)?[0-9]{7,10}$)';
    // RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Phone cannot be empty';
    }
    *//*else if (!regExp.hasMatch(value)) {
      return 'Please enter valid phone number';
    }*//*
    return null;
  }*/

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

      String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
      RegExp regExp = new RegExp(pattern);
      if(!regExp.hasMatch(value))
      {
        return "Minimum six characters, at least one upper,lower and number";
      }
      return null;
    }
  }
}
