import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/global.dart';
import 'package:auroim/constance/themes.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:flutter/painting.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  bool _isMyAccountInProgress = false;

  @override
  void initState() {
    super.initState();
    loadUserDetails();
  }

  loadUserDetails() async {
    setState(() {
      _isMyAccountInProgress = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      _isMyAccountInProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();
    double appBarheight = appBar.preferredSize.height;
    return Stack(
      children: <Widget>[
        SafeArea(
          child: Scaffold(
            backgroundColor: AllCoustomTheme.getBodyContainerThemeColor(),
            appBar: new AppBar(
              backgroundColor: Color(0xFF5CA2F4),
              title: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.20),
                child: new Text(
                  'My Account',
                  style: TextStyle(
                    color: AllCoustomTheme.getTextThemeColors(),
                    fontSize: ConstanceData.SIZE_TITLE18,
                  ),
                ),
              ),
              iconTheme: new IconThemeData(color: Colors.white),
            ),
            body: ModalProgressHUD(
              inAsyncCall: _isMyAccountInProgress,
              opacity: 0,
              progressIndicator: CupertinoActivityIndicator(
                radius: 12,
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(right: 0, left: 0),
                  child: !_isMyAccountInProgress
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "My purchases",
                                    style: TextStyle(
                                        color: AllCoustomTheme.getTextThemeColor(),
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        fontFamily: "Roboto",
                                        fontStyle: FontStyle.normal,
                                        letterSpacing: 0.2
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "My Subscriptions",
                                    style: TextStyle(
                                        color: AllCoustomTheme.getTextThemeColor(),
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        fontFamily: "Roboto",
                                        fontStyle: FontStyle.normal,
                                        letterSpacing: 0.2
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.0,top: 10.0),
                              child: ExpandablePanel(
                                header: Text(
                                  'Portfolio Return',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: AllCoustomTheme.getTextThemeColor(),
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                  ),
                                ),
                                expanded: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Animator(
                                            tween: Tween<double>(begin: 0, end: 1),
                                            duration: Duration(milliseconds: 500),
                                            cycles: 1,
                                            builder: (anim) => SizeTransition(
                                              sizeFactor: anim,
                                              axis: Axis.horizontal,
                                              axisAlignment: 1,
                                              child: Icon(
                                                Icons.circle,
                                                color: AllCoustomTheme.getsecoundTextThemeColor(),
                                                size: 8,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 14,
                                          ),
                                          Animator(
                                            tween: Tween<double>(begin: 0, end: 1),
                                            duration: Duration(milliseconds: 500),
                                            cycles: 1,
                                            builder: (anim) => SizeTransition(
                                              sizeFactor: anim,
                                              axis: Axis.horizontal,
                                              axisAlignment: 1,
                                              child: Text(
                                                'Auro',
                                                style: TextStyle(
                                                  color: AllCoustomTheme.getTextThemeColor(),
                                                  fontSize: ConstanceData.SIZE_TITLE14,

                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Animator(
                                            tween: Tween<double>(begin: 0, end: 1),
                                            duration: Duration(milliseconds: 500),
                                            cycles: 1,
                                            builder: (anim) => SizeTransition(
                                              sizeFactor: anim,
                                              axis: Axis.horizontal,
                                              axisAlignment: 1,
                                              child: Icon(
                                                Icons.circle,
                                                color: AllCoustomTheme.getsecoundTextThemeColor(),
                                                size: 8,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 14,
                                          ),
                                          Animator(
                                            tween: Tween<double>(begin: 0, end: 1),
                                            duration: Duration(milliseconds: 500),
                                            cycles: 1,
                                            builder: (anim) => SizeTransition(
                                              sizeFactor: anim,
                                              axis: Axis.horizontal,
                                              axisAlignment: 1,
                                              child: Text(
                                                'Personal',
                                                style: TextStyle(
                                                  color: AllCoustomTheme.getTextThemeColor(),
                                                  fontSize: ConstanceData.SIZE_TITLE14,

                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                tapHeaderToExpand: true,
                                hasIcon: true,
                                iconColor: Colors.blueGrey,

                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            Container(
                              child: ExpansionTile(
                                title: Text(
                                  "",
                                  style: TextStyle(
                                    color: AllCoustomTheme.getTextThemeColor(),
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                  ),
                                ),
                                children: <Widget>[
                                  ExpansionTile(
                                    childrenPadding: EdgeInsets.only(left: 25.0),
                                    title: Text(
                                      'My Fund balance',
                                      style: TextStyle(
                                        color: AllCoustomTheme.getTextThemeColor(),
                                        fontSize: ConstanceData.SIZE_TITLE16,

                                      ),
                                    ),
                                    children: <Widget>[
                                      InkWell(
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Animator(
                                              tween: Tween<double>(begin: 0, end: 1),
                                              duration: Duration(milliseconds: 500),
                                              cycles: 1,
                                              builder: (anim) => SizeTransition(
                                                sizeFactor: anim,
                                                axis: Axis.horizontal,
                                                axisAlignment: 1,
                                                child: Icon(
                                                  Icons.circle,
                                                  color: AllCoustomTheme.getsecoundTextThemeColor(),
                                                  size: 8,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 14,
                                            ),
                                            Animator(
                                              tween: Tween<double>(begin: 0, end: 1),
                                              duration: Duration(milliseconds: 500),
                                              cycles: 1,
                                              builder: (anim) => SizeTransition(
                                                sizeFactor: anim,
                                                axis: Axis.horizontal,
                                                axisAlignment: 1,
                                                child: Text(
                                                  'Cash Balance',
                                                  style: TextStyle(
                                                    color: AllCoustomTheme.getTextThemeColor(),
                                                    fontSize: ConstanceData.SIZE_TITLE14,

                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Animator(
                                              tween: Tween<double>(begin: 0, end: 1),
                                              duration: Duration(milliseconds: 500),
                                              cycles: 1,
                                              builder: (anim) => SizeTransition(
                                                sizeFactor: anim,
                                                axis: Axis.horizontal,
                                                axisAlignment: 1,
                                                child: Icon(
                                                  Icons.circle,
                                                  color: AllCoustomTheme.getsecoundTextThemeColor(),
                                                  size: 8,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 14,
                                            ),
                                            Animator(
                                              tween: Tween<double>(begin: 0, end: 1),
                                              duration: Duration(milliseconds: 500),
                                              cycles: 1,
                                              builder: (anim) => SizeTransition(
                                                sizeFactor: anim,
                                                axis: Axis.horizontal,
                                                axisAlignment: 1,
                                                child: Text(
                                                  'Auro Account balance',
                                                  style: TextStyle(
                                                    color: AllCoustomTheme.getTextThemeColor(),
                                                    fontSize: ConstanceData.SIZE_TITLE14,

                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Animator(
                                              tween: Tween<double>(begin: 0, end: 1),
                                              duration: Duration(milliseconds: 500),
                                              cycles: 1,
                                              builder: (anim) => SizeTransition(
                                                sizeFactor: anim,
                                                axis: Axis.horizontal,
                                                axisAlignment: 1,
                                                child: Icon(
                                                  Icons.circle,
                                                  color: AllCoustomTheme.getsecoundTextThemeColor(),
                                                  size: 8,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 14,
                                            ),
                                            Animator(
                                              tween: Tween<double>(begin: 0, end: 1),
                                              duration: Duration(milliseconds: 500),
                                              cycles: 1,
                                              builder: (anim) => SizeTransition(
                                                sizeFactor: anim,
                                                axis: Axis.horizontal,
                                                axisAlignment: 1,
                                                child: Text(
                                                  'Personal account balance',
                                                  style: TextStyle(
                                                    color: AllCoustomTheme.getTextThemeColor(),
                                                    fontSize: ConstanceData.SIZE_TITLE14,

                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Animator(
                                              tween: Tween<double>(begin: 0, end: 1),
                                              duration: Duration(milliseconds: 500),
                                              cycles: 1,
                                              builder: (anim) => SizeTransition(
                                                sizeFactor: anim,
                                                axis: Axis.horizontal,
                                                axisAlignment: 1,
                                                child: Icon(
                                                  Icons.circle,
                                                  color: AllCoustomTheme.getsecoundTextThemeColor(),
                                                  size: 8,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 14,
                                            ),
                                            Animator(
                                              tween: Tween<double>(begin: 0, end: 1),
                                              duration: Duration(milliseconds: 500),
                                              cycles: 1,
                                              builder: (anim) => SizeTransition(
                                                sizeFactor: anim,
                                                axis: Axis.horizontal,
                                                axisAlignment: 1,
                                                child: Text(
                                                  'Add/Redeem funds',
                                                  style: TextStyle(
                                                    color: AllCoustomTheme.getTextThemeColor(),
                                                    fontSize: ConstanceData.SIZE_TITLE14,

                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  ExpansionTile(
                                    childrenPadding: EdgeInsets.only(left: 25.0),
                                    title: Text(
                                      'Portfolio Holding details',
                                      style: TextStyle(
                                        color: AllCoustomTheme.getTextThemeColor(),
                                        fontSize: ConstanceData.SIZE_TITLE16,

                                      ),
                                    ),
                                    children: <Widget>[
                                      InkWell(
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Animator(
                                              tween: Tween<double>(begin: 0, end: 1),
                                              duration: Duration(milliseconds: 500),
                                              cycles: 1,
                                              builder: (anim) => SizeTransition(
                                                sizeFactor: anim,
                                                axis: Axis.horizontal,
                                                axisAlignment: 1,
                                                child: Icon(
                                                  Icons.circle,
                                                  color: AllCoustomTheme.getsecoundTextThemeColor(),
                                                  size: 8,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 14,
                                            ),
                                            Animator(
                                              tween: Tween<double>(begin: 0, end: 1),
                                              duration: Duration(milliseconds: 500),
                                              cycles: 1,
                                              builder: (anim) => SizeTransition(
                                                sizeFactor: anim,
                                                axis: Axis.horizontal,
                                                axisAlignment: 1,
                                                child: Text(
                                                  'Auro',
                                                  style: TextStyle(
                                                    color: AllCoustomTheme.getTextThemeColor(),
                                                    fontSize: ConstanceData.SIZE_TITLE14,

                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Animator(
                                              tween: Tween<double>(begin: 0, end: 1),
                                              duration: Duration(milliseconds: 500),
                                              cycles: 1,
                                              builder: (anim) => SizeTransition(
                                                sizeFactor: anim,
                                                axis: Axis.horizontal,
                                                axisAlignment: 1,
                                                child: Icon(
                                                  Icons.circle,
                                                  color: AllCoustomTheme.getsecoundTextThemeColor(),
                                                  size: 8,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 14,
                                            ),
                                            Animator(
                                              tween: Tween<double>(begin: 0, end: 1),
                                              duration: Duration(milliseconds: 500),
                                              cycles: 1,
                                              builder: (anim) => SizeTransition(
                                                sizeFactor: anim,
                                                axis: Axis.horizontal,
                                                axisAlignment: 1,
                                                child: Text(
                                                  'Personal',
                                                  style: TextStyle(
                                                    color: AllCoustomTheme.getTextThemeColor(),
                                                    fontSize: ConstanceData.SIZE_TITLE14,

                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "Profile viewing options",
                                    style: TextStyle(
                                        color:
                                            AllCoustomTheme.getTextThemeColor(),
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        fontFamily: "Roboto",
                                        fontStyle: FontStyle.normal,
                                        letterSpacing: 0.2),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "Choose whether you're visible or viewing in private mode",
                                    style: TextStyle(
                                      color: AllCoustomTheme
                                          .getNewSecondTextThemeColor(),
                                      fontSize: ConstanceData.SIZE_TITLE14,
                                      fontFamily: "Roboto",
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                          ],
                        )
                      : SizedBox(),
                ),
              )),
          )
        )
      ],
    );
  }
}
