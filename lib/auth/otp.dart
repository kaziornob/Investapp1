import 'dart:convert';

import 'package:animator/animator.dart';
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/auth/userPersonalDetails.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/global.dart';
import 'package:auroim/constance/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class EnterOtpScreen extends StatefulWidget {
  final allParams;

  const EnterOtpScreen({Key key, this.allParams}) : super(key: key);

  @override
  _EnterOtpScreenState createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends State<EnterOtpScreen> {
  bool _isInProgress = false;
  ApiProvider request = new ApiProvider();

  var height = 0.0;
  var width = 0.0;
  bool isSelectbutton1 = false;
  bool isSelectbutton2 = false;
  bool isSelectbutton3 = false;
  bool isSelectbutton4 = false;

  TextEditingController controller1 = new TextEditingController();
  TextEditingController controller2 = new TextEditingController();
  TextEditingController controller3 = new TextEditingController();
  TextEditingController controller4 = new TextEditingController();
  TextEditingController controller5 = new TextEditingController();
  TextEditingController currController = new TextEditingController();

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
                                  builder: (anim) => FractionalTranslation(
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
                              builder: (anim) => Transform.scale(
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
                                  isSelectbutton1
                                      ? pinWidget(controller1)
                                      : PinDisable(),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  isSelectbutton2
                                      ? pinWidget(controller2)
                                      : PinDisable(),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  isSelectbutton3
                                      ? pinWidget(controller3)
                                      : PinDisable(),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  isSelectbutton4
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
                            builder: (anim) => Transform.scale(
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
      builder: (anim) => Transform(
        transform: Matrix4.translationValues(anim.value.dx, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            isSelectbutton1 ? PinEnable() : PinDisable(),
            SizedBox(
              width: 16,
            ),
            isSelectbutton2 ? PinEnable() : PinDisable(),
            SizedBox(
              width: 16,
            ),
            isSelectbutton3 ? PinEnable() : PinDisable(),
            SizedBox(
              width: 16,
            ),
            isSelectbutton4 ? PinEnable() : PinDisable(),
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

  // void matchOtp(msg) {
  //   showDialog(context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           // backgroundColor: Colors.orange,
  //           backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
  //           title: Text(
  //               "",
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //               color: AllCoustomTheme.getTextThemeColors(),
  //               fontWeight: FontWeight.bold,
  //               fontSize: ConstanceData.SIZE_TITLE18,
  //             ),
  //           ),
  //           content: Text(
  //               "$msg",
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
  //                   'Ok',
  //                 style: TextStyle(
  //                   color: AllCoustomTheme.getTextThemeColors(),
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: ConstanceData.SIZE_TITLE18,
  //                 ),
  //               ),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //                 Navigator.of(context, rootNavigator: true).push(
  //                   CupertinoPageRoute<void>(
  //                     builder: (BuildContext context) =>
  //                         UserPersonalDetails(),
  //                   ),
  //                 );
  //               },
  //             ),
  //           ],);
  //       }
  //   );
  // }

  // void getDialog(otp) {
  //   showDialog(context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text(
  //               "",
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //               color: Colors.black,
  //               fontWeight: FontWeight.bold,
  //               fontSize: ConstanceData.SIZE_TITLE18,
  //             ),
  //           ),
  //           content: Text(
  //               "OTP sent to your email",
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //               color: Colors.black,
  //               fontWeight: FontWeight.bold,
  //               fontSize: ConstanceData.SIZE_TITLE18,
  //             ),
  //           ),
  //           actions: <Widget>[
  //             FlatButton(
  //               child: Text('Ok'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],);
  //       }
  //   );
  // }

  // otp verify process
  submit(otp) async {
    HelperClass.showLoading(context,null,false);

    var tempJsonReq = {
      "email": "${widget.allParams['email']}",
      "password": "${widget.allParams['password']}",
      "phone": "${widget.allParams['phone']}",
      "otp": "$otp"
    };
    String jsonReq = json.encode(tempJsonReq);

    var jsonReqResp = await request.postSubmit('users/otp', jsonReq);
    var result = json.decode(jsonReqResp.body);

    print("otp  response: $result");

    if (jsonReqResp.statusCode == 200 || jsonReqResp.statusCode == 201) {
      if (result != null &&
          result.containsKey('auth') &&
          result['auth'] == true) {
        var now = new DateTime.now();
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('Session_token', result['token']);
        prefs.setString(
          'DateTime',
          new DateFormat("yyyy-MM-dd HH:mm").format(now),
        );
        Navigator.pop(context);

        Toast.show("${result['message']}", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

        await Future.delayed(const Duration(milliseconds: 700));

        Navigator.of(context, rootNavigator: true).push(
          CupertinoPageRoute<void>(
            builder: (BuildContext context) => UserPersonalDetails(),
          ),
        );
        // matchOtp(result["message"]);
      }
    } else if (result != null &&
        result.containsKey('auth') &&
        result['auth'] != true) {
      Navigator.pop(context);
      Toast.show("${result['message']}", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      Navigator.pop(context);
      Toast.show("Something went wrong!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  // email verify process
  // Future getOtp() async {
  //   // String json = '{"email":""}';
  //   // var response = await request.getPostRequestWithParam('Forget_password',json);
  //   var response;
  //   return response;
  // }

  // Future resendOtp() async {
  //
  //   FocusScope.of(context).requestFocus(FocusNode());
  //
  //   var value = await getOtp();
  //   setState(() {
  //     isSelectbutton1 = false;
  //     isSelectbutton2 = false;
  //     isSelectbutton3 = false;
  //     isSelectbutton4 = false;
  //     totalPinNumber =0;
  //   });
  //   if (value['Status'] == true) {
  //     getDialog(value['otp']);
  //   }
  //   else
  //   {
  //     Toast.show("Something went wrong", context,
  //         duration: Toast.LENGTH_LONG,
  //         gravity: Toast.BOTTOM);
  //   }
  //
  // }

  isPressNumberButton1(String str) {
    if (!isSelectbutton1) {
      setState(() {
        isSelectbutton1 = true;
        controller1.text = str;
        currController = controller2;
      });
      totalPinNumber++;
    } else if (!isSelectbutton2) {
      setState(() {
        isSelectbutton2 = true;
        controller2.text = str;
        currController = controller3;
      });
      totalPinNumber++;
    } else if (!isSelectbutton3) {
      setState(() {
        isSelectbutton3 = true;
        controller3.text = str;
        currController = controller4;
      });
      totalPinNumber++;
    } else if (!isSelectbutton4) {
      setState(() {
        isSelectbutton4 = true;
        controller4.text = str;
        currController = controller5;
      });
      totalPinNumber++;
    }
    print("while num press ,total pin number: $totalPinNumber");
  }

  int totalPinNumber = 0;

  removePin() {
    isSelectbutton4
        ? setState(() {
            isSelectbutton4 = false;
            controller4.text = "";
            currController = controller3;
            totalPinNumber--;
          })
        : isSelectbutton3
            ? setState(() {
                isSelectbutton3 = false;
                controller3.text = "";
                currController = controller2;
                totalPinNumber--;
              })
            : isSelectbutton2
                ? setState(() {
                    isSelectbutton2 = false;
                    controller2.text = "";
                    currController = controller1;
                    totalPinNumber--;
                  })
                : isSelectbutton1
                    ? setState(() {
                        isSelectbutton1 = false;
                        controller1.text = "";
                        totalPinNumber--;
                      })
                    : setState(() {
                        totalPinNumber--;
                      });
  }
}
