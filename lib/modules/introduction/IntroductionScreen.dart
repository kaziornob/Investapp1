import 'package:carousel_slider/carousel_slider.dart';
import 'package:auroim/auth/signInScreen.dart';
import 'package:auroim/auth/signUpScreen.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/routes.dart';
import 'package:auroim/constance/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;

class IntroductionScreen extends StatefulWidget {
  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

final List<String> introSliderDataList = ['1','2','3','4','5'];


class _IntroductionScreenState extends State<IntroductionScreen> with SingleTickerProviderStateMixin {
  bool _visible = false;
  int _current=0;


  AnimationController controller;
  Animation<Offset> offset;

  @override
  void initState() {
    super.initState();
    animationText();
    secoundAnimation();
  }

  animationText() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _visible = true;
    });
  }

  secoundAnimation() {
    controller = AnimationController(vsync: this, duration: Duration(seconds: 1));

    offset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 1)).animate(controller);

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    final List<Widget> introSliders = introSliderDataList.map((item) => Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Image(
                    fit: BoxFit.cover,
                    width: 1000.0,
                    image: new AssetImage('assets/handShake.png')
                ),
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    'Let experts build your investment portfolio,while you do whatever you do best',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    ),).toList();

    return Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Container(
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  HexColor(globals.primaryColorString).withOpacity(0.6),
                  HexColor(globals.primaryColorString).withOpacity(0.6),
                  HexColor(globals.primaryColorString).withOpacity(0.6),
                  HexColor(globals.primaryColorString).withOpacity(0.6),
                ],
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height, minWidth: MediaQuery.of(context).size.width),
                child: Padding(
                  padding: EdgeInsets.only(right: 16, left: 16, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.12,
                        child: Center(
                          child: new Image(
                              width: 270.0,
                              fit: BoxFit.fill,
                              image: new AssetImage('assets/logo.png')
                          ),
                        )
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.10,
                          margin: EdgeInsets.only(top: 5.0,left: 20.0,right: 10.0,bottom: 5.0),
                          child: Center(
                            child: Text(
                              'Learn how to invest responsibly irrespective of your background',
                              style: TextStyle(
                                fontSize: ConstanceData.SIZE_TITLE18,
                                color: AllCoustomTheme.getTextThemeColors(),
                                  letterSpacing: 0.2
                              ),
                            )
                          )
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.45,
                        /*margin: EdgeInsets.only(left: 30.0,right: 30.0),
                        decoration: new BoxDecoration(
                          // color: Color(0xFFFFFFFF),
                          border: Border.all(
                            color: Color(0xFFFFFFFF),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(2.0),
                          ),
                        ),*/
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CarouselSlider(
                                items: introSliders,
                                options: CarouselOptions(
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    height: 280.0,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _current = index;
                                      });
                                    }
                                ),
                              ),
                            ]
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: introSliderDataList.map((url) {
                            int index = introSliderDataList.indexOf(url);
                            return Container(
                              width: 10.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _current == index
                                    ? Color(0xFFFFFFFF)
                                    : Color(0xff696969),
                              ),
                            );
                          }).toList(),
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
                          child: Container(
                            height: 45.0,
                            alignment: FractionalOffset.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 1.5),
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  globals.buttoncolor1,
                                  globals.buttoncolor2,
                                ],
                              ),
                            ),
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                color: AllCoustomTheme.getReBlackAndWhiteThemeColors(),
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                          onPressed: () async {
                            await Future.delayed(
                                const Duration(seconds: 1));
                            Navigator.of(context,
                                rootNavigator: true)
                                .push(
                              CupertinoPageRoute<void>(
                                builder: (BuildContext context) =>
                                    SignUpScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Already have an account?',
                                    style: TextStyle(
                                        fontSize: ConstanceData.SIZE_TITLE18,
                                        color: AllCoustomTheme.getTextThemeColors(),
                                        letterSpacing: 0.2
                                    ),
                                  ),
                                  InkWell(
                                    onTap: ()
                                    async {
                                      await Future.delayed(const Duration(milliseconds: 700));

                                      Navigator.of(context, rootNavigator: true)
                                          .push(
                                        CupertinoPageRoute<void>(
                                          builder: (BuildContext context) => SignInScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Sign In',
                                      style: TextStyle(
                                          fontSize: ConstanceData.SIZE_TITLE18,
                                          color: AllCoustomTheme.getTextThemeColors(),
                                          letterSpacing: 0.2,
                                          decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  )
                                ],
                              )
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  bool isClickButton = false;

  goToNextScreen() async {
    setState(() {
      isClickButton = true;
    });
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      isClickButton = false;
    });
    Navigator.pushReplacementNamed(
      context,
      Routes.SwipeIntrodution,
    );
  }
}
