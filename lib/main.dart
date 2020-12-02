import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:auro/firstScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:auro/serverConfigRequest/config.dart';
import 'package:auro/shared/globalInstance.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'serverConfigRequest/AllRequest.dart';
import 'package:auro/style/theme.dart' as AppThemeData;
import 'package:package_info/package_info.dart';


class MyApp extends StatefulWidget {
  final SharedPreferences prefs;
  static String version;

  MyApp({this.prefs});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget defaultHome = new Login();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setLocalStorageValues() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', null);
    prefs.setString('Email_ID', null);
    prefs.setString('User_name', null);
    prefs.setString('First_name', null);
    prefs.setString('Last_name', null);
    prefs.setString('Session_token', null);
    prefs.setDouble('Coins', null);
    prefs.setString('DateTime', null);
  }

  _decideMainPage(context) {
    if (widget.prefs != null &&
        widget.prefs.containsKey('user_id') &&
        widget.prefs.getString('user_id') != null &&
        widget.prefs.containsKey('Session_token') &&
        widget.prefs.getString('Session_token') != null &&
        widget.prefs.containsKey('DateTime') &&
        widget.prefs.getString('DateTime').isNotEmpty) {
      var now = new DateTime.now();
      var strTodayDateTime = new DateFormat("yyyy-MM-dd HH:mm").format(now);
      var todayDateTime = DateTime.parse("$strTodayDateTime");

      var storedDateTime =
      DateTime.parse("${widget.prefs.getString('DateTime')}");

      final daysMinDifference = todayDateTime.difference(storedDateTime).inDays;

      if (daysMinDifference >= 30) {
        setLocalStorageValues();
        return new Login();
      } else {
        return new MyHomePage();
      }

    } else {
      // return new Login();
      return new FirstScreen();
    }
  }

  var config;
  @override
  Widget build(BuildContext context) {
    config = AppConfig.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: config.appName,
      theme: ThemeData(
        primaryColor: const Color(0xFFfec20f),
        accentColor: const Color(0xFF000080),
        cursorColor: const Color(0xFF000080),
      ),
      home: Builder(
        builder: (context) => _decideMainPage(context),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final int index;
  static String storedDateTime;

  const MyHomePage({Key key, this.index}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  int _selectedPage = 0;
  AllHttpRequest request = new AllHttpRequest();
  Timer timer;
  final _pageOptions = [
/*    SearchQuestion(),
    MyQuestions(),
    MyContent(),
    MyCourses(),*/
  ];


  setPageValue(int index) {
    getLocalStorageValues();
    setState(() {
      _selectedPage = index;
    });
  }

  void setLocalStorageValues() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', null);
    prefs.setString('Email_ID', null);
    prefs.setString('User_name', null);
    prefs.setString('First_name', null);
    prefs.setString('Last_name', null);
    prefs.setString('Session_token', null);
//    prefs.setInt('Coins', null);
    prefs.setDouble('Coins', null);

    prefs.setString('DateTime', null);
  }

  void getLocalStorageValues() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    MyHomePage.storedDateTime = prefs.getString('DateTime');

    var now = new DateTime.now();
    var strTodayDateTime = new DateFormat("yyyy-MM-dd HH:mm").format(now);
    var todayDateTime = DateTime.parse("$strTodayDateTime");

    var storedDateTime = DateTime.parse("${MyHomePage.storedDateTime}");

    final daysMinDifference = todayDateTime.difference(storedDateTime).inDays;

    if (daysMinDifference >= 30) {
      setLocalStorageValues();
      Navigator.popUntil(context, ModalRoute.withName('/LoginPage'));
    }
  }

  versionCheck(context) async {
    //Get Current installed version of app
    final PackageInfo info = await PackageInfo.fromPlatform();
    int currentVersion = int.parse('${info.buildNumber}');


    try {
      if (currentVersion != null) {
        var jsonReq = '{"appVersion":"$currentVersion"}';
        var response = await request.postSubmit('check_app_version', jsonReq);

        if (response.statusCode == 200) {
          var respData = json.decode(response.body);
          if (respData.containsKey('status') &&
              respData['status'] != null &&
              respData['status'] != "" &&
              respData.containsKey('launchUrl') &&
              respData['launchUrl'] != null &&
              respData['launchUrl'] != "" &&
              respData.containsKey('appVersion') &&
              respData['appVersion'] != null &&
              respData['appVersion'] != "" &&
              respData['status'] != "NoUpdate") {
            if (respData['appVersion'] > currentVersion) {
              _showVersionDialog(
                  context, respData['status'], respData['launchUrl']);
            }
          }
        } else {
          return false;
        }
      }
    } catch (exception) {
    }
  }

  _showVersionDialog(context, compatibilityStatus, appLaunchUrl) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "New Update Available";
        String message =
            "There is a newer version of app available please update it now.";
        String btnLabel = "Update Now";
        String btnLabelCancel = "Later";

        return WillPopScope(
            onWillPop: () async => false,
            child: compatibilityStatus == "UpdateRequired"
                ? new AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: Text(btnLabel),
                  onPressed: () {
                    // _launchURL(appLaunchUrl);
                  },
                ),
              ],
            )
                : (compatibilityStatus == "UpdateAvailable"
                ? new AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: Text(btnLabel),
                  onPressed: () {
                    Navigator.pop(context);
                    // _launchURL(appLaunchUrl);
                  },
                ),
                FlatButton(
                  child: Text(btnLabelCancel),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            )
                : new AlertDialog(
              title: Text("No update Available"),
              content: Text('No update Available'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            )));

        /*return Platform.isIOS
            ? new CupertinoAlertDialog(
                title: Text(title),
                content: Text(message),
                actions: <Widget>[
                  FlatButton(
                    child: Text(btnLabel),
                    onPressed: () => _launchURL(appLaunchUrl),
                  ),
                  FlatButton(
                    child: Text(btnLabelCancel),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
            )
            : (
                  compatibilityStatus=="UpdateRequired"
                  ? new AlertDialog(
                        title: Text(title),
                        content: Text(message),
                        actions: <Widget>[
                          FlatButton(
                            child: Text(btnLabel),
                            onPressed: () {
                              _launchURL(appLaunchUrl);
                            },
                          ),
                        ],
                      )
                  : (
                        compatibilityStatus=="UpdateAvailable"
                          ? new AlertDialog(
                                title: Text(title),
                                content: Text(message),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text(btnLabel),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _launchURL(appLaunchUrl);
                                    },
                                  ),
                                  FlatButton(
                                    child: Text(btnLabelCancel),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              )
                            : new AlertDialog(
                                title: Text("No update Available"),
                                content: Text('No update Available'),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Cancel'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              )
                    )
              );*/
      },
    );
  }

/*  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }*/

  @override
  void initState() {

    try {
      versionCheck(context);
    } catch (e) {
    }

    getLocalStorageValues();

    super.initState();
    if (widget.index == null) {
      setPageValue(0);
    } else {
      setPageValue(widget.index);
    }
  }

  @override
  void dispose() {
//    WidgetsBinding.instance.removeObserver(this);
    timer.cancel();
    super.dispose();
  }


  /// Handles [WillPopScope.onWillPop].
  // ignore: missing_return
  Future<bool> onWillPop() async {
    setState(() {
      _selectedPage = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedPage == 0) {
      return new Scaffold(
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
              canvasColor: Colors.white,
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              primaryColor: const Color(0xff161946),
              textTheme: Theme.of(context).textTheme.copyWith(
                  caption: new TextStyle(
                      color: Colors
                          .blueGrey))), // sets the inactive color of the `BottomNavigationBar`
          child: new BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedPage,
            onTap: (int index) {
              setState(() {
                setPageValue(index);
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.search,
                    size: _selectedPage == 0 ? 30.0 : 20.0,
                    color: _selectedPage == 0
                        ? AppThemeData.Colors.SelectedBottomNavBarIconColor
                        : AppThemeData.Colors.BottomNavBarIconColor),
                title: Text('Search',
                    style: TextStyle(
                        color: _selectedPage == 0
                            ? AppThemeData
                            .Colors.SelectedBottomNavBarLabelTextColor
                            : AppThemeData.Colors.BottomNavBarLabelTextColor,
                        fontWeight: FontWeight.bold)),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.question_answer,
                    size: _selectedPage == 1 ? 30.0 : 20.0,
                    color: _selectedPage == 1
                        ? AppThemeData.Colors.SelectedBottomNavBarIconColor
                        : AppThemeData.Colors.BottomNavBarIconColor),
                title: Text('Questions',
                    style: TextStyle(
                        color: _selectedPage == 1
                            ? AppThemeData
                            .Colors.SelectedBottomNavBarLabelTextColor
                            : AppThemeData.Colors.BottomNavBarLabelTextColor,
                        fontWeight: FontWeight.bold)),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.create,
                      size: _selectedPage == 2 ? 30.0 : 20.0,
                      color: _selectedPage == 2
                          ? AppThemeData.Colors.SelectedBottomNavBarIconColor
                          : AppThemeData.Colors.BottomNavBarIconColor),
                  title: Text('Content',
                      style: TextStyle(
                          color: _selectedPage == 2
                              ? AppThemeData
                              .Colors.SelectedBottomNavBarLabelTextColor
                              : AppThemeData.Colors.BottomNavBarLabelTextColor,
                          fontWeight: FontWeight.bold))),
              BottomNavigationBarItem(
                icon: Icon(Icons.subscriptions,
                    size: _selectedPage == 3 ? 30.0 : 20.0,
                    color: _selectedPage == 3
                        ? AppThemeData.Colors.SelectedBottomNavBarIconColor
                        : AppThemeData.Colors.BottomNavBarIconColor),
                title: Text('Courses',
                    style: TextStyle(
                        color: _selectedPage == 3
                            ? AppThemeData
                            .Colors.SelectedBottomNavBarLabelTextColor
                            : AppThemeData.Colors.BottomNavBarLabelTextColor,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      );
    } else {
      return new Scaffold(
        body: WillPopScope(
          onWillPop: onWillPop,
          child: _pageOptions[_selectedPage],
        ),
        bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
              canvasColor: Colors.white,
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              primaryColor: AppThemeData.Colors.SelectedBottomNavBarIconColor,
              textTheme: Theme.of(context).textTheme.copyWith(
                  caption: new TextStyle(
                      color: Colors
                          .blueGrey))), // sets the inactive color of the `BottomNavigationBar`
          child: new BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedPage,
            onTap: (int index) {
              setState(() {
                setPageValue(index);
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.search,
                    size: _selectedPage == 0 ? 30.0 : 20.0,
                    color: _selectedPage == 0
                        ? AppThemeData.Colors.SelectedBottomNavBarIconColor
                        : AppThemeData.Colors.BottomNavBarIconColor),
                title: Text('Search',
                    style: TextStyle(
                        color: _selectedPage == 0
                            ? AppThemeData
                            .Colors.SelectedBottomNavBarLabelTextColor
                            : AppThemeData.Colors.BottomNavBarLabelTextColor,
                        fontWeight: FontWeight.bold)),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.question_answer,
                    size: _selectedPage == 1 ? 30.0 : 20.0,
                    color: _selectedPage == 1
                        ? AppThemeData.Colors.SelectedBottomNavBarIconColor
                        : AppThemeData.Colors.BottomNavBarIconColor),
                title: Text('Questions',
                    style: TextStyle(
                        color: _selectedPage == 1
                            ? AppThemeData
                            .Colors.SelectedBottomNavBarLabelTextColor
                            : AppThemeData.Colors.BottomNavBarLabelTextColor,
                        fontWeight: FontWeight.bold)),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.create,
                      size: _selectedPage == 2 ? 30.0 : 20.0,
                      color: _selectedPage == 2
                          ? AppThemeData.Colors.SelectedBottomNavBarIconColor
                          : AppThemeData.Colors.BottomNavBarIconColor),
                  title: Text('Content',
                      style: TextStyle(
                          color: _selectedPage == 2
                              ? AppThemeData
                              .Colors.SelectedBottomNavBarLabelTextColor
                              : AppThemeData.Colors.BottomNavBarLabelTextColor,
                          fontWeight: FontWeight.bold))),
              BottomNavigationBarItem(
                icon: Icon(Icons.subscriptions,
                    size: _selectedPage == 3 ? 30.0 : 20.0,
                    color: _selectedPage == 3
                        ? AppThemeData.Colors.SelectedBottomNavBarIconColor
                        : AppThemeData.Colors.BottomNavBarIconColor),
                title: Text('Courses',
                    style: TextStyle(
                        color: _selectedPage == 3
                            ? AppThemeData
                            .Colors.SelectedBottomNavBarLabelTextColor
                            : AppThemeData.Colors.BottomNavBarLabelTextColor,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      );
    }
  }
}