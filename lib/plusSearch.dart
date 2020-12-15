import 'dart:io';
import 'package:auro/shared/navigation_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auro/style/theme.dart' as StyleTheme;
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';



class PlusSearch extends StatefulWidget {
  @override
  _PlusSearchState createState() => _PlusSearchState();
}

class _PlusSearchState extends State<PlusSearch> {

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
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
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
                          "Search NOW",
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
    );
  }

}