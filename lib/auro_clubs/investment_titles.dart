import 'package:flutter/material.dart';
import 'package:animator/animator.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:auroim/modules/drawer/drawer.dart';

class InvestmentTitles extends StatefulWidget {
  @override
  _InvestmentTitlesState createState() => _InvestmentTitlesState();
}

class _InvestmentTitlesState extends State<InvestmentTitles> {
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Row(children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.chevron_left,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'AURO INVESTMENT TITLES',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xffD8AF4F),
                        fontFamily: "Rosarivo",
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Ranks are based on coins earned on Auro',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                      fontFamily: "Rosarivo",
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: Color(0xFF525a6d),
                      width: 0.5, // Underline width
                    ))),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'RANK',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xffD8AF4F),
                          fontFamily: "Rosarivo",
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        'TITLE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xffD8AF4F),
                          fontFamily: "Rosarivo",
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        'MEMBER %',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xffD8AF4F),
                          fontFamily: "Rosarivo",
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        'BADGE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xffD8AF4F),
                          fontFamily: "Rosarivo",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: Color(0xFF525a6d),
                      width: 0.5, // Underline width
                    ))),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 17,
                          ),
                          Text(
                            '1',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: "Rosarivo",
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            '2',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: "Rosarivo",
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            '3',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: "Rosarivo",
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            '4',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: "Rosarivo",
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            '5',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: "Rosarivo",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 17,
                          ),
                          Text(
                            'Guru',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: "Rosarivo",
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            'Bull of Wall Street',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: "Rosarivo",
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            'Genius',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: "Rosarivo",
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            'Trusted User',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: "Rosarivo",
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            'Challenger',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: "Rosarivo",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 17,
                          ),
                          Text(
                            '10',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: "Rosarivo",
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            '20',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: "Rosarivo",
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            '30',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: "Rosarivo",
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            '25',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: "Rosarivo",
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            '15',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: "Rosarivo",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Image(
                              height: 50,
                              fit: BoxFit.fill,
                              image: new AssetImage('assets/guru_logo.png')),
                          SizedBox(
                            height: 20,
                          ),
                          new Image(
                              height: 50,
                              fit: BoxFit.fill,
                              image: new AssetImage('assets/bull_logo.png')),
                          SizedBox(
                            height: 20,
                          ),
                          new Image(
                              height: 50,
                              fit: BoxFit.fill,
                              image: new AssetImage('assets/genius_logo.png')),
                          SizedBox(
                            height: 20,
                          ),
                          new Image(
                              height: 50,
                              fit: BoxFit.fill,
                              image: new AssetImage(
                                  'assets/trusted_user_logo.png')),
                          SizedBox(
                            height: 20,
                          ),
                          new Image(
                              height: 50,
                              fit: BoxFit.fill,
                              image:
                                  new AssetImage('assets/challenger_logo.png')),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
