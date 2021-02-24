import 'dart:math';

import 'package:animator/animator.dart';
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/global.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/deposite/depositeCurrency.dart';
import 'package:auroim/modules/home/homeScreen.dart';
import 'package:auroim/modules/muitisig/multisig.dart';
import 'package:auroim/modules/myWallet/wallet.dart';
import 'package:auroim/modules/settings/myAccount.dart';
import 'package:auroim/modules/settings/setting.dart';
import 'package:auroim/modules/tradingPair/tradingPair.dart';
import 'package:auroim/modules/userProfile/userProfile.dart';
import 'package:auroim/modules/withdraw/withdrawCurrency.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;

class AppDrawer extends StatefulWidget {
  final String selectItemName;

  const AppDrawer({Key key, this.selectItemName}) : super(key: key);
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

var appBarheight = 0.0;

class _AppDrawerState extends State<AppDrawer> {
  var profileData;
  ApiProvider request = new ApiProvider();


  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  Future <void> getProfileData() async {
    var response = await request.getRequest('users/get_details');
    print("profile data: $response");
    if(response!=null && response!=false)
    {
      if (this.mounted) {
        setState(() {
          profileData = response['data'];

        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();
    appBarheight = appBar.preferredSize.height;
    return Container(
      // color: AllCoustomTheme.getThemeData().primaryColor,
      color: AllCoustomTheme.getBodyContainerThemeColor(),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: appBarheight + 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Animator(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: Duration(milliseconds: 500),
                        cycles: 1,
                        builder: (anim) => SizeTransition(
                          sizeFactor: anim,
                          axis: Axis.horizontal,
                          axisAlignment: 1,
                          child: CircleAvatar(
                            radius: 17.0,
                            backgroundImage: new AssetImage('assets/download.jpeg'),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
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
                            profileData!=null && profileData['f_name']!=null
                                && profileData['l_name'] ? "${profileData['f_name']}" + "${profileData['l_name']}" : 'Not Found',
                            style: TextStyle(
                              color: AllCoustomTheme.getTextThemeColor(),
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto",

                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 40,
                      ),
                      InkWell(
                        onTap: ()
                        {
                          Navigator.pop(context);
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (BuildContext context) =>
                                  MyAccount(),
                            ),
                          );
                        },
                        child: Animator(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: Duration(milliseconds: 500),
                          cycles: 1,
                          builder: (anim) => SizeTransition(
                              sizeFactor: anim,
                              axis: Axis.horizontal,
                              axisAlignment: 1,
                              child: Text(
                                'My Account',
                                style: TextStyle(
                                  color: AllCoustomTheme.getSeeMoreThemeColor(),
                                  fontSize: ConstanceData.SIZE_TITLE15,
                                  fontFamily: "Roboto",
                                ),
                              )
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        margin: EdgeInsets.only(top:7.0),
                        child: Icon(
                          Icons.circle,
                          size: 7,
                          color: AllCoustomTheme.getSeeMoreThemeColor(),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: ()
                        {
                          Navigator.pop(context);
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (BuildContext context) =>
                                  Setting(),
                            ),
                          );
                        },
                        child: Animator(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: Duration(milliseconds: 500),
                          cycles: 1,
                          builder: (anim) => SizeTransition(
                              sizeFactor: anim,
                              axis: Axis.horizontal,
                              axisAlignment: 1,
                              child: Text(
                                'Settings',
                                style: TextStyle(
                                  color: AllCoustomTheme.getSeeMoreThemeColor(),
                                  fontSize: ConstanceData.SIZE_TITLE15,
                                  fontFamily: "Roboto",
                                ),
                              )
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )
            ),
            SizedBox(
              height: 10,
            ),
            Animator(
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(milliseconds: 500),
              cycles: 1,
              builder: (anim) => SizeTransition(
                sizeFactor: anim,
                axis: Axis.horizontal,
                axisAlignment: 1,
                child: Container(
                  height: 3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                            color: Color(0xFF525a6d),
                            width: 1.6, // Underline width
                          )
                      )
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top:7.0),
                      child: Icon(
                        Icons.crop_square_outlined,
                        size: 15,
                        color: Color(0xFFD8AF4F),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      margin: EdgeInsets.only(top:5.0),
                      child: Text(
                        'Reactivate Premium for free',
                        style: TextStyle(
                          color: AllCoustomTheme.getTextThemeColor(),
                          fontSize: ConstanceData.SIZE_TITLE15,
                          fontFamily: "Roboto",
                        ),
                      )
                    ),
                  ],
                ),
            ),
            SizedBox(
              height: 10,
            ),
            Animator(
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(milliseconds: 500),
              cycles: 1,
              builder: (anim) => SizeTransition(
                sizeFactor: anim,
                axis: Axis.horizontal,
                axisAlignment: 1,
                child: Container(
                  height: 3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                            color: Color(0xFF525a6d),
                            width: 1.6, // Underline width
                          )
                      )
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Column(
                children: <Widget>[
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: ExpansionTile(
                            title: Text(
                              "",
                            ),
                            children: <Widget>[
                              ExpansionTile(
                                childrenPadding: EdgeInsets.only(left: 25.0),
                                title:  Row(
                                  children: <Widget>[
                                    Animator(
                                      tween: Tween<double>(begin: 0, end: 1),
                                      duration: Duration(milliseconds: 500),
                                      cycles: 1,
                                      builder: (anim) => SizeTransition(
                                        sizeFactor: anim,
                                        axis: Axis.horizontal,
                                        axisAlignment: 1,
                                        child: new Image(
                                            width: 20.0,
                                            fit: BoxFit.fill,
                                            image: new AssetImage('assets/appIcon.jpg')
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
                                          'Invest',
                                          style: TextStyle(
                                            color: AllCoustomTheme.getTextThemeColor(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
                                              'Go pro',
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
                                              'Go live',
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
                                childrenPadding: EdgeInsets.only(left: 20.0),
                                title:  Row(
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
                                          Icons.bus_alert,
                                          color: AllCoustomTheme.getsecoundTextThemeColor(),
                                          size: 20,
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
                                          'Markets',
                                          style: TextStyle(
                                            color: AllCoustomTheme.getTextThemeColor(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(),
                                    ),
                                  ],
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
                                              'Public Equities',
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
                                       Expanded(
                                         child:  Animator(
                                           tween: Tween<double>(begin: 0, end: 1),
                                           duration: Duration(milliseconds: 500),
                                           cycles: 1,
                                           builder: (anim) => SizeTransition(
                                             sizeFactor: anim,
                                             axis: Axis.horizontal,
                                             axisAlignment: 1,
                                             child:  Text(
                                               'Private Equity/ Venture Capital deals',
                                               style: TextStyle(
                                                 color: AllCoustomTheme.getTextThemeColor(),
                                                 fontSize: ConstanceData.SIZE_TITLE14,

                                               ),
                                             ),
                                           ),
                                         ),
                                       )
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
                                              'Crypto Currencies',
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
                                              'Auro Star Funds',
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
                        SizedBox(
                          height: 20,
                        ),
                        // my prifle
                        Container(
                          child: ExpansionTile(
                            title: Text(
                              "My profile",
                              style: TextStyle(
                                color: AllCoustomTheme.getSeeMoreThemeColor(),
                                fontSize: ConstanceData.SIZE_TITLE16,
                              ),
                            ),
                            children: <Widget>[
                              ExpansionTile(
                                childrenPadding: EdgeInsets.only(left: 25.0),
                                title: Text(
                                  'My Investment Track Record',
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
                                              'Total Coins',
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
                                              'Learn Coins',
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
                                              'Invest Coins',
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
                                              'Stock/Portfolio Pitch Coins',
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
                                              'Social Invest Coins',
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
                              ListTile(
                                title: InkWell(
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
                                            'My Auro Investment Club',
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
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // exchange
                        Container(
                          child: ExpandablePanel(
                            header: Text(
                              'Exchange',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: AllCoustomTheme.getSeeMoreThemeColor(),
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
                                            'My Questions',
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
                                            'Recommended Questions',
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
                                            'Trending Questions',
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
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: ExpandablePanel(
                            header: Text(
                              'Promotions',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: AllCoustomTheme.getSeeMoreThemeColor(),
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
                                            'Refer a friend and earn coins',
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
                                      Expanded(
                                        child: Animator(
                                          tween: Tween<double>(begin: 0, end: 1),
                                          duration: Duration(milliseconds: 500),
                                          cycles: 1,
                                          builder: (anim) => SizeTransition(
                                            sizeFactor: anim,
                                            axis: Axis.horizontal,
                                            axisAlignment: 1,
                                            child: Text(
                                              'Register your product on one of our markets (Please send email with details to AuroLP@AuroIM.com)',
                                              style: TextStyle(
                                                color: AllCoustomTheme.getTextThemeColor(),
                                                fontSize: ConstanceData.SIZE_TITLE14,

                                              ),
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
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: ExpandablePanel(
                            header: Text(
                              'Support',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: AllCoustomTheme.getSeeMoreThemeColor(),
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
                                            'Chat with us (whatsapp/Telegram)',
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
                                            'Ask a question ( aurobot -Phase)',
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
                                            'Contact Us',
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
                                            'T & C',
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
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}