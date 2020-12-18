import 'dart:io';
import 'package:auro/shared/navigation_menu.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auro/style/theme.dart' as StyleTheme;
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final GlobalKey<ScaffoldState> homeScaffoldKey = new GlobalKey<ScaffoldState>();

  Widget _buildTitleRecommended(BuildContext context) {
    var horizontalTitleAlignment =
    Platform.isIOS ? CrossAxisAlignment.start : CrossAxisAlignment.start;

    return new InkWell(
      onTap: () => homeScaffoldKey.currentState.openDrawer(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: horizontalTitleAlignment,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left:35.0),
            child: Image(
                width: 180.0,
                fit: BoxFit.fill,
                image: new AssetImage('assets/login_logo.png')),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        title: _buildTitleRecommended(context),
        backgroundColor: Color(0xFF000000),
        iconTheme: IconThemeData(
          color: StyleTheme.Colors.AppBarMenuIconColor,
        ),
      ),
      drawer: NavigationMenu(),
        body: DoubleBackToCloseApp(
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: new BoxDecoration(
                    color: StyleTheme.Colors.backgroundColor,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 90.0,bottom: 10.0,left: 90.0,right: 75.0),
                        width: MediaQuery.of(context).size.width * 0.95,
                        decoration: new BoxDecoration(
                          color: Color(0xFFfec20f),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: MaterialButton(
                          splashColor: Colors.grey,
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0,top: 2.0),
                            child: Text(
                              "HOME",
                              style: TextStyle(
                                  fontSize: 17.5,
                                  color: Color(0xFFFFFFFF),
                                  fontFamily: "WorkSansBold"),
                            ),
                          ),
                          onPressed: () async {

                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],

            ),
          ),
          snackBar: const SnackBar(
            content: Text(
              'Tap again to leave',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Color(0xff161946),
          ),
        )
    );
  }

}