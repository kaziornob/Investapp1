import 'dart:math';

import 'package:animator/animator.dart';
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/global.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/main.dart';
import 'package:auroim/modules/deposite/depositeCurrency.dart';
import 'package:auroim/modules/home/homeScreen.dart';
import 'package:auroim/modules/introduction/IntroductionScreen.dart';
import 'package:auroim/modules/introduction/introduction_screen2.dart';
import 'package:auroim/modules/investRelatedPages/riskOnboardingPages/onBoardingFirst.dart';
import 'package:auroim/modules/muitisig/multisig.dart';
import 'package:auroim/modules/myWallet/wallet.dart';
import 'package:auroim/modules/settings/myAccount.dart';
import 'package:auroim/modules/settings/myProfile.dart';
import 'package:auroim/modules/settings/setting.dart';
import 'package:auroim/modules/tradingPair/tradingPair.dart';
import 'package:auroim/modules/userProfile/userProfile.dart';
import 'package:auroim/modules/withdraw/withdrawCurrency.dart';
import 'package:auroim/provider_abhinav/user_details.dart';
import 'package:auroim/widgets/how_app_works.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatefulWidget {
  final String selectItemName;
  final VoidCallback auroStreakCallback;
  final Function changeThemeCallback;

  const AppDrawer({
    Key key,
    this.selectItemName,
    this.auroStreakCallback,
    this.changeThemeCallback,
  }) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

var appBarheight = 0.0;

class _AppDrawerState extends State<AppDrawer> {
  var profileData;
  ApiProvider request = new ApiProvider();
  bool _isinit = true;

  Future<void> getProfileData() async {
    var response = await request.getRequest('users/get_details');
    print("profile data: $response");
    if (response != null && response != false) {
      if (this.mounted) {
        setState(() {
          profileData = response['data'];
        });
      }
    }
  }

  getUserDetails() async {
    print("getting user Details");
    ApiProvider request = new ApiProvider();
    // print("call set screen");
    var response = await request.getRequest('users/get_details');
    print("user detail response: $response");
    if (response != null && response != false) {
      userAllDetail = response['data'];

      Provider.of<UserDetails>(context, listen: false)
          .setUserDetails(userAllDetail);
      print(userAllDetail.toString());
    } else {
      print("Not got user data");
    }
  }

  @override
  void didChangeDependencies() async {
    if (_isinit) {
      getUserDetails();
    }
    super.didChangeDependencies();
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
              height: appBarheight,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 10),
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
                              backgroundImage:
                                  new AssetImage('assets/download.jpeg'),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Consumer<UserDetails>(
                          builder: (context, userDetailsProvider, index) {
                            if (userDetailsProvider.userDetails == null) {
                              print("No User Data to set");
                              return Text("Not Found");
                            } else {
                              print("Set Username");
                              return Text(userDetailsProvider
                                          .userDetails["f_name"] ==
                                      null
                                  ? "Not found"
                                  : userDetailsProvider.userDetails["f_name"]);
                            }
                          },
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 40.0,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      MyAccount(),
                                ),
                              );
                            },
                            child: Text(
                              'My Account',
                              style: TextStyle(
                                color: AllCoustomTheme.getSeeMoreThemeColor(),
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontFamily: "Roboto",
                              ),
                            )),
                        SizedBox(
                          width: 2.0,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 7.0),
                          child: Icon(
                            Icons.circle,
                            size: 6,
                            color: AllCoustomTheme.getSeeMoreThemeColor(),
                          ),
                        ),
                        SizedBox(
                          width: 2.0,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (BuildContext context) => Setting(),
                                ),
                              );
                            },
                            child: Text(
                              'Settings',
                              style: TextStyle(
                                color: AllCoustomTheme.getSeeMoreThemeColor(),
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontFamily: "Roboto",
                              ),
                            )),
                        SizedBox(
                          width: 2.0,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 7.0),
                          child: Icon(
                            Icons.circle,
                            size: 6,
                            color: AllCoustomTheme.getSeeMoreThemeColor(),
                          ),
                        ),
                        SizedBox(
                          width: 2.0,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      MyProfile(),
                                ),
                              );
                            },
                            child: Text(
                              'My Profile',
                              style: TextStyle(
                                color: AllCoustomTheme.getSeeMoreThemeColor(),
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontFamily: "Roboto",
                              ),
                            ))
                      ],
                    ),
                  ],
                )),
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
                  ))),
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
                    margin: EdgeInsets.only(top: 7.0),
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
                      margin: EdgeInsets.only(top: 5.0),
                      child: Text(
                        'Go Live with Auro Portfolio',
                        style: TextStyle(
                          color: AllCoustomTheme.getTextThemeColor(),
                          fontSize: ConstanceData.SIZE_TITLE15,
                          fontFamily: "Roboto",
                        ),
                      )),
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
                  ))),
                ),
              ),
            ),
            SizedBox(
              height: 20,
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
                          child: ExpandablePanel(
                            header: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                        image: new AssetImage(
                                            'assets/appIcon.jpg')),
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
                                        color: AllCoustomTheme
                                            .getSeeMoreThemeColor(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                                            color: AllCoustomTheme
                                                .getsecoundTextThemeColor(),
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
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          OnBoardingFirst(
                                                    logo: "logo.png",
                                                    callingFrom:
                                                        "Accredited Investor",
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              'Go pro',
                                              style: TextStyle(
                                                color: AllCoustomTheme
                                                    .getTextThemeColor(),
                                                fontSize:
                                                    ConstanceData.SIZE_TITLE14,
                                              ),
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
                                            color: AllCoustomTheme
                                                .getsecoundTextThemeColor(),
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
                                              color: AllCoustomTheme
                                                  .getTextThemeColor(),
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE14,
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
                            header: Row(
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
                                      color: AllCoustomTheme
                                          .getsecoundTextThemeColor(),
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
                                        color: AllCoustomTheme
                                            .getSeeMoreThemeColor(),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(),
                                ),
                              ],
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
                                            color: AllCoustomTheme
                                                .getsecoundTextThemeColor(),
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
                                              color: AllCoustomTheme
                                                  .getTextThemeColor(),
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE14,
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
                                            color: AllCoustomTheme
                                                .getsecoundTextThemeColor(),
                                            size: 8,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 14,
                                      ),
                                      Expanded(
                                        child: Animator(
                                          tween:
                                              Tween<double>(begin: 0, end: 1),
                                          duration: Duration(milliseconds: 500),
                                          cycles: 1,
                                          builder: (anim) => SizeTransition(
                                            sizeFactor: anim,
                                            axis: Axis.horizontal,
                                            axisAlignment: 1,
                                            child: Text(
                                              'Private Equity/ Venture Capital deals',
                                              style: TextStyle(
                                                color: AllCoustomTheme
                                                    .getTextThemeColor(),
                                                fontSize:
                                                    ConstanceData.SIZE_TITLE14,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
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
                                            color: AllCoustomTheme
                                                .getsecoundTextThemeColor(),
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
                                              color: AllCoustomTheme
                                                  .getTextThemeColor(),
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE14,
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
                                            color: AllCoustomTheme
                                                .getsecoundTextThemeColor(),
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
                                              color: AllCoustomTheme
                                                  .getTextThemeColor(),
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE14,
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
                              ],
                            ),
                            tapHeaderToExpand: true,
                            hasIcon: true,
                            iconColor: Colors.blueGrey,
                          ),
                        ),
                        // my prifle
                        ListTileTheme(
                          contentPadding: EdgeInsets.only(right: 10.0),
                          child: ExpansionTile(
                            title: Text(
                              "My profile",
                              style: TextStyle(
                                color: AllCoustomTheme.getSeeMoreThemeColor(),
                                fontSize: ConstanceData.SIZE_TITLE16,
                              ),
                            ),
                            children: <Widget>[
                              ListTile(
                                title: InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.of(context).push(
                                      CupertinoPageRoute(
                                        builder: (BuildContext context) =>
                                            MyProfile(),
                                      ),
                                    );
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
                                            color: AllCoustomTheme
                                                .getsecoundTextThemeColor(),
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
                                            'My Investment Track Record',
                                            style: TextStyle(
                                              color: AllCoustomTheme
                                                  .getTextThemeColor(),
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ListTile(
                                title: InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    widget.auroStreakCallback();
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
                                            color: AllCoustomTheme
                                                .getsecoundTextThemeColor(),
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
                                              color: AllCoustomTheme
                                                  .getTextThemeColor(),
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE14,
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
                                            color: AllCoustomTheme
                                                .getsecoundTextThemeColor(),
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
                                              color: AllCoustomTheme
                                                  .getTextThemeColor(),
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE14,
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
                                            color: AllCoustomTheme
                                                .getsecoundTextThemeColor(),
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
                                              color: AllCoustomTheme
                                                  .getTextThemeColor(),
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE14,
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
                                            color: AllCoustomTheme
                                                .getsecoundTextThemeColor(),
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
                                              color: AllCoustomTheme
                                                  .getTextThemeColor(),
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE14,
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
                                            color: AllCoustomTheme
                                                .getsecoundTextThemeColor(),
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
                                              color: AllCoustomTheme
                                                  .getTextThemeColor(),
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE14,
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
                                            color: AllCoustomTheme
                                                .getsecoundTextThemeColor(),
                                            size: 8,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 14,
                                      ),
                                      Expanded(
                                        child: Animator(
                                          tween:
                                              Tween<double>(begin: 0, end: 1),
                                          duration: Duration(milliseconds: 500),
                                          cycles: 1,
                                          builder: (anim) => SizeTransition(
                                            sizeFactor: anim,
                                            axis: Axis.horizontal,
                                            axisAlignment: 1,
                                            child: Text(
                                              'Register your product on one of our markets (Please send email with details to AuroLP@AuroIM.com)',
                                              style: TextStyle(
                                                color: AllCoustomTheme
                                                    .getTextThemeColor(),
                                                fontSize:
                                                    ConstanceData.SIZE_TITLE14,
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
                                  onTap: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return HowAppWorks(
                                            videoLink:
                                                "https://www.youtube.com/watch?v=RWFXn2Dsb9E",
                                          );
                                        });
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
                                            color: AllCoustomTheme
                                                .getsecoundTextThemeColor(),
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
                                            'Presentation at Stanford \nAngels Summit',
                                            style: TextStyle(
                                              color: AllCoustomTheme
                                                  .getTextThemeColor(),
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE14,
                                            ),
                                            overflow: TextOverflow.clip,
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
                                  onTap: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return HowAppWorks(
                                            videoLink:
                                                "https://www.youtube.com/watch?v=Tj5vvzUVqrc&t=2s",
                                          );
                                        });
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
                                            color: AllCoustomTheme
                                                .getsecoundTextThemeColor(),
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
                                            'How app works',
                                            style: TextStyle(
                                              color: AllCoustomTheme
                                                  .getTextThemeColor(),
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE14,
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
                                            color: AllCoustomTheme
                                                .getsecoundTextThemeColor(),
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
                                              color: AllCoustomTheme
                                                  .getTextThemeColor(),
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE14,
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
                                            color: AllCoustomTheme
                                                .getsecoundTextThemeColor(),
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
                                              color: AllCoustomTheme
                                                  .getTextThemeColor(),
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE14,
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
                                            color: AllCoustomTheme
                                                .getsecoundTextThemeColor(),
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
                                              color: AllCoustomTheme
                                                  .getTextThemeColor(),
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE14,
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
                                            color: AllCoustomTheme
                                                .getsecoundTextThemeColor(),
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
                                              color: AllCoustomTheme
                                                  .getTextThemeColor(),
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE14,
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
                          child: ListTile(
                            onTap: () async {
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.remove('Session_token');
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => IntroductionScreen2(),
                                ),
                              );
                            },
                            title: Text(
                              "Logout",
                              style: TextStyle(
                                  color:
                                      AllCoustomTheme.getSeeMoreThemeColor()),
                            ),
                          ),
                        ),
                        // Container(
                        //   child: SwitchListTile(
                        //     value: globals.isGoldBlack,
                        //     onChanged: widget.changeThemeCallback,
                        //     title: Text(
                        //       globals.isGoldBlack
                        //           ? "Non-Professional"
                        //           : "Professional",
                        //       style: TextStyle(
                        //           color:
                        //               AllCoustomTheme.getSeeMoreThemeColor()),
                        //     ),
                        //   ),
                        // ),
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
