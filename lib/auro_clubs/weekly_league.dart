import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:auroim/modules/drawer/drawer.dart';

import 'investor.dart';

class WeeklyLeague extends StatefulWidget {
  @override
  _WeeklyLeagueState createState() => _WeeklyLeagueState();
}

class _WeeklyLeagueState extends State<WeeklyLeague> {
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'WEEKLY AURO STREAK',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xffD8AF4F),
                            fontFamily: "Rosarivo",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        Investor('Warren Buffet'),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Image(
                                      height: 80,
                                      fit: BoxFit.fill,
                                      image:
                                          new AssetImage('assets/buffet.png')),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'Warren Buffet',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              )),
                          SizedBox(
                            width: 25,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        Investor('Jim Simons'),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Image(
                                      height: 80,
                                      fit: BoxFit.fill,
                                      image:
                                          new AssetImage('assets/simons.png')),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'Jim Simons',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              )),
                          SizedBox(
                            width: 25,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        Investor('Ray Dalio'),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Image(
                                      height: 80,
                                      fit: BoxFit.fill,
                                      image:
                                          new AssetImage('assets/dalio.png')),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'Ray Dalio',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              )),
                          SizedBox(
                            width: 25,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        Investor('Masayoshi Son'),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Image(
                                      height: 80,
                                      fit: BoxFit.fill,
                                      image: new AssetImage('assets/son.png')),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'Masayoshi Son',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              )),
                          SizedBox(
                            width: 25,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        Investor('John Templeton'),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Image(
                                      height: 80,
                                      fit: BoxFit.fill,
                                      image: new AssetImage(
                                          'assets/templeton.png')),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'John Templeton',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              )),
                          SizedBox(
                            width: 25,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        Investor('Michael Novogratz'),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Image(
                                      height: 80,
                                      fit: BoxFit.fill,
                                      image: new AssetImage(
                                          'assets/novogratz.png')),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'Michael Novogratz',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              )),
                          SizedBox(
                            width: 25,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        Investor('Steve Mandel'),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Image(
                                      height: 80,
                                      fit: BoxFit.fill,
                                      image:
                                          new AssetImage('assets/mandel.png')),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'Steve Mandel',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              )),
                          SizedBox(
                            width: 25,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        Investor('George Soros'),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Image(
                                      height: 80,
                                      fit: BoxFit.fill,
                                      image:
                                          new AssetImage('assets/soros.png')),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'George Soros',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              )),
                          SizedBox(
                            width: 25,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        Investor('Lei Zhang'),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Image(
                                      height: 80,
                                      fit: BoxFit.fill,
                                      image:
                                          new AssetImage('assets/zhang.png')),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'Lei Zhang',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              )),
                          SizedBox(
                            width: 25,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        Investor('Rakesh Jhunjhunwala'),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Image(
                                      height: 80,
                                      fit: BoxFit.fill,
                                      image: new AssetImage(
                                          'assets/jhunjhunwala.png')),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'Rakesh Jhunjhunwala',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'WEEKLY LEAGUE',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xffD8AF4F),
                            fontFamily: "Rosarivo",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
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
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 12,
                            ),
                            new Image(
                                height: 30,
                                fit: BoxFit.fill,
                                image: new AssetImage('assets/usericon.png')),
                            SizedBox(
                              height: 40,
                            ),
                            new Image(
                                height: 30,
                                fit: BoxFit.fill,
                                image: new AssetImage('assets/usericon.png')),
                            SizedBox(
                              height: 40,
                            ),
                            new Image(
                                height: 30,
                                fit: BoxFit.fill,
                                image: new AssetImage('assets/usericon.png')),
                            SizedBox(
                              height: 40,
                            ),
                            new Image(
                                height: 30,
                                fit: BoxFit.fill,
                                image: new AssetImage('assets/usericon.png')),
                            SizedBox(
                              height: 40,
                            ),
                            new Image(
                                height: 30,
                                fit: BoxFit.fill,
                                image: new AssetImage('assets/usericon.png')),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 17,
                            ),
                            Text(
                              'Joel James',
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
                              'Alex Brown',
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
                              'Arun Singh',
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
                              'Amit Singh',
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
                              'John Martin',
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
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 17,
                            ),
                            Text(
                              '31K',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xffD8AF4F),
                                fontFamily: "Rosarivo",
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              '30K',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xffD8AF4F),
                                fontFamily: "Rosarivo",
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              '29K',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xffD8AF4F),
                                fontFamily: "Rosarivo",
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              '28K',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xffD8AF4F),
                                fontFamily: "Rosarivo",
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              '27K',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xffD8AF4F),
                                fontFamily: "Rosarivo",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Image(
                                height: 50,
                                fit: BoxFit.fill,
                                image: new AssetImage('assets/buffet.png')),
                            SizedBox(
                              height: 20,
                            ),
                            new Image(
                                height: 50,
                                fit: BoxFit.fill,
                                image: new AssetImage('assets/mandel.png')),
                            SizedBox(
                              height: 20,
                            ),
                            new Image(
                                height: 50,
                                fit: BoxFit.fill,
                                image: new AssetImage('assets/buffet.png')),
                            SizedBox(
                              height: 20,
                            ),
                            new Image(
                                height: 50,
                                fit: BoxFit.fill,
                                image: new AssetImage('assets/simons.png')),
                            SizedBox(
                              height: 20,
                            ),
                            new Image(
                                height: 50,
                                fit: BoxFit.fill,
                                image: new AssetImage('assets/mandel.png')),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
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
                                    new AssetImage('assets/genius_logo.png')),
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
                                image: new AssetImage(
                                    'assets/challenger_logo.png')),
                            SizedBox(
                              height: 20,
                            ),
                            new Image(
                                height: 50,
                                fit: BoxFit.fill,
                                image: new AssetImage('assets/bull_logo.png')),
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
      ),
    );
  }
}
