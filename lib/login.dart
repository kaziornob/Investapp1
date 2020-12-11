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



class Login extends StatefulWidget {

  // ignore: non_constant_identifier_names
  static int selectedTab;

  static bool keyboardVisible=false;

  static bool signUpPressed=false;


  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login>
    with SingleTickerProviderStateMixin {
  AllHttpRequest request = new AllHttpRequest();

  DialogHelper helper = new DialogHelper();

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();
  final FocusNode myFocusNodeInstitute = FocusNode();

  TextEditingController loginUsernameController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();
  TextEditingController loginProviderController = new TextEditingController();
  TextEditingController loginAccessTokenController = new TextEditingController();


  bool _obscureTextLogin = true;

  TextEditingController signupInstController = new TextEditingController();
  TextEditingController signupNameController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupConfirmPasswordController = new TextEditingController();
  TextEditingController signupEmailController = new TextEditingController();

  PageController _pageController;

  Color left = Colors.black;
  Color right = Colors.white;

  bool _saving;

  Future submit(from) async {
    String json;

    setState(() {
      _saving = true;
    });

    if(from == 'facebook' || from == 'google')
    {
      var provider = loginProviderController.text;
      var token = loginAccessTokenController.text;

      // set up POST request arguments
      json = '{"username":"","password":"","provider":"$provider","access_token":"$token"}';
    }
    else
    {
      var email = loginUsernameController.text.trim();
      var password = loginPasswordController.text.trim();
      // set up POST request arguments

      json = '{"email":"$email","password":"$password","provider":"","access_token":""}';
    }
    var response = await request.login(json);
    return response;
  }

  // sign up process
  Future signUpSubmit() async {

    setState(() {
      _saving = true;
      Login.signUpPressed = false;
    });

    var name = signupNameController.text;
    var email = signupEmailController.text;
    var institute = signupInstController.text;
    var password = signupPasswordController.text;
    var confirmPassword = signupConfirmPasswordController.text;
    // set up POST request arguments
    String json =
        '{"email":"$email","username":"$name","password":"$password","confirmPassword":"$confirmPassword","institute":"$institute"}';
    var response = await request.submitSignUp(json);
    return response;
  }


  @override
  void dispose() {
    myFocusNodePassword.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodeName.dispose();
    _pageController?.dispose();
    _saving = false;
    super.dispose();
  }

  ScrollController _loginPageScrollController = new ScrollController();

  @override
  void initState() {

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {

        setState(() {
          Login.keyboardVisible = visible;
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

    setState(() {
      Login.selectedTab=0;
    });

    super.initState();
    _saving = false;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
  }

  List<Widget> _loginBuildForm(BuildContext context) {
    Form form = new Form(

      child: new ListView(
        controller: _loginPageScrollController,
        children: <Widget>[

          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*1.1,
            decoration: new BoxDecoration(
              color: Theme.Colors.backgroundLoginColor,
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.only(top: 20.0,left: 10.0,right: 10.0,bottom: 10.0),
                  child: new Image(
                      fit: BoxFit.fill,
                      image: new AssetImage('assets/sign_in.png')),
                ),

                Padding(
                    padding: EdgeInsets.only(top: 30.0,left: 10.0,right: 10.0,bottom: 10.0),
                    child: Text(
                      'SIGN IN',
                      style: new TextStyle(
                          fontFamily: "WorkSansBold",
                          color: Color(0xFF000000),
                          fontSize: 25.0,
                          letterSpacing: 0.2
                      ),
                    )
                ),

                Expanded(
                  flex: 2,
                  child: PageView(
                    controller: _pageController,
                    children: <Widget>[
                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildSignIn(context),
                      ),
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
        children: _loginBuildForm(context),
      ),
    );
  }

  Widget _buildSignIn(BuildContext context) {
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
                  height: 190.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeEmailLogin,
                          controller: loginUsernameController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.black,
                              size: 22.0,
                            ),
                            hintText: "Email",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                          ),
                          onSubmitted: (v) {
                            FocusScope.of(context)
                                .requestFocus(myFocusNodePasswordLogin);
                          },
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
                          focusNode: myFocusNodePasswordLogin,
                          controller: loginPasswordController,
                          obscureText: _obscureTextLogin,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.lock,
                              size: 22.0,
                              color: Colors.black,
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleLogin,
                              child: Icon(
                                _obscureTextLogin
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 350.0),
                decoration: new BoxDecoration(
                  color: Color(0xFFfec20f),
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                child: MaterialButton(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 42.0),
                    child: Text(
                      "DONE",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontFamily: "WorkSansBold"),
                    ),
                  ),
                  onPressed: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (loginUsernameController.text != '' &&
                        loginPasswordController.text != '') {
                      var value = await submit('');
                      if (value == true) {

                        setState(() {
                          loginPasswordController.text = '';
                          loginUsernameController.text = '';
                          _saving = false;

                        });

                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                            new MyHomePage(index: 0)));
                      } else {
                        setState(() {
                          _saving = false;
                        });
                        helper.ackAlert(context);
                      }
                    } else {
                      helper.MandotryField(context,'Email , Password');
                    }
                  },
                ),
              ),
            ],
          ),
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


  Future newSignUpSubmit() async {

    FocusScope.of(context).requestFocus(FocusNode());

    if (signupPasswordController.text ==
        signupConfirmPasswordController.text)
    {
        var value = await signUpSubmit();

        if (value == true) {
          new Future.delayed(new Duration(seconds: 2), () {
            setState(() {
              _saving = false;
              signupPasswordController.text = '';
              signupConfirmPasswordController.text = '';
              signupInstController.text = '';
              signupNameController.text = '';
              signupEmailController.text = '';
            });
          });
        }

        else
        {

          setState(() {
            _saving = false;

          });

          Toast.show("Already Exist", context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.CENTER);
        }


    } else {
      helper.PasswordNotMatched(context);
    }
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }
}
