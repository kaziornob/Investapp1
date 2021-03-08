import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:animator/animator.dart';
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/modules/bussPost/createPoll.dart';
import 'package:auroim/modules/bussPost/portfolioPitch.dart';
import 'package:auroim/modules/bussPost/stockPitch.dart';
import 'package:auroim/modules/bussPost/wishList.dart';
import 'package:auroim/modules/home/main_exchange_tab.dart';
import 'package:auroim/modules/home/main_learn_marketplace_tab.dart';
import 'package:auroim/modules/home/main_plus_tab.dart';
import 'package:auroim/modules/investRelatedPages/riskOnboardingPages/onBoardingFirst.dart';
import 'package:auroim/modules/investRelatedPages/searchFirstPage.dart';
import 'package:auroim/modules/investRelatedPages/securityFirstPage.dart';
import 'package:auroim/modules/qaInvForumPages/addEditQus.dart';
import 'package:auroim/modules/qaInvForumPages/qusDetail.dart';
import 'package:auroim/modules/qaInvForumPages/qusView.dart';
import 'package:auroim/modules/socialInvestRelatedPages/InvestedAssetModule.dart';
import 'package:auroim/modules/socialInvestRelatedPages/auroStrikeBadges.dart';
import 'package:auroim/modules/socialInvestRelatedPages/clubDetail.dart';
import 'package:auroim/modules/questionAndAnswerModule/models/question.dart';
import 'package:auroim/modules/questionAndAnswerModule/resources/question_api_provider.dart';
import 'package:auroim/modules/questionAndAnswerModule/ui/pages/error.dart';
import 'package:auroim/modules/questionAndAnswerModule/ui/pages/questionTemplate.dart';
import 'package:auroim/modules/stripePayment/stripePaymentServer.dart';
import 'package:auroim/widgets/auro_stars.dart';
import 'package:auroim/widgets/crypto_marketplace/crypto_marketplace_main_page.dart';
import 'package:auroim/widgets/goLiveInvest/personalSleeve.dart';
import 'package:auroim/widgets/private_deals_marketplace/private_deals_intro.dart';
import 'package:auroim/widgets/private_deals_marketplace/private_deals_main_page.dart';
import 'package:auroim/widgets/public_companies_list.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'main_home_tab.dart';
import 'main_invest_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

const String testDevice = 'YOUR_DEVICE_ID';

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  var _homeScaffoldKey = new GlobalKey<ScaffoldState>();
  ApiProvider request = new ApiProvider();

  TextEditingController _appbarTextController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();

  bool searching = false;
  int userAuroCoinScore;
  ScrollController _scrollController = ScrollController();

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

  List<String> tagItemList = <String>['native', 'fixed'];

  //fifth screen params
  String selectedInceptionLeague;
  String selectedWeeklyLeague;

  // second screen params

  int selectedTabIndex;

  final List<Tab> tabList = <Tab>[
    new Tab(text: 'Recommended'),
    new Tab(text: 'Coined'),
    new Tab(text: "Buzzing"),
    new Tab(text: "Month"),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    getSharedPrefData();
    _tabController = new TabController(vsync: this, length: tabList.length);
    _appbarTextController.addListener(() {
      if (_appbarTextController.text.length > 0) {
        setState(() {
          searching = true;
        });
      } else {
        setState(() {
          searching = false;
        });
      }
    });

    setFirstTab();
    callItself();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
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
    _scrollController = ScrollController(initialScrollOffset: 50.0);
  }

  SharedPreferences prefs;

  getSharedPrefData() async {
    prefs = await SharedPreferences.getInstance();
    print("investor type : ${prefs.getString('InvestorType')}");
  }

  @override
  dispose() {
    super.dispose();

    subscription.cancel();
    admobBannerController.dispose();
    _scrollController.dispose();
  }

  connectionError() {
    showInSnackBar(ConstanceData.NoInternet);
  }

  Future showInSnackBar(String value, {bool isGreeen = false}) async {
    await Future.delayed(const Duration(milliseconds: 700));
    _homeScaffoldKey.currentState.showSnackBar(
      new SnackBar(
        duration: Duration(seconds: 2),
        content: new Text(
          value,
          style: TextStyle(
            color: AllCoustomTheme.getReBlackAndWhiteThemeColors(),
          ),
        ),
        backgroundColor:
            isGreeen ? AllCoustomTheme.getThemeData().primaryColor : Colors.red,
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
            allCoinList
                .removeWhere((length) => length.quote.uSD.marketCap == null);
            if (allCoin == true) {
              getApiAllData(index);
            }
            lstCryptoCoinDetail.clear();
            lstCryptoCoinDetail.addAll(allCoinList);
            lstCryptoCoinDetail.sort((a, b) =>
                b.quote.uSD.marketCap.compareTo(a.quote.uSD.marketCap));
            print(lstCryptoCoinDetail[0].quote.uSD);

            marketListData.clear();
            marketListData.addAll(allCoinList);
            marketListData.sort((a, b) =>
                b.quote.uSD.marketCap.compareTo(a.quote.uSD.marketCap));
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

  Future<Null> changeHistory(
      String type, String amt, String total, String agg) async {
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
            (ohlcvWidthOptions[historyTotal][currentOHLCVWidthSetting][1] - 1)
                .toString() +
            "&aggregate=" +
            ohlcvWidthOptions[historyTotal][currentOHLCVWidthSetting][2]
                .toString()),
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
      // homeDonutArray = [];
      // getDoughnutPortfolioData();
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
            InkWell(
              onTap: () {
                _homeScaffoldKey.currentState.openDrawer();
              },
              child: FractionalTranslation(
                translation: Offset(0.4, 0.2),
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
        //search box area
        Container(
          margin: EdgeInsets.only(top: 10.0, left: 13.0),
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
                width: MediaQuery.of(context).size.width * 0.58,
                height: MediaQuery.of(context).size.height * 0.05,
                child: TextFormField(
                  controller: _appbarTextController,
                  focusNode: _focusNode,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: ConstanceData.SIZE_TITLE14,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      FontAwesomeIcons.search,
                      color: AllCoustomTheme.getNewSecondTextThemeColor(),
                      size: 15,
                    ),
                    hintText: "Search Listed Companies",
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
            Padding(
              padding: EdgeInsets.only(top: 3.0),
              child: Image(
                  height: 40,
                  width: 40,
                  image: new AssetImage('assets/appIcon.png')),
            ),
            FractionalTranslation(
              translation: Offset(-0.5, 0.0),
              child: GestureDetector(
                onTap: () {},
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
            key: _homeScaffoldKey,
            appBar: isSelect1 || isSelect2 || isSelect4 || isSelect5
                ? PreferredSize(
                    preferredSize: Size.fromHeight(65.0),
                    child: AppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor:
                          AllCoustomTheme.getAppBarBackgroundThemeColors(),
                      title: _buildAppBar(context),
                    ),
                  )
                : null,
            bottomNavigationBar: Container(
              decoration: new BoxDecoration(
                color: AllCoustomTheme.getBodyContainerThemeColor(),
                border: Border.all(
                  color: AllCoustomTheme.getSecondIconThemeColor(),
                  width: 1.0,
                ),
              ),
              // height: 52,
              height: MediaQuery.of(context).size.height * 0.088,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment: Alignment.topCenter,
                                            child: Icon(
                                              Icons.home,
                                              size: 23,
                                              color: isSelect1
                                                  ? AllCoustomTheme
                                                      .getIconThemeColors()
                                                  : AllCoustomTheme
                                                      .getSecondIconThemeColor(),
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
                                                    fontSize: ConstanceData
                                                        .SIZE_TITLE14,
                                                    color: isSelect1
                                                        ? AllCoustomTheme
                                                            .getIconThemeColors()
                                                        : AllCoustomTheme
                                                            .getSecondIconThemeColor(),
                                                    fontFamily: "Rasa",
                                                    fontStyle: FontStyle.normal,
                                                    letterSpacing: 0.2),
                                              )),
                                        ],
                                      )),
                                )
                              : firstAnimation(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
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
            ),
            drawer: SizedBox(
              width: MediaQuery.of(context).size.width * 0.75 < 400
                  ? MediaQuery.of(context).size.width * 0.75
                  : 350,
              child: Drawer(
                elevation: 0,
                child: AppDrawer(
                  selectItemName: 'home',
                  auroStreakCallback: () {
                    print("auro streak page to go on tapped");
                    _scrollController = ScrollController(
                      initialScrollOffset: 500,
                      keepScrollOffset: true,
                    );
                    setState(() {
                      selectFive();
                    });
                    print("sfsfsfsf");
                    // if (_scrollController.hasClients) {
                    //   _scrollController
                    //       .animateTo(
                    //     500.0,
                    //     duration: Duration(milliseconds: 500),
                    //     curve: Curves.ease,
                    //   )
                    //       .whenComplete(() {
                    //     print("the animation to auro streak finished");
                    //   }).catchError((error) {
                    //     print("the animation to auro streak error");
                    //     print(error.toString());
                    //   });
                    // }else{
                    //   print("no scroll client");
                    // }
                  },
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            // floatingActionButton: Visibility(
            //   visible: isSelect3,
            //   child: FloatingActionButton(
            //     onPressed: () async {
            //       displayModalBottomSheet(context);
            //     },
            //     child: Icon(
            //       Icons.more_vert_outlined,
            //       color: AllCoustomTheme.getTextThemeColors(),
            //       size: 30.0,
            //     ),
            //     backgroundColor: AllCoustomTheme.getsecoundTextThemeColor(),
            //   ),
            // ),
            body: searching
                ? Container(
                    color: globals.isGoldBlack ? Colors.black : Colors.white,
                    height: MediaQuery.of(context).size.height - 65,
                    child: FutureBuilder(
                      future: _featuredCompaniesProvider
                          .searchPublicCompanyList(_appbarTextController.text),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (snapshot.data.length == 0) {
                            return ListTile(
                              onTap: () {
                                setState(() {
                                  _appbarTextController.clear();
                                });
                              },
                              title: Text(
                                "No Results",
                                style: TextStyle(
                                  color: globals.isGoldBlack
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              trailing: Icon(Icons.close_rounded,
                                  color: globals.isGoldBlack
                                      ? Colors.white
                                      : Colors.black),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    _appbarTextController.text = "";
                                    FocusScope.of(context).unfocus();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => SecurityPageFirst(
                                          companyTicker: snapshot.data[index]
                                              ["ticker"],
                                        ),
                                      ),
                                    );
                                  },
                                  title: Text(
                                    snapshot.data[index]["company_name"],
                                    style: TextStyle(
                                      color: globals.isGoldBlack
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        }
                      },
                    ),
                  )
                : ModalProgressHUD(
                    inAsyncCall: _isInProgress,
                    opacity: 0,
                    progressIndicator: SizedBox(),
                    child: Container(
                      // color: isSelect2 || isSelect5 ? AllCoustomTheme.getPageBackgroundThemeColor() : AllCoustomTheme.getThemeData().primaryColor,
                      color: isSelect2 || isSelect1
                          ? AllCoustomTheme.getPageBackgroundThemeColor()
                          : (isSelect5 || isSelect4
                              ? AllCoustomTheme.getBodyContainerThemeColor()
                              : AllCoustomTheme.getThemeData().primaryColor),
                      height: height,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                              height: isSelect1 ||
                                      isSelect2 ||
                                      isSelect5 ||
                                      isSelect4
                                  ? 2
                                  : MediaQuery.of(context).padding.top,
                              child: Visibility(
                                visible: isSelect1 ||
                                    isSelect2 ||
                                    isSelect5 ||
                                    isSelect4,
                                child: Container(
                                  decoration: new BoxDecoration(
                                    color: Color(0xFFFFFFFF),
                                    border: Border.all(
                                      color: Color(0xFFFFFFFF),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              )),
                          Expanded(
                            child: isSelect1
                                ? MainHomeTab()
                                : isSelect2
                                    ? MainInvestTab()
                                    : (isSelect3
                                        ? MainPlusTab()
                                        : (isSelect4
                                            ? MainExchangeTab()
                                            : MainLearnMarketTab())),
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
            color: isSelect1
                ? AllCoustomTheme.getIconThemeColors()
                : AllCoustomTheme.getSecondIconThemeColor(),
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
                  color: isSelect1
                      ? AllCoustomTheme.getIconThemeColors()
                      : AllCoustomTheme.getSecondIconThemeColor(),
                  fontFamily: "Rasa",
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0.2),
            )),
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
            color: isSelect2
                ? AllCoustomTheme.getIconThemeColors()
                : AllCoustomTheme.getSecondIconThemeColor(),
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
                  color: isSelect2
                      ? AllCoustomTheme.getIconThemeColors()
                      : AllCoustomTheme.getSecondIconThemeColor(),
                  fontFamily: "Rasa",
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0.2),
            )),
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
        color: isSelect3
            ? AllCoustomTheme.getIconThemeColors()
            : AllCoustomTheme.getSecondIconThemeColor(),
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
            color: isSelect4
                ? AllCoustomTheme.getIconThemeColors()
                : AllCoustomTheme.getSecondIconThemeColor(),
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
                  color: isSelect4
                      ? AllCoustomTheme.getIconThemeColors()
                      : AllCoustomTheme.getSecondIconThemeColor(),
                  fontFamily: "Rasa",
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0.2),
            )),
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
            color: isSelect5
                ? AllCoustomTheme.getIconThemeColors()
                : AllCoustomTheme.getSecondIconThemeColor(),
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Align(
            alignment: Alignment.topCenter,
            child: Text(
              // "Learn",
              prefs != null &&
                      prefs.containsKey('InvestorType') &&
                      prefs.getString('InvestorType') != null &&
                      prefs.getString('InvestorType') == 'Accredited Investor'
                  ? 'MarketPlace'
                  : 'Learn',
              style: TextStyle(
                  fontSize: ConstanceData.SIZE_TITLE14,
                  color: isSelect5
                      ? AllCoustomTheme.getIconThemeColors()
                      : AllCoustomTheme.getSecondIconThemeColor(),
                  fontFamily: "Rasa",
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0.2),
            )),
      ],
    );
  }

  singleRow(context, security, share, ip, cp, perReturn, color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          // width: (MediaQuery.of(context).size.width / 2) - 6,
          width: 70,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: color,
          ),
          child: Center(child: Text(security)),
        ),
        Container(
          // width: (MediaQuery.of(context).size.width / 2) - 6,
          width: 70,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: color,
          ),
          child: Center(
              child: Text(
            share,
            textAlign: TextAlign.center,
          )),
        ),
        Container(
          // width: (MediaQuery.of(context).size.width / 2) - 6,
          width: 70,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: color,
          ),
          child: Center(
              child: Text(
            ip,
            textAlign: TextAlign.center,
          )),
        ),
        Container(
          // width: (MediaQuery.of(context).size.width / 2) - 6,
          width: 70,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: color,
          ),
          child: Center(
              child: Text(
            cp,
            textAlign: TextAlign.center,
          )),
        ),
        Container(
          // width: (MediaQuery.of(context).size.width / 2) - 6,
          width: 70,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: color,
          ),
          child: Center(
              child: Text(
            perReturn,
            textAlign: TextAlign.center,
          )),
        ),
      ],
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

  Widget getAreaChartView() {
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
                  height: MediaQuery.of(context).size.height * 0.36,
                  width: MediaQuery.of(context).size.width * 0.96,
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: new Border.all(
                          color: AllCoustomTheme.getChartBoxThemeColor(),
                          width: 1.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.10,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "APPLE",
                                    style: TextStyle(
                                      color: AllCoustomTheme
                                          .getChartBoxTextThemeColor(),
                                      fontSize: ConstanceData.SIZE_TITLE18,
                                      fontFamily: "Roboto",
                                    ),
                                  ),
                                  Text(
                                    "2.20 (1.61%)",
                                    style: TextStyle(
                                      color: AllCoustomTheme
                                          .getNewSecondTextThemeColor(),
                                      fontSize: ConstanceData.SIZE_TITLE8,
                                      fontFamily: "Roboto",
                                    ),
                                  ),
                                  Text(
                                    '\$' + " 390.00",
                                    style: TextStyle(
                                      color: AllCoustomTheme
                                          .getChartBoxTextThemeColor(),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "HIGH",
                                        style: TextStyle(
                                          color: AllCoustomTheme
                                              .getNewTextThemeColors(),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "LOW",
                                        style: TextStyle(
                                          color: AllCoustomTheme
                                              .getNewTextThemeColors(),
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
                            width: MediaQuery.of(context).size.width * 0.88,
                            height: MediaQuery.of(context).size.height * 0.15,
                            child: Container(
                              margin: EdgeInsets.only(left: 10.0),
                              child: SfCartesianChart(
                                  primaryXAxis: NumericAxis(
                                    isVisible: false,
                                  ),
                                  primaryYAxis: NumericAxis(isVisible: false),
                                  series: <ChartSeries>[
                                    StackedAreaSeries<NewSalesData, double>(
                                      dataSource: newSalesData,
                                      xValueMapper: (NewSalesData data, _) =>
                                          data.year,
                                      yValueMapper: (NewSalesData data, _) =>
                                          data.sales,
                                      gradient: gradientColors,
                                    ),
                                  ]),
                            )),
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
                                width: MediaQuery.of(context).size.width * 0.25,
                                height:
                                    MediaQuery.of(context).size.height * 0.038,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    border: new Border.all(
                                        color: AllCoustomTheme
                                            .getChartBoxThemeColor(),
                                        width: 1.5),
                                    color:
                                        AllCoustomTheme.getChartBoxThemeColor(),
                                  ),
                                  child: MaterialButton(
                                    splashColor: Colors.grey,
                                    child: Text(
                                      "BUY",
                                      style: TextStyle(
                                        color: AllCoustomTheme
                                            .getButtonTextThemeColors(),
                                        fontSize: ConstanceData.SIZE_TITLE13,
                                        fontFamily: "Roboto",
                                      ),
                                    ),
                                    onPressed: () async {
/*                                      Navigator.of(context).push(new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                          new OnBoardingFirst(logo: "logo.png",callingFrom: "Accredited Investor",)));*/
                                      Navigator.of(context).push(
                                          new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  new SecurityPageFirst(
                                                      logo: "logo.png",
                                                      callingFrom:
                                                          "Accredited Investor")));
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.26,
                                height:
                                    MediaQuery.of(context).size.height * 0.038,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    border: new Border.all(
                                        color: AllCoustomTheme
                                            .getChartBoxThemeColor(),
                                        width: 1.5),
                                    // color: AllCoustomTheme.getChartBoxThemeColor(),
                                  ),
                                  child: MaterialButton(
                                    splashColor: Colors.grey,
                                    child: Text(
                                      "SELL",
                                      style: TextStyle(
                                        color: AllCoustomTheme
                                            .getChartBoxTextThemeColor(),
                                        fontSize: ConstanceData.SIZE_TITLE13,
                                        fontFamily: "Roboto",
                                      ),
                                    ),
                                    onPressed: () async {
/*                                      Navigator.of(context).push(new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                          new OnBoardingFirst(logo: "logo.png",callingFrom: "Accredited Investor",)));*/
                                      Navigator.of(context).push(
                                          new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  new SecurityPageFirst(
                                                      logo: "logo.png",
                                                      callingFrom:
                                                          "Accredited Investor")));
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.32,
                                height:
                                    MediaQuery.of(context).size.height * 0.038,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    border: new Border.all(
                                        color: AllCoustomTheme
                                            .getChartBoxThemeColor(),
                                        width: 1.5),
                                    // color: AllCoustomTheme.getChartBoxThemeColor(),
                                  ),
                                  child: MaterialButton(
                                    splashColor: Colors.grey,
                                    child: Text(
                                      "WATCH",
                                      style: TextStyle(
                                        color: AllCoustomTheme
                                            .getChartBoxTextThemeColor(),
                                        fontSize: ConstanceData.SIZE_TITLE13,
                                        fontFamily: "Roboto",
                                      ),
                                    ),
                                    onPressed: () async {
                                      Navigator.of(context).push(
                                          new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  new OnBoardingFirst(
                                                    logo: "logo.png",
                                                    callingFrom:
                                                        "Accredited Investor",
                                                  )));
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
                  )),
            ],
          ),
        );
      },
    );
  }

  // second screen section end
  Widget askQus() {
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
    ));
  }

  Widget overall() {
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
    ));
  }

  _upDownMarketCap() {
    isLoadingList();
    if (marketCapUpDown == Icons.arrow_upward) {
      setState(() {
        marketCapUpDown = Icons.arrow_downward;
        marketListData.sort(
            (a, b) => a.quote.uSD.marketCap.compareTo(b.quote.uSD.marketCap));
      });
    } else {
      setState(() {
        marketCapUpDown = Icons.arrow_upward;
        marketListData.sort(
            (a, b) => b.quote.uSD.marketCap.compareTo(a.quote.uSD.marketCap));
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

  // api calls section end

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
        // homeDonutArray = [];
      });
      // getDountPortfolioData();
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
        // selectedUser = "Pooja";
      });
      await Future.delayed(const Duration(milliseconds: 500));
      // displayModalBottomSheet(context);
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
      // getQuestionsData();
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
}
