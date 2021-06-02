import 'package:flutter/material.dart';
import 'package:animator/animator.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:auroim/modules/drawer/drawer.dart';

class AuroCoins extends StatefulWidget {
  @override
  _AuroCoinsState createState() => _AuroCoinsState();
}

class _AuroCoinsState extends State<AuroCoins> {
  FocusNode searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.arrow_back_sharp,
          color: Colors.white,
          size: 40,
        ),
        backgroundColor: Color(0xFF8A8A8A),
        onPressed: () => Navigator.of(context).pop(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'AURO COINS',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xffD8AF4F),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Image(
                            height: 80,
                            fit: BoxFit.fill,
                            image: new AssetImage('assets/header_img.png')),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'We know what differentiates a good investor from a great investor, so we reward you differently:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(children: <Widget>[
                          new Image(
                              height: 80,
                              fit: BoxFit.fill,
                              image: new AssetImage(
                                  'assets/portfolio_invest.png')),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'PORTFOLIO INVEST',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ]),
                        // SizedBox(
                        //   width: 10
                        // ),
                        Column(children: <Widget>[
                          new Image(
                              height: 80,
                              fit: BoxFit.fill,
                              image:
                                  new AssetImage('assets/security_invest.png')),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'SECURITY INVEST',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ]),
                        SizedBox(width: 1),
                        Column(children: <Widget>[
                          new Image(
                              height: 80,
                              fit: BoxFit.fill,
                              image: new AssetImage('assets/wiki_invest.png')),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'WIKI INVEST',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ]),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(children: <Widget>[
                          new Image(
                              height: 80,
                              fit: BoxFit.fill,
                              image: new AssetImage('assets/edu_invest.png')),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'EDU INVEST',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ]),
                        // SizedBox(
                        //     width: 10
                        // ),
                        Column(children: <Widget>[
                          new Image(
                              height: 80,
                              fit: BoxFit.fill,
                              image:
                                  new AssetImage('assets/social_invest.png')),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'SOCIAL INVEST',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ]),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'See above to learn how to earn coins from investment activities and spend them on and off Auro',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
