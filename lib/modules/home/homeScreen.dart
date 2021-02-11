import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:animator/animator.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/modules/bussPost/createPoll.dart';
import 'package:auroim/modules/bussPost/portfolioPitch.dart';
import 'package:auroim/modules/bussPost/stockPitch.dart';
import 'package:auroim/modules/bussPost/wishList.dart';
import 'package:auroim/modules/investRelatedPages/riskOnboardingPages/onBoardingFirst.dart';
import 'package:auroim/modules/investRelatedPages/searchFirstPage.dart';
import 'package:auroim/modules/investRelatedPages/securityFirstPage.dart';
import 'package:auroim/modules/qaInvForumPages/addEditQus.dart';
import 'package:auroim/modules/socialInvestRelatedPages/InvestedAssetModule.dart';
import 'package:auroim/modules/socialInvestRelatedPages/auroStrikeBadges.dart';
import 'package:auroim/modules/socialInvestRelatedPages/clubDetail.dart';
import 'package:auroim/modules/questionAndAnswerModule/models/question.dart';
import 'package:auroim/modules/questionAndAnswerModule/resources/question_api_provider.dart';
import 'package:auroim/modules/questionAndAnswerModule/ui/pages/error.dart';
import 'package:auroim/modules/questionAndAnswerModule/ui/pages/questionTemplate.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/global.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/graphDetail/OHLCVGraph.dart';
import 'package:auroim/graphDetail/QuickPercentChangeBar.dart';
import 'package:auroim/main.dart';
import 'package:auroim/model/listingsModel.dart';
import 'package:auroim/modules/chagePIN/changepin.dart';
import 'package:auroim/modules/drawer/drawer.dart';
import 'package:auroim/modules/underGroundSlider/notificationSlider.dart';
import 'package:auroim/modules/userProfile/userProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

const String testDevice = 'YOUR_DEVICE_ID';

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _isInProgress = false;
  bool isSelect1 = false;
  bool isSelect2 = false;
  bool isSelect3 = false;
  bool isSelect4 = false;
  bool isSelect5 = false;


  bool _isSearch = false;
  bool allCoin = false;
  bool isLoading = false;

  var width = 0.0;
  var height = 0.0;
  var appBarheight = 0.0;
  var statusBarHeight = 0.0;
  var graphHeight = 0.0;
  List<CryptoCoinDetail> _serchCoinList = [];
  var marketCapUpDown;

  String historyAmt = "720";
  String historyType = "minute";
  String historyTotal = "24h";
  String historyAgg = "2";
  String _high = "0";
  String _low = "0";
  String _change = "0";
  String symbol = 'BTC';

  USD generalStats;
  int currentOHLCVWidthSetting = 0;
  List historyOHLCV;

  var subscription;

  List<CryptoCoinDetail> lstCryptoCoinDetail = [];

  AdmobBannerController admobBannerController;

  // third screen params
  List<String> userList = <String>['Pooja','Ritika'];

  String selectedUser;
  List<String> tagItemList = <String>['native','fixed'];

  //fifth screen params
  String selectedInceptionLeague;
  String selectedWeeklyLeague;

  // second screen params

  int selectedTabIndex;

  final List<Tab> tabList = <Tab>[
    new Tab(text: 'Recommended'),
    new Tab(text: 'Trending'),
    new Tab(text: "Week"),
    new Tab(text: "Month"),
    // new Tab(text: "Ask Question"),
  ];

  final List<Tab> socialFilterTabList = <Tab>[
    new Tab(text: 'Overall'),
    new Tab(text: 'Weekly'),
  ];

  TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabList.length);

    setFirstTab();
    callItself();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print(result.index); // 0=wifi, 1=mobile, 2=none
      if (result.index != 2) {
        setFirstTab();
        callItself();
        marketCapUpDown = Icons.arrow_upward;
      } else {
        connectionError();
      }
    });
    bannerSize = AdmobBannerSize.BANNER;
  }

  @override
  dispose() {
    super.dispose();
    subscription.cancel();
    admobBannerController.dispose();
  }

  connectionError() {
    showInSnackBar(ConstanceData.NoInternet);
  }

  Future showInSnackBar(String value, {bool isGreeen = false}) async {
    await Future.delayed(const Duration(milliseconds: 700));
    _scaffoldKey.currentState.showSnackBar(
      new SnackBar(
        duration: Duration(seconds: 2),
        content: new Text(
          value,
          style: TextStyle(
            color: AllCoustomTheme.getReBlackAndWhiteThemeColors(),
          ),
        ),
        backgroundColor: isGreeen ? AllCoustomTheme.getThemeData().primaryColor : Colors.red,
      ),
    );
  }

  isLoadingList() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      isLoading = false;
    });
  }

  Future<Null> getApiAllData(int index) async {
    List<CryptoCoinDetail> allCoinList = [];
    allCoinList.clear();
    List<CryptoCoinDetail> coindata = await getData1(index);
    coindata = await getData1(index);
    if (coindata != null) {
      if (coindata.length != 0) {
        index += coindata.length;
        if (index == 1) {
          setState(() {
            allCoinList.addAll(coindata);
          });
        } else {
          allCoinList.addAll(coindata);
          setState(() {
            allCoinList.removeWhere((length) => length.quote.uSD.marketCap == null);
            if (allCoin == true) {
              getApiAllData(index);
            }
            lstCryptoCoinDetail.clear();
            lstCryptoCoinDetail.addAll(allCoinList);
            lstCryptoCoinDetail.sort((a, b) => b.quote.uSD.marketCap.compareTo(a.quote.uSD.marketCap));
            print(lstCryptoCoinDetail[0].quote.uSD);

            marketListData.clear();
            marketListData.addAll(allCoinList);
            marketListData.sort((a, b) => b.quote.uSD.marketCap.compareTo(a.quote.uSD.marketCap));
          });
        }
      }
    }
  }

  callItself() async {
    getApiAllData(1);
    changeHistory(historyType, historyAmt, historyTotal, historyAgg);
    await Future.delayed(Duration(hours: 1));
    callItself();
  }

  Future<Null> changeHistory(String type, String amt, String total, String agg) async {
    setState(() {
      _high = "0";
      _low = "0";
      _change = "0";

      historyAmt = amt;
      historyType = type;
      historyTotal = total;
      historyAgg = agg;

      historyOHLCV = null;
    });
    //getGeneralStats();
    _makeGeneralStats();
    await getHistoryOHLCV();
    _getHL();
  }

  _makeGeneralStats() {
    for (CryptoCoinDetail coin in marketListData) {
      if (coin.symbol == symbol) {
        generalStats = coin.quote.uSD;
        setState(() {});
        break;
      }
    }
  }

  _getHL() {
    num highReturn = -double.infinity;
    num lowReturn = double.infinity;

    for (var i in historyOHLCV) {
      if (i["high"] > highReturn) {
        highReturn = i["high"].toDouble();
      }
      if (i["low"] < lowReturn) {
        lowReturn = i["low"].toDouble();
      }
    }

    _high = normalizeNumNoCommas(highReturn);
    _low = normalizeNumNoCommas(lowReturn);

    var start = historyOHLCV[0]["open"] == 0 ? 1 : historyOHLCV[0]["open"];
    var end = historyOHLCV.last["close"];
    var changePercent = (end - start) / start * 100;
    _change = changePercent.toStringAsFixed(2);
  }

  Future<Null> getHistoryOHLCV() async {
    var response = await http.get(
        Uri.encodeFull("https://min-api.cryptocompare.com/data/histo" +
            ohlcvWidthOptions[historyTotal][currentOHLCVWidthSetting][3] +
            "?fsym=" +
            symbol +
            "&tsym=USD&limit=" +
            (ohlcvWidthOptions[historyTotal][currentOHLCVWidthSetting][1] - 1).toString() +
            "&aggregate=" +
            ohlcvWidthOptions[historyTotal][currentOHLCVWidthSetting][2].toString()),
        headers: {"Accept": "application/json"});
    setState(() {
      historyOHLCV = new JsonDecoder().convert(response.body)["Data"];
      if (historyOHLCV == null) {
        historyOHLCV = [];
      }
    });
  }

  setFirstTab() {
    setState(() {
      isSelect1 = true;
      isSelect2 = false;
      isSelect3 = false;
      isSelect4 = false;
      isSelect5 = false;
    });
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: CircleAvatar(
                radius: 20.0,
                backgroundImage: new AssetImage('assets/download.jpeg'),
                backgroundColor: Colors.transparent,
              ),
            ),
            FractionalTranslation(
              translation: Offset(0.4, 0.2),
              child: GestureDetector(
                onTap: () {
                  _scaffoldKey.currentState.openDrawer();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 11.0,
                  child: Icon(
                    Icons.sort_outlined,
                    size: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
/*        SizedBox(
          width: 10,
        ),*/
        //search box area
        Container(
          // width: MediaQuery.of(context).size.width*0.60,
          // height: MediaQuery.of(context).size.height*0.053,
          margin: EdgeInsets.only(top: 10.0,left: 13.0),
          decoration: new BoxDecoration(
            color: Color(0xFFFFFFFF),
            border: Border.all(
              color: Color(0xff696969),
              width: 1.5,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width*0.58,
                height: MediaQuery.of(context).size.height*0.05,
                child: TextFormField(
                  style: TextStyle(
                    color: AllCoustomTheme.getTextThemeColors(),
                    fontSize: ConstanceData.SIZE_TITLE14,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      FontAwesomeIcons.search,
                      color: AllCoustomTheme.getNewSecondTextThemeColor(),
                      size: 15,
                    ),
                    hintText: "Search",
                    hintStyle: TextStyle(
                      color: AllCoustomTheme.getNewSecondTextThemeColor(),
                      fontSize: ConstanceData.SIZE_TITLE14,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: 5,
        ),
        //globe icon
        Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Image(
                height: 40,
                width: 40,
                image: new AssetImage('assets/appIcon.png')
            ),
            FractionalTranslation(
              translation: Offset(-0.5, 0.0),
              child: GestureDetector(
                onTap: () {
                  _scaffoldKey.currentState.openDrawer();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 6.0,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();
    appBarheight = appBar.preferredSize.height;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    statusBarHeight = MediaQuery.of(context).padding.top;
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
        SafeArea(
          bottom: true,
          child: Scaffold(
            key: _scaffoldKey,
            appBar: isSelect2 || isSelect4 || isSelect5 ?
            PreferredSize(
                preferredSize: Size.fromHeight(65.0),
                child: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: AllCoustomTheme.getAppBarBackgroundThemeColors(),
                  title: _buildAppBar(context),
                ),
            ) : null,
            bottomNavigationBar: Container(
              decoration: new BoxDecoration(
                color: AllCoustomTheme.getBodyContainerThemeColor(),
                border: Border.all(
                  color: AllCoustomTheme.getSecondIconThemeColor(),
                  width: 1.0,
                ),
              ),
              height: 52,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            isSelect1
                                ? Animator(
                              duration: Duration(milliseconds: 500),
                              cycles: 1,
                              builder: (anim) => Transform.scale(
                                scale: anim.value,
                                child: Container(
                                  height: 2.5,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        globals.iconButtonColor1,
                                        globals.iconButtonColor2,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                                : SizedBox(
                              height: 2,
                            ),
                            GestureDetector(
                              onTap: () {
                                selectFirst();
                              },
                              child: isSelect1
                                  ? Animator(
                                tween: Tween<double>(begin: 0.8, end: 1.1),
                                curve: Curves.decelerate,
                                cycles: 1,
                                builder: (anim) => Transform.scale(
                                    scale: anim.value,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Icon(
                                            Icons.home,
                                            size: 23,
                                            color: isSelect1 ? AllCoustomTheme.getIconThemeColors() : AllCoustomTheme.getSecondIconThemeColor(),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Align(
                                            alignment: Alignment.topCenter,
                                            child: Text(
                                              "Home",
                                              style: TextStyle(
                                                  fontSize: ConstanceData.SIZE_TITLE14,
                                                  color: isSelect1 ? AllCoustomTheme.getIconThemeColors() : AllCoustomTheme.getSecondIconThemeColor(),
                                                  fontFamily: "Rasa",
                                                  fontStyle: FontStyle.normal,
                                                  letterSpacing: 0.2
                                              ),
                                            )
                                        ),
                                      ],
                                    )
                                ),
                              )
                                  : firstAnimation(),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            isSelect2
                                ? Animator(
                              duration: Duration(milliseconds: 500),
                              cycles: 1,
                              builder: (anim) => Transform.scale(
                                scale: anim.value,
                                child: Container(
                                  height: 2.5,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        globals.iconButtonColor1,
                                        globals.iconButtonColor2,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                                : SizedBox(
                              height: 2,
                            ),
                            GestureDetector(
                              onTap: () {
                                selectSecond();
                              },
                              child: isSelect2
                                  ? Animator(
                                tween: Tween<double>(begin: 0.8, end: 1.1),
                                curve: Curves.decelerate,
                                cycles: 1,
                                builder: (anim) => Transform.scale(
                                  scale: anim.value,
                                  child: secondAnimation(),
                                ),
                              )
                                  : secondAnimation(),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            isSelect3
                                ? Animator(
                              duration: Duration(milliseconds: 500),
                              cycles: 1,
                              builder: (anim) => Transform.scale(
                                scale: anim.value,
                                child: Container(
                                  height: 2.5,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        globals.iconButtonColor1,
                                        globals.iconButtonColor2,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                                : SizedBox(
                              height: 2,
                            ),
                            GestureDetector(
                              onTap: () {
                                selectThird();
                              },
                              child: isSelect3
                                  ? Animator(
                                tween: Tween<double>(begin: 0.8, end: 1.1),
                                curve: Curves.decelerate,
                                cycles: 1,
                                builder: (anim) => Transform.scale(
                                  scale: anim.value,
                                  child: thirdAnimation(),
                                ),
                              )
                                  : thirdAnimation(),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            isSelect5
                                ? Animator(
                              duration: Duration(milliseconds: 500),
                              cycles: 1,
                              builder: (anim) => Transform.scale(
                                scale: anim.value,
                                child: Container(
                                  height: 2.5,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        globals.iconButtonColor1,
                                        globals.iconButtonColor2,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                                : SizedBox(
                              height: 2,
                            ),
                            GestureDetector(
                              onTap: () {
                                selectFive();
                              },
                              child: isSelect5
                                  ? Animator(
                                tween: Tween<double>(begin: 0.8, end: 1.1),
                                curve: Curves.decelerate,
                                cycles: 1,
                                builder: (anim) => Transform.scale(
                                  scale: anim.value,
                                  child: fifthAnimation(),
                                ),
                              )
                                  : fifthAnimation(),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            isSelect4
                                ? Animator(
                              duration: Duration(milliseconds: 500),
                              cycles: 1,
                              builder: (anim) => Transform.scale(
                                scale: anim.value,
                                child: Container(
                                  height: 2.5,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        globals.iconButtonColor1,
                                        globals.iconButtonColor2,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                                : SizedBox(
                              height: 2,
                            ),
                            GestureDetector(
                              onTap: () {
                                selectFourth();
                              },
                              child: isSelect4
                                  ? Animator(
                                tween: Tween<double>(begin: 0.8, end: 1.1),
                                curve: Curves.decelerate,
                                cycles: 1,
                                builder: (anim) => Transform.scale(
                                  scale: anim.value,
                                  child: fourthAnimation(),
                                ),
                              )
                                  : fourthAnimation(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              )
            ),
            drawer: SizedBox(
              width: MediaQuery.of(context).size.width * 0.75 < 400 ? MediaQuery.of(context).size.width * 0.75 : 350,
              child: Drawer(
                elevation: 0,
                child: AppDrawer(
                  selectItemName: 'home',
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            floatingActionButton: Visibility(
              visible: isSelect3,
              child: FloatingActionButton(
                onPressed: () async {
                  displayModalBottomSheet(context);
                },
                child: Icon(
                  Icons.more_vert_outlined,
                  color: AllCoustomTheme.getTextThemeColors(),
                  size: 30.0,
                ),
                backgroundColor: AllCoustomTheme.getsecoundTextThemeColor(),
              ),
            ),
            body: ModalProgressHUD(
              inAsyncCall: _isInProgress,
              opacity: 0,
              progressIndicator: SizedBox(),
              child: Container(
                // color: isSelect2 || isSelect5 ? AllCoustomTheme.getPageBackgroundThemeColor() : AllCoustomTheme.getThemeData().primaryColor,
                color: isSelect2 ? AllCoustomTheme.getPageBackgroundThemeColor() :
                (isSelect5 || isSelect4 ? AllCoustomTheme.getBodyContainerThemeColor() : AllCoustomTheme.getThemeData().primaryColor
                ),
                height: height,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: isSelect2 || isSelect5 || isSelect4 ? 2 : MediaQuery.of(context).padding.top,
                      child: Visibility(
                        visible: isSelect2 || isSelect5 || isSelect4,
                        child: Container(
                          decoration: new BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            border: Border.all(
                              color: Color(0xFFFFFFFF),
                              width: 1.5,
                            ),
                          ),
                        ),
                      )
                    ),
                    Expanded(
                      child: isSelect1
                          ? firstScreen()
                          : isSelect2
                              ? secondScreen()
                              : (isSelect3 ? thirdScreen() : (isSelect4 ? fourthScreen() : fifthScreen() )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget firstAnimation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Icon(
            Icons.home,
            size: 23,
            color: isSelect1 ? AllCoustomTheme.getIconThemeColors() : AllCoustomTheme.getSecondIconThemeColor(),
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            "Home",
            style: TextStyle(
                fontSize: ConstanceData.SIZE_TITLE14,
                color: isSelect1 ? AllCoustomTheme.getIconThemeColors() : AllCoustomTheme.getSecondIconThemeColor(),
                fontFamily: "Rasa",
                fontStyle: FontStyle.normal,
                letterSpacing: 0.2
            ),
          )
        ),
      ],
    );
  }

  Widget secondAnimation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Icon(
            FontAwesomeIcons.coins,
            size: 20,
            color: isSelect2 ? AllCoustomTheme.getIconThemeColors() : AllCoustomTheme.getSecondIconThemeColor(),
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            "Invest",
            style: TextStyle(
                fontSize: ConstanceData.SIZE_TITLE14,
                color: isSelect2 ? AllCoustomTheme.getIconThemeColors() : AllCoustomTheme.getSecondIconThemeColor(),
                fontFamily: "Rasa",
                fontStyle: FontStyle.normal,
                letterSpacing: 0.2
            ),
          )
        ),
      ],
    );
  }

  Widget thirdAnimation() {
    return Container(
      height: 40,
      width: width / 3,
      color: Colors.transparent,
      child: Icon(
        Icons.add_circle,
        size: 30,
        color: isSelect3 ? AllCoustomTheme.getIconThemeColors() : AllCoustomTheme.getSecondIconThemeColor(),
      ),
    );
  }

  Widget fourthAnimation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Icon(
            FontAwesomeIcons.handshake,
            size: 20,
            color: isSelect4 ? AllCoustomTheme.getIconThemeColors() : AllCoustomTheme.getSecondIconThemeColor(),
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            "Exchange",
            style: TextStyle(
                fontSize: ConstanceData.SIZE_TITLE14,
                color: isSelect4 ? AllCoustomTheme.getIconThemeColors() : AllCoustomTheme.getSecondIconThemeColor(),
                fontFamily: "Rasa",
                fontStyle: FontStyle.normal,
                letterSpacing: 0.2
            ),
          )
        ),
      ],
    );
  }


  Widget fifthAnimation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Icon(
            FontAwesomeIcons.globe,
            size: 20,
            color: isSelect5 ? AllCoustomTheme.getIconThemeColors() : AllCoustomTheme.getSecondIconThemeColor(),
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            "Learn",
            style: TextStyle(
                fontSize: ConstanceData.SIZE_TITLE14,
                color: isSelect5 ? AllCoustomTheme.getIconThemeColors() : AllCoustomTheme.getSecondIconThemeColor(),
                fontFamily: "Rasa",
                fontStyle: FontStyle.normal,
                letterSpacing: 0.2
            ),
          )
        ),
      ],
    );
  }

  Widget firstScreen() {
    graphHeight = height - appBarheight - 42;
    return Container(
      height: graphHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                  child: Icon(
                    Icons.sort,
                    color: AllCoustomTheme.getsecoundTextThemeColor(),
                  ),
                ),
                historyOHLCV != null
                    ? Animator(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.decelerate,
                        cycles: 1,
                        builder: (anim) => Transform.scale(
                          scale: anim.value,
                          child: Text(
                            'Bitcoin, BTC Live',
                            style: TextStyle(color: AllCoustomTheme.getTextThemeColors(), fontSize: ConstanceData.SIZE_TITLE18),
                          ),
                        ),
                      )
                    : SizedBox(),
                Animator(
                  duration: Duration(milliseconds: 500),
                  tween: Tween<double>(begin: -0.1, end: 0.1),
                  curve: Curves.decelerate,
                  cycles: 0,
                  builder: (anim) => Transform(
                    transform: Matrix4.skewX(anim.value),
                    child: Icon(
                      Icons.notifications,
                      color: AllCoustomTheme.getsecoundTextThemeColor(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: historyOHLCV != null
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Animator(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.decelerate,
                        cycles: 1,
                        builder: (anim) => Transform.scale(
                          scale: anim.value,
                          child: Text(
                            '\$',
                            style: TextStyle(
                              color: AllCoustomTheme.getTextThemeColors(),
                              fontWeight: FontWeight.bold,
                              fontSize: ConstanceData.SIZE_TITLE18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Animator(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.decelerate,
                        cycles: 1,
                        builder: (anim) => Transform.scale(
                          scale: anim.value,
                          child: Text(
                            generalStats != null
                                ? normalizeNumNoCommas(
                                    generalStats.price,
                                  )
                                : "0",
                            style: TextStyle(
                              color: AllCoustomTheme.getTextThemeColors(),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
/*                      Row(
                        children: <Widget>[
                          Animator(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.decelerate,
                            cycles: 1,
                            builder: (anim) => Transform.scale(
                              scale: anim.value,
                              child: Text(
                                '1h:',
                                style: TextStyle(
                                  color: AllCoustomTheme.getTextThemeColors(),
                                ),
                              ),
                            ),
                          ),
                          Animator(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.decelerate,
                            cycles: 1,
                            builder: (anim) => Transform.scale(
                              scale: anim.value,
                              child: generalStats.percentChange1h != null
                                  ? Icon(
                                      generalStats.percentChange1h.toString().contains('-') ? Icons.arrow_downward : Icons.arrow_upward,
                                      color: generalStats.percentChange1h.toString().contains('-') ? Colors.red : Colors.green,
                                      size: 16,
                                    )
                                  : SizedBox(),
                            ),
                          ),
                          Animator(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.decelerate,
                            cycles: 1,
                            builder: (anim) => Transform.scale(
                              scale: anim.value,
                              child: generalStats.percentChange1h != null
                                  ? Text(
                                      generalStats.percentChange1h.toString() + '%',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        color: generalStats.percentChange1h.toString().contains('-') ? Colors.red : Colors.green,
                                        fontSize: ConstanceData.SIZE_TITLE14,
                                      ),
                                    )
                                  : SizedBox(),
                            ),
                          ),
                        ],
                      )*/
                    ],
                  )
                : SizedBox(),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: historyOHLCV != null
                ? historyOHLCV.isEmpty != true
                    ? Animator(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.decelerate,
                        cycles: 1,
                        builder: (anim) => Transform.scale(
                          scale: anim.value,
                          child: OHLCVGraph(
                            data: historyOHLCV,
                            enableGridLines: true,
                            gridLineColor: globals.buttoncolor1,
                            gridLineLabelColor: AllCoustomTheme.getsecoundTextThemeColor(),
                            gridLineAmount: 4,
                            volumeProp: 0.3,
                            lineWidth: 1,
                            gridLineWidth: 0.5,
                            decreaseColor: Colors.red,
                          ),
                        ),
                      )
                    : Container(
                        alignment: Alignment.topCenter,
                        child: Text("No OHLCV data found :(", style: Theme.of(context).textTheme.caption),
                      )
                : Container(
                    child: Center(
                      child: CupertinoActivityIndicator(
                        radius: 12,
                      ),
                    ),
                  ),
          ),
          generalStats != null
              ? historyOHLCV != null
                  ? Animator(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.decelerate,
                      cycles: 1,
                      builder: (anim) => Transform.scale(
                        scale: anim.value,
                        child: QuickPercentChangeBar(
                          snapshot: generalStats,
                        ),
                      ),
                    )
                  : SizedBox()
              : Container(
                  height: 0.0,
                ),
        ],
      ),
    );
  }

/*  Widget oldSecoundScreen() {
    print(lstCryptoCoinDetail[0]);
    graphHeight = height - appBarheight - 42;
    return Container(
      height: graphHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (BuildContext context) => CryptoNews(),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.info_outline,
                    color: AllCoustomTheme.getsecoundTextThemeColor(),
                  ),
                ),
                Icon(
                  Icons.more_horiz,
                  color: AllCoustomTheme.getsecoundTextThemeColor(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: <Widget>[
              Animator(
                tween: Tween<double>(begin: 0, end: 1),
                duration: Duration(milliseconds: 500),
                cycles: 1,
                builder: (anim) => SizeTransition(
                  sizeFactor: anim,
                  axis: Axis.horizontal,
                  axisAlignment: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Live Stock',
                      style: TextStyle(
                        color: AllCoustomTheme.getTextThemeColors(),
                        fontWeight: FontWeight.bold,
                        fontSize: ConstanceData.SIZE_TITLE25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: AllCoustomTheme.boxColor(),
                    ),
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: ConstanceData.SIZE_TITLE16,
                        color: AllCoustomTheme.getTextThemeColors(),
                      ),
                      cursorColor: AllCoustomTheme.getTextThemeColors(),
                      onChanged: (value) {
                        filterSearchResults(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(
                          Icons.search,
                          size: 20,
                          color: AllCoustomTheme.getsecoundTextThemeColor(),
                        ),
                        hintStyle: TextStyle(
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getsecoundTextThemeColor(),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _upDownMarketCap();
                    },
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: AllCoustomTheme.boxColor(),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 8, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Market cap',
                              style: TextStyle(
                                color: AllCoustomTheme.getTextThemeColors(),
                              ),
                            ),
                            Animator(
                              tween: Tween<double>(begin: 0, end: 2 * pi),
                              duration: Duration(milliseconds: 500),
                              repeats: 1,
                              builder: (anim) => Transform(
                                transform: Matrix4.rotationX(anim.value),
                                alignment: Alignment.center,
                                child: Icon(
                                  marketCapUpDown == Icons.arrow_upward ? Icons.arrow_upward : Icons.arrow_downward,
                                  size: 18,
                                  color: AllCoustomTheme.getTextThemeColors(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          isLoading
              ? Expanded(
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Shimmer.fromColors(
                      baseColor: globals.buttoncolor1,
                      highlightColor: globals.buttoncolor2,
                      enabled: true,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 26),
                        child: Column(
                          children: [1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1]
                              .map(
                                (_) => Padding(
                                  padding: const EdgeInsets.only(left: 16, right: 16),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius: 14,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  height: 8.0,
                                                  color: Colors.white,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                                                ),
                                                Container(
                                                  width: 40.0,
                                                  height: 8.0,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: _isSearch ? _serchCoinList.length : lstCryptoCoinDetail.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index % 11 == 0) {
                          return Column(
                            children: [
                              Container(
                                child: AdmobBanner(
                                  adUnitId: getBannerAdUnitId(),
                                  adSize: bannerSize,
                                  listener: (AdmobAdEvent event, Map<String, dynamic> args) {
                                    handleEvent(event, args, 'Banner');
                                  },
                                  onBannerCreated: (AdmobBannerController controller) {
                                    setState(() {
                                      admobBannerController = controller;
                                    });
                                  },
                                ),
                              ),
                              Divider(
                                color: AllCoustomTheme.getsecoundTextThemeColor(),
                              )
                            ],
                          );
                        }
                        var coinData = _isSearch ? _serchCoinList[index] : lstCryptoCoinDetail[index];
                        var coinId = coinData.id.toString();
                        var coinSymbol = coinData.symbol.toString();
                        var coinName = coinData.name.toString();
                        var price = coinData.quote.uSD.price.toString();
                        var percentchange1h = coinData.quote.uSD.percentChange1h.toString();
                        var marketCap = coinData.quote.uSD.marketCap.toString();
                        var volume = coinData.quote.uSD.volume24h.toString();
                        var availableSupply = coinData.totalSupply.toString();
                        var changein24HR = coinData.quote.uSD.percentChange24h.toString();
                        return InkWell(
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
                                  height: height - appBarheight - 42,
                                  child: Scaffold(
                                    backgroundColor: Colors.transparent,
                                    body: SliderOpen(
                                      coinSymbol: coinSymbol,
                                      coinName: coinName,
                                      price: price,
                                      percentchange1h: percentchange1h,
                                      marketCap: marketCap,
                                      volume: volume,
                                      availableSupply: availableSupply,
                                      changein24HR: changein24HR,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    height: 30,
                                    width: 30,
                                    child: CachedNetworkImage(
                                      errorWidget: (context, url, error) => CircleAvatar(
                                        backgroundColor: AllCoustomTheme.getsecoundTextThemeColor(),
                                        child: Text(
                                          coinSymbol.substring(0, 1),
                                        ),
                                      ),
                                      imageUrl: coinImageURL + coinSymbol.toLowerCase() + "@2x.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        coinName,
                                        style: TextStyle(
                                          color: AllCoustomTheme.getTextThemeColors(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        coinSymbol,
                                        style: TextStyle(
                                          color: AllCoustomTheme.getsecoundTextThemeColor(),
                                          fontSize: ConstanceData.SIZE_TITLE12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(child: Container()),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        ' \$ ' + double.parse(price).toStringAsFixed(2),
                                        style: TextStyle(
                                          color: AllCoustomTheme.getTextThemeColors(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        percentchange1h.contains('-') ? '' + percentchange1h + '%' : '+' + percentchange1h + '%',
                                        style: TextStyle(
                                          color: percentchange1h.contains('-') ? Colors.red : Colors.green,
                                          fontSize: ConstanceData.SIZE_TITLE12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Divider(
                                color: AllCoustomTheme.getsecoundTextThemeColor(),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                )
        ],
      ),
    );
  }*/

  // second screen section start

  Widget getAreaChartView()
  {
    final List<NewSalesData> newSalesData = [
      NewSalesData(2010, 35),
      NewSalesData(2011, 28),
      NewSalesData(2012, 34),
      NewSalesData(2013, 32),
      NewSalesData(2014, 40)
    ];

    final List<Color> color = <Color>[];
    color.add(Colors.blue[50]);
    color.add(Colors.blue[200]);
    color.add(Colors.blue);

    final List<double> stops = <double>[];
    stops.add(0.0);
    stops.add(0.5);
    stops.add(1.0);

    final LinearGradient gradientColors =
    LinearGradient(colors: color, stops: stops);

    return ListView.builder(
      itemCount: 3,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                  height: MediaQuery.of(context).size.height*0.36,
                  width: MediaQuery.of(context).size.width*0.96,
                  child: Container(
                    margin: EdgeInsets.only(left: 10,right: 10),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: new Border.all(color: AllCoustomTheme.getChartBoxThemeColor(), width: 1.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.10,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "APPLE",
                                    style: TextStyle(
                                      color: AllCoustomTheme.getChartBoxTextThemeColor(),
                                      fontSize: ConstanceData.SIZE_TITLE18,
                                      fontFamily: "Roboto",
                                    ),
                                  ),
                                  Text(
                                    "2.20 (1.61%)",
                                    style: TextStyle(
                                      color: AllCoustomTheme.getNewSecondTextThemeColor(),
                                      fontSize: ConstanceData.SIZE_TITLE8,
                                      fontFamily: "Roboto",
                                    ),
                                  ),
                                  Text(
                                    '\$'+" 390.00",
                                    style: TextStyle(
                                      color: AllCoustomTheme.getChartBoxTextThemeColor(),
                                      fontSize: ConstanceData.SIZE_TITLE18,
                                      fontFamily: "Roboto",
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "HIGH",
                                        style: TextStyle(
                                          color: AllCoustomTheme.getNewTextThemeColors(),
                                          fontSize: ConstanceData.SIZE_TITLE10,
                                          fontFamily: "Roboto",
                                        ),
                                      ),
                                      Icon(
                                        FontAwesomeIcons.arrowUp,
                                        color: Colors.green,
                                        size: 10,
                                      ),
                                      Text(
                                        "139.00",
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: ConstanceData.SIZE_TITLE10,
                                          fontFamily: "Roboto",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "LOW",
                                        style: TextStyle(
                                          color: AllCoustomTheme.getNewTextThemeColors(),
                                          fontSize: ConstanceData.SIZE_TITLE10,
                                          fontFamily: "Roboto",
                                        ),
                                      ),
                                      Icon(
                                        FontAwesomeIcons.arrowDown,
                                        color: Colors.red,
                                        size: 10,
                                      ),
                                      Text(
                                        "139.00",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: ConstanceData.SIZE_TITLE10,
                                          fontFamily: "Roboto",
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width*0.88,
                            height: MediaQuery.of(context).size.height*0.15,
                            child: Container(
                              margin: EdgeInsets.only(left: 10.0),
                              child: SfCartesianChart(
                                  primaryXAxis: NumericAxis(
                                    isVisible: false,
                                  ),
                                  primaryYAxis: NumericAxis(
                                      isVisible: false
                                  ),
                                  series: <ChartSeries>[
                                    StackedAreaSeries<NewSalesData, double>(
                                      dataSource: newSalesData,
                                      xValueMapper: (NewSalesData data, _) => data.year,
                                      yValueMapper: (NewSalesData data, _) => data.sales,
                                      gradient: gradientColors,
                                    ),
                                  ]
                              ),
                            )
                        ),
                        SizedBox(
                          // height: MediaQuery.of(context).size.height*0.10,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.25,
                                height: MediaQuery.of(context).size.height*0.038,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    border: new Border.all(color: AllCoustomTheme.getChartBoxThemeColor(), width: 1.5),
                                    color: AllCoustomTheme.getChartBoxThemeColor(),
                                  ),
                                  child: MaterialButton(
                                    splashColor: Colors.grey,
                                    child: Text(
                                      "BUY",
                                      style: TextStyle(
                                        color: AllCoustomTheme.getButtonTextThemeColors(),
                                        fontSize: ConstanceData.SIZE_TITLE13,
                                        fontFamily: "Roboto",
                                      ),
                                    ),
                                    onPressed: () async
                                    {
/*                                      Navigator.of(context).push(new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                          new OnBoardingFirst(logo: "logo.png",callingFrom: "Accredited Investor",)));*/
                                      Navigator.of(context).push(new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                          new SecurityPageFirst(logo: "logo.png",callingFrom: "Accredited Investor")));
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.26,
                                height: MediaQuery.of(context).size.height*0.038,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    border: new Border.all(color: AllCoustomTheme.getChartBoxThemeColor(), width: 1.5),
                                    // color: AllCoustomTheme.getChartBoxThemeColor(),
                                  ),
                                  child: MaterialButton(
                                    splashColor: Colors.grey,
                                    child: Text(
                                      "SELL",
                                      style: TextStyle(
                                        color: AllCoustomTheme.getChartBoxTextThemeColor(),
                                        fontSize: ConstanceData.SIZE_TITLE13,
                                        fontFamily: "Roboto",
                                      ),
                                    ),
                                    onPressed: () async
                                    {
/*                                      Navigator.of(context).push(new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                          new OnBoardingFirst(logo: "logo.png",callingFrom: "Accredited Investor",)));*/
                                      Navigator.of(context).push(new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                          new SecurityPageFirst(logo: "logo.png",callingFrom: "Accredited Investor")));
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.32,
                                height: MediaQuery.of(context).size.height*0.038,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    border: new Border.all(color: AllCoustomTheme.getChartBoxThemeColor(), width: 1.5),
                                    // color: AllCoustomTheme.getChartBoxThemeColor(),
                                  ),
                                  child: MaterialButton(
                                    splashColor: Colors.grey,
                                    child: Text(
                                      "WATCH",
                                      style: TextStyle(
                                        color: AllCoustomTheme.getChartBoxTextThemeColor(),
                                        fontSize: ConstanceData.SIZE_TITLE13,
                                        fontFamily: "Roboto",
                                      ),
                                    ),
                                    onPressed: () async
                                    {
                                      Navigator.of(context).push(new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                          new OnBoardingFirst(logo: "logo.png",callingFrom: "Accredited Investor",)));
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        )
                      ],
                    ),
                  )
              ),
            ],
          ),
        );
      },
    );
  }


/*  Widget getDonutChartView()
  {
    final List<ChartData> chartData = [
      ChartData('David', 25, globals.isGoldBlack ? Color(0xFFE8E2DB) : Color(0xFF1D6177)),
      ChartData('Steve', 38, globals.isGoldBlack ? Color(0xFF1A3263) : Color(0xFF000000)),
      ChartData('Jack', 34, globals.isGoldBlack ? Color(0xFFF5564E) : Color(0xFF7499C6)),
      ChartData('Others', 52, Color(0xFFFAB95B))
    ];

    return ListView.builder(
      itemCount: 3,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          // margin: EdgeInsets.only(left: 20.0,right: 20.0),
          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.048,right: MediaQuery.of(context).size.width*0.048),
          // alignment: Alignment.centerLeft,
          child: SfCircularChart(
              series: <CircularSeries>[
                // Renders doughnut chart
                DoughnutSeries<ChartData, String>(
                    dataSource: chartData,
                    pointColorMapper:(ChartData data,  _) => data.color,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y
                )
              ]
          ),
        );
      },
    );
  }*/

  Widget secondScreen() {

    int donutCurrentIndex = 0;

    final List donutArray = [1,2,3];

    final List<ChartData> chartData = [
      ChartData('David', 25, globals.isGoldBlack ? Color(0xFFE8E2DB) : Color(0xFF1D6177)),
      ChartData('Steve', 38, globals.isGoldBlack ? Color(0xFF1A3263) : Color(0xFF000000)),
      ChartData('Jack', 34, globals.isGoldBlack ? Color(0xFFF5564E) : Color(0xFF7499C6)),
      ChartData('Others', 52, Color(0xFFFAB95B))
    ];


    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
/*          Padding(
            padding: EdgeInsets.only(left:16.0,right:16.0),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                  child: Icon(
                    Icons.sort,
                    color: AllCoustomTheme.getsecoundTextThemeColor(),
                  ),
                ),
                InkWell(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: CircleAvatar(
                          radius: 15.0,
                          backgroundImage: new AssetImage('assets/download.jpeg'),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      SizedBox(
                          width:10.0
                      ),
                      //search box area
                      Container(
                        width: MediaQuery.of(context).size.width*0.64,
                        height: MediaQuery.of(context).size.height*0.06,
                        decoration: new BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          border: Border.all(
                            color: Color(0xff696969),
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width*0.61,
                              height: MediaQuery.of(context).size.height*0.05,
                              child: TextFormField(
                                style: TextStyle(
                                  color: AllCoustomTheme.getTextThemeColors(),
                                  fontSize: ConstanceData.SIZE_TITLE14,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.search,
                                    color: AllCoustomTheme.getNewSecondTextThemeColor(),
                                    size: 15,
                                  ),
                                  hintText: "Search",
                                  hintStyle: TextStyle(
                                    color: AllCoustomTheme.getNewSecondTextThemeColor(),
                                    fontSize: ConstanceData.SIZE_TITLE14,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      //setting icon
                      InkWell(
                          child: Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: CircleAvatar(
                              radius: 15.0,
                              backgroundColor: Colors.transparent,
                              child: Icon(
                                Icons.settings,
                                color: Colors.grey,
                                size: 30.0,
                              ),
                            ),
                          )
                      ),

                    ],
                  ),

                )
              ],
            ),
          ),*/

          // handshake image box
/*          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.25,
            child:  Container(
              margin: EdgeInsets.only(left: 5.0,right: 5.0),
              child: Image(
                  fit: BoxFit.fill,
                  image: new AssetImage('assets/handShake.png')
              ),
            ),
          ),*/
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.60,
            child:  Container(
                margin: EdgeInsets.only(left: 5.0,right: 5.0,top:10.0),
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        child: Text(
                          'AURO PAPER',
                          // textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AllCoustomTheme.getHeadingThemeColors(),
                            fontSize: ConstanceData.SIZE_TITLE20,
                            fontFamily: "Rosarivo",
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0.1
                          ),
                        )
                    ),
                    Container(
                        // margin: EdgeInsets.only(left: 80.0,right: 80.0),
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.25,right: MediaQuery.of(context).size.width*0.25),
                      alignment: Alignment.center,
                        padding: EdgeInsets.only(
                          bottom: 3, // space between underline and text
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                  color: Color(0xFFD8AF4F),
                                  width: 1.6, // Underline width
                                )
                            )
                        ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.27,
                        // child: getDonutChartView(),
                        child: CarouselSlider.builder(
                          itemCount: donutArray.length,
                          options: CarouselOptions(
                              autoPlay: false,
                              viewportFraction: 0.95,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  donutCurrentIndex = index;
                                });
                              }
                          ),
                          itemBuilder: (context,index){
                            return Container(
                              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.048,right: MediaQuery.of(context).size.width*0.048),
                              child: SfCircularChart(
                                  series: <CircularSeries>[
                                    // Renders doughnut chart
                                    DoughnutSeries<ChartData, String>(
                                        dataSource: chartData,
                                        pointColorMapper:(ChartData data,  _) => data.color,
                                        xValueMapper: (ChartData data, _) => data.x,
                                        yValueMapper: (ChartData data, _) => data.y
                                    )
                                  ]
                              ),
                            );
                          },
                        ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: donutArray.map((url) {
                          int index = donutArray.indexOf(url);
                          return Container(
                            width: 10.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: donutCurrentIndex == index
                              // ? Color(0xFFFFFFFF)
                                  ? Color(0xFFD8AF4F)
                                  : Color(0xffCBB4B4),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                        // margin: EdgeInsets.only(left: 35.0,right: 20.0),
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.07,right: MediaQuery.of(context).size.width*0.03),
                        child: Text(
                          "Voila! We’ve created a paper  portfolio for you that can help you start engaging and learning about how to invest. "
                              "Please note that this is NOT our recommended investment portfolio for which you need to complete additional risk onbording.",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: AllCoustomTheme.getNewSecondTextThemeColor(),
                            fontSize: 14.5,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                            letterSpacing: 0.2
                          ),
                        )
                    ),
                  ],
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  // height: 32,
                  height: MediaQuery.of(context).size.height*0.06,
                  child: Container(
                    /*height: 32,
                    width: 234,*/
                    height: MediaQuery.of(context).size.height*0.06,
                    width: MediaQuery.of(context).size.width*0.72,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: new Border.all(color: AllCoustomTheme.getButtonBoxColor(), width: 1.5),
                        color: AllCoustomTheme.getButtonBoxColor()
                    ),
                    child: MaterialButton(
                      splashColor: Colors.grey,
                      child: Text(
                        "Initiate First Name Portfolio",
                        style: TextStyle(
                          color: AllCoustomTheme.getButtonTextThemeColors(),
                          fontSize: ConstanceData.SIZE_TITLE13,
                          fontFamily: "Roboto",
                        ),
                      ),
                      onPressed: () async {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                            new SearchFirstPage(logo: "login_logo.png",callingFrom: "Accredited Investor",)));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          // go pro,live button
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    // height: 32,
                    height: MediaQuery.of(context).size.height*0.06,
                    child: Container(
                      /*height: 32,
                      width: 110,*/
                      height: MediaQuery.of(context).size.height*0.06,
                      width: MediaQuery.of(context).size.width*0.32,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: new Border.all(color: AllCoustomTheme.getButtonBoxColor(), width: 1.5),
                          color: AllCoustomTheme.getButtonBoxColor()
                      ),
                      child: MaterialButton(
                        splashColor: Colors.grey,
                        child: Text(
                          "GO PRO",
                          style: AllCoustomTheme.getButtonSelectedTextStyleTheme()
                        ),
                        onPressed: () async
                        {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                              new OnBoardingFirst(logo: "logo.png",callingFrom: "Accredited Investor",)));
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    // height: 32,
                    height: MediaQuery.of(context).size.height*0.06,
                    child: Container(
                      /*height: 32,
                      width: 110,*/
                      height: MediaQuery.of(context).size.height*0.06,
                      width: MediaQuery.of(context).size.width*0.32,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: new Border.all(color: AllCoustomTheme.getButtonBoxColor(), width: 1.5),
                          // color: AllCoustomTheme.getButtonBoxColor()
                      ),
                      child: MaterialButton(
                        splashColor: Colors.grey,
                        child: Text(
                          "GO LIVE",
                          style: AllCoustomTheme.getButtonNonSelectedTextStyleTheme()
                        ),
                        onPressed: () async
                        {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                              new WishList()));
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 30,
              ),
            ],
          ),

          // portfolio component box
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.73,
            child:  Container(
                margin: EdgeInsets.only(left: 5.0,right: 5.0),
                /*decoration: new BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFfec20f),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(2.0),
                  ),
                ),*/
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top:5.0),
                      child: Center(
                          child: Text(
                            'PORTFOLIO COMPONENTS',
                            style: new TextStyle(
                              color: AllCoustomTheme.getHeadingThemeColors(),
                              fontSize: ConstanceData.SIZE_TITLE18,
                              fontFamily: "Rosarivo",
                            ),
                          )
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.only(left: 30.0,right: 30.0),
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.06,right: MediaQuery.of(context).size.width*0.06),

                      padding: EdgeInsets.only(
                        bottom: 3, // space between underline and text
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                color: AllCoustomTheme.getHeadingThemeColors(),
                                width: 1.0, // Underline width
                              )
                          )
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top:10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(left:95.0,bottom: 5.0),
                                child: Text(
                                  'Auro Portfolio',
                                  style: new TextStyle(
                                    color: AllCoustomTheme.getSubHeadingThemeColors(),
                                    fontSize: ConstanceData.SIZE_TITLE15,
                                    fontFamily: "Roboto",
                                    package: 'Roboto-Regular',
                                  ),
                                )
                            ),
                            Padding(
                                padding: EdgeInsets.only(left:30.0,top: 3.0),
                                child: Text(
                                  'SEE ALL',
                                  style: new TextStyle(
                                    color: AllCoustomTheme.getSeeMoreThemeColor(),
                                    fontSize: ConstanceData.SIZE_TITLE15,
                                    fontFamily: "Roboto",
                                  ),
                                )
                            )
                          ],
                        )
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.37,
                        child: Container(
                            margin: EdgeInsets.only(top: 5.0,left: 5.0,right: 5.0,bottom: 5.0),
                            child: getAreaChartView()
                        )
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(left:70.0),
                                child: Text(
                                  "First Name's Portfolio",
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                    color: AllCoustomTheme.getSubHeadingThemeColors(),
                                    fontSize: ConstanceData.SIZE_TITLE15,
                                    fontFamily: "Roboto",
                                  ),
                                )
                            ),
                            Padding(
                                padding: EdgeInsets.only(left:15.0),
                                child: Text(
                                  'See More',
                                  style: TextStyle(
                                    color: AllCoustomTheme.getSeeMoreThemeColor(),
                                    fontSize: ConstanceData.SIZE_TITLE15,
                                    fontFamily: "Roboto",
                                  ),
                                )
                            ),
                          ],
                        )
                    ),
                    Container(
                      margin: EdgeInsets.only(left:15.0,bottom: 5.0,top: 5.0),
                      child: Text(
                        'You can also invest in individual securities that you like and create your own portfolio!! ',
                        style: TextStyle(
                          color: AllCoustomTheme.getNewSecondTextThemeColor(),
                          fontSize: ConstanceData.SIZE_TITLE15,
                          fontFamily: "Roboto",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            // height: 35,
                            height: MediaQuery.of(context).size.height*0.065,
                            child: Container(
                              /*height: 35,
                              width: 150,*/
                              height: MediaQuery.of(context).size.height*0.065,
                              width: MediaQuery.of(context).size.width*0.45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  border: new Border.all(color: AllCoustomTheme.getButtonBoxColor(), width: 1.5),
                                  color: AllCoustomTheme.getButtonBoxColor()
                              ),
                              child: MaterialButton(
                                splashColor: Colors.grey,
                                child: Text(
                                  "START NOW",
                                  style: TextStyle(
                                    color: AllCoustomTheme.getButtonTextThemeColors(),
                                    fontSize: ConstanceData.SIZE_TITLE13,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ),
          ),
          // go live button
          // investment guru component box
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.57,
            child:  Container(
                margin: EdgeInsets.only(left: 5.0,right: 5.0),
                /*decoration: new BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFfec20f),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(2.0),
                  ),
                ),*/
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top:10.0),
                      child: Center(
                          child: Text(
                            'INVESTMENT GURUS',
                            style: new TextStyle(
                              color: AllCoustomTheme.getHeadingThemeColors(),
                              fontSize: ConstanceData.SIZE_TITLE18,
                              fontFamily: "Rosarivo",
                            ),
                          )
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.only(left: 50.0,right: 50.0),
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.12,right: MediaQuery.of(context).size.width*0.12),

                      padding: EdgeInsets.only(
                        bottom: 3, // space between underline and text
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                color: AllCoustomTheme.getHeadingThemeColors(),
                                width: 1.0, // Underline width
                              )
                          )
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.34,
                        child: Container(
                            margin: EdgeInsets.only(top: 15.0,left: 5.0,right: 5.0,bottom: 5.0),
                            child: getAreaChartView(),
                        )
                    ),
                    Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(left:230.0,bottom: 5.0,top: 3.0),
                                child: Text(
                                  'See More',
                                  style: new TextStyle(
                                    color: AllCoustomTheme.getSeeMoreThemeColor(),
                                    fontSize: ConstanceData.SIZE_TITLE15,
                                    fontFamily: "Roboto",
                                  ),
                                )
                            ),
                          ],
                        )
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            // height: 35,
                            height: MediaQuery.of(context).size.height*0.065,
                            child: Container(
                              /*height: 35,
                              width: 150,*/
                              height: MediaQuery.of(context).size.height*0.065,
                              width: MediaQuery.of(context).size.width*0.45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  border: new Border.all(color: AllCoustomTheme.getButtonBoxColor(), width: 1.5),
                                  color: AllCoustomTheme.getButtonBoxColor()
                              ),
                              child: MaterialButton(
                                splashColor: Colors.grey,
                                child: Text(
                                  "START NOW",
                                  style: TextStyle(
                                    color: AllCoustomTheme.getButtonTextThemeColors(),
                                    fontSize: ConstanceData.SIZE_TITLE13,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                )
            ),
          ),
          // pe/vc/re component box
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.27,
            child:  Container(
                margin: EdgeInsets.only(left: 5.0,right: 5.0),
/*                decoration: new BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFfec20f),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(2.0),
                  ),
                ),*/
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top:5.0),
                      child: Center(
                          child: Text(
                            'PE/VC/RE/ESG',
                            style: new TextStyle(
                              color: AllCoustomTheme.getHeadingThemeColors(),
                              fontSize: ConstanceData.SIZE_TITLE18,
                              fontFamily: "Rosarivo",
                            ),
                          )
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.only(left: 90.0,right: 90.0),
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.25,right: MediaQuery.of(context).size.width*0.25),

                      padding: EdgeInsets.only(
                        bottom: 3, // space between underline and text
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                color: AllCoustomTheme.getHeadingThemeColors(),
                                width: 1.0, // Underline width
                              )
                          )
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.065,
                            child: Container(
                              height: MediaQuery.of(context).size.height*0.065,
                              width: MediaQuery.of(context).size.width*0.45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  border: new Border.all(color: AllCoustomTheme.getButtonBoxColor(), width: 1.5),
                                  color: AllCoustomTheme.getButtonBoxColor()
                              ),
                              child: MaterialButton(
                                splashColor: Colors.grey,
                                child: Text(
                                  "START NOW",
                                  style: TextStyle(
                                    color: AllCoustomTheme.getButtonTextThemeColors(),
                                    fontSize: ConstanceData.SIZE_TITLE13,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left:235.0),
                        child: Text(
                          'See More',
                          style: new TextStyle(
                            color: AllCoustomTheme.getSeeMoreThemeColor(),
                            fontSize: ConstanceData.SIZE_TITLE15,
                            fontFamily: "Roboto",
                          ),
                        )
                    ),

                  ],
                )
            ),
          ),
          // last start now component box
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.27,
            child:  Container(
                margin: EdgeInsets.only(left: 5.0,right: 5.0),
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top:5.0),
                      child: Center(
                          child: Text(
                            'STUDENT',
                            style: new TextStyle(
                              color: AllCoustomTheme.getHeadingThemeColors(),
                              fontSize: ConstanceData.SIZE_TITLE18,
                              fontFamily: "Rosarivo",
                            ),
                          )
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.only(left: 110.0,right: 110.0),
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.30,right: MediaQuery.of(context).size.width*0.30),

                      padding: EdgeInsets.only(
                        bottom: 3, // space between underline and text
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                color: AllCoustomTheme.getHeadingThemeColors(),
                                width: 1.0, // Underline width
                              )
                          )
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.065,
                            child: Container(
                              height: MediaQuery.of(context).size.height*0.065,
                              width: MediaQuery.of(context).size.width*0.45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  border: new Border.all(color: AllCoustomTheme.getButtonBoxColor(), width: 1.5),
                                  color: AllCoustomTheme.getButtonBoxColor()
                              ),
                              child: MaterialButton(
                                splashColor: Colors.grey,
                                child: Text(
                                  "START NOW",
                                  style: TextStyle(
                                    color: AllCoustomTheme.getButtonTextThemeColors(),
                                    fontSize: ConstanceData.SIZE_TITLE13,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ),
          ),
        ],
      )
    );
  }

  // second screen section end


  // fourth screen section start

  Widget fourthScreen() {
    return Container(
      // height: graphHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: ()
                  {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (BuildContext context) => AddEditQus(),
                      ),
                    );
                  },
                  child: Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.60),
                      child: Text(
                        "Ask question",
                        style: TextStyle(
                          color: AllCoustomTheme.getSeeMoreThemeColor(),
                          fontSize: ConstanceData.SIZE_TITLE16,
                          fontFamily: "Roboto",
                        ),
                      )
                  ),
                )
/*                GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                  child: Icon(
                    Icons.sort,
                    color: AllCoustomTheme.getsecoundTextThemeColor(),
                  ),
                ),*/
/*                Container(
                  margin: EdgeInsets.only(left: 150),
                  height: 30,
                  width: 150,
                  decoration: BoxDecoration(
                    color: AllCoustomTheme.getThemeData().textSelectionColor,
                    border: new Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: MaterialButton(
                    splashColor: Colors.grey,
                    child: Text(
                      "Ask question",
                      style: TextStyle(
                        color: AllCoustomTheme.getTextThemeColors(),
                        fontSize: ConstanceData.SIZE_TITLE16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (BuildContext context) => AddEditQus(),
                        ),
                      );
                    },
                  ),
                ),*/
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
/*          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: CircleAvatar(
                    radius: 15.0,
                    backgroundImage: new AssetImage('assets/download.jpeg'),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: AllCoustomTheme.boxColor(),
                    ),
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: ConstanceData.SIZE_TITLE16,
                        color: AllCoustomTheme.getTextThemeColors(),
                      ),
                      cursorColor: AllCoustomTheme.getTextThemeColors(),
                      onChanged: (value) {
                        filterSearchResults(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(
                          Icons.search,
                          size: 20,
                          color: AllCoustomTheme.getsecoundTextThemeColor(),
                        ),
                        hintStyle: TextStyle(
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getsecoundTextThemeColor(),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Container(
                  child: CircleAvatar(
                    radius: 15.0,
                    backgroundImage: new AssetImage('assets/appIcon.jpg'),
                    backgroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),*/
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 10.0,right: 3.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  onTap: (index)
                  {
                    selectedTabIndex = index;
                  },
                  labelColor: AllCoustomTheme.getTextThemeColor(),
                  labelStyle: TextStyle(fontSize: 14.0,letterSpacing: 0.2),
                  indicatorColor: AllCoustomTheme.getTextThemeColor(),
                  indicatorWeight: 4.0,
                  // unselectedLabelColor: StyleTheme.Colors.AppBarTabTextColor,
                  tabs: <Widget>[
                    new Tab(text: "Recommended"),
                    new Tab(text: "Trending"),
                    new Tab(text: "Week"),
                    new Tab(text: "Month"),
                    // new Tab(text: "Ask Question"),

                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(top: 10.0),
              child: new TabBarView(
                controller: _tabController,
                children: tabList.map((Tab tab) {
                  return _getPage(tab);
                }).toList(),
                physics: ScrollPhysics(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget recommended()
  {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment:  CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 8.0,
          ),
          // random images
          Row(
            crossAxisAlignment:  CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: new Image(
                    height: 115,
                    width: 150.0,
                    fit: BoxFit.fill,
                    image: new AssetImage('assets/stackOverflow.png')
                ),
              ),
              Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          new Image(
                              height: 70,
                              width: 85.0,
                              fit: BoxFit.fill,
                              image: new AssetImage('assets/language.png')
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          new Image(
                              height: 40,
                              width: 40.0,
                              fit: BoxFit.fill,
                              image: new AssetImage('assets/android.png')
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          new Image(
                              height: 40,
                              width: 40.0,
                              fit: BoxFit.fill,
                              image: new AssetImage('assets/askUbuntu.png')
                          ),
                        ],
                      )
                    ],
                  )
              ),
              Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          new Image(
                              height: 40,
                              width: 40.0,
                              fit: BoxFit.fill,
                              image: new AssetImage('assets/askUbuntu.png')
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          new Image(
                              height: 40,
                              width: 40.0,
                              fit: BoxFit.fill,
                              image: new AssetImage('assets/android.png')
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          new Image(
                              height: 70,
                              width: 85.0,
                              fit: BoxFit.fill,
                              image: new AssetImage('assets/arqade.jpeg')
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                    ],
                  )
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          // question section
          Row(
            children: [
              Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Is now a good time to add to one’s Apple holdings or wait for a sell-off given sharp rally recently? ',
                      style: TextStyle(
                          color: AllCoustomTheme.getNewSecondTextThemeColor(),
                          fontSize: ConstanceData.SIZE_TITLE16,
                          fontFamily: "Rosarivo",
                          fontStyle: FontStyle.normal,
                          letterSpacing: 0.2
                      ),
                    ),
                  )
              )
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          // question attributes section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 10.0,
              ),
              Container(
                child: CircleAvatar(
                  radius: 13.5,
                  backgroundImage: new AssetImage('assets/download.jpeg'),
                  backgroundColor: Colors.transparent,
                ),
              ),
              Container(
                child: new Text(
                  "10K",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: ConstanceData.SIZE_TITLE14,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                child: Icon(
                  Icons.comment_bank_sharp,
                  color: AllCoustomTheme.getTextThemeColor(),
                ),
              ),
              Container(
                child: new Text(
                  "10",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: ConstanceData.SIZE_TITLE14,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                child: Icon(
                  Icons.remove_red_eye_outlined,
                  color: AllCoustomTheme.getTextThemeColor(),
                ),
              ),
              Container(
                child: new Text(
                  "10",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: ConstanceData.SIZE_TITLE14,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                child: Icon(
                  Icons.add,
                  color: AllCoustomTheme.getTextThemeColor(),
                ),
              ),
              Container(
                child: new Text(
                  "100",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: ConstanceData.SIZE_TITLE14,
                  ),
                ),
              ),

              SizedBox(
                width: 20,
              ),
              Container(
                child: Icon(
                  Icons.arrow_upward,
                  color: AllCoustomTheme.getThemeData().textSelectionColor,
                ),
              ),
              Container(
                child: new Text(
                  "7",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: ConstanceData.SIZE_TITLE14,
                  ),
                ),
              ),

            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          //tags section
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: StaggeredGridView.countBuilder(
              itemCount: tagItemList != null ? tagItemList.length : 0,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              shrinkWrap: true,
              staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
              itemBuilder: (context, index){
                return Container(
                    decoration: BoxDecoration(
                        color: AllCoustomTheme.getThemeData().textSelectionColor,
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: AllCoustomTheme.getThemeData().textSelectionColor, width: 1.0)),
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            '${tagItemList[index]}',
                            style: TextStyle(
                                color: AllCoustomTheme.getTextThemeColor(),
                                fontSize: ConstanceData.SIZE_TITLE16,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.normal,
                                height: 1.3
                            ),
                          ),
                        ),
                      ],
                    )
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget trending()
  {
    return Container(
        child: Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            'Coming Soon... ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AllCoustomTheme.getTextThemeColor(),
              fontSize: ConstanceData.SIZE_TITLE18,
            ),
          ),
        )
    );
  }

  Widget week()
  {
    return Container(
        child: Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            'Coming Soon... ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AllCoustomTheme.getTextThemeColor(),
              fontSize: ConstanceData.SIZE_TITLE18,
            ),
          ),
        )
    );
  }

  Widget month()
  {
    return Container(
        child: Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            'Coming Soon... ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AllCoustomTheme.getTextThemeColor(),
              fontSize: ConstanceData.SIZE_TITLE18,
            ),
          ),
        )
    );
  }

  Widget askQus()
  {
    return Container(
        child: Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            'Coming Soon... ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AllCoustomTheme.getTextThemeColors(),
              fontSize: ConstanceData.SIZE_TITLE18,
            ),
          ),
        )
    );
  }

  Widget overall()
  {
    return Container(
        child: Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            'Coming Soon... ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AllCoustomTheme.getTextThemeColors(),
              fontSize: ConstanceData.SIZE_TITLE18,
            ),
          ),
        )
    );
  }

  Widget weekly()
  {
    return Container(
        child: Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            'Coming Soon... ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AllCoustomTheme.getTextThemeColors(),
              fontSize: ConstanceData.SIZE_TITLE18,
            ),
          ),
        )
    );
  }
  // ignore: missing_return
  Widget _getPage(Tab tab){
    switch(tab.text){
      case 'Recommended': return recommended();
      case 'Trending': return trending();
      case 'Week': return week();
      case 'Month': return month();
      // case 'Ask Question': return askQus();
    }
  }

  // fourth screen section end


  Widget getUserDropDownList()
  {
    if (userList != null && userList.length != 0)
    {
      return new DropdownButtonHideUnderline(
        child: ButtonTheme(
            alignedDropdown: true,
            child: Container(
              height: 20.0,
              child: new DropdownButton(
                value: selectedUser,
                dropdownColor: AllCoustomTheme.getThemeData().primaryColor,
                isExpanded: true,
                onChanged: (String newValue) {
                  setState(() {
                    selectedUser = newValue;
                  });
                },
                items: userList.map((String value) {
                  return new DropdownMenuItem(
                    value: value,
                    child: new Text(
                      value,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ConstanceData.SIZE_TITLE14,
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
        ),
      );
    }
    else
    {
      return Container(
        height: 0.0,
        width: 0.0,
      );
    }
  }

  Widget getUserField()
  {
    return new FormField(
      builder: (FormFieldState state) {
        return InputDecorator(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.0),
            ),
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: ConstanceData.SIZE_TITLE20,
                color: AllCoustomTheme.getTextThemeColors()
            ),

            errorText: state.hasError ? state.errorText : null,
          ),
          isEmpty: selectedUser == '',
          child: getUserDropDownList(),
        );
      },
      validator: (val) {
        return ((val != null && val!='') || (selectedUser!=null && selectedUser!='')) ? null : 'choose One';
      },
    );
  }

  Widget thirdScreen() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: Column(
          children: <Widget>[
            /*SizedBox(
              height: appBarheight,
            ),*/
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                  child: Icon(
                    Icons.sort,
                    color: AllCoustomTheme.getsecoundTextThemeColor(),
                  ),
                ),
                Expanded(
                  child: Animator(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.decelerate,
                    cycles: 1,
                    builder: (anim) => Transform.scale(
                      scale: anim.value,
                      child: Text(
                        'Start Post',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontWeight: FontWeight.bold,
                          fontSize: ConstanceData.SIZE_TITLE20,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 14,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
                Expanded(
                  child: getUserField(),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  // labelText: 'Employment Status',
                  hintText: 'What do you want to talk about?',
                  hintStyle: TextStyle(
                      fontSize: ConstanceData.SIZE_TITLE16,
                      color: AllCoustomTheme.getTextThemeColors()
                  ),
                  labelStyle: TextStyle(
                      fontSize: ConstanceData.SIZE_TITLE16,
                      color: AllCoustomTheme.getTextThemeColors()
                  ),
                ),
              ),
            ),
/*            Container(
              child: displayModalBottomSheet(context),
            ),*/
          ],
        )
      ),
    );
  }


  displayModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
        builder: (builder) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 40.0,
                    ),
                    CircleAvatar(
                      backgroundColor: AllCoustomTheme.getsecoundTextThemeColor(),
                      radius: 20,
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: AllCoustomTheme.boxColor(),
                      ),
                    ),
                    SizedBox(
                      width: 40.0,
                    ),
                    CircleAvatar(
                      backgroundColor: AllCoustomTheme.getsecoundTextThemeColor(),
                      radius: 20,
                      child: Icon(
                        Icons.video_call,
                        color: AllCoustomTheme.boxColor(),
                      ),
                    ),
                    SizedBox(
                      width: 40.0,
                    ),
                    CircleAvatar(
                      backgroundColor: AllCoustomTheme.getsecoundTextThemeColor(),
                      radius: 20,
                      child: Icon(
                        Icons.image,
                        color: AllCoustomTheme.boxColor(),
                      ),
                    ),
                    SizedBox(
                      width: 40.0,
                    ),
                  ],
                ),
                Divider(
                  color: AllCoustomTheme.getsecoundTextThemeColor(),
                ),
                InkWell(
                  child: Padding(
                    padding: EdgeInsets.only(top:10.0),
                    child: Center(
                      child: Text(
                        'Upload stock pitch',
                        style: TextStyle(
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: ConstanceData.SIZE_TITLE18,
                        ),
                      ),
                    ),
                  ),
                  onTap: ()
                  {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (BuildContext context) => StockPitch(),
                      ),
                    );
                  },
                ),
                Divider(
                  color: AllCoustomTheme.getsecoundTextThemeColor(),
                ),
                InkWell(
                  child: Padding(
                    padding: EdgeInsets.only(top:10.0),
                    child: Center(
                      child: Text(
                        'Upload portfolio pitch',
                        style: TextStyle(
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: ConstanceData.SIZE_TITLE18,
                        ),
                      ),
                    ),
                  ),
                  onTap: ()
                  {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (BuildContext context) => PortfolioPitch(),
                      ),
                    );
                  },
                ),
                Divider(
                  color: AllCoustomTheme.getsecoundTextThemeColor(),
                ),
                Padding(
                  padding: EdgeInsets.only(top:10.0),
                  child: Center(
                    child: Text(
                      'Ask a question',
                      style: TextStyle(
                        color: AllCoustomTheme.getTextThemeColors(),
                        fontSize: ConstanceData.SIZE_TITLE18,
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: AllCoustomTheme.getsecoundTextThemeColor(),
                ),
                Padding(
                  padding: EdgeInsets.only(top:10.0),
                  child: Center(
                    child: Text(
                      'Add a document',
                      style: TextStyle(
                        color: AllCoustomTheme.getTextThemeColors(),
                        fontSize: ConstanceData.SIZE_TITLE18,
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: AllCoustomTheme.getsecoundTextThemeColor(),
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.of(context).pop();
                        Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (BuildContext context) => CreatePoll(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top:10.0,bottom: 20.0),
                    child: Center(
                      child: Text(
                        'Create a poll',
                        style: TextStyle(
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: ConstanceData.SIZE_TITLE18,
                        ),
                      ),
                    ),
                  )
                )
              ],
            ),
          );
        });
  }

  Widget fourthSettingScreen() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          AdmobBanner(
            adUnitId: getBannerAdUnitId(),
            adSize: bannerSize,
            listener: (AdmobAdEvent event, Map<String, dynamic> args) {
              handleEvent(event, args, 'Banner');
            },
            onBannerCreated: (AdmobBannerController controller) {
              setState(() {
                admobBannerController = controller;
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Animator(
                tween: Tween<double>(begin: 0, end: 1),
                duration: Duration(milliseconds: 500),
                cycles: 1,
                builder: (anim) => SizeTransition(
                  sizeFactor: anim,
                  axis: Axis.horizontal,
                  axisAlignment: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Settings',
                      style: TextStyle(
                        color: AllCoustomTheme.getTextThemeColors(),
                        fontWeight: FontWeight.bold,
                        fontSize: ConstanceData.SIZE_TITLE25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'General',
                        style: TextStyle(
                          color: AllCoustomTheme.getsecoundTextThemeColor(),
                          fontSize: ConstanceData.SIZE_TITLE16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  InkWell(
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
                            height: height / 1.8,
                            child: Scaffold(
                              backgroundColor: Colors.transparent,
                              body: NotificationSlider(),
                            ),
                          );
                        },
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Notifications',
                          style: TextStyle(
                            color: AllCoustomTheme.getTextThemeColors(),
                          ),
                        ),
                        AnimatedForwardArrow(
                          isShowingarroeForward: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  AnimatedDivider(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Currency Preference',
                        style: TextStyle(
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                      AnimatedForwardArrow(
                        isShowingarroeForward: true,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: AnimatedDivider(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Alerts',
                        style: TextStyle(
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                      AnimatedForwardArrow(
                        isShowingarroeForward: true,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: AnimatedDivider(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Account',
                        style: TextStyle(
                          color: AllCoustomTheme.getsecoundTextThemeColor(),
                          fontSize: ConstanceData.SIZE_TITLE16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (BuildContext context) => UserProfile(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'User Profile',
                          style: TextStyle(
                            color: AllCoustomTheme.getTextThemeColors(),
                          ),
                        ),
                        AnimatedForwardArrow(
                          isShowingarroeForward: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: AnimatedDivider(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (BuildContext context) => ChangePINCode(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Change PIN-code',
                          style: TextStyle(
                            color: AllCoustomTheme.getTextThemeColors(),
                          ),
                        ),
                        AnimatedForwardArrow(
                          isShowingarroeForward: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: AnimatedDivider(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Log Out',
                        style: TextStyle(
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                      AnimatedForwardArrow(
                        isShowingarroeForward: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget getInceptionMemberView(data){

    return new ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Card(
          color: AllCoustomTheme.getsecoundTextThemeColor(),
          child: ListTile(
              leading: CircleAvatar(
                radius: 15.0,
                backgroundImage: new AssetImage('assets/download.jpeg'),
                backgroundColor: Colors.transparent,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    titleCase(data[index]['name']),
                    style: new TextStyle(
                      color: AllCoustomTheme.getTextThemeColors(),
                      fontSize: ConstanceData.SIZE_TITLE16,
                      fontFamily: "Roboto",
                      package: 'Roboto-Regular',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {

                    },
/*                    child: Icon(
                      Icons.badge,
                      color: Colors.yellow,
                    ),*/
                    child: Image(
                      image: AssetImage('assets/buttonBadge.png'),
                      fit: BoxFit.fill,
                      height: 30,
                      width: 30,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {

                    },
                    child: Image(
                      image: AssetImage('assets/badgeStar.jpg'),
                      fit: BoxFit.fill,
                      height: 30,
                      width: 40,
                    ),
                  ),
                ],
              ),
              onTap: () {

              }

          ),
        );
      },
    );
  }

  Widget getWeeklyLeagueMemberView(data){

    return new ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Card(
          color: AllCoustomTheme.getsecoundTextThemeColor(),
          child: ListTile(
              leading: CircleAvatar(
                radius: 15.0,
                backgroundImage: new AssetImage('assets/download.jpeg'),
                backgroundColor: Colors.transparent,
              ),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
/*                  Text(
                    "${index+1}",
                    style: new TextStyle(
                      color: AllCoustomTheme.getTextThemeColors(),
                      fontSize: ConstanceData.SIZE_TITLE16,
                    ),
                  ),
                  CircleAvatar(
                    radius: 15.0,
                    backgroundImage: new AssetImage('assets/download.jpeg'),
                    backgroundColor: Colors.transparent,
                  ),*/
                  Text(
                    titleCase(data[index]['name']),
                    style: new TextStyle(
                      color: AllCoustomTheme.getTextThemeColors(),
                      fontSize: ConstanceData.SIZE_TITLE16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {

                    },
                    child: Image(
                      image: AssetImage('assets/buttonBadge.png'),
                      fit: BoxFit.fill,
                      height: 30,
                      width: 30,
                    ),
                  ),
                ],
              ),
              onTap: () {

              }

          ),
        );
      },
    );
  }

  Widget fifthScreen() {

    final List<ChartData> chartData = [
      ChartData('David', 35, Color(0xFFFF8C00)),
      ChartData('Steve', 38, Color(0xFF008080)),
      ChartData('Jack', 34, Color(0xFFc7ebdf)),
    ];


    final List<ChartData> trackChartData = [
      ChartData('Total', 35, Color(0xFFFF8C00)),
      ChartData('Invest Edu', 38, Color(0xFF008080)),
      ChartData('Track Record', 34, Color(0xFFc7ebdf)),
      ChartData('Stock Pitch', 38, Color(0xFFe70b31)),
      ChartData('Invest Q&A', 38, Color(0xFFfec20f)),
      ChartData('Social Invest', 38, Color(0xFFCD853F)),

    ];

    List<dynamic> inceptionMemberList = <dynamic>[
      {"name": "green","measure": "741 XP"},
      {"name": "alena","measure": "716 XP"},
      {"name": "tat 1 anna","measure": "488 XP"},
      {"name": "kristie","measure": "413 XP"},
      {"name": "piotr","measure": "304 XP"},
    ];

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          /*Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                  child: Icon(
                    Icons.sort,
                    color: AllCoustomTheme.getsecoundTextThemeColor(),
                  ),
                ),
                Expanded(
                  child: Animator(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.decelerate,
                    cycles: 1,
                    builder: (anim) => Transform.scale(
                      scale: anim.value,
                      child: Text(
                        'Track Record',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AllCoustomTheme.getHeadingThemeColors(),
                            fontSize: ConstanceData.SIZE_TITLE20,
                            fontFamily: "Rosarivo",
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0.1
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),*/

          //search box
/*          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: AllCoustomTheme.boxColor(),
                    ),
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: ConstanceData.SIZE_TITLE16,
                        color: AllCoustomTheme.getTextThemeColors(),
                      ),
                      cursorColor: AllCoustomTheme.getTextThemeColors(),
                      onChanged: (value) {
                        filterSearchResults(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(
                          Icons.search,
                          size: 20,
                          color: AllCoustomTheme.getsecoundTextThemeColor(),
                        ),
                        hintStyle: TextStyle(
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getsecoundTextThemeColor(),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),*/
          SizedBox(
            height: 10,
          ),
          Container(
              height: 30,
/*                    decoration: BoxDecoration(
                      color: AllCoustomTheme.getReBlackAndWhiteThemeColors(),
                    ),*/
              child: Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  'SCOREBOARD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AllCoustomTheme.getHeadingThemeColors(),
                    fontSize: ConstanceData.SIZE_TITLE18,
                    fontFamily: "Rosarivo",
                  ),
                ),
              )
          ),
          Container(
            // margin: EdgeInsets.only(left: 110.0,right: 110.0),
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.25,right: MediaQuery.of(context).size.width*0.25),
            padding: EdgeInsets.only(
              bottom: 3, // space between underline and text
            ),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                      color: AllCoustomTheme.getHeadingThemeColors(),
                      width: 1.0, // Underline width
                    )
                )
            ),
          ),
          SizedBox(
            height: 4,
          ),
          //donut chart box
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.30,
              margin: EdgeInsets.only(left: 15.0,right: 5.0),
              /*decoration: new BoxDecoration(
                color: AllCoustomTheme.getTextThemeColors(),
                border: Border.all(
                  color: AllCoustomTheme.getTextThemeColors(),
                  width: 1,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(2.0),
                ),
              ),*/
              child: Stack(
                children: [
                  SfCircularChart(
                      series: <CircularSeries>[
                        // Renders doughnut chart
                        DoughnutSeries<ChartData, String>(
                            dataSource: chartData,
                            pointColorMapper:(ChartData data,  _) => data.color,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y
                        )
                      ]
                  ),
                  new Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.11),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              '150',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AllCoustomTheme.getTextThemeColor(),
                                fontSize: ConstanceData.SIZE_TITLE16,
                                fontFamily: "Roboto",
                                package: 'Roboto-Regular',
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'coins',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AllCoustomTheme.getTextThemeColor(),
                                fontSize: ConstanceData.SIZE_TITLE16,
                                fontFamily: "Roboto",
                                package: 'Roboto-Regular',
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ),
                  InkWell(
                    child: new Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                          height: 30,
                          width: 70,
                          margin: EdgeInsets.only(top:20.0,bottom: 20.0),
                          decoration: new BoxDecoration(
                            // color: Color(0xFF1E90FF),
                            color: Color(0xFFc7ebdf),
                            border: Border.all(
                              // color: Color(0xFF1E90FF),
                              color: Color(0xFFc7ebdf),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(2.0),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'EASY',
                              style: TextStyle(
                                color: AllCoustomTheme.getsecoundTextThemeColor(),
                                fontSize: ConstanceData.SIZE_TITLE16,
                                fontFamily: "Roboto",
                                package: 'Roboto-Regular',
                              ),
                            ),
                          )
                      ),
                    ),
                    onTap: ()
                    {
                      // goToQuestionTemp();
                    },
                  ),
                  new Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                        height: 30,
                        width: 110,
                        margin: EdgeInsets.only(top:20.0,bottom: 20.0),
                        decoration: new BoxDecoration(
                          color: Color(0xFF008080),
                          border: Border.all(
                            color: Color(0xFF008080),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(2.0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'INTERMEDIATE',
                            style: TextStyle(
                              color: AllCoustomTheme.getsecoundTextThemeColor(),
                              fontSize: ConstanceData.SIZE_TITLE15,
                              fontFamily: "Roboto",
                              package: 'Roboto-Regular',
                            ),
                          ),
                        )
                    ),
                  ),
                  new Align(
                    alignment: Alignment.topRight,
                    child: Container(
                        height: 30,
                        width: 70,
                        margin: EdgeInsets.only(top:60.0,bottom: 40.0),
                        decoration: new BoxDecoration(
                          color: Color(0xFFFF8C00),
                          border: Border.all(
                            color: Color(0xFFFF8C00),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(2.0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'HARD',
                            style: TextStyle(
                              color: AllCoustomTheme.getsecoundTextThemeColor(),
                              fontSize: ConstanceData.SIZE_TITLE16,
                              fontFamily: "Roboto",
                              package: 'Roboto-Regular',
                            ),
                          ),
                        )
                    ),
                  )
                ],
              )
          ),
          SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16,right: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                      height: 30,
                      decoration: new BoxDecoration(
                        // color: Color(0xFF1E90FF),
                        color: AllCoustomTheme.getsecoundTextThemeColor(),
                        border: Border.all(
                          // color: Color(0xFF1E90FF),
                          color: AllCoustomTheme.getsecoundTextThemeColor(),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(2.0),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: Text(
                          "Today's progress: 1 concept",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AllCoustomTheme.getSubHeadingThemeColors(),
                            fontSize: ConstanceData.SIZE_TITLE16,
                            fontFamily: "Roboto",
                            package: 'Roboto-Regular',
                          ),
                        ),
                      )
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16,right: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      List<Question> questions = await getQuestions();
                      if (questions.length < 1) {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (_) => ErrorPage(
                              message: "There are not enough questions yet.",
                            )
                        )
                        );
                        return;
                      }
                      Navigator.of(context).push(CupertinoPageRoute(
                        builder: (BuildContext context) => QuestionTemplate(questions: questions),
                      ),
                      );
                    },
                    child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: AllCoustomTheme.getSeeMoreThemeColor(),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            'INCREASE YOUR SCORE',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AllCoustomTheme.getTextThemeColor(),
                              fontSize: ConstanceData.SIZE_TITLE15,
                              fontFamily: "Roboto",
                            ),
                          ),
                        )
                    ),
                  )
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16,right: 5.0),
            child: Container(
              height: MediaQuery.of(context).size.height*0.06,
              child: ListView(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Center(
                        child: Text(
                          'Ankur’s Investment Track Record',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFD8AF4F),
                            fontSize: ConstanceData.SIZE_TITLE18,
                            fontFamily: "Roboto",
                            package: 'Roboto-Regular',
                          ),
                        ),
                      )
                  ),
                  Container(
                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03,right: MediaQuery.of(context).size.width*0.03),
                    padding: EdgeInsets.only(
                      bottom: 3, // space between underline and text
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                              color: AllCoustomTheme.getHeadingThemeColors(),
                              width: 1.0, // Underline width
                            )
                        )
                    ),
                  ),
                ],
              ),
            )
          ),
          SizedBox(
            height: 10,
          ),
          //pie chart with tabs
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.65,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16,right: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: ()
                          {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (BuildContext context) => AuroStrikeBadges(),
                              ),
                            );
                          },
                          child: Container(
                            child: Image(
                              image: AssetImage('assets/buttonBadge.png'),
                              fit: BoxFit.fill,
                              height: 30,
                              width: 40,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Container(
                          child: Image(
                            image: AssetImage('assets/badgeStar.jpg'),
                            fit: BoxFit.fill,
                            height: 30,
                            width: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.4,
                    margin: EdgeInsets.only(left: 180.0,right: 3.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TabBar(
                          controller: _tabController,
                          isScrollable: true,
                          onTap: (index)
                          {
                            selectedTabIndex = index;
                          },
                          labelColor: AllCoustomTheme.getTextThemeColor(),
                          labelStyle: TextStyle(
                              fontSize: 16.0,letterSpacing: 0.2
                          ),
                          indicatorColor: AllCoustomTheme.getTextThemeColor(),
                          indicatorWeight: 4.0,
                          // unselectedLabelColor: StyleTheme.Colors.AppBarTabTextColor,
                          tabs: <Widget>[
                            new Tab(
                                text: "Overall",
                            ),
                            new Tab(text: "Weekly"),
                            new Tab(text: ""),
                            new Tab(text: ""),
                            // new Tab(text: ""),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(top: 10.0),
                      child: new TabBarView(
                        controller: _tabController,
                        children: tabList.map((Tab tab) {
                          return Container(
                            child: Stack(
                              children: [
                                SfCircularChart(
                                    legend: Legend(
                                        isVisible: true,
                                        textStyle: TextStyle(color: AllCoustomTheme.getTextThemeColor()),
                                        alignment: ChartAlignment.center,
                                        position: LegendPosition.bottom,
                                        overflowMode: LegendItemOverflowMode.wrap,
                                        itemPadding: 10.0
                                    ),
                                    series: <CircularSeries>[
                                      // Render pie chart
                                      DoughnutSeries<ChartData, String>(
                                        dataSource: trackChartData,
                                        pointColorMapper:(ChartData data,  _) => data.color,
                                        xValueMapper: (ChartData data, _) => data.x,
                                        yValueMapper: (ChartData data, _) => data.y,
                                        dataLabelSettings:DataLabelSettings(
                                          isVisible : true,
                                        ),
                                      )
                                    ]
                                ),
                                new Align(
                                    alignment: Alignment.topCenter,
                                    child: GestureDetector(
                                      onTap: ()
                                      {
                                        Navigator.of(context).push(
                                          CupertinoPageRoute(
                                            builder: (BuildContext context) => InvestedAssetModule(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        // margin: EdgeInsets.only(top:115),
                                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.16),
                                        child: Column(
                                          children: [
                                            Center(
                                              child: Text(
                                                '800',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: AllCoustomTheme.getTextThemeColor(),
                                                  fontSize: ConstanceData.SIZE_TITLE16,
                                                  fontFamily: "Roboto",
                                                  package: 'Roboto-Regular',
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Text(
                                                'coins',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: AllCoustomTheme.getTextThemeColor(),
                                                  fontSize: ConstanceData.SIZE_TITLE16,
                                                  fontFamily: "Roboto",
                                                  package: 'Roboto-Regular',
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        physics: ScrollPhysics(),
                      ),
                    ),
                  ),
                ],
              )
          ),
/*          Padding(
            padding: const EdgeInsets.only(left: 16,right: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: ()
                  {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (BuildContext context) => AuroStrikeBadges(),
                      ),
                    );
                  },
                  child: Container(
                    child: Image(
                      image: AssetImage('assets/buttonBadge.png'),
                      fit: BoxFit.fill,
                      height: 30,
                      width: 40,
                    ),
                  ),
                ),
                SizedBox(
                  width: 18,
                ),
                Container(
                  child: Image(
                    image: AssetImage('assets/badgeStar.jpg'),
                    fit: BoxFit.fill,
                    height: 30,
                    width: 40,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // pie chart
          Container(
            child: Stack(
              children: [
                SfCircularChart(
                    legend: Legend(
                        isVisible: true,
                        textStyle: TextStyle(color: AllCoustomTheme.getTextThemeColors()),
                        alignment: ChartAlignment.center,
                        position: LegendPosition.bottom,
                        overflowMode: LegendItemOverflowMode.wrap,
                        itemPadding: 10.0
                    ),
                    series: <CircularSeries>[
                      // Render pie chart
                      DoughnutSeries<ChartData, String>(
                        dataSource: trackChartData,
                        pointColorMapper:(ChartData data,  _) => data.color,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        dataLabelSettings:DataLabelSettings(
                          isVisible : true,
                        ),
                      )
                    ]
                ),
                new Align(
                    alignment: Alignment.topCenter,
                    child: GestureDetector(
                      onTap: ()
                      {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (BuildContext context) => InvestedAssetModule(),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(top:105),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                '800',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: ConstanceData.SIZE_TITLE16,
                                  color: AllCoustomTheme.getTextThemeColors(),
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                'coins',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: ConstanceData.SIZE_TITLE16,
                                  color: AllCoustomTheme.getTextThemeColors(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                ),
              ],
            ),
          ),*/
          // inception to data league
          SizedBox(
            height: 20,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 16,right: 5.0),
              child: Container(
                height: MediaQuery.of(context).size.height*0.06,
                child: ListView(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Inception-To-Date League',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFD8AF4F),
                              fontSize: ConstanceData.SIZE_TITLE18,
                              fontFamily: "Roboto",
                              package: 'Roboto-Regular',
                            ),
                          ),
                        )
                    ),
                    Container(
                      // margin: EdgeInsets.only(right: 130.0),
                      margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.28),

                      padding: EdgeInsets.only(
                        bottom: 3, // space between underline and text
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                color: AllCoustomTheme.getHeadingThemeColors(),
                                width: 1.0, // Underline width
                              )
                          )
                      ),
                    ),
                  ],
                ),
              )
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13,right: 5.0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 160,
                  ),
                  Expanded(
                      child: new FormField(
                        builder: (FormFieldState state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                              ),
                              labelStyle: AllCoustomTheme.getDropDownFieldLabelStyleTheme(),
                              errorText: state.hasError ? state.errorText : null,
                            ),
                            isEmpty: selectedInceptionLeague == '',
                            child: new DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: Container(
                                    height: 16.0,
                                    child: new DropdownButton(
                                      value: selectedInceptionLeague,
                                      dropdownColor: Colors.white,
                                      isExpanded: true,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          selectedInceptionLeague = newValue;
                                        });
                                      },
                                      items: <String>['Total Coins', 'Invest Edu coins', 'Track Record coins', 'Stock Pitch coins','Invest Q&A coins',
                                      'Social Invest coins']
                                          .map((String value) {
                                        return new DropdownMenuItem(
                                          value: value,
                                          child: new Text(
                                            value,
                                              style: AllCoustomTheme.getDropDownMenuItemStyleTheme()
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                )
                            ),
                          );
                        },
                      )
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13,right: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.35,
                    child: Scrollbar(
                      child: getInceptionMemberView(inceptionMemberList),
                    )
                  ),
                ),
              ],
            ),
          ),
          // weekly auro strike
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16,right: 5.0),
            child: Container(
              height: MediaQuery.of(context).size.height*0.06,
              child: ListView(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Weekly Auro Streak',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFD8AF4F),
                            fontSize: ConstanceData.SIZE_TITLE18,
                            fontFamily: "Roboto",
                            package: 'Roboto-Regular',
                          ),
                        ),
                      )
                  ),
                  Container(
                    // margin: EdgeInsets.only(right: 180.0),
                    margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.42),
                    padding: EdgeInsets.only(
                      bottom: 3, // space between underline and text
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                              color: AllCoustomTheme.getHeadingThemeColors(),
                              width: 1.0, // Underline width
                            )
                        )
                    ),
                  ),
                ],
              ),
            )
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13,right: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.10,
                    child: Scrollbar(
                      child: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: ()
                              {
                                var tempField = {"rankingNum": "1" ,"name": "Warren Buffet","philosophy": "Buy companies at a low price, improve them via management and make long term gains",
                                  "trackRecord": "He has a 30-year-plus track record making on average 20 percent a year" ,"image": "WarrenBuffet"};
                                print("tempfield: $tempField");
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (BuildContext context) => ClubDetail(allField: tempField),
                                  ),
                                );
                              },
                              child: Container(
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 25.0,
                                        backgroundImage: index==0 ? new AssetImage('assets/filledweeklyAuroBadge.png') : new AssetImage('assets/weeklyAuroBadge.png'),
                                        backgroundColor: Colors.transparent,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      )
                                    ],
                                  )
                              )
                          );
                        },
                      ),
                    )
                  ),
                ),
              ],
            ),
          ),

          //weekly league
          SizedBox(
            height: 15,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 16,right: 5.0),
              child: Container(
                height: MediaQuery.of(context).size.height*0.06,
                child: ListView(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Weekly League',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFD8AF4F),
                              fontSize: ConstanceData.SIZE_TITLE18,
                              fontFamily: "Roboto",
                              package: 'Roboto-Regular',
                            ),
                          ),
                        )
                    ),
                    Container(
                      // margin: EdgeInsets.only(right: 210.0),
                      margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.55),
                      padding: EdgeInsets.only(
                        bottom: 3, // space between underline and text
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                color: AllCoustomTheme.getHeadingThemeColors(),
                                width: 1.0, // Underline width
                              )
                          )
                      ),
                    ),
                  ],
                ),
              )
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13,right: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 110,
                ),
                Expanded(
                    child: new FormField(
                      builder: (FormFieldState state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                            ),
                            labelStyle: AllCoustomTheme.getDropDownFieldLabelStyleTheme(),

                            errorText: state.hasError ? state.errorText : null,
                          ),
                          isEmpty: selectedWeeklyLeague == '',
                          child: new DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: Container(
                                  height: 16.0,
                                  child: new DropdownButton(
                                    value: selectedWeeklyLeague,
                                    dropdownColor: Colors.white,
                                    isExpanded: true,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        selectedWeeklyLeague = newValue;
                                      });
                                    },
                                    items: <String>['Adaptive Investment Learning', 'Investment Track Record', 'Investment Stock Pitch',
                                      'Investment QnA',
                                      'Social Investment Score']
                                        .map((String value) {
                                      return new DropdownMenuItem(
                                        value: value,
                                        child: new Text(
                                          value,
                                          style: AllCoustomTheme.getDropDownMenuItemStyleTheme()
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              )
                          ),
                        );
                      },
                    )
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13,right: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.35,
                    child: Scrollbar(
                      child:getWeeklyLeagueMemberView(inceptionMemberList),
                    )
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  _upDownMarketCap() {
    isLoadingList();
    if (marketCapUpDown == Icons.arrow_upward) {
      setState(() {
        marketCapUpDown = Icons.arrow_downward;
        marketListData.sort((a, b) => a.quote.uSD.marketCap.compareTo(b.quote.uSD.marketCap));
      });
    } else {
      setState(() {
        marketCapUpDown = Icons.arrow_upward;
        marketListData.sort((a, b) => b.quote.uSD.marketCap.compareTo(a.quote.uSD.marketCap));
      });
    }
  }

  void filterSearchResults(String query) {
    isLoadingList();
    _serchCoinList.clear();
    if (query != "") {
      marketListData.forEach((coin) {
        if (coin.symbol.toString().contains(query) ||
            coin.symbol.toString().toLowerCase().contains(query) ||
            coin.symbol.toString().toUpperCase().contains(query) ||
            coin.name.toString().contains(query) ||
            coin.name.toString().toLowerCase().contains(query) ||
            coin.name.toString().toUpperCase().contains(query)) {
          _serchCoinList.add(coin);
        }
      });
      setState(() {
        _isSearch = true;
      });
    } else {
      setState(() {
        _isSearch = false;
      });
    }
  }

  selectFirst() async {
    if (!isSelect1) {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none) {
        setFirstTab();
        callItself();
      }
      setState(() {
        isSelect1 = true;
        isSelect2 = false;
        isSelect3 = false;
        isSelect4 = false;
        isSelect5 = false;
      });
    }
  }

  selectSecond() async {
    if (!isSelect2) {
      setState(() {
        isSelect1 = false;
        isSelect2 = true;
        isSelect3 = false;
        isSelect4 = false;
        isSelect5 = false;
      });
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none) {
        isLoadingList();
      }
    }
  }

  selectThird() async {
    if (!isSelect3) {
      setState(() {
        isSelect1 = false;
        isSelect2 = false;
        isSelect3 = true;
        isSelect4 = false;
        isSelect5 = false;
        selectedUser = "Pooja";
      });
      await Future.delayed(const Duration(milliseconds: 500));
      displayModalBottomSheet(context);

    }
  }

  selectFourth() {
    if (!isSelect4) {
      setState(() {
        isSelect1 = false;
        isSelect2 = false;
        isSelect3 = false;
        isSelect4 = true;
        isSelect5 = false;
      });
    }
  }

  selectFive() {
    if (!isSelect5) {
      setState(() {
        isSelect1 = false;
        isSelect2 = false;
        isSelect3 = false;
        isSelect4 = false;
        isSelect5 = true;
      });
    }
  }

  /// Inefficient way of capitalizing each word in a string.
  String titleCase(String text) {
    if (text.length <= 1) return text.toUpperCase();
    var words = text.split(' ');
    var capitalized = words.map((word) {
      var first = word.substring(0, 1).toUpperCase();
      var rest = word.substring(1);
      return '$first$rest';
    });
    return capitalized.join(' ');
  }
}
