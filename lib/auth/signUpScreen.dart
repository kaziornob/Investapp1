import 'dart:convert';
import 'dart:ui';
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/auth/otp.dart';
import 'package:auroim/auth/signInScreen.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/static_data/static_data.dart';
import 'package:auroim/widgets/animated_widgets/animated_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:toast/toast.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isInProgress = false;
  bool _obscureText = true;
  bool phoneError = true;
  ApiProvider request = new ApiProvider();
  final internationalPhoneInput = InternationalPhoneInput();
  final _signUpFormKey = GlobalKey<FormState>();

  var callingCodes = StaticData.callingCodes;

  //  //facebook sign in
  // FacebookLogin fbLogin = new FacebookLogin();

  String phoneNumber;
  String phoneIsoCode;
  bool visible = false;
  bool passwordFill = false;
  String confirmedNumber = '';

  TextEditingController emailController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController signUpConfirmPasswordController =
      TextEditingController();
  TextEditingController loginProviderController = TextEditingController();
  TextEditingController loginAccessTokenController = TextEditingController();

  @override
  void initState() {
    // callingCodes.sort((a,b) {
    //   if(int.parse(a.split("+")[1]) > int.parse(a.split("+")[1])){
    //     return a;
    //   }else{
    //     return b;
    //   }
    // });
    List ss = [];
    callingCodes.forEach((item) {
      int item1 = int.parse(item.replaceAll("-", "").split("+")[1]);
      ss.add(item1);
    });
    ss.sort();
    phoneIsoCode = '+852';
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    signUpConfirmPasswordController.dispose();
    signUpPasswordController.dispose();
    loginAccessTokenController.dispose();
    loginProviderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: AllCoustomTheme.getBodyContainerThemeColor(),
      body: SafeArea(
        child: _isInProgress
            ? BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaY: 5.0,
                  sigmaX: 5.0,
                ),
                child: Container(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            AnimatedBackButton(),
                            Text(
                              "Sign Up".toUpperCase(),
                              style: TextStyle(
                                fontSize: 26,
                                fontFamily: 'Rosario',
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(),
                          ],
                        ),
                      ),
                      formWidget(),
                      signUpButton(),
                    ],
                  ),
                  bottomTextWidget(),
                ],
              ),
      ),
    );
  }

  bottomTextWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Have an account? ",
                style: TextStyle(
                    color: Colors.black, fontFamily: 'Roboto', fontSize: 16),
              ),
              TextSpan(
                text: "Sign In",
                style: TextStyle(
                  color: Color(0xFFD8AF4F),
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context, rootNavigator: true).pushReplacement(
                      CupertinoPageRoute<void>(
                        builder: (BuildContext context) => SignInScreen(),
                      ),
                    );
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }

  showPass() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  formWidget() {
    return Form(
      key: _signUpFormKey,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              controller: emailController,
              validator: _validateEmail,
              cursorColor: AllCoustomTheme.getTextThemeColor(),
              style: TextStyle(
                fontSize: ConstanceData.SIZE_TITLE14,
                fontFamily: "Roboto",
                color: Color(0xffD8AF4F),
              ),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                focusColor: AllCoustomTheme.getTextThemeColor(),
                fillColor: AllCoustomTheme.getTextThemeColor(),
                hintText: 'Enter email here...',
                hintStyle: TextStyle(
                    color: Colors.grey[600],
                    fontSize: ConstanceData.SIZE_TITLE14),
                labelText: 'E-mail',
                labelStyle: AllCoustomTheme.getTextFormFieldLabelStyleTheme(),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, bottom: 0, right: 20),
            child: TextFormField(
              cursorColor: AllCoustomTheme.getTextThemeColor(),
              style: TextStyle(
                fontSize: ConstanceData.SIZE_TITLE14,
                fontFamily: "Roboto",
                color: Color(0xffD8AF4F),
              ),
              keyboardType: TextInputType.text,
              obscureText: _obscureText,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                focusColor: AllCoustomTheme.getTextThemeColor(),
                fillColor: AllCoustomTheme.getTextThemeColor(),
                hintText: 'Enter password here...',
                hintStyle: TextStyle(
                    color: Colors.grey[600],
                    fontSize: ConstanceData.SIZE_TITLE14),
                labelText: 'Password',
                labelStyle: AllCoustomTheme.getTextFormFieldLabelStyleTheme(),
                suffix: InkWell(
                  child: _obscureText
                      ? Icon(Icons.remove_red_eye)
                      : Icon(Icons.remove_red_eye_outlined),
                  onTap: showPass,
                ),
              ),
              validator: _validatePassword,
              controller: signUpPasswordController,
              onFieldSubmitted: (value) {
                setState(() {
                  passwordFill = true;
                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Visibility(
            visible: !passwordFill,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      "At least six characters with uppercase, lowercase and numbers",
                      style: TextStyle(
                        fontSize: ConstanceData.SIZE_TITLE10,
                        color: Color(0xff666666),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, bottom: 0, right: 20),
            child: TextFormField(
              cursorColor: AllCoustomTheme.getTextThemeColor(),
              style: TextStyle(
                fontSize: ConstanceData.SIZE_TITLE14,
                fontFamily: "Roboto",
                color: Color(0xffD8AF4F),
              ),
              keyboardType: TextInputType.text,
              obscureText: _obscureText,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                focusColor: AllCoustomTheme.getTextThemeColor(),
                fillColor: AllCoustomTheme.getTextThemeColor(),
                hintText: 'Re-Enter password here...',
                hintStyle: TextStyle(
                  color: Colors.grey[600],
                  fontSize: ConstanceData.SIZE_TITLE14,
                ),
                labelText: 'Confirm Password',
                labelStyle: AllCoustomTheme.getTextFormFieldLabelStyleTheme(),
                suffix: InkWell(
                  child: _obscureText
                      ? Icon(Icons.remove_red_eye)
                      : Icon(Icons.remove_red_eye_outlined),
                  onTap: showPass,
                ),
              ),
              validator: _validatePassword,
              controller: signUpConfirmPasswordController,
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  signUpButton() {
    return GestureDetector(
      onTap: _isInProgress
          ? () {}
          : () {
              _submit("", "");
            },
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
        child: Container(
          height: 45,
          width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
            color: Color(0xFFD8AF4F),
            borderRadius: BorderRadius.circular(37),
          ),
          child: Center(
            child: Text(
              "Sign Up",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  onValidPhoneNumber(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      visible = true;
      confirmedNumber = internationalizedPhoneNumber;
    });
  }

  _submit(from, token) async {
    if (signUpPasswordController.text.trim() ==
        signUpConfirmPasswordController.text.trim()) {
      Toast.show("Please Wait...", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      setState(() {
        _isInProgress = true;
      });
      if (_signUpFormKey.currentState.validate() == false) {
        setState(() {
          _isInProgress = false;
          print("form or phone no not valid");
        });
        return;
      }

      var email = emailController.text.trim();
      var password = signUpPasswordController.text.trim();
      var tempJsonReq;
      var provider;
      // var authToken;
      if (from == 'facebook' || from == 'google') {
        provider = loginProviderController.text;
        // authToken = token;
        tempJsonReq = {
          "email": "$email",
          "password": "$password",
          "provider": "$provider",
          "access_token": "$token"
        };
      } else {
        tempJsonReq = {
          "email": "$email",
          "password": "$password",
          "provider": "",
          "access_token": ""
        };
      }

      String jsonReq = json.encode(tempJsonReq);

      var jsonReqResp = await request.signUp('users/authenticate/new', jsonReq);

      var result = json.decode(jsonReqResp.body);

      if (jsonReqResp.statusCode == 200 || jsonReqResp.statusCode == 201) {
        if (result != null &&
            result.containsKey('auth') &&
            result['auth'] == true) {
          setState(() {
            _isInProgress = false;
          });
          var tempField = {
            "email": "$email",
            "password": "$password",
            "provider": "$provider",
            "access_token": "$token"
          };
          getDialog(tempField);
        }
      } else if (result != null &&
          result.containsKey('auth') &&
          result['auth'] != true) {
        Toast.show("${result['message']}", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

        setState(() {
          _isInProgress = false;
        });
      } else {
        setState(() {
          _isInProgress = false;
        });
        Toast.show("Something went wrong!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    } else {
      PasswordNotMatched(context);
    }
  }

  void getDialog(tempField) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            /*title: Text(
              "",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AllCoustomTheme.getTextThemeColors(),
                fontWeight: FontWeight.bold,
                fontSize: ConstanceData.SIZE_TITLE18,
              ),
            ),*/
            content: Text(
              "OTP sent to your mail",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Rosario',
                fontWeight: FontWeight.bold,
                fontSize: ConstanceData.SIZE_TITLE18,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Ok',
                  style: TextStyle(
                    color: Color(0xffD8AF4F),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: ConstanceData.SIZE_TITLE18,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context, rootNavigator: true)
                      .push(
                    CupertinoPageRoute<void>(
                      builder: (BuildContext context) =>
                          EnterOtpScreen(allParams: tempField),
                    ),
                  )
                      .then((onValue) {
                    setState(() {
                      _isInProgress = false;
                    });
                  });
                },
              ),
            ],
          );
        });
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

  String _validatePassword(value) {
    if (value.isEmpty) {
      return "Password cannot be empty";
    } else {
      String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
      RegExp regExp = new RegExp(pattern);
      if (!regExp.hasMatch(value)) {
        return "Min 6 characters, atleast 1 upper,lower & number";
      }
      return null;
    }
  }
}

// import 'dart:convert';
// import 'dart:ui';
// import 'package:auroim/api/apiProvider.dart';
// import 'package:auroim/auth/otp.dart';
// import 'package:auroim/auth/signInScreen.dart';
// import 'package:auroim/constance/constance.dart';
// import 'package:auroim/constance/themes.dart';
// import 'package:auroim/static_data/static_data.dart';
// import 'package:auroim/widgets/animated_widgets/animated_back_button.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:international_phone_input/international_phone_input.dart';
// import 'package:toast/toast.dart';
//
// class SignUpScreen extends StatefulWidget {
//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   bool _isInProgress = false;
//   bool _obscureText = true;
//   bool phoneError = true;
//   ApiProvider request = new ApiProvider();
//   final internationalPhoneInput = InternationalPhoneInput();
//   final _signUpFormKey = GlobalKey<FormState>();
//
//   var callingCodes = StaticData.callingCodes;
//
//   //  //facebook sign in
//   // FacebookLogin fbLogin = new FacebookLogin();
//
//   String phoneNumber;
//   String phoneIsoCode;
//   bool visible = false;
//   bool passwordFill = false;
//   String confirmedNumber = '';
//
//   TextEditingController emailController = TextEditingController();
//   TextEditingController signUpPasswordController = TextEditingController();
//   TextEditingController signUpConfirmPasswordController =
//       TextEditingController();
//   TextEditingController loginProviderController = TextEditingController();
//   TextEditingController loginAccessTokenController = TextEditingController();
//
//   @override
//   void initState() {
//     // callingCodes.sort((a,b) {
//     //   if(int.parse(a.split("+")[1]) > int.parse(a.split("+")[1])){
//     //     return a;
//     //   }else{
//     //     return b;
//     //   }
//     // });
//     List ss = [];
//     callingCodes.forEach((item) {
//       int item1 = int.parse(item.replaceAll("-", "").split("+")[1]);
//       ss.add(item1);
//     });
//     ss.sort();
//     phoneIsoCode = '+852';
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     emailController.dispose();
//     signUpConfirmPasswordController.dispose();
//     signUpPasswordController.dispose();
//     loginAccessTokenController.dispose();
//     loginProviderController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AllCoustomTheme.getBodyContainerThemeColor(),
//       body: SafeArea(
//         child: _isInProgress
//             ? BackdropFilter(
//                 filter: ImageFilter.blur(
//                   sigmaY: 5.0,
//                   sigmaX: 5.0,
//                 ),
//                 child: Container(
//                   height: 100,
//                   width: 100,
//                   child: CircularProgressIndicator(),
//                 ),
//               )
//             : SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               AnimatedBackButton(),
//                               Text(
//                                 "Sign Up",
//                                 style: TextStyle(
//                                   fontSize: 30,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               SizedBox(),
//                             ],
//                           ),
//                         ),
//                         formWidget(),
//                         signUpButton(),
//                       ],
//                     ),
//                     bottomTextWidget(),
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }
//
//   bottomTextWidget() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 20.0),
//       child: Container(
//         child: RichText(
//           text: TextSpan(
//             children: [
//               TextSpan(
//                 text: "Have An Account? ",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               TextSpan(
//                 text: "Sign In",
//                 style: TextStyle(
//                   color: Color(0xFFD8AF4F),
//                   fontWeight: FontWeight.bold,
//                 ),
//                 recognizer: TapGestureRecognizer()
//                   ..onTap = () {
//                     Navigator.of(context, rootNavigator: true).pushReplacement(
//                       CupertinoPageRoute<void>(
//                         builder: (BuildContext context) => SignInScreen(),
//                       ),
//                     );
//                   },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void onPhoneNumberChange(
//       String number, String internationalizedPhoneNumber, String isoCode) {
//     print(number);
//     setState(() {
//       phoneError = true;
//       phoneNumber = number;
//       phoneIsoCode = isoCode;
//       confirmedNumber = internationalizedPhoneNumber;
//       print("internationalNum $confirmedNumber");
//     });
//   }
//
//   showPass() {
//     setState(() {
//       _obscureText = !_obscureText;
//     });
//   }
//
//   formWidget() {
//     return Form(
//       key: _signUpFormKey,
//       child: Column(
//         children: <Widget>[
//           SizedBox(
//             height: 30,
//           ),
//           Row(
//             children: <Widget>[
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 20, top: 4, right: 20),
//                   child: TextFormField(
//                     controller: emailController,
//                     validator: _validateEmail,
//                     cursorColor: AllCoustomTheme.getTextThemeColor(),
//                     style: AllCoustomTheme.getTextFormFieldBaseStyleTheme(),
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: InputDecoration(
//                       focusColor: AllCoustomTheme.getTextThemeColor(),
//                       fillColor: AllCoustomTheme.getTextThemeColor(),
//                       hintText: 'Enter email here...',
//                       hintStyle: TextStyle(
//                           color: Colors.grey[600],
//                           fontSize: ConstanceData.SIZE_TITLE14),
//                       labelText: 'E-mail',
//                       labelStyle:
//                           AllCoustomTheme.getTextFormFieldLabelStyleTheme(),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Row(
//             children: <Widget>[
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 20, bottom: 10, right: 20),
//                   child: TextFormField(
//                     cursorColor: AllCoustomTheme.getTextThemeColor(),
//                     style: AllCoustomTheme.getTextFormFieldBaseStyleTheme(),
//                     keyboardType: TextInputType.text,
//                     obscureText: _obscureText,
//                     decoration: InputDecoration(
//                       focusColor: AllCoustomTheme.getTextThemeColor(),
//                       fillColor: AllCoustomTheme.getTextThemeColor(),
//                       hintText: 'Enter password here...',
//                       hintStyle: TextStyle(
//                           color: Colors.grey[600],
//                           fontSize: ConstanceData.SIZE_TITLE14),
//                       labelText: 'Password',
//                       labelStyle:
//                           AllCoustomTheme.getTextFormFieldLabelStyleTheme(),
//                       suffix: IconButton(
//                         icon: _obscureText
//                             ? Icon(Icons.remove_red_eye)
//                             : Icon(Icons.remove_red_eye_outlined),
//                         onPressed: showPass,
//                       ),
//                     ),
//                     validator: _validatePassword,
//                     controller: signUpPasswordController,
//                     onFieldSubmitted: (value) {
//                       setState(() {
//                         passwordFill = true;
//                       });
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Visibility(
//             visible: !passwordFill,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.only(left: 20, right: 20),
//                     child: Text(
//                       "Minimum six characters, at least one upper,lower and number",
//                       style: TextStyle(
//                         fontSize: ConstanceData.SIZE_TITLE12,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//               ],
//             ),
//           ),
//           Row(
//             children: <Widget>[
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 20, bottom: 10, right: 20),
//                   child: TextFormField(
//                     cursorColor: AllCoustomTheme.getTextThemeColor(),
//                     style: AllCoustomTheme.getTextFormFieldBaseStyleTheme(),
//                     keyboardType: TextInputType.text,
//                     obscureText: _obscureText,
//                     decoration: InputDecoration(
//                       focusColor: AllCoustomTheme.getTextThemeColor(),
//                       fillColor: AllCoustomTheme.getTextThemeColor(),
//                       hintText: 'Re-Enter password here...',
//                       hintStyle: TextStyle(
//                         color: Colors.grey[600],
//                         fontSize: ConstanceData.SIZE_TITLE14,
//                       ),
//                       labelText: 'Confirm Password',
//                       labelStyle:
//                           AllCoustomTheme.getTextFormFieldLabelStyleTheme(),
//                       suffix: IconButton(
//                         icon: _obscureText
//                             ? Icon(Icons.remove_red_eye)
//                             : Icon(Icons.remove_red_eye_outlined),
//                         onPressed: showPass,
//                       ),
//                     ),
//                     validator: _validatePassword,
//                     controller: signUpConfirmPasswordController,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Row(
//             children: <Widget>[
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 20, bottom: 0, right: 20),
//                   child: InternationalPhoneInput(
//                     labelText: 'Phone',
//                     labelStyle:
//                         AllCoustomTheme.getTextFormFieldLabelStyleTheme(),
//                     style: AllCoustomTheme.getTextFormFieldBaseStyleTheme(),
//                     onPhoneNumberChange: onPhoneNumberChange,
//                     initialPhoneNumber: phoneNumber,
//                     initialSelection: phoneIsoCode,
//                     enabledCountries: callingCodes,
//                     showCountryCodes: true,
//                     showCountryFlags: true,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Visibility(
//             visible: phoneError == false ? true : false,
//             child: Row(
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.only(left: 14, top: 4),
//                   child: Text(
//                     "Phone cannot be empty",
//                     style: TextStyle(
//                       fontSize: ConstanceData.SIZE_TITLE12,
//                       color: Color(0xFFC70039),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   signUpButton() {
//     return GestureDetector(
//       onTap: _isInProgress
//           ? () {}
//           : () {
//               _submit("", "");
//             },
//       child: Padding(
//         padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
//         child: Container(
//           height: 50,
//           width: MediaQuery.of(context).size.width - 40,
//           decoration: BoxDecoration(
//             color: Color(0xFFD8AF4F),
//             borderRadius: BorderRadius.circular(25),
//           ),
//           child: Center(
//             child: Text(
//               "Sign Up",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   onValidPhoneNumber(
//       String number, String internationalizedPhoneNumber, String isoCode) {
//     setState(() {
//       visible = true;
//       confirmedNumber = internationalizedPhoneNumber;
//     });
//   }
//
//   _submit(from, token) async {
//     if (signUpPasswordController.text.trim() ==
//         signUpConfirmPasswordController.text.trim()) {
//       Toast.show("Please Wait...", context,
//           duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//       setState(() {
//         _isInProgress = true;
//       });
//       if (_signUpFormKey.currentState.validate() == false ||
//           phoneNumber == "" ||
//           phoneNumber == null) {
//         setState(() {
//           _isInProgress = false;
//           print("form or phone no not valid");
//         });
//         return;
//       }
//
//       var email = emailController.text.trim();
//       var password = signUpPasswordController.text.trim();
//       var phone = confirmedNumber;
//       var tempJsonReq;
//       var provider;
//       var authToken;
//       if (from == 'facebook' || from == 'google') {
//         provider = loginProviderController.text;
//         authToken = token;
//         tempJsonReq = {
//           "email": "$email",
//           "password": "$password",
//           "phone": "$phone",
//           "provider": "$provider",
//           "access_token": "$token"
//         };
//       } else {
//         tempJsonReq = {
//           "email": "$email",
//           "password": "$password",
//           "phone": "$phone",
//           "provider": "",
//           "access_token": ""
//         };
//       }
//
//       String jsonReq = json.encode(tempJsonReq);
//
//       var jsonReqResp = await request.signUp('users/authenticate/new', jsonReq);
//
//       var result = json.decode(jsonReqResp.body);
//
//       if (jsonReqResp.statusCode == 200 || jsonReqResp.statusCode == 201) {
//         if (result != null &&
//             result.containsKey('auth') &&
//             result['auth'] == true) {
//           setState(() {
//             _isInProgress = false;
//           });
//           var tempField = {
//             "email": "$email",
//             "password": "$password",
//             "phone": "$phone",
//             "provider": "$provider",
//             "access_token": "$token"
//           };
//           getDialog(tempField);
//         }
//       } else if (result != null &&
//           result.containsKey('auth') &&
//           result['auth'] != true) {
//         Toast.show("${result['message']}", context,
//             duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//
//         setState(() {
//           _isInProgress = false;
//         });
//       } else {
//         setState(() {
//           _isInProgress = false;
//         });
//         Toast.show("Something went wrong!", context,
//             duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//       }
//     } else {
//       PasswordNotMatched(context);
//     }
//   }
//
//   void getDialog(tempField) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
//             title: Text(
//               "",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: AllCoustomTheme.getTextThemeColors(),
//                 fontWeight: FontWeight.bold,
//                 fontSize: ConstanceData.SIZE_TITLE18,
//               ),
//             ),
//             content: Text(
//               "OTP sent to your email",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: AllCoustomTheme.getTextThemeColors(),
//                 fontWeight: FontWeight.bold,
//                 fontSize: ConstanceData.SIZE_TITLE18,
//               ),
//             ),
//             actions: <Widget>[
//               FlatButton(
//                 child: Text(
//                   'Ok',
//                   style: TextStyle(
//                     color: AllCoustomTheme.getTextThemeColors(),
//                     fontWeight: FontWeight.bold,
//                     fontSize: ConstanceData.SIZE_TITLE18,
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   Navigator.of(context, rootNavigator: true)
//                       .push(
//                     CupertinoPageRoute<void>(
//                       builder: (BuildContext context) =>
//                           EnterOtpScreen(allParams: tempField),
//                     ),
//                   )
//                       .then((onValue) {
//                     setState(() {
//                       _isInProgress = false;
//                     });
//                   });
//                 },
//               ),
//             ],
//           );
//         });
//   }
//
//   // ignore: non_constant_identifier_names
//   Future<void> PasswordNotMatched(BuildContext context) {
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
//           title: Text(
//             "Confirm password didn't match",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: AllCoustomTheme.getTextThemeColors(),
//               fontWeight: FontWeight.bold,
//               fontSize: ConstanceData.SIZE_TITLE18,
//             ),
//           ),
//           actions: <Widget>[
//             FlatButton(
//               child: Text(
//                 'Ok',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: AllCoustomTheme.getTextThemeColors(),
//                   fontWeight: FontWeight.bold,
//                   fontSize: ConstanceData.SIZE_TITLE18,
//                 ),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   String _validateEmail(value) {
//     if (value.isEmpty) {
//       return "Email cannot be empty";
//     } else if (Validators.validateEmail(value) == false) {
//       return "Please enter valid email";
//     }
//     return null;
//   }
//
//   String _validatePassword(value) {
//     if (value.isEmpty) {
//       return "Password cannot be empty";
//     } else {
//       String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
//       RegExp regExp = new RegExp(pattern);
//       if (!regExp.hasMatch(value)) {
//         return "Min 6 characters, atleast 1 upper,lower & number";
//       }
//       return null;
//     }
//   }
// }
