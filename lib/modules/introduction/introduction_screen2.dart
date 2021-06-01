import 'package:auroim/auth/otp.dart';
import 'package:auroim/auth/signInScreen.dart';
import 'package:auroim/auth/signUpScreen.dart';
import 'package:auroim/auth/userPersonalDetails.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/widgets/how_app_works.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class IntroductionScreen2 extends StatefulWidget {
  @override
  _IntroductionScreen2State createState() => _IntroductionScreen2State();
}

class _IntroductionScreen2State extends State<IntroductionScreen2> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _current == 0
          ? Colors.black
          : AllCoustomTheme.getBodyContainerThemeColor(),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CarouselSlider.builder(
                    itemCount: 5,
                    options: CarouselOptions(
                      height: _current == 0
                          ? constraints.maxHeight * 0.75
                          : constraints.maxHeight * 0.7,
                      autoPlay: false,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      },
                    ),
                    itemBuilder: (context, index) {
                      return getSliderWidgets(
                        constraints.maxWidth,
                        _current == 0
                            ? constraints.maxHeight * 0.75
                            : constraints.maxHeight * 0.7,
                      );
                    },
                  ),
                  getBottomWidgets(
                    constraints.maxWidth,
                    _current == 0
                        ? constraints.maxHeight * 0.25
                        : constraints.maxHeight * 0.3,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  getBottomWidgets(maxWidth, maxHeight) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: maxHeight * 0.1),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [0, 1, 2, 3, 4].map(
                  (index) {
                    return Container(
                      width: 10.0,
                      height: 8.0,
                      margin: EdgeInsets.symmetric(horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index
                            ? Color(0xFFD8AF4F)
                            : Color(0xffCBB4B4),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
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
                    border:
                        new Border.all(color: Color(0xFFD8AF4F), width: 1.5),
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
                Container(
                  height: 40,
                  width: (MediaQuery.of(context).size.width / 2) - 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: new Border.all(
                      color: Color(0xFFFFB300),
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
                          builder: (BuildContext context) => SignInScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: maxHeight * 0.1,
          ),
          RichText(
            text: TextSpan(
              children: [
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  getSliderWidgets(maxWidth, maxHeight) {
    return Container(
      height: maxHeight,
      width: maxWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: maxWidth / 1.5,
            height: maxHeight * 0.1,
            child: Image.asset(
              "assets/logo_with_ai.png",
              fit: BoxFit.cover,
            ),
          ),
          getSliderText()["title"] == null
              ? SizedBox()
              : Container(
                  width: maxWidth - 20,
                  child: Text(
                    getSliderText()["title"],
                    style: TextStyle(
                      fontFamily: "Rasa",
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0.2,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
          getSliderText()["subtitle"] == null
              ? SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    width: maxWidth - 20,
                    child: Text(
                      getSliderText()["subtitle"],
                      style: TextStyle(
                        fontFamily: "Rasa",
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
          Container(
            width: maxWidth,
            height: _current == 0 ? maxHeight * 0.7 : maxHeight * 0.6,
            child: Image.asset(
              getImagePath(),
              fit: BoxFit.cover,
            ),
          ),
          getSliderText()["subtitle2"] == null
              ? SizedBox()
              : Container(
                  width: maxWidth - 20,
                  child: Text(
                    getSliderText()["subtitle2"],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _current == 0 ? Colors.white : Colors.black,
                      fontFamily: "Rasa",
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  String getImagePath() {
    switch (_current) {
      case 0:
        return "assets/landing_page_stars.png";
      case 1:
        return "assets/multipleAssets.png";
      case 2:
        return "assets/invest.png";
      case 3:
        return "assets/pitchStock.png";
      case 4:
        return "assets/pitchStock.png";
      default:
        return "assets/landing_page_stars.png";
    }
  }

  Map getSliderText() {
    switch (_current) {
      case 0:
        return {
          "subtitle2":
              "Invest with confidence on world’s leading Robo and Social Investment App.Built by licenced asset-manager with strong track record of outperforming markets"
        };
      case 1:
        return {
          "title":
              "GET YOUR PERSONAL PORTFOLIO BY LICENSED GLOBAL ASSET MANAGER",
          "subtitle":
              "Institutional grade portfolios designed just for you across multiple asset classes – listed, unlisted and crypto",
          "subtitle2": "..and Yes! we pick  securities that you can engage with, "
              "not just mutual funds and ETFs like other Robos…and so no double fees on those.",
        };
      case 2:
        return {
          "title": "LEARN HOW TO INVEST BETTER",
          "subtitle":
              "Invest with confidence on world’s leading Robo and Social Investment App.Built by licenced asset-manager with strong track record of outperforming markets",
          "subtitle2":
              "…Learn investment principles used by the all-time greats",
        };
      case 3:
        return {
          "title": "PITCH STOCK & PORTFOLIOS",
          "subtitle":
              "Pitch stocks and portfolios while building your own investment track record",
          "subtitle2":
              "…allow others to follow your investments and earn a cut of their profits",
        };
      case 4:
        return {
          "title": "TRADE YOURSELF & FOLLOW STAR INVESTORS",
          "subtitle":
              "Build your own or choose from and Invest In a wide selection of professionally managed portfolios.",
          "subtitle2": "…while you sit back and watch your wealth grow",
        };
      default:
        return {
          "subtitle2":
              "Invest with confidence on world’s leading Robo and Social Investment App.Built by licenced asset-manager with strong track record of outperforming markets"
        };
    }
  }
}
