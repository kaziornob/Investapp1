import 'dart:io';

import 'package:auro/shared/navigation_menu.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:auro/style/theme.dart' as Theme;


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final GlobalKey<ScaffoldState> homeScaffoldKey =
  new GlobalKey<ScaffoldState>();

  Widget _buildTitleRecommended(BuildContext context) {
    var horizontalTitleAlignment =
    Platform.isIOS ? CrossAxisAlignment.start : CrossAxisAlignment.start;

    return new InkWell(
      onTap: () => homeScaffoldKey.currentState.openDrawer(),
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: horizontalTitleAlignment,
          children: <Widget>[
            Center(
              child: Image(
                  width: 200.0,
                  fit: BoxFit.fill,
                  image: new AssetImage('assets/login_logo.png')),
            ),
            const Text(''),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        title: _buildTitleRecommended(context),
      ),
      drawer: NavigationMenu(),
      body: DoubleBackToCloseApp(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*1.1,
                decoration: new BoxDecoration(
                  color: Theme.Colors.backgroundColor,
                ),
                child: Column(
                  children: <Widget>[

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
