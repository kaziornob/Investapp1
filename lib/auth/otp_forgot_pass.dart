import 'package:animator/animator.dart';
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/global.dart';
import 'package:auroim/constance/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

import 'confirm_new_password.dart';

class ForgotPasswordOtpScreen extends StatefulWidget {
  final email;

  const ForgotPasswordOtpScreen({Key key, this.email}) : super(key: key);

  @override
  _ForgotPasswordOtpScreenState createState() =>
      _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> {
  bool _isInProgress = false;
  ApiProvider request = ApiProvider();

  var height = 0.0;
  var width = 0.0;
  bool isSelectButton1 = false;
  bool isSelectButton2 = false;
  bool isSelectButton3 = false;
  bool isSelectButton4 = false;

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  TextEditingController currController = TextEditingController();

  @override
  void initState() {
    loadUserDetails();
    super.initState();
  }

  loadUserDetails() async {
    setState(() {
      _isInProgress = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      _isInProgress = false;
      currController = controller1;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    double appBarheight = appBar.preferredSize.height;
    return Stack(
      children: <Widget>[
        Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                HexColor(globals.primaryColorString).withOpacity(0.9),
                HexColor(globals.primaryColorString).withOpacity(0.9),
                HexColor(globals.primaryColorString).withOpacity(0.9),
                HexColor(globals.primaryColorString).withOpacity(0.9),
              ],
            ),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/logInSlider1.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
        SafeArea(
          bottom: true,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: ModalProgressHUD(
              inAsyncCall: _isInProgress,
              opacity: 0,
              progressIndicator: CupertinoActivityIndicator(
                radius: 12,
              ),
              child: !_isInProgress
                  ? Column(
                      children: <Widget>[
                        SizedBox(
                          height: appBarheight,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16, left: 16),
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
                                  builder: (_, anim, __) =>
                                      FractionalTranslation(
                                    translation: anim.value,
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color:
                                          AllCoustomTheme.getTextThemeColors(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SizedBox(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Animator(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.decelerate,
                              cycles: 1,
                              builder: (_, anim, __) => Transform.scale(
                                scale: anim.value,
                                child: Text(
                                  'Enter OTP',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AllCoustomTheme.getTextThemeColors(),
                                    fontWeight: FontWeight.bold,
                                    fontSize: ConstanceData.SIZE_TITLE18,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        totalPinNumber >= 5
                            ? animateOnErrorOtp()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  isSelectButton1
                                      ? pinWidget(controller1)
                                      : PinDisable(),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  isSelectButton2
                                      ? pinWidget(controller2)
                                      : PinDisable(),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  isSelectButton3
                                      ? pinWidget(controller3)
                                      : PinDisable(),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  isSelectButton4
                                      ? pinWidget(controller4)
                                      : PinDisable(),
                                ],
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                // resendOtp();
                              },
                              child: Text(
                                'Didn’t receive an OTP?',
                                style: TextStyle(
                                  color: AllCoustomTheme.getTextThemeColors(),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: SizedBox(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Animator(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.decelerate,
                            cycles: 1,
                            builder: (_, anim, __) => Transform.scale(
                              scale: anim.value,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      customKeyboardKeys(
                                          "1", () => isPressNumberButton1('1')),
                                      customKeyboardKeys(
                                          "2", () => isPressNumberButton1('2')),
                                      customKeyboardKeys(
                                          "3", () => isPressNumberButton1('3')),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      customKeyboardKeys(
                                          "4", () => isPressNumberButton1('4')),
                                      customKeyboardKeys(
                                          "5", () => isPressNumberButton1('5')),
                                      customKeyboardKeys(
                                          "6", () => isPressNumberButton1('6')),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      customKeyboardKeys(
                                          "7", () => isPressNumberButton1('7')),
                                      customKeyboardKeys(
                                          "8", () => isPressNumberButton1('8')),
                                      customKeyboardKeys(
                                          "9", () => isPressNumberButton1('9')),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: InkWell(
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          onTap: () async {
                                            print(
                                                "total number: $totalPinNumber");
                                            // if(totalPinNumber==4) {
                                            if (controller1.text != "" &&
                                                controller2.text != "" &&
                                                controller3.text != "" &&
                                                controller4.text != "") {
                                              var finalOtp = controller1.text +
                                                  controller2.text +
                                                  controller3.text +
                                                  controller4.text;
                                              print("final otp: $finalOtp");
                                              submit(finalOtp);
                                            } else {
                                              Toast.show(
                                                  "Enter all digit", context,
                                                  duration: Toast.LENGTH_LONG,
                                                  gravity: Toast.BOTTOM);
                                            }
                                          },
                                          child: Icon(
                                            Icons.check,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      customKeyboardKeys(
                                          "0", () => isPressNumberButton1('0')),
                                      Expanded(
                                        child: InkWell(
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          onTap: () {
                                            removePin();
                                          },
                                          child: Icon(
                                            Icons.keyboard_arrow_left,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  : SizedBox(),
            ),
          ),
        )
      ],
    );
  }

  animateOnErrorOtp() {
    return Animator(
      tween: Tween<Offset>(
        begin: Offset(-3, 0),
        end: Offset(3, 0),
      ),
      duration: Duration(milliseconds: 500),
      cycles: 2,
      builder: (_, anim, __) => Transform(
        transform: Matrix4.translationValues(anim.value.dx, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            isSelectButton1 ? PinEnable() : PinDisable(),
            SizedBox(
              width: 16,
            ),
            isSelectButton2 ? PinEnable() : PinDisable(),
            SizedBox(
              width: 16,
            ),
            isSelectButton3 ? PinEnable() : PinDisable(),
            SizedBox(
              width: 16,
            ),
            isSelectButton4 ? PinEnable() : PinDisable(),
          ],
        ),
      ),
    );
  }

  customKeyboardKeys(digit, callback) {
    return Expanded(
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: callback,
        child: PinNumberStyle(
          digit: '$digit',
        ),
      ),
    );
  }

  pinWidget(controller) {
    return Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [globals.buttoncolor1, globals.buttoncolor2],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Center(
          child: Center(
            child: CircleAvatar(
              radius: 4,
              backgroundColor: AllCoustomTheme.getTextThemeColors(),
              child: TextField(
                controller: controller,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // otp verify process
  submit(otp) async {
    HelperClass.showLoading(context, null, false);

    // var tempJsonReq = {"email": "${widget.email}", "otp": "$otp"};

    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(
        builder: (context) => ConfirmNewPassword(
          email: widget.email,
          otp: otp,
        ),
      ),
    );
    // String jsonReq = json.encode(tempJsonReq);

    // var jsonReqResp = await request.postSubmit('users/otp', jsonReq);
    // var result = json.decode(jsonReqResp.body);

    // print("otp  response: $result");
    //
    // if (jsonReqResp.statusCode == 200 || jsonReqResp.statusCode == 201) {
    //   if (result != null &&
    //       result.containsKey('auth') &&
    //       result['auth'] == true) {
    //     var now = new DateTime.now();
    //     final SharedPreferences prefs = await SharedPreferences.getInstance();
    //     prefs.setString('Session_token', result['token']);
    //     prefs.setString(
    //       'DateTime',
    //       new DateFormat("yyyy-MM-dd HH:mm").format(now),
    //     );
    //     Navigator.pop(context);
    //
    //     Toast.show("${result['message']}", context,
    //         duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    //
    //     await Future.delayed(const Duration(milliseconds: 700));
    //
    //     Navigator.of(context, rootNavigator: true).push(
    //       CupertinoPageRoute<void>(
    //         builder: (BuildContext context) => UserPersonalDetails(),
    //       ),
    //     );
    //     // matchOtp(result["message"]);
    //   }
    // } else if (result != null &&
    //     result.containsKey('auth') &&
    //     result['auth'] != true) {
    //   Navigator.pop(context);
    //   Toast.show("${result['message']}", context,
    //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    // } else {
    //   Navigator.pop(context);
    //   Toast.show("Something went wrong!", context,
    //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    // }
  }

  isPressNumberButton1(String str) {
    if (!isSelectButton1) {
      setState(() {
        isSelectButton1 = true;
        controller1.text = str;
        currController = controller2;
      });
      totalPinNumber++;
    } else if (!isSelectButton2) {
      setState(() {
        isSelectButton2 = true;
        controller2.text = str;
        currController = controller3;
      });
      totalPinNumber++;
    } else if (!isSelectButton3) {
      setState(() {
        isSelectButton3 = true;
        controller3.text = str;
        currController = controller4;
      });
      totalPinNumber++;
    } else if (!isSelectButton4) {
      setState(() {
        isSelectButton4 = true;
        controller4.text = str;
        currController = controller5;
      });
      totalPinNumber++;
    }
    print("while num press ,total pin number: $totalPinNumber");
  }

  int totalPinNumber = 0;

  removePin() {
    isSelectButton4
        ? setState(() {
            isSelectButton4 = false;
            controller4.text = "";
            currController = controller3;
            totalPinNumber--;
          })
        : isSelectButton3
            ? setState(() {
                isSelectButton3 = false;
                controller3.text = "";
                currController = controller2;
                totalPinNumber--;
              })
            : isSelectButton2
                ? setState(() {
                    isSelectButton2 = false;
                    controller2.text = "";
                    currController = controller1;
                    totalPinNumber--;
                  })
                : isSelectButton1
                    ? setState(() {
                        isSelectButton1 = false;
                        controller1.text = "";
                        totalPinNumber--;
                      })
                    : setState(() {
                        totalPinNumber--;
                      });
  }
}
