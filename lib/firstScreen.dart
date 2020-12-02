import 'package:auro/login.dart';
import 'package:auro/signUp.dart';
import 'package:flutter/material.dart';
import 'package:auro/style/theme.dart' as Theme;


class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
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
                Padding(
                    padding: EdgeInsets.only(top: 15.0,left: 50.0,right: 10.0,bottom: 10.0),
                    child: Text(
                      'Let experts build your investment portfolio,while you do whatever you do best',
                      style: new TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          color: Color(0xFFFFFFFF), fontSize: 18.0,
                          letterSpacing: 0.2
                      ),
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(top: 15.0,left: 50.0,right: 10.0,bottom: 10.0),
                    child: Text(
                      'Access hot private deals/ IPO/ Impact/ Investing/ Crypto and a lot more...',
                      style: new TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          color: Color(0xFFFFFFFF), fontSize: 18.0,
                          letterSpacing: 0.2
                      ),
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(top: 15.0,left: 50.0,right: 10.0,bottom: 10.0),
                    child: Text(
                      'AI - DRIVEN SOCIAL BUILT BY LICENSED VETERAN ASSET MANAGER',
                      style: new TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          color: Color(0xFFfec20f), fontSize: 20.0,
                          letterSpacing: 0.2
                      ),
                    )
                ),
                Container(
                  margin: EdgeInsets.only(top: 25.0),
                  decoration: new BoxDecoration(
                    color: Color(0xFFfec20f),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  child: MaterialButton(
                    splashColor: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            fontSize: 22.0,
                            color: Color(0xFFFFFFFF),
                            fontFamily: "WorkSansBold"),
                      ),
                    ),
                    onPressed: () async {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => new Login()));
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30.0),
                  decoration: new BoxDecoration(
                    color: Color(0xFFfec20f),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  child: MaterialButton(
                    splashColor: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(
                            fontSize: 22.0,
                            color: Color(0xFFFFFFFF),
                            fontFamily: "WorkSansBold"),
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
          ),
        ],

      ),
    );
  }
}
