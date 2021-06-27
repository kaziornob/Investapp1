import 'dart:convert';
import 'dart:ui';
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/auth/forgotPasswordScreen.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/presentation/pages/app/homeScreen.dart';
import 'package:auroim/provider_abhinav/user_details.dart';
import 'package:auroim/widgets/animated_widgets/animated_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../main.dart';
import 'signUpScreen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isInProgress = false;
  bool _obscureText = true;

  ApiProvider request = ApiProvider();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _signInFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllCoustomTheme.getBodyContainerThemeColor(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        AnimatedBackButton(),
                        Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(),
                      ],
                    ),
                  ),
                  formWidget(),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 20.0,
                      bottom: 20,
                      top: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        forgotPassword(),
                      ],
                    ),
                  ),
                  signInButton(),
                ],
              ),
              bottomTextWidget(),
            ],
          ),
        ),
      ),
    );
  }

  forgotPassword() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          CupertinoPageRoute<void>(
            builder: (BuildContext context) => ForgotPasswordScreen(),
          ),
        );
      },
      child: Text(
        'Forgot Password?',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: "Roboto",
          color: AllCoustomTheme.getTextThemeColor(),
        ),
      ),
    );
  }

  formWidget() {
    return Form(
      key: _signInFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 20, top: 4, right: 20),
                  child: TextFormField(
                    validator: _validateEmail,
                    controller: emailController,
                    cursorColor: AllCoustomTheme.getTextThemeColor(),
                    style: AllCoustomTheme.getTextFormFieldBaseStyleTheme(),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        focusColor: AllCoustomTheme.getTextThemeColor(),
                        fillColor: AllCoustomTheme.getTextThemeColor(),
                        hintText: 'Enter email here...',
                        hintStyle: TextStyle(
                            color: Colors.grey[600],
                            fontSize: ConstanceData.SIZE_TITLE14),
                        labelText: 'E-mail',
                        labelStyle:
                            AllCoustomTheme.getTextFormFieldLabelStyleTheme()),
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
                  padding: EdgeInsets.only(left: 20, bottom: 15, right: 20),
                  child: TextFormField(
                    controller: passwordController,
                    cursorColor: AllCoustomTheme.getTextThemeColor(),
                    style: AllCoustomTheme.getTextFormFieldBaseStyleTheme(),
                    keyboardType: TextInputType.text,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      focusColor: AllCoustomTheme.getTextThemeColor(),
                      fillColor: AllCoustomTheme.getTextThemeColor(),
                      hintText: 'Enter password here...',
                      hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: ConstanceData.SIZE_TITLE14),
                      labelText: 'Password',
                      labelStyle:
                          AllCoustomTheme.getTextFormFieldLabelStyleTheme(),
                      suffix: IconButton(
                        icon: _obscureText
                            ? Icon(Icons.remove_red_eye)
                            : Icon(Icons.remove_red_eye_outlined),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    validator: _validatePassword,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _submit() async {
    Toast.show("Please Wait...", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    setState(() {
      _isInProgress = true;
    });

    if (_signInFormKey.currentState.validate() == false) {
      setState(() {
        _isInProgress = false;
      });
      return;
    }
    FocusScope.of(context).unfocus();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var email = emailController.text.trim();
    var password = passwordController.text.trim();
    // set up POST request arguments

    var tempJsonReq = {"email": "$email", "password": "$password"};
    String jsonReq = json.encode(tempJsonReq);

    var response = await request.login('users/authenticate/me', jsonReq);
    print("login response: $response");
    setState(() {
      _isInProgress = false;
    });
    if (response == true) {
      await getUserDetails();
      prefs.setString('InvestorType', userAllDetail["inv_status"]);
      globals.isGoldBlack = prefs != null &&
              prefs.containsKey('InvestorType') &&
              prefs.getString('InvestorType') != null &&
              prefs.getString('InvestorType') == 'Accredited Investor'
          ? false
          : true;
      Toast.show("Successfully Signed In", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          ModalRoute.withName("/Home"));
    } else {
      Toast.show("Wrong Email OR Password", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  signInButton() {
    return GestureDetector(
      onTap: _isInProgress ? () {} : _submit,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
          color: Color(0xFFD8AF4F),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            "Sign In",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
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

  bottomTextWidget() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20.0,
        top: 20.0,
      ),
      child: Container(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Don't Have An Account? ",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: "Sign up",
                style: TextStyle(
                  color: Color(0xFFD8AF4F),
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context, rootNavigator: true).pushReplacement(
                      CupertinoPageRoute<void>(
                        builder: (BuildContext context) => SignUpScreen(),
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

  getUserDetails() async {
    print("getting user Details");
    ApiProvider request = new ApiProvider();
    // print("call set screen");
    var response = await request.getRequest('users/get_details');
    print("user detail response: $response");
    if (response != null && response != false) {
      userAllDetail = response['data'];

      Provider.of<UserDetails>(context, listen: false)
          .setUserDetails(userAllDetail);
      print(userAllDetail.toString());
    } else {
      print("Not got user data");
    }
  }

  String _validatePassword(value) {
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
