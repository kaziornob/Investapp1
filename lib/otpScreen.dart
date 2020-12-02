import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:auro//forgotPassword.dart';
import 'package:auro/style/theme.dart' as Theme;
import 'package:auro/serverConfigRequest/AllRequest.dart';
import 'package:toast/toast.dart';




class OtpPage extends StatefulWidget {

  // ignore: non_constant_identifier_names
  final String email;
  // ignore: non_constant_identifier_names
  final String encodedOtp;

  static String reqEncodedOtp = '';

  // ignore: non_constant_identifier_names
  const OtpPage({Key key, this.email,this.encodedOtp}) : super(key: key);


  @override
  OtpPageState createState() => OtpPageState();
}

class OtpPageState extends State<OtpPage> {

  TextEditingController controller1 = new TextEditingController();
  TextEditingController controller2 = new TextEditingController();
  TextEditingController controller3 = new TextEditingController();
  TextEditingController controller4 = new TextEditingController();
  TextEditingController controller5 = new TextEditingController();
  TextEditingController controller6 = new TextEditingController();

  TextEditingController currController = new TextEditingController();

  AllHttpRequest request = new AllHttpRequest();
  int _state;

  String otpWaitTimeLabel;


  @override
  void dispose() {
    super.dispose();
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();
    controller6.dispose();
    otpWaitTimeLabel = "00:00";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    otpWaitTimeLabel = "";
    _state = 0;
    currController = controller1;
    OtpPage.reqEncodedOtp = widget.encodedOtp;
    // startTimer();

  }



  // otp verify process
  Future submit(otpVal) async {

    var email = widget.email;
    // set up POST request arguments
    String json = '{"email":"$email","otp":"$otpVal"}';
    var response = await request.otpRequest('verify_OTP',json,OtpPage.reqEncodedOtp);
    return response;
  }

  void startTimer() {
    // ignore: cancel_subscriptions
    var sub = CountDown(new Duration(minutes: 5)).stream.listen(null);

    sub.onData((Duration d) {
      setState(() {
        int sec = d.inSeconds % 60;
//        otpWaitTimeLabel = d.inMinutes.toString() + ":" + sec.toString();
        otpWaitTimeLabel = formatTime(d.inMinutes) + ":" + formatTime(sec);
      });
    });

    sub.onDone(() {
    });
  }

  String formatTime(int timeNum) {
    return timeNum < 10 ? "0" + timeNum.toString() : timeNum.toString();
  }


  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [

      Padding(
        padding: EdgeInsets.only(left: 0.0, right: 2.0),
        child: new Container(
          color: Colors.transparent,
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: new Container(
            alignment: Alignment.center,
            decoration: new BoxDecoration(
                // color: Color.fromRGBO(0, 0, 0, 0.1),
                color: Color(0xFFFFFFFF),

                border: new Border.all(
                    width: 1.0,
                    color: Color.fromRGBO(0, 0, 0, 0.1)
                ),
                borderRadius: new BorderRadius.circular(4.0)
            ),
            child: new TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
              ],
              enabled: false,
              controller: controller1,
              autofocus: false,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, color: Colors.black),

            )

        ),
      ),

      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: new Container(
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              // color: Color.fromRGBO(0, 0, 0, 0.1),
              color: Color(0xFFFFFFFF),

              border: new Border.all(
                  width: 1.0,
                  color: Color.fromRGBO(0, 0, 0, 0.1)
              ),
              borderRadius: new BorderRadius.circular(4.0)
          ),
          child: new TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],
            controller: controller2,
            autofocus: false,
            enabled: false,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: new Container(
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              // color: Color.fromRGBO(0, 0, 0, 0.1),
              color: Color(0xFFFFFFFF),

              border: new Border.all(
                  width: 1.0,
                  color: Color.fromRGBO(0, 0, 0, 0.1)
              ),
              borderRadius: new BorderRadius.circular(4.0)
          ),
          child: new TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],

            keyboardType: TextInputType.number,
            controller: controller3,
            textAlign: TextAlign.center,
            autofocus: false,
            enabled: false,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(right: 2.0, left: 2.0),
        child: new Container(
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              // color: Color.fromRGBO(0, 0, 0, 0.1),
              color: Color(0xFFFFFFFF),

              border: new Border.all(
                  width: 1.0,
                  color: Color.fromRGBO(0, 0, 0, 0.1)
              ),
              borderRadius: new BorderRadius.circular(4.0)
          ),
          child: new TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
            ],

            textAlign: TextAlign.center,
            controller: controller4,
            autofocus: false,
            enabled: false,
            style: TextStyle(fontSize: 24.0, color: Colors.black),
          ),
        ),
      ),

      Padding(
        padding: EdgeInsets.only(left: 2.0, right: 0.0),
        child: new Container(
          color: Colors.transparent,
        ),
      ),

    ];

    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      /*appBar: AppBar(
        title: Text('Verify Email'),
        leading: const BackButton(),
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  Theme.Colors.loginGradientStart,
                  Theme.Colors.loginGradientEnd
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
      ),*/
      backgroundColor: Color(0xFF000000),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 50.0,left: 10.0,right: 10.0,bottom: 10.0),
                    child: new Image(
                        width: 300.0,
                        fit: BoxFit.fill,
                        image: new AssetImage('assets/login_logo.png')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 55.0),
                    child: Text("Confirm OTP", style: TextStyle(
                        fontSize: 25.0, fontWeight: FontWeight.bold,color: Color(0xFFFFFFFF),),),
                  ),
/*                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text("Verifying your email!", style: TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 4.0, right: 16.0),
                    child: Text(
                      "Please type the verification code sent to",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, top: 2.0, right: 30.0),
                    child: Text(
                      '${widget.email}',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.red),
                      textAlign: TextAlign.center,),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Image(
                      image: AssetImage('assets/otp-icon.png'),
                      height: 120.0,
                      width: 120.0,),
                  ),*/

/*                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0,bottom: 5.0),
                        child: Text(
                          _state==2 ? ' '  : otpWaitTimeLabel,
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.red[500]),

                        ),

                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 15.0,left: 15.0,bottom: 5.0),
                        child: getResendButton(),
                      )

                    ],
                  )*/
                ],
              ), flex: 85,),

            Visibility(
              visible: (otpWaitTimeLabel=="00:00" || _state==2) ? false : true,
              child: Flexible(child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children
                      :
                  <Widget>[
                    GridView.count (
                        crossAxisCount:
                        8,
                        padding: EdgeInsets.only(left: 70.0),
                        mainAxisSpacing: 10.0,
                        shrinkWrap: true,
                        primary: false,
                        scrollDirection: Axis.vertical,
                        children: List < Container
                        >
                            .
                        generate
                          (
                            6, (int index) => Container(child: widgetList[index])
                        )
                    ),
                  ]
              )
                , flex: 13,),
            ),


            Visibility(
              visible: (otpWaitTimeLabel=="00:00" || _state==2) ? false : true,
              child: Flexible(child: Column(
                mainAxisSize:
                MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  new Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 16.0, right:
                      8.0, bottom: 0.0),
                      child: Row
                        (
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize
                            .min,
                        children: <Widget>[

                          MaterialButton
                            (onPressed: () {
                            inputTextToField("1");
                          }
                            , child: Text("1", style
                                : TextStyle(color: Color(0xFFFFFFFF),fontSize: 25.0, fontWeight: FontWeight
                                .w400), textAlign: TextAlign.center)
                            ,),

                          MaterialButton(onPressed: () {
                            inputTextToField("2");
                          }
                            , child: Text("2", style
                                : TextStyle(color: Color(0xFFFFFFFF),fontSize: 25.0, fontWeight: FontWeight
                                .w400), textAlign: TextAlign.center)
                            ,),

                          MaterialButton(onPressed: () {
                            inputTextToField("3");
                          }
                            , child: Text("3", style
                                : TextStyle(color: Color(0xFFFFFFFF),fontSize: 25.0, fontWeight: FontWeight
                                .w400), textAlign: TextAlign.center)
                            ,),
                        ],
                      ),
                    ),
                  ),

                  new Container(
                    child: Padding(
                      padding:
                      const EdgeInsets.only(left: 8.0, top
                          : 4.0, right: 8.0, bottom: 0.0
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.
                        start,
                        mainAxisSize: MainAxisSize.min,
                        children:
                        <Widget>[
                          MaterialButton(onPressed: () {
                            inputTextToField("4");
                          }
                            , child: Text("4", style
                                : TextStyle(color: Color(0xFFFFFFFF),fontSize: 25.0, fontWeight: FontWeight
                                .w400), textAlign: TextAlign.center)
                            ,),

                          MaterialButton(onPressed: () {
                            inputTextToField("5");
                          }
                            , child: Text("5", style
                                : TextStyle(color: Color(0xFFFFFFFF),fontSize: 25.0, fontWeight: FontWeight
                                .w400), textAlign: TextAlign.center)
                            ,),

                          MaterialButton(onPressed: () {
                            inputTextToField("6");
                          }
                            , child: Text("6", style
                                : TextStyle(color: Color(0xFFFFFFFF),fontSize: 25.0, fontWeight: FontWeight
                                .w400), textAlign: TextAlign.center)
                            ,),
                        ],
                      ),
                    ),
                  ),

                  new Container(
                    child: Padding(
                      padding:
                      const EdgeInsets.only(left: 8.0, top
                          : 4.0, right: 8.0, bottom: 0.0
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.
                        start,
                        mainAxisSize: MainAxisSize.min,
                        children:
                        <Widget>[
                          MaterialButton(onPressed: () {
                            inputTextToField("7");
                          }
                            , child: Text("7", style
                                : TextStyle(color: Color(0xFFFFFFFF),fontSize: 25.0, fontWeight: FontWeight
                                .w400), textAlign: TextAlign.center)
                            ,),

                          MaterialButton(onPressed: () {
                            inputTextToField("8");
                          }
                            , child: Text("8", style
                                : TextStyle(color: Color(0xFFFFFFFF),fontSize: 25.0, fontWeight: FontWeight
                                .w400), textAlign: TextAlign.center)
                            ,),

                          MaterialButton(onPressed: () {
                            inputTextToField("9");
                          }
                            , child: Text("9", style
                                : TextStyle(color: Color(0xFFFFFFFF),fontSize: 25.0, fontWeight: FontWeight
                                .w400), textAlign: TextAlign.center)
                            ,),
                        ],
                      ),
                    ),
                  ),

                  new Container(
                    child: Padding(
                      padding:
                      const EdgeInsets.only(left: 8.0, top
                          : 4.0, right: 8.0, bottom: 0.0
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.
                        start,
                        mainAxisSize: MainAxisSize.min,
                        children:
                        <Widget>[
                          MaterialButton(
                              onPressed: () {
                              deleteText();
                            },
                            child: Image.asset('assets/delete.png'
                                  , width: 25.0, height: 25.0,color: Color(0xFFFFFFFF),)),

                          MaterialButton(onPressed: () {
                            inputTextToField("0");
                          }
                            , child: Text("0", style
                                : TextStyle(color: Color(0xFFFFFFFF),fontSize: 25.0, fontWeight: FontWeight
                                .w400), textAlign: TextAlign.center)
                            ,),

                          MaterialButton(onPressed: () async {

                            var finalOtp = controller1.text + controller2.text + controller3.text + controller4.text;


                            if(finalOtp.length==4)
                            {
                              var value = await submit(finalOtp);

                              if (value == 'OTP Matched') {
                                matchOtp();
                              }
                              else
                              {
                                Toast.show("$value" + "", context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM);
                              }
                            }
                            else
                            {
                              Toast.show("Enter all digit", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            }
                          },
                              child: Image.asset('assets/success.png',
                                  width: 25.0, height: 25.0)),
                        ],
                      ),
                    ),
                  ),
                ],
              ), flex: 90,),
            )

          ],
        )
        ,
      )
      ,
    );
  }

  Widget getResendButton()
  {
    if(otpWaitTimeLabel=="00:00")
    {
      return  SizedBox(
        height: 30,
        width: _state==0 ? 105 : 115,
        child: new MaterialButton(
            child: setUpButtonChild(),
            onPressed: () {
              setState(() {
                if (_state == 0) {
                  resendOtp();
                  animateButton();
                }
              });
            },
            color: Colors.yellow[900],
        ),
      );
    }
    else
    {
      return Container(
        height: 0.0,
        width: 0.0,
      );
    }
  }

  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        "Resend Otp",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14.0,
        ),
      );
    } else if (_state == 1) {
      return CircularProgressIndicator(
        strokeWidth: 2.2,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return new Text(
        "Already sent",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14.0,
        ),
      );
    }
  }


  void animateButton() {
    setState(() {
      _state = 1;
    });
  }

  void inputTextToField(String str) {
    //Edit first textField
    if (currController == controller1) {
      controller1.text = str;
      currController = controller2;
    }

    //Edit second textField
    else if (currController == controller2) {
      controller2.text = str;
      currController = controller3;
    }

    //Edit third textField
    else if (currController == controller3) {
      controller3.text = str;
      currController = controller4;
    }

    //Edit fourth textField
    else if (currController == controller4) {
      controller4.text = str;
      currController = controller5;
    }

    //Edit fifth textField
    else if (currController == controller5) {
      controller5.text = str;
      currController = controller6;
    }

    //Edit sixth textField
    else if (currController == controller6) {
      controller6.text = str;
      currController = controller6;
    }
  }

  void deleteText() {
    if (currController.text.length == 0) {

    }
    else {
      currController.text = "";
      currController = controller5;
      return;
    }

    if (currController == controller1) {
      controller1.text = "";
    }
    else if (currController == controller2) {
      controller1.text = "";
      currController = controller1;
    }
    else if (currController == controller3) {
      controller2.text = "";
      currController = controller2;
    }
    else if (currController == controller4) {
      controller3.text = "";
      currController = controller3;
    }
    else if (currController == controller5) {
      controller4.text = "";
      currController = controller4;
    }
    else if (currController == controller6) {
      controller5.text = "";
      currController = controller5;
    }
  }

  void matchOtp() {
    showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text("Otp matched successfully."),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  setState(() {
                    _state = 2;
                    otpWaitTimeLabel = "00:00";
                  });
                  if(_state==2)
                    {

                      Navigator.of(context).pop();
/*                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ForgotPassword(email: widget.email)));*/
                    }
                },
              ),
            ],);
        }
    );
  }


  Future resendOtp() async {

    FocusScope.of(context).requestFocus(FocusNode());

    var value = await getOtp();
    setState(() {
      controller1.text = '';
      controller2.text = '';
      controller3.text = '';
      controller4.text = '';
      currController = controller1;
    });
    if (value['Status'] == true) {
      getDialog(value['otp']);
    }
    else
      {
        Toast.show("Something went wrong", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM);
        setState(() {
          _state = 0;
        });
      }

  }

  // email verify process
  Future getOtp() async {
    String json =
        '{"email":"${widget.email}"}';
    // var response = await request.getPostRequestWithParam('Forget_password',json);
    var response;
    return response;
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
                  setState(() {
                    _state = 0;
                  });
                  OtpPage.reqEncodedOtp = otp;
                  Navigator.of(context).pop();
                  startTimer();
                },
              ),
            ],);
        }
    );
  }


}

class CountDown {
  /// reference point for start and resume
  DateTime _begin;
  Timer _timer;
  Duration _duration;
  Duration remainingTime;
  bool isPaused = false;
  StreamController<Duration> _controller;
  Duration _refresh;
  /// provide a way to send less data to the client but keep the data of the timer up to date
  int _everyTick, counter = 0;
  /// once you instantiate the CountDown you need to register to receive information
  CountDown(Duration duration, {Duration refresh: const Duration(milliseconds: 10), int everyTick: 1}) {
    _refresh = refresh;
    _everyTick = everyTick;

    this._duration = duration;
    _controller = new StreamController<Duration>(onListen: _onListen, onPause: _onPause, onResume: _onResume, onCancel: _onCancel);
  }
  Stream<Duration> get stream => _controller.stream;
  /// _onListen
  /// invoke when the first subscriber has subscribe and not before to avoid leak of memory
  _onListen() {
    // reference point
    _begin = new DateTime.now();
    _timer = new Timer.periodic(_refresh, _tick);
  }
  /// the remaining time is set at '_refresh' ms accurate
  _onPause() {
    isPaused = true;
    _timer.cancel();
    _timer = null;
  }
  /// ...restart the timer with the new duration
  _onResume() {
    _begin = new DateTime.now();
    _duration = this.remainingTime;
    isPaused = false;
    //  lance le timer
    _timer = new Timer.periodic(_refresh, _tick);
  }
  _onCancel() {
    // on pause we already cancel the _timer
    if (!isPaused) {
      _timer.cancel();
      _timer = null;
    }
    // _controller.close(); // close automatically the "pipe" when the sub close it by sub.cancel()
  }

  void _tick(Timer timer) {
    counter++;
    Duration alreadyConsumed = new DateTime.now().difference(_begin);
    this.remainingTime = this._duration - alreadyConsumed;
    if (this.remainingTime.isNegative) {
      timer.cancel();
      timer = null;
      // tell the onDone's subscriber that it's finish
      _controller.close();
    } else {
      // here we can control the frequency of sending data
      if (counter % _everyTick == 0) {
        _controller.add(this.remainingTime);
        counter = 0;
      }
    }
  }
}