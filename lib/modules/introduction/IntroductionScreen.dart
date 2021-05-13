import 'package:auroim/widgets/how_app_works.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:auroim/auth/signInScreen.dart';
import 'package:auroim/auth/signUpScreen.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/routes.dart';
import 'package:auroim/constance/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;

class IntroductionScreen extends StatefulWidget {
  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

final List<String> introSliderDataList = ['1', '2', '3', '4', '5'];

class _IntroductionScreenState extends State<IntroductionScreen>
    with SingleTickerProviderStateMixin {
  bool _visible = false;
  int _current = 0;

  AnimationController controller;
  Animation<Offset> offset;

  List listPaths = [
    {
      "logoBottomLine": "YOUR PERSONAL ASSET MANAGER",
      "firstPara": "",
      "image": "assets/logInSlider1.png",
      "lastPara":
          "Invest with confidence on world’s leading Robo and Social Investment App.Built by licenced asset-manager with strong track record of outperforming markets"
    },
    {
      "logoBottomLine": "PERSONALIZED PORTFOLIOS",
      "firstPara":
          "Let globally licensed (SEC, SFC,  SEBI FPI) asset manager build a personalized portfolio for you based on your risk appetite and goals",
      "image": "assets/personalizedPortfolio.png",
      "lastPara":
          "…hire professional money managers with a great track record to build an institutional grade portfolio for you."
    },
    {
      "logoBottomLine": "MULTIPLE ASSET CLASSES",
      "firstPara":
          "Tell us if you have any preferences and we’ll customize your portfolio across global stocks, bonds, "
              "commodities, crypto, private equity, hedge fund, venture capital, impact investing and private deals.",
      "image": "assets/multipleAssets.png",
      "lastPara": "..and Yes! we pick  securities that you can engage with, "
          "not just mutual funds and ETFs like other Robos…and so no double fees on those."
    },
    {
      "logoBottomLine": "LEARN HOW TO INVEST BETTER",
      "firstPara":
          "Master investment concepts with our Adaptive Learning Investment module. "
              "Ask questions and participate in discussions while earning Auro Coins that can be redeemed for free stocks.",
      "image": "assets/invest.png",
      "lastPara": "…Learn investment principles used by the all-time greats"
    },
    {
      "logoBottomLine": "PITCH STOCK & PORTFOLIOS",
      "firstPara":
          "Pitch stocks and portfolios while building your own investment track record",
      "image": "assets/pitchStock.png",
      "lastPara":
          "…allow others to follow your investments and earn a cut of their profits"
    },
    {
      "logoBottomLine": "FOLLOW STAR INVESTORS",
      "firstPara":
          "Choose from and Invest in a wide selection of professionally managed portfolios.",
      "image": "assets/starInvestor.png",
      "lastPara": "…while you sit back and watch your wealth grow"
    }
  ];

  @override
  void initState() {
    super.initState();
    animationText();
    secondAnimation();
  }

  animationText() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _visible = true;
    });
  }

  secondAnimation() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    offset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 1))
        .animate(controller);

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      // decoration: BoxDecoration(border: Border.all(color: Colors.green)),
      height: height,
      child: Stack(
        children: <Widget>[
          Visibility(
            visible: _current == 0 ? true : false,
            child: Image.asset(
              "assets/LogInSliderBackground.png",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Scaffold(
            backgroundColor: _current == 0
                ? Colors.transparent
                : AllCoustomTheme.getBodyContainerThemeColor(),
            body: SingleChildScrollView(
              child: Container(
                // height: MediaQuery.of(context).size.height*1.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(children: [
                        CarouselSlider.builder(
                          itemCount: listPaths.length,
                          options: CarouselOptions(
                              height: MediaQuery.of(context).size.height * 0.83,
                              autoPlay: false,
                              viewportFraction: 0.95,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              }),
                          itemBuilder: (context, index) {
                            return MySliderView(listPaths[index], _current);
                          },
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 50,
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: listPaths.map((url) {
                      int index = listPaths.indexOf(url);
                      return Container(
                        width: 10.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              // ? Color(0xFFFFFFFF)
                              ? Color(0xFFD8AF4F)
                              : Color(0xffCBB4B4),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                // GestureDetector(
                //   onTap: () async {
                //     await showDialog(
                //         context: context,
                //         builder: (context) {
                //           return HowAppWorks(
                //             videoLink:
                //                 "https://www.youtube.com/watch?v=zrVikZUqeH4",
                //           );
                //         });
                //   },
                //   child: Container(
                //     decoration: BoxDecoration(
                //       border: Border(
                //         bottom: BorderSide(
                //             color: _current != 0 ? Colors.grey : Colors.white),
                //       ),
                //     ),
                //     child: RichText(
                //       text: TextSpan(
                //         children: [
                //           TextSpan(
                //             text: "Why do i need Auro.AI?",
                //             style: TextStyle(
                //               fontSize: 15,
                //               color: _current != 0 ? Colors.grey : Colors.white,
                //               letterSpacing: 0.2,
                //               fontFamily: "Rasa",
                //               fontStyle: FontStyle.normal,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: (MediaQuery.of(context).size.width / 2) - 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          border: new Border.all(
                              color: Color(0xFFD8AF4F), width: 1.5),
                          color: Colors.transparent,
                        ),
                        child: MaterialButton(
                          splashColor: Colors.grey,
                          child: Text(
                            "Try For Free",
                            style: TextStyle(
                              color: Color(0xFFD8AF4F),
                              fontSize: ConstanceData.SIZE_TITLE14,
                            ),
                          ),
                          onPressed: () async {
                            Navigator.of(context, rootNavigator: true).push(
                              CupertinoPageRoute<void>(
                                builder: (BuildContext context) =>
                                    SignUpScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                      // SizedBox(
                      //   width: 5,
                      // ),
                      Container(
                        height: 40,
                        width: (MediaQuery.of(context).size.width / 2) - 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: new Border.all(
                            color: Color(0xFFD8AF4F),
                            width: 1.5,
                          ),
                          color: Color(0xFFFFB300),
                        ),
                        child: MaterialButton(
                          splashColor: Colors.grey,
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: ConstanceData.SIZE_TITLE14,
                            ),
                          ),
                          onPressed: () async {
                            Navigator.of(context, rootNavigator: true).push(
                              CupertinoPageRoute<void>(
                                builder: (BuildContext context) =>
                                    SignInScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      // TextSpan(
                      //   text: "Swipe to see how App works or click ",
                      //   style: TextStyle(
                      //     fontSize: 15,
                      //     color: _current != 0 ? Colors.grey : Colors.white,
                      //     letterSpacing: 0.2,
                      //     fontFamily: "Rasa",
                      //     fontStyle: FontStyle.normal,
                      //   ),
                      // ),
                      TextSpan(
                        text: "Why do I Need Auro.AI",
                        style: TextStyle(
                          fontSize: 15,
                          color: _current != 0 ? Colors.grey : Colors.white,
                          letterSpacing: 0.2,
                          fontFamily: "Rasa",
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return HowAppWorks(
                                  videoLink:
                                      "https://www.youtube.com/watch?v=J_87M2qmie4",
                                );
                              },
                            );
                          },
                      ),
                      // TextSpan(
                      //   text: "for video",
                      //   style: TextStyle(
                      //     fontSize: 15,
                      //     color: _current != 0 ? Colors.grey : Colors.white,
                      //     letterSpacing: 0.2,
                      //     fontFamily: "Rasa",
                      //     fontStyle: FontStyle.normal,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
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

class MySliderView extends StatelessWidget {
  final currentIndex;
  final allFields;

  MySliderView(this.allFields, this.currentIndex);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        // decoration: BoxDecoration(
        //   border: Border.all(color: Colors.white),
        // ),
        child: Column(
          children: [
            Container(
              // margin: EdgeInsets.only(top: 30.0),
              height: MediaQuery.of(context).size.height * 0.09,
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.white),
              // ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.white),
                    // ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(
                          height: 50,
                          width: 150.0,
                          fit: BoxFit.fill,
                          image: AssetImage('assets/logo.png'),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          // height: 50,
                          // width: 50,
                          // margin:,
                          // decoration: BoxDecoration(
                          //   border: Border.all(color: Colors.white),
                          // ),
                          child: Text(
                            "AI",
                            style: TextStyle(
                              fontSize: 60,
                              color: Color(0xFFD8AF4F),
                              fontFamily: "Scheherazade",
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   margin: EdgeInsets.only(left: 50.0, right: 50.0),
            //   padding: EdgeInsets.only(
            //     bottom: 1, // space between underline and text
            //   ),
            //   decoration: BoxDecoration(
            //       border: Border(
            //           bottom: BorderSide(
            //     color: Color(0xFFD8AF4F),
            //     width: 1.5, // Underline width
            //   ))),
            // ),
            Container(
              margin: EdgeInsets.only(top: 7.0),
              child: Text(
                '${allFields["logoBottomLine"]}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: ConstanceData.SIZE_TITLE18,
                    color: currentIndex == 0
                        ? Color(0xFFFFFFFF)
                        : Color(0xFF060513),
                    fontFamily: "Rasa",
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0.2),
              ),
            ),
            SizedBox(
              height: currentIndex != 0 ? 12 : 22,
            ),
            Visibility(
              visible: currentIndex != 0,
              child: LayoutBuilder(builder: (context, constraints) {
                return Container(
                  width: currentIndex == 1
                      ? constraints.maxWidth * 0.67
                      : constraints.maxWidth * 0.73,
                  child: Text(
                    "${allFields["firstPara"]}",
                    style: TextStyle(
                      fontSize: ConstanceData.SIZE_TITLE14,
                      color: Color(0xFF060513),
                      letterSpacing: 0.2,
                      fontFamily: "Rasa",
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                );
              }),
            ),
            Container(
              height: currentIndex == 0
                  ? MediaQuery.of(context).size.height * 0.35
                  : MediaQuery.of(context).size.height * 0.37,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: currentIndex == 0 ? 10.0 : 0.0),
              child: Image(
                fit: BoxFit.contain,
                image: AssetImage('${allFields["image"]}'),
              ),
            ),
            LayoutBuilder(builder: (context, constraints) {
              // print("layout builder :: ${constraints.maxWidth} ::: ${constraints.maxHeight}");
              return Container(
                // decoration: BoxDecoration(
                //   border: Border.all(color: Colors.green),
                // ),
                width: currentIndex == 0
                    ? constraints.maxWidth * 0.85
                    : constraints.maxWidth * 0.85,
                child: currentIndex == 0
                    ? Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Text(
                          "${allFields["lastPara"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: ConstanceData.SIZE_TITLE16,
                            color: Color(0xFFFFFFFF),
                            fontFamily: "RedHatDisplay",
                            letterSpacing: 0.2,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      )
                    : Text(
                        "${allFields["lastPara"]}",
                        style: TextStyle(
                          fontSize: ConstanceData.SIZE_TITLE14,
                          color: Color(0xFF060513),
                          fontFamily: "Rasa",
                          letterSpacing: 0.2,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
