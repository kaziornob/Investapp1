import 'package:auro/login.dart';
import 'package:auro/signUpPages/signUp.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auro/style/theme.dart' as Theme;
import 'package:flutter/rendering.dart';

final List<String> introSliderDataList = ['1','2','3','4','5'];


class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  int _current=0;

  @override
  Widget build(BuildContext context) {

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

/*    final List<Widget> introSlider = introSliderDataList.map((item) =>
        Container(
          height: MediaQuery.of(context).size.height*0.33,
          margin: EdgeInsets.only(left: 7.0),
          decoration: new BoxDecoration(
            color: Color(0xFFFFFFFF),
            border: Border.all(
              color: Color(0xff696969),
              width: 1,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(2.0),
            ),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                      ],
                    ),
                  )
                ],
              )
          ),
        )
      ,).toList();*/

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*1.1,
            decoration: new BoxDecoration(
              color: Theme.Colors.backgroundColor,
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 40.0,left: 10.0,right: 10.0,bottom: 10.0),
                  child: new Image(
                      width: 300.0,
                      fit: BoxFit.fill,
                      image: new AssetImage('assets/login_logo.png')),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0,left: 50.0,right: 10.0,bottom: 10.0),
                  child: Text(
                    'Learn how to invest responsibly irrespective of your background',
                    style: new TextStyle(
                      fontFamily: "Poppins",
                        color: Color(0xFFFFFFFF), fontSize: 18.0,
                        letterSpacing: 0.2
                    ),
                  )
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.45,
                  margin: EdgeInsets.only(left: 30.0,right: 30.0),
                  decoration: new BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    border: Border.all(
                      color: Color(0xFFFFFFFF),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.0),
                    ),
                  ),
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
/*                        child: CarouselSlider(
                          options: CarouselOptions(
                              aspectRatio: 2.0,
                              enlargeCenterPage: false,
                              scrollDirection: Axis.horizontal,
                              autoPlay: false,
                              onPageChanged: (index, reason) {
                              }
                          ),
                          items: introSlider,
                        )*/
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
                Container(
                  margin: EdgeInsets.only(top: 30.0,left: 15.0,right: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 25.0,left: 15.0),
                        decoration: new BoxDecoration(
                          color: Color(0xFFfec20f),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: MaterialButton(
                          splashColor: Colors.grey,
                          child: Padding(
                            padding: EdgeInsets.only(left: 15.0,right: 15.0),
                            child: Center(
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                    fontSize: 22.0,
                                    color: Color(0xFFFFFFFF),
                                    fontFamily: "WorkSansBold"),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context) => new Login()));
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 25.0,left: 45.0),
                        decoration: new BoxDecoration(
                          color: Color(0xFFfec20f),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: MaterialButton(
                          splashColor: Colors.grey,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0,right: 10.0),
                            child: Center(
                              child: Text(
                                "SIGN UP",
                                style: TextStyle(
                                    fontSize: 22.0,
                                    color: Color(0xFFFFFFFF),
                                    fontFamily: "WorkSansBold"),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context) => new SignUp()));
                          },
                        ),
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
        ],

      ),
    );
  }
}
