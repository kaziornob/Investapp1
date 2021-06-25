import 'dart:io';

// import 'package:admob_flutter/admob_flutter.dart';
import 'package:animator/animator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/global.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/drawer/drawer.dart';
import 'package:auroim/modules/muitisig/walletCoinDetail.dart';
import 'package:auroim/modules/underGroundSlider/setSchedule.dart';
import 'package:auroim/modules/underGroundSlider/transferMoney.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MultisigWallet extends StatefulWidget {
  @override
  _MultisigWalletState createState() => _MultisigWalletState();
}

class _MultisigWalletState extends State<MultisigWallet> {
  var appBarheight = 0.0;
  var _multiSigScaffoldKey = new GlobalKey<ScaffoldState>();
  var height = 0.0;

  bool _isInProgress = false;
  // AdmobBannerSize bannerSize;
  @override
  void initState() {
    super.initState();
    loadUserDetails();
    // bannerSize = AdmobBannerSize.BANNER;
  }

  loadUserDetails() async {
    setState(() {
      _isInProgress = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      _isInProgress = false;
    });
  }

  String getBannerAdUnitId() {
    if (Platform.isIOS) {
      return '';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-5575162454233793/7463434777';
    }
    return null;
  }

  // void handleEvent(
  //     AdmobAdEvent event, Map<String, dynamic> args, String adType) {
  //   switch (event) {
  //     case AdmobAdEvent.loaded:
  //       print('New Admob $adType Ad loaded!');
  //       break;
  //     case AdmobAdEvent.opened:
  //       print('Admob $adType Ad opened!');
  //       break;
  //     case AdmobAdEvent.closed:
  //       print('Admob $adType Ad closed!');
  //       break;
  //     case AdmobAdEvent.failedToLoad:
  //       print('Admob $adType failed to load. :(');
  //       break;
  //       // case AdmobAdEvent.rewarded:
  //       //   showDialog(
  //       //     context: scaffoldState.currentContext,
  //       //     builder: (BuildContext context) {
  //       //       return WillPopScope(
  //       //         child: AlertDialog(
  //       //           content: Column(
  //       //             mainAxisSize: MainAxisSize.min,
  //       //             children: <Widget>[
  //       //               Text('Reward callback fired. Thanks Andrew!'),
  //       //               Text('Type: ${args['type']}'),
  //       //               Text('Amount: ${args['amount']}'),
  //       //             ],
  //       //           ),
  //       //         ),
  //       //         onWillPop: () async {
  //       //           scaffoldState.currentState.hideCurrentSnackBar();
  //       //           return true;
  //       //         },
  //       //       );
  //       //     },
  //       //   );
  //       break;
  //     default:
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    AppBar appBar = AppBar();
    appBarheight = appBar.preferredSize.height;
    return Stack(
      children: <Widget>[
        Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                HexColor(globals.primaryColorString).withOpacity(0.6),
                HexColor(globals.primaryColorString).withOpacity(0.6),
                HexColor(globals.primaryColorString).withOpacity(0.6),
                HexColor(globals.primaryColorString).withOpacity(0.6),
              ],
            ),
          ),
        ),
        Scaffold(
          key: _multiSigScaffoldKey,
          drawer: SizedBox(
            width: MediaQuery.of(context).size.width * 0.75 < 400
                ? MediaQuery.of(context).size.width * 0.75
                : 350,
            child: Drawer(
              child: AppDrawer(
                selectItemName: 'multisig',
              ),
            ),
          ),
          backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
          body: ModalProgressHUD(
            inAsyncCall: _isInProgress,
            opacity: 0,
            progressIndicator: CupertinoActivityIndicator(
              radius: 12,
            ),
            child: !_isInProgress
                ? Column(
                    children: <Widget>[
                      SizedBox(
                        height: appBarheight,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 16,
                          left: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                _multiSigScaffoldKey.currentState.openDrawer();
                              },
                              child: Icon(
                                Icons.sort,
                                color:
                                    AllCoustomTheme.getsecoundTextThemeColor(),
                              ),
                            ),
                            Animator(
                              tween: Tween<double>(begin: 0, end: 1),
                              duration: Duration(milliseconds: 500),
                              cycles: 1,
                              builder: (_, anim, __) => SizeTransition(
                                sizeFactor: CurvedAnimation(
                                    curve: Curves.fastOutSlowIn,
                                    parent: anim.controller),
                                axis: Axis.horizontal,
                                axisAlignment: 1,
                                child: InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    showCupertinoModalPopup<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                globals.buttoncolor1,
                                                globals.buttoncolor2,
                                              ],
                                            ),
                                          ),
                                          height: height / 2,
                                          child: Scaffold(
                                            backgroundColor: Colors.transparent,
                                            body: SetSchedule(),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Icon(
                                    Icons.watch_later,
                                    color: AllCoustomTheme
                                        .getsecoundTextThemeColor(),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Animator(
                            tween: Tween<double>(begin: 0, end: 1),
                            duration: Duration(milliseconds: 500),
                            cycles: 1,
                            builder: (_, anim, __) => SizeTransition(
                              sizeFactor: CurvedAnimation(
                                  curve: Curves.fastOutSlowIn,
                                  parent: anim.controller),
                              axis: Axis.horizontal,
                              axisAlignment: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  'Wallet',
                                  style: TextStyle(
                                    color: AllCoustomTheme.getTextThemeColors(),
                                    fontWeight: FontWeight.bold,
                                    fontSize: ConstanceData.SIZE_TITLE25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 16,
                            ),
                            child: Animator(
                              duration: Duration(milliseconds: 500),
                              cycles: 1,
                              builder: (_, anim, __) => Transform.scale(
                                scale: anim.value,
                                child: InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    showCupertinoModalPopup<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                globals.buttoncolor1,
                                                globals.buttoncolor2,
                                              ],
                                            ),
                                          ),
                                          height: height / 1.5,
                                          child: Scaffold(
                                            backgroundColor: Colors.transparent,
                                            body: TransferMoney(),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: AllCoustomTheme
                                          .getsecoundTextThemeColor(),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Transfer',
                                        style: TextStyle(
                                          color: AllCoustomTheme
                                              .getTextThemeColors(),
                                          fontSize: ConstanceData.SIZE_TITLE14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.only(left: 16, top: 0),
                          children: <Widget>[
                            Animator(
                              duration: Duration(milliseconds: 500),
                              cycles: 1,
                              builder: (_, anim, __) => Transform.scale(
                                scale: anim.value,
                                child: Column(
                                  children: <Widget>[
                                    MagicBoxGradiantLine(),
                                    InkWell(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        gotoWalletCoinDetail('Bitcoin', 'BTC');
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                          ),
                                          color: AllCoustomTheme.boxColor(),
                                        ),
                                        height: 80,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 6,
                                              bottom: 6,
                                              left: 10,
                                              right: 12),
                                          child: Row(
                                            children: <Widget>[
                                              CachedNetworkImage(
                                                imageUrl:
                                                    'https://static.coincap.io/assets/icons/btc@2x.png',
                                                height: 45,
                                                width: 45,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        CircleAvatar(
                                                  backgroundColor: AllCoustomTheme
                                                      .getsecoundTextThemeColor(),
                                                  child: Text(
                                                    'B',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'Bitcoin',
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getTextThemeColors(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE18,
                                                    ),
                                                  ),
                                                  Text(
                                                    'BTC',
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getsecoundTextThemeColor(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Expanded(
                                                child: SizedBox(),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Text(
                                                    '\$5770.50',
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getTextThemeColors(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    '1.43578',
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getsecoundTextThemeColor(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Animator(
                              duration: Duration(milliseconds: 500),
                              cycles: 1,
                              builder: (_, anim, __) => Transform.scale(
                                scale: anim.value,
                                child: InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    gotoWalletCoinDetail('Bitcoin Cash', 'BCH');
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      MagicBoxGradiantLine(),
                                      Container(
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                          ),
                                          color: AllCoustomTheme.boxColor(),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 6,
                                              bottom: 6,
                                              left: 10,
                                              right: 12),
                                          child: Row(
                                            children: <Widget>[
                                              CachedNetworkImage(
                                                imageUrl:
                                                    'https://static.coincap.io/assets/icons/bch@2x.png',
                                                height: 45,
                                                width: 45,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        CircleAvatar(
                                                  backgroundColor: AllCoustomTheme
                                                      .getsecoundTextThemeColor(),
                                                  child: Text(
                                                    'B',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'Bitcoin Cash',
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getTextThemeColors(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE18,
                                                    ),
                                                  ),
                                                  Text(
                                                    'BCH',
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getsecoundTextThemeColor(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Expanded(
                                                child: SizedBox(),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Text(
                                                    '\$2303.89',
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getTextThemeColors(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    '0.2568',
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getsecoundTextThemeColor(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Animator(
                              duration: Duration(milliseconds: 500),
                              cycles: 1,
                              builder: (_, anim, __) => Transform.scale(
                                scale: anim.value,
                                child: InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    gotoWalletCoinDetail('Monero', 'XMR');
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      MagicBoxGradiantLine(),
                                      Container(
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                          ),
                                          color: AllCoustomTheme.boxColor(),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 6,
                                              bottom: 6,
                                              left: 10,
                                              right: 12),
                                          child: Row(
                                            children: <Widget>[
                                              CachedNetworkImage(
                                                imageUrl:
                                                    'https://static.coincap.io/assets/icons/xmr@2x.png',
                                                height: 45,
                                                width: 45,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        CircleAvatar(
                                                  backgroundColor: AllCoustomTheme
                                                      .getsecoundTextThemeColor(),
                                                  child: Text(
                                                    'M',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'Monero',
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getTextThemeColors(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE18,
                                                    ),
                                                  ),
                                                  Text(
                                                    'XMR',
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getsecoundTextThemeColor(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Expanded(
                                                child: SizedBox(),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Text(
                                                    '\$893.76',
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getTextThemeColors(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    '0.0001',
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getsecoundTextThemeColor(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Container(
                            //   height: 85,
                            //   child: AdmobBanner(
                            //     adUnitId: getBannerAdUnitId(),
                            //     adSize: bannerSize,
                            //     listener: (AdmobAdEvent event, Map<String, dynamic> args) {
                            //       handleEvent(event, args, 'Banner');
                            //     },
                            //     onBannerCreated: (AdmobBannerController controller) {
                            //       // Dispose is called automatically for you when Flutter removes the banner from the widget tree.
                            //       // Normally you don't need to worry about disposing this yourself, it's handled.
                            //       // If you need direct access to dispose, this is your guy!
                            //       // controller.dispose();
                            //     },
                            //   ),
                            // ),
                            SizedBox(
                              height: 10,
                            ),
                            Animator(
                              duration: Duration(milliseconds: 500),
                              cycles: 1,
                              builder: (_, anim, __) => Transform.scale(
                                scale: anim.value,
                                child: InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    gotoWalletCoinDetail('Dash', 'DASH');
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      MagicBoxGradiantLine(),
                                      Container(
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                          ),
                                          color: AllCoustomTheme.boxColor(),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 6,
                                              bottom: 6,
                                              left: 10,
                                              right: 12),
                                          child: Row(
                                            children: <Widget>[
                                              CachedNetworkImage(
                                                imageUrl:
                                                    'https://static.coincap.io/assets/icons/dash@2x.png',
                                                height: 45,
                                                width: 45,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        CircleAvatar(
                                                  backgroundColor: AllCoustomTheme
                                                      .getsecoundTextThemeColor(),
                                                  child: Text(
                                                    'D',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'Dash',
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getTextThemeColors(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE18,
                                                    ),
                                                  ),
                                                  Text(
                                                    'DASH',
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getsecoundTextThemeColor(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Expanded(
                                                child: SizedBox(),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Text(
                                                    '\$1725.38',
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getTextThemeColors(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    '2.3242',
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getsecoundTextThemeColor(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Animator(
                              duration: Duration(milliseconds: 500),
                              cycles: 1,
                              builder: (_, anim, __) => Transform.scale(
                                scale: anim.value,
                                child: InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    gotoWalletCoinDetail('Bytecoin', 'BCN');
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      MagicBoxGradiantLine(),
                                      Container(
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                          ),
                                          color: AllCoustomTheme.boxColor(),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 6,
                                              bottom: 6,
                                              left: 10,
                                              right: 12),
                                          child: Row(
                                            children: <Widget>[
                                              CachedNetworkImage(
                                                imageUrl:
                                                    'https://static.coincap.io/assets/icons/bcn@2x.png',
                                                height: 45,
                                                width: 45,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        CircleAvatar(
                                                  backgroundColor: AllCoustomTheme
                                                      .getsecoundTextThemeColor(),
                                                  child: Text(
                                                    'B',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'Bytecoin',
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getTextThemeColors(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE18,
                                                    ),
                                                  ),
                                                  Text(
                                                    'BCN',
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getsecoundTextThemeColor(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Expanded(
                                                child: SizedBox(),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Text(
                                                    '\$1874.90',
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getTextThemeColors(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    '0.8957',
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getsecoundTextThemeColor(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Animator(
                              duration: Duration(milliseconds: 500),
                              cycles: 1,
                              builder: (_, anim, __) => Transform.scale(
                                scale: anim.value,
                                child: InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    gotoWalletCoinDetail('Dai', 'DAI');
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      MagicBoxGradiantLine(),
                                      Container(
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                          ),
                                          color: AllCoustomTheme.boxColor(),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 6,
                                              bottom: 6,
                                              left: 10,
                                              right: 12),
                                          child: Row(
                                            children: <Widget>[
                                              CachedNetworkImage(
                                                imageUrl:
                                                    'https://static.coincap.io/assets/icons/dai@2x.png',
                                                height: 45,
                                                width: 45,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        CircleAvatar(
                                                  backgroundColor: AllCoustomTheme
                                                      .getsecoundTextThemeColor(),
                                                  child: Text(
                                                    'D',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'Dai',
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getTextThemeColors(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE18,
                                                    ),
                                                  ),
                                                  Text(
                                                    'DAI',
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getsecoundTextThemeColor(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Expanded(
                                                child: SizedBox(),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Text(
                                                    '\$1.0086',
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getTextThemeColors(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    '1.0100',
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getsecoundTextThemeColor(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Animator(
                              duration: Duration(milliseconds: 500),
                              cycles: 1,
                              builder: (_, anim, __) => Transform.scale(
                                scale: anim.value,
                                child: InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    gotoWalletCoinDetail('Lisk', 'LSK');
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      MagicBoxGradiantLine(),
                                      Container(
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                          ),
                                          color: AllCoustomTheme.boxColor(),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 6,
                                              bottom: 6,
                                              left: 10,
                                              right: 12),
                                          child: Row(
                                            children: <Widget>[
                                              CachedNetworkImage(
                                                imageUrl:
                                                    'https://static.coincap.io/assets/icons/lsk@2x.png',
                                                height: 45,
                                                width: 45,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        CircleAvatar(
                                                  backgroundColor: AllCoustomTheme
                                                      .getsecoundTextThemeColor(),
                                                  child: Text(
                                                    'L',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'Lisk',
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getTextThemeColors(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE18,
                                                    ),
                                                  ),
                                                  Text(
                                                    'LSK',
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getsecoundTextThemeColor(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Expanded(
                                                child: SizedBox(),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Text(
                                                    '\$0.8143',
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getTextThemeColors(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    '0.7200',
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getsecoundTextThemeColor(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                : SizedBox(),
          ),
        )
      ],
    );
  }

  gotoWalletCoinDetail(String coinName, String coinShortName) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (BuildContext context) => WalletCoinDetail(
          coinName: coinName,
          shortName: coinShortName,
        ),
      ),
    );
  }
}
