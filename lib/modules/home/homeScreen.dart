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

  // third screen params
  List<String> userList = <String>['Pooja', 'Ritika'];

  String selectedUser;
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
    homeDonutArray = [];
    portfolioChartData = null;
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
      homeDonutArray = [];
      getDoughnutPortfolioData();
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
                                ? firstScreen()
                                : isSelect2
                                    ? secondScreen()
                                    : (isSelect3
                                        ? thirdScreen()
                                        : (isSelect4
                                            ? fourthScreen()
                                            : fifthScreen())),
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

  int homeDonutCurrentIndex = 0;

  List homeDonutArray = [];

  List<ChartData> homeChartData = [];

  setHomeDoughnutChartData() {
    print("portfolioChartData: $portfolioChartData");
    print("homeDonutCurrentIndex: $homeDonutCurrentIndex");

    if (portfolioChartData != null && portfolioChartData != false) {
      print("herererer");
      if (homeDonutCurrentIndex == 0 && portfolioChartData["data"] != null) {
        // var tempWeightsData =
        //     portfolioChartData['weights_assetclass']['weights'];
        print("in bro index 0");
        homeChartData = [];
        Map countMap = {};

        portfolioChartData["data"].forEach(
          (element) {
            if (countMap.containsKey(element["asset_class"])) {
              int earlyCount = countMap[element["asset_class"]];
              countMap[element["asset_class"]] = earlyCount + 1;
            } else {
              countMap[element["asset_class"]] = 1;
            }
          },
        );

        countMap.forEach((key, value) {
          homeChartData.add(ChartData(
              '$key',
              value.toDouble(),
              // double.parse(tempDouble.toStringAsFixed(4)),
              globals.isGoldBlack ? Color(0xFFE8E2DB) : Color(0xFF1D6177)));
        });

        // final
      } else if (homeDonutCurrentIndex == 1) {
        print("in bro index 1");
        homeChartData = [];
        Map countMap = {};

        portfolioChartData["data"].forEach(
          (element) {
            if (countMap.containsKey(element["country"])) {
              int earlyCount = countMap[element["country"]];
              countMap[element["country"]] = earlyCount + 1;
            } else {
              countMap[element["country"]] = 1;
            }
          },
        );

        countMap.forEach((key, value) {
          homeChartData.add(ChartData(
              '$key',
              value.toDouble(),
              // double.parse(tempDouble.toStringAsFixed(4)),
              globals.isGoldBlack ? Color(0xFFE8E2DB) : Color(0xFF1D6177)));
        });
      } else if (homeDonutCurrentIndex == 3) {
        print("in bro index 3");
        homeChartData = [];
        Map countMap = {};

        portfolioChartData["data"].forEach(
          (element) {
            if (countMap.containsKey(element["sector"])) {
              int earlyCount = countMap[element["sector"]];
              countMap[element["sector"]] = earlyCount + 1;
            } else {
              countMap[element["sector"]] = 1;
            }
          },
        );

        countMap.forEach((key, value) {
          homeChartData.add(ChartData(
              '$key',
              value.toDouble(),
              // double.parse(tempDouble.toStringAsFixed(4)),
              globals.isGoldBlack ? Color(0xFFE8E2DB) : Color(0xFF1D6177)));
        });
      }
    }

    //
    // // print("portfolioChartData: $portfolioChartData");
    // print("homeDonutCurrentIndex: $homeDonutCurrentIndex");
    //
    // if (portfolioChartData != null && portfolioChartData != false) {
    //   if (homeDonutCurrentIndex == 0 &&
    //       portfolioChartData['data']['weights_assetclass'] != null &&
    //       portfolioChartData['data']['weights_assetclass']['weights'] != null) {
    //     var tempWeightsData =
    //         portfolioChartData['weights_assetclass']['weights'];
    //
    //     homeChartData = [];
    //     final data1 = tempWeightsData as Map;
    //     for (final name in data1.keys) {
    //       final value = data1[name];
    //       var tempDouble = value.toDouble();
    //       homeChartData.add(ChartData(
    //           '$name',
    //           double.parse(tempDouble.toStringAsFixed(4)),
    //           globals.isGoldBlack ? Color(0xFFE8E2DB) : Color(0xFF1D6177)));
    //     }
    //   } else if (homeDonutCurrentIndex == 1 &&
    //       portfolioChartData['weights_assetcountry'] != null &&
    //       portfolioChartData['weights_assetcountry']['weights'] != null) {
    //     homeChartData = [];
    //     var tempWeightsData =
    //         portfolioChartData['weights_assetcountry']['weights'];
    //     final data1 = tempWeightsData as Map;
    //     for (final name in data1.keys) {
    //       final value = data1[name];
    //       var tempDouble = value.toDouble();
    //       homeChartData.add(ChartData(
    //           '$name',
    //           double.parse(tempDouble.toStringAsFixed(5)),
    //           globals.isGoldBlack ? Color(0xFFE8E2DB) : Color(0xFF1D6177)));
    //     }
    //   } else if (homeDonutCurrentIndex == 2 &&
    //       portfolioChartData['weights_foliotickers'] != null &&
    //       portfolioChartData['weights_foliotickers']['sector'] != null) {
    //     homeChartData = [];
    //
    //     var tempWeightsData =
    //         portfolioChartData['weights_foliotickers']['sector'];
    //     var allSectorKeys = [];
    //     final data = tempWeightsData as Map;
    //     for (final name in data.keys) {
    //       final value = data[name];
    //       allSectorKeys.add(value);
    //     }
    //
    //     var finalSectorData = Map();
    //     allSectorKeys.forEach((element) {
    //       if (!finalSectorData.containsKey(element)) {
    //         finalSectorData[element] = 1;
    //       } else {
    //         finalSectorData[element] += 1;
    //       }
    //     });
    //
    //     print(finalSectorData);
    //
    //     for (final name in finalSectorData.keys) {
    //       final value = finalSectorData[name];
    //
    //       homeChartData.add(ChartData('$name', value.toDouble(),
    //           globals.isGoldBlack ? Color(0xFFE8E2DB) : Color(0xFF1D6177)));
    //     }
    //   }
    // }
  }

  Widget firstScreen() {
    return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'AURO PAPER PORTFOLIO',
                style: TextStyle(
                    color: AllCoustomTheme.getHeadingThemeColors(),
                    fontSize: ConstanceData.SIZE_TITLE20,
                    fontFamily: "Rosarivo",
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.1),
              ),
            ),
            Container(
              // margin: EdgeInsets.only(left: 80.0,right: 80.0),
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.07,
                  right: MediaQuery.of(context).size.width * 0.07),
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                bottom: 3, // space between underline and text
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Color(0xFFD8AF4F),
                width: 1.6, // Underline width
              ))),
            ),
            // handshake/loader image box
            Visibility(
                visible: homeDonutArray == null || homeDonutArray.length == 0
                    ? true
                    : false,
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.10,
                      bottom: MediaQuery.of(context).size.height * 0.10),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.redAccent,
                    valueColor: AlwaysStoppedAnimation(Colors.green),
                    strokeWidth: 10,
                  ),
                )),

/*            Visibility(
              visible: homeDonutArray == null || homeDonutArray.length == 0
                  ? true
                  : false,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.25,
                child: Container(
                  margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
                  child: Image(
                      fit: BoxFit.fill,
                      image: new AssetImage('assets/handShake.png')),
                ),
              ),
            ),*/
            Visibility(
              visible: homeDonutArray.length != 0 ? true : false,
              // visible: true,
              child: Container(
                child: CarouselSlider.builder(
                  itemCount: homeDonutArray.length,
                  options: CarouselOptions(
                      autoPlay: false,
                      viewportFraction: homeDonutCurrentIndex == 1 ? 1.1 : 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          homeDonutCurrentIndex = index;
                          setHomeDoughnutChartData();
                        });
                      }),
                  itemBuilder: (context, index) {
                    if (index == 2) {
                      print("index: $index");
                      final List<Map<String, dynamic>> securities = [
                        {"name": "1", "share": "", "price": ""},
                        {"name": "2", "share": "", "price": ""},
                        {"name": "3", "share": "", "price": ""},
                      ];

                      // if (portfolioChartData != null &&
                      //     portfolioChartData['weights_foliotickers'] != null &&
                      //     portfolioChartData['weights_foliotickers']
                      //             ['weights'] !=
                      //         null) {
                      //   print("data comes: $index");
                      //   print(
                      //       "weights folio tickers: ${portfolioChartData['weights_foliotickers']["weights"]}");
                      //   final Map<String, dynamic> weights =
                      //       portfolioChartData['weights_foliotickers']
                      //           ["weights"];
                      //
                      //   print("weights: $weights");
                      //
                      //   final Map<String, dynamic> weight_values =
                      //       portfolioChartData['weights_foliotickers']
                      //           ["weights_value"];
                      //   final Map<String, dynamic> in_prices =
                      //       portfolioChartData['weights_foliotickers']
                      //           ["in_price"];
                      //   final Map<String, dynamic> security_names =
                      //       portfolioChartData['weights_foliotickers']
                      //           ["security_name"];
                      //   print("weights : $weights");
                      //
                      //   var sortedKeys = weights.keys.toList(growable: false)
                      //     ..sort(
                      //         (k1, k2) => weights[k1].compareTo(weights[k2]));
                      //   sortedKeys = sortedKeys.getRange(0, 3).toList();
                      //   sortedKeys.forEach((k) => {
                      //         securities.add({
                      //           "weight": weights[k],
                      //           "name": security_names[k],
                      //           "price": in_prices[k],
                      //           "weight_value": weight_values[k],
                      //           "share": weight_values[k] / in_prices[k]
                      //         })
                      //       });
                      //   print("securities : $securities");
                      // }

                      return Container(
                        child: Column(
                          children: [
                            singleRow(
                                context,
                                "Security",
                                '# of shares/ \$',
                                'In-Price',
                                'Current Price',
                                '% Return',
                                Colors.indigo[100]),
                            singleRow(
                                context,
                                "${securities[0]['name']}",
                                '${securities[0]['share']}',
                                '${securities[0]['price']}',
                                '-',
                                '-',
                                Colors.indigo[50]),
                            singleRow(
                                context,
                                "${securities[1]['name']}",
                                '${securities[1]['share']}',
                                '${securities[1]['price']}',
                                '-',
                                '-',
                                Colors.indigo[100]),
                            singleRow(
                                context,
                                "${securities[2]['name']}",
                                '${securities[2]['share']}',
                                '${securities[2]['price']}',
                                '-',
                                '-',
                                Colors.indigo[50]),
                          ],
                        ),
                      );
                    }
                    return Container(
                      child: SfCircularChart(
                          legend: Legend(
                              isVisible: true,
                              textStyle: TextStyle(
                                  color: AllCoustomTheme.getTextThemeColors()),
                              overflowMode: LegendItemOverflowMode.wrap,
                              itemPadding: 5.0),
                          series: <CircularSeries>[
                            DoughnutSeries<ChartData, String>(
                              dataSource: homeChartData,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              dataLabelSettings: DataLabelSettings(
                                  isVisible: true,
                                  useSeriesColor: true,
                                  showCumulativeValues: true,
                                  showZeroValue: true),
                            )
                          ]),
                    );
                  },
                ),
              ),
            ),
            Visibility(
              visible: homeDonutArray.length != 0 ? true : false,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: homeDonutArray.map((url) {
                    int index = homeDonutArray.indexOf(url);
                    return Container(
                      width: 10.0,
                      height: 8.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: homeDonutCurrentIndex == index
                            // ? Color(0xFFFFFFFF)
                            ? Color(0xFFD8AF4F)
                            : Color(0xffCBB4B4),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Visibility(
              visible: homeDonutArray.length != 0 ? true : false,
              child: Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.07,
                      right: MediaQuery.of(context).size.width * 0.03),
                  child: Text(
                    "Voila! We’ve created a paper  portfolio for you that can help you start engaging and learning about how to invest. "
                    "Please note that this is NOT our recommended investment portfolio for which you need to complete additional risk onbording.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: AllCoustomTheme.getNewSecondTextThemeColor(),
                        fontSize: 14.5,
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0.2),
                  )),
            ),
            SizedBox(
              height: 10.0,
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
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.32,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: new Border.all(
                                color: AllCoustomTheme.getButtonBoxColor(),
                                width: 1.5),
                            color: AllCoustomTheme.getButtonBoxColor()),
                        child: MaterialButton(
                          splashColor: Colors.grey,
                          child: Text("GO PRO",
                              style: AllCoustomTheme
                                  .getButtonSelectedTextStyleTheme()),
                          onPressed: () async {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new OnBoardingFirst(
                                      logo: "logo.png",
                                      callingFrom: "Accredited Investor",
                                    )));
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
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: new Border.all(
                              color: AllCoustomTheme.getButtonBoxColor(),
                              width: 1.5),
                        ),
                        child: MaterialButton(
                          splashColor: Colors.grey,
                          child: Text("GO LIVE",
                              style: AllCoustomTheme
                                  .getButtonNonSelectedTextStyleTheme()),
                          onPressed: () async {
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
              height: MediaQuery.of(context).size.height * 0.73,
              child: Container(
                  margin: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Center(
                            child: Text(
                          'AURO PORTFOLIO COMPONENTS',
                          style: new TextStyle(
                            color: AllCoustomTheme.getHeadingThemeColors(),
                            fontSize: ConstanceData.SIZE_TITLE18,
                            fontFamily: "Rosarivo",
                          ),
                        )),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.02,
                            right: MediaQuery.of(context).size.width * 0.02),
                        padding: EdgeInsets.only(
                          bottom: 3, // space between underline and text
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: AllCoustomTheme.getHeadingThemeColors(),
                          width: 1.0, // Underline width
                        ))),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding:
                                      EdgeInsets.only(left: 95.0, bottom: 5.0),
                                  child: Text(
                                    'Auro Portfolio',
                                    style: new TextStyle(
                                      color: AllCoustomTheme
                                          .getSubHeadingThemeColors(),
                                      fontSize: ConstanceData.SIZE_TITLE15,
                                      fontFamily: "Roboto",
                                      package: 'Roboto-Regular',
                                    ),
                                  )),
                              Padding(
                                  padding:
                                      EdgeInsets.only(left: 30.0, top: 3.0),
                                  child: Text(
                                    'SEE ALL',
                                    style: new TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: AllCoustomTheme
                                          .getSeeMoreThemeColor(),
                                      fontSize: ConstanceData.SIZE_TITLE15,
                                      fontFamily: "Roboto",
                                    ),
                                  ))
                            ],
                          )),
                      // PublicCompaniesList(),
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width - 20,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            singleTableForPortFolio(),
                            singleTableForPortFolio(),
                            singleTableForPortFolio(),
                          ],
                        ),
                      ),
/*                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.37,
                          child: Container(
                              margin: EdgeInsets.only(
                                  top: 5.0, left: 5.0, right: 5.0, bottom: 5.0),
                              child: getAreaChartView())
                      ),*/
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
            ),
            // go live button
          ],
        ));
  }

  singleTableForPortFolio() {
    // print("index: $index");
    final List<Map<String, dynamic>> securities = [
      {"name": "1", "share": "", "price": ""},
      {"name": "2", "share": "", "price": ""},
      {"name": "3", "share": "", "price": ""},
    ];

    // if (portfolioChartData != null &&
    //     portfolioChartData['weights_foliotickers'] != null &&
    //     portfolioChartData['weights_foliotickers']
    //             ['weights'] !=
    //         null) {
    //   print("data comes: $index");
    //   print(
    //       "weights folio tickers: ${portfolioChartData['weights_foliotickers']["weights"]}");
    //   final Map<String, dynamic> weights =
    //       portfolioChartData['weights_foliotickers']
    //           ["weights"];
    //
    //   print("weights: $weights");
    //
    //   final Map<String, dynamic> weight_values =
    //       portfolioChartData['weights_foliotickers']
    //           ["weights_value"];
    //   final Map<String, dynamic> in_prices =
    //       portfolioChartData['weights_foliotickers']
    //           ["in_price"];
    //   final Map<String, dynamic> security_names =
    //       portfolioChartData['weights_foliotickers']
    //           ["security_name"];
    //   print("weights : $weights");
    //
    //   var sortedKeys = weights.keys.toList(growable: false)
    //     ..sort(
    //         (k1, k2) => weights[k1].compareTo(weights[k2]));
    //   sortedKeys = sortedKeys.getRange(0, 3).toList();
    //   sortedKeys.forEach((k) => {
    //         securities.add({
    //           "weight": weights[k],
    //           "name": security_names[k],
    //           "price": in_prices[k],
    //           "weight_value": weight_values[k],
    //           "share": weight_values[k] / in_prices[k]
    //         })
    //       });
    //   print("securities : $securities");
    // }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            singleRow(context, "Security", '# of shares/ \$', 'In-Price',
                'Current Price', '% Return', Colors.indigo[100]),
            singleRow(
                context,
                "${securities[0]['name']}",
                '${securities[0]['share']}',
                '${securities[0]['price']}',
                '-',
                '-',
                Colors.indigo[50]),
            singleRow(
                context,
                "${securities[1]['name']}",
                '${securities[1]['share']}',
                '${securities[1]['price']}',
                '-',
                '-',
                Colors.indigo[100]),
            singleRow(
                context,
                "${securities[2]['name']}",
                '${securities[2]['share']}',
                '${securities[2]['price']}',
                '-',
                '-',
                Colors.indigo[50]),
          ],
        ),
      ),
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

  Widget secondScreen() {
    return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SearchFirstPage(),

            // personal sleeve section
            PersonalSleeve(
              goToPersonalSleeveCallback: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PersonalSleeve()));
              },
            ),
            // auro stars section
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      padding: const EdgeInsets.only(
                        bottom: 8,
                      ),
                      child: Center(
                        child: Text(
                          "Auro Stars",
                          style: TextStyle(
                              color: AllCoustomTheme.getHeadingThemeColors(),
                              fontSize: ConstanceData.SIZE_TITLE20,
                              fontFamily: "Rosarivo",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.1),
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AllCoustomTheme.getHeadingThemeColors(),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                AuroStars(),
              ],
            ),
            //public equities section
            Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      padding: const EdgeInsets.only(
                        bottom: 8,
                      ),
                      child: Center(
                        child: Text(
                          "Listed Company Marketplace",
                          style: TextStyle(
                              color: AllCoustomTheme.getHeadingThemeColors(),
                              fontSize: ConstanceData.SIZE_TITLE20,
                              fontFamily: "Rosarivo",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.1),
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AllCoustomTheme.getHeadingThemeColors(),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                PublicCompaniesList(),
              ],
            ),
            //crypto market place section
            Visibility(
                visible: globals.isGoldBlack == false ? true : false,
                child: CryptoMarketplace()),

            //Pvt deals section
            Visibility(
                visible: globals.isGoldBlack == false ? true : false,
                child: PrivateDealsIntro(
                  goToMarketplaceCallback: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PrivateDealsMarketplaceMainPage(),
                      ),
                    );
                  },
                )),
            // investment guru component box
            // SizedBox(
            //   width: MediaQuery.of(context).size.width,
            //   height: MediaQuery.of(context).size.height * 0.57,
            //   child: Container(
            //       margin: EdgeInsets.only(left: 5.0, right: 5.0),
            //       child: ListView(
            //         physics: NeverScrollableScrollPhysics(),
            //         children: <Widget>[
            //           Padding(
            //             padding: EdgeInsets.only(top: 10.0),
            //             child: Center(
            //                 child: Text(
            //               'INVESTMENT GURUS',
            //               style: new TextStyle(
            //                 color: AllCoustomTheme.getHeadingThemeColors(),
            //                 fontSize: ConstanceData.SIZE_TITLE18,
            //                 fontFamily: "Rosarivo",
            //               ),
            //             )),
            //           ),
            //           Container(
            //             margin: EdgeInsets.only(
            //                 left: MediaQuery.of(context).size.width * 0.12,
            //                 right: MediaQuery.of(context).size.width * 0.12),
            //             padding: EdgeInsets.only(
            //               bottom: 3, // space between underline and text
            //             ),
            //             decoration: BoxDecoration(
            //                 border: Border(
            //                     bottom: BorderSide(
            //               color: AllCoustomTheme.getHeadingThemeColors(),
            //               width: 1.0, // Underline width
            //             ))),
            //           ),
            //           SizedBox(
            //               width: MediaQuery.of(context).size.width,
            //               height: MediaQuery.of(context).size.height * 0.34,
            //               child: Container(
            //                 margin: EdgeInsets.only(
            //                     top: 15.0, left: 5.0, right: 5.0, bottom: 5.0),
            //                 child: getAreaChartView(),
            //               )),
            //           Container(
            //               child: Row(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: <Widget>[
            //               Padding(
            //                   padding: EdgeInsets.only(
            //                       left: 230.0, bottom: 5.0, top: 3.0),
            //                   child: Text(
            //                     'See More',
            //                     style: new TextStyle(
            //                       color: AllCoustomTheme.getSeeMoreThemeColor(),
            //                       fontSize: ConstanceData.SIZE_TITLE15,
            //                       fontFamily: "Roboto",
            //                     ),
            //                   )),
            //             ],
            //           )),
            //           SizedBox(
            //             height: 20,
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(
            //                 bottom: 20, left: 20, right: 20),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: <Widget>[
            //                 SizedBox(
            //                   height:
            //                       MediaQuery.of(context).size.height * 0.065,
            //                   child: Container(
            //                     height:
            //                         MediaQuery.of(context).size.height * 0.065,
            //                     width: MediaQuery.of(context).size.width * 0.45,
            //                     decoration: BoxDecoration(
            //                         borderRadius:
            //                             BorderRadius.all(Radius.circular(20)),
            //                         border: new Border.all(
            //                             color:
            //                                 AllCoustomTheme.getButtonBoxColor(),
            //                             width: 1.5),
            //                         color: AllCoustomTheme.getButtonBoxColor()),
            //                     child: MaterialButton(
            //                       splashColor: Colors.grey,
            //                       child: Text(
            //                         "START NOW",
            //                         style: TextStyle(
            //                           color: AllCoustomTheme
            //                               .getButtonTextThemeColors(),
            //                           fontSize: ConstanceData.SIZE_TITLE13,
            //                           fontFamily: "Roboto",
            //                           fontWeight: FontWeight.bold,
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ],
            //       )),
            // ),
            // pe/vc/re component box
            // SizedBox(
            //   width: MediaQuery.of(context).size.width,
            //   height: MediaQuery.of(context).size.height * 0.27,
            //   child: Container(
            //       margin: EdgeInsets.only(left: 5.0, right: 5.0),
            //       child: ListView(
            //         physics: NeverScrollableScrollPhysics(),
            //         children: <Widget>[
            //           Padding(
            //             padding: EdgeInsets.only(top: 5.0),
            //             child: Center(
            //                 child: Text(
            //               'PE/VC/RE/ESG',
            //               style: new TextStyle(
            //                 color: AllCoustomTheme.getHeadingThemeColors(),
            //                 fontSize: ConstanceData.SIZE_TITLE18,
            //                 fontFamily: "Rosarivo",
            //               ),
            //             )),
            //           ),
            //           Container(
            //             // margin: EdgeInsets.only(left: 90.0,right: 90.0),
            //             margin: EdgeInsets.only(
            //                 left: MediaQuery.of(context).size.width * 0.25,
            //                 right: MediaQuery.of(context).size.width * 0.25),
            //
            //             padding: EdgeInsets.only(
            //               bottom: 3, // space between underline and text
            //             ),
            //             decoration: BoxDecoration(
            //                 border: Border(
            //                     bottom: BorderSide(
            //               color: AllCoustomTheme.getHeadingThemeColors(),
            //               width: 1.0, // Underline width
            //             ))),
            //           ),
            //           SizedBox(
            //             height: 30,
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(
            //                 bottom: 20, left: 20, right: 20),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: <Widget>[
            //                 SizedBox(
            //                   height:
            //                       MediaQuery.of(context).size.height * 0.065,
            //                   child: Container(
            //                     height:
            //                         MediaQuery.of(context).size.height * 0.065,
            //                     width: MediaQuery.of(context).size.width * 0.45,
            //                     decoration: BoxDecoration(
            //                         borderRadius:
            //                             BorderRadius.all(Radius.circular(20)),
            //                         border: new Border.all(
            //                             color:
            //                                 AllCoustomTheme.getButtonBoxColor(),
            //                             width: 1.5),
            //                         color: AllCoustomTheme.getButtonBoxColor()),
            //                     child: MaterialButton(
            //                       splashColor: Colors.grey,
            //                       child: Text(
            //                         "START NOW",
            //                         style: TextStyle(
            //                           color: AllCoustomTheme
            //                               .getButtonTextThemeColors(),
            //                           fontSize: ConstanceData.SIZE_TITLE13,
            //                           fontFamily: "Roboto",
            //                           fontWeight: FontWeight.bold,
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //           Padding(
            //               padding: EdgeInsets.only(left: 235.0),
            //               child: Text(
            //                 'See More',
            //                 style: new TextStyle(
            //                   color: AllCoustomTheme.getSeeMoreThemeColor(),
            //                   fontSize: ConstanceData.SIZE_TITLE15,
            //                   fontFamily: "Roboto",
            //                 ),
            //               )),
            //         ],
            //       )),
            // ),
            // last start now component box
            // SizedBox(
            //   width: MediaQuery.of(context).size.width,
            //   height: MediaQuery.of(context).size.height * 0.27,
            //   child: Container(
            //       margin: EdgeInsets.only(left: 5.0, right: 5.0),
            //       child: ListView(
            //         physics: NeverScrollableScrollPhysics(),
            //         children: <Widget>[
            //           Padding(
            //             padding: EdgeInsets.only(top: 5.0),
            //             child: Center(
            //                 child: Text(
            //               'STUDENT',
            //               style: new TextStyle(
            //                 color: AllCoustomTheme.getHeadingThemeColors(),
            //                 fontSize: ConstanceData.SIZE_TITLE18,
            //                 fontFamily: "Rosarivo",
            //               ),
            //             )),
            //           ),
            //           Container(
            //             // margin: EdgeInsets.only(left: 110.0,right: 110.0),
            //             margin: EdgeInsets.only(
            //                 left: MediaQuery.of(context).size.width * 0.30,
            //                 right: MediaQuery.of(context).size.width * 0.30),
            //
            //             padding: EdgeInsets.only(
            //               bottom: 3, // space between underline and text
            //             ),
            //             decoration: BoxDecoration(
            //                 border: Border(
            //                     bottom: BorderSide(
            //               color: AllCoustomTheme.getHeadingThemeColors(),
            //               width: 1.0, // Underline width
            //             ))),
            //           ),
            //           SizedBox(
            //             height: 30,
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(
            //                 bottom: 20, left: 20, right: 20),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: <Widget>[
            //                 SizedBox(
            //                   height:
            //                       MediaQuery.of(context).size.height * 0.065,
            //                   child: Container(
            //                     height:
            //                         MediaQuery.of(context).size.height * 0.065,
            //                     width: MediaQuery.of(context).size.width * 0.45,
            //                     decoration: BoxDecoration(
            //                         borderRadius:
            //                             BorderRadius.all(Radius.circular(20)),
            //                         border: new Border.all(
            //                             color:
            //                                 AllCoustomTheme.getButtonBoxColor(),
            //                             width: 1.5),
            //                         color: AllCoustomTheme.getButtonBoxColor()),
            //                     child: MaterialButton(
            //                       splashColor: Colors.grey,
            //                       child: Text(
            //                         "START NOW",
            //                         style: TextStyle(
            //                           color: AllCoustomTheme
            //                               .getButtonTextThemeColors(),
            //                           fontSize: ConstanceData.SIZE_TITLE13,
            //                           fontFamily: "Roboto",
            //                           fontWeight: FontWeight.bold,
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ],
            //       )),
            // ),
          ],
        ));
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
            padding: const EdgeInsets.only(right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      // print("gschascvkajsc");
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (BuildContext context) => AddEditQus(),
                        ),
                      );
                    },
                    child: Text(
                      "Ask question",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AllCoustomTheme.getSeeMoreThemeColor(),
                        fontSize: ConstanceData.SIZE_TITLE16,
                        fontFamily: "Roboto",
                      ),
                    ))
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
            margin: EdgeInsets.only(left: 10.0, right: 3.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  onTap: (index) {
                    selectedTabIndex = index;
                  },
                  labelColor: AllCoustomTheme.getTextThemeColor(),
                  labelStyle: TextStyle(fontSize: 14.0, letterSpacing: 0.2),
                  indicatorColor: AllCoustomTheme.getTextThemeColor(),
                  indicatorWeight: 4.0,
                  // unselectedLabelColor: StyleTheme.Colors.AppBarTabTextColor,
                  tabs: <Widget>[
                    new Tab(text: "Recommended"),
                    new Tab(text: "Coined"),
                    new Tab(text: "Buzzing"),
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

  Widget getQuestionsList(data) {
    if (data != null && data.length != 0) {
      return new ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // question section
              GestureDetector(
                onTap: () {
                  List<TagData> itemList = List();

                  itemList.add(TagData("1", "native"));
                  itemList.add(TagData("2", "fixed"));

                  var tempField = {
                    "id": "${data[index]['id']}",
                    "title": "${data[index]['title']}",
                    "body": "${data[index]['question']}",
                    "vote": "${data[index]['vote']}",
                    "totalAns": "${data[index]['no. of answer']}",
                    "tags": itemList,
                  };

                  print("QusDetail tempField: $tempField");
                  // data[index]
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (BuildContext context) =>
                          QusDetail(allParams: tempField),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        "${data[index]['question']}",
                        style: TextStyle(
                            color: AllCoustomTheme.getNewSecondTextThemeColor(),
                            fontSize: ConstanceData.SIZE_TITLE16,
                            fontFamily: "Rosarivo",
                            fontStyle: FontStyle.normal,
                            letterSpacing: 0.2),
                      ),
                    ))
                  ],
                ),
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
                    width: 15,
                  ),
                  Container(
                    child: Icon(
                      Icons.comment_bank_sharp,
                      color: AllCoustomTheme.getTextThemeColor(),
                    ),
                  ),
                  Container(
                    child: new Text(
                      "${data[index]['no. of answer']}",
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
                      Icons.remove_red_eye_outlined,
                      color: AllCoustomTheme.getTextThemeColor(),
                    ),
                  ),
                  Container(
                    child: new Text(
                      "0",
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
                    width: 15,
                  ),
                  Container(
                    child: Icon(
                      Icons.arrow_upward,
                      color: AllCoustomTheme.getThemeData().textSelectionColor,
                    ),
                  ),
                  Container(
                    child: new Text(
                      "${data[index]['vote']}",
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
                      Icons.arrow_downward,
                      color: AllCoustomTheme.getTextThemeColor(),
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
                  itemBuilder: (context, index) {
                    return Container(
                        decoration: BoxDecoration(
                            color: AllCoustomTheme.getThemeData()
                                .textSelectionColor,
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                                color: AllCoustomTheme.getThemeData()
                                    .textSelectionColor,
                                width: 1.0)),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                '${tagItemList[index]}',
                                // data[index]['tags']
                                style: TextStyle(
                                    color: AllCoustomTheme.getTextThemeColor(),
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.normal,
                                    height: 1.3),
                              ),
                            ),
                          ],
                        ));
                  },
                ),
              ),
            ],
          );
        },
      );
    } else {
      return Center(
          child: Text(
        "No data available yet",
        textAlign: TextAlign.center,
        style: new TextStyle(
          color: AllCoustomTheme.getTextThemeColors(),
          fontSize: ConstanceData.SIZE_TITLE18,
          fontFamily: "Rasa",
        ),
      ));
    }
  }

  Widget recommended() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 8.0,
          ),
          // random images
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: new Image(
                    height: 115,
                    width: 150.0,
                    fit: BoxFit.fill,
                    image: new AssetImage('assets/arqade.jpeg')),
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
                          image: new AssetImage('assets/language.png')),
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
                          image: new AssetImage('assets/android.png')),
                      SizedBox(
                        width: 5,
                      ),
                      new Image(
                          height: 40,
                          width: 40.0,
                          fit: BoxFit.fill,
                          image: new AssetImage('assets/askUbuntu.png')),
                    ],
                  )
                ],
              )),
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
                          image: new AssetImage('assets/askUbuntu.png')),
                      SizedBox(
                        width: 5,
                      ),
                      new Image(
                          height: 40,
                          width: 40.0,
                          fit: BoxFit.fill,
                          image: new AssetImage('assets/android.png')),
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
                          image: new AssetImage('assets/arqade.jpeg')),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                ],
              )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: Scrollbar(
                      child: getQuestionsList(questionsList),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget trending() {
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
    ));
  }

  Widget week() {
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
    ));
  }

  Widget month() {
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
    ));
  }

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

  Widget weekly() {
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

  // ignore: missing_return
  Widget _getPage(Tab tab) {
    switch (tab.text) {
      case 'Recommended':
        return recommended();
      case 'Coined':
        return trending();
      case 'Buzzing':
        return week();
      case 'Month':
        return month();
      // case 'Ask Question': return askQus();
    }
  }

  // fourth screen section end

  Widget getUserDropDownList() {
    if (userList != null && userList.length != 0) {
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
            )),
      );
    } else {
      return Container(
        height: 0.0,
        width: 0.0,
      );
    }
  }

  Widget getUserField() {
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
                color: AllCoustomTheme.getTextThemeColors()),
            errorText: state.hasError ? state.errorText : null,
          ),
          isEmpty: selectedUser == '',
          child: getUserDropDownList(),
        );
      },
      validator: (val) {
        return ((val != null && val != '') ||
                (selectedUser != null && selectedUser != ''))
            ? null
            : 'choose One';
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
                      _homeScaffoldKey.currentState.openDrawer();
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
                        color: AllCoustomTheme.getTextThemeColors()),
                    labelStyle: TextStyle(
                        fontSize: ConstanceData.SIZE_TITLE16,
                        color: AllCoustomTheme.getTextThemeColors()),
                  ),
                ),
              ),
/*            Container(
              child: displayModalBottomSheet(context),
            ),*/
            ],
          )),
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
                      backgroundColor:
                          AllCoustomTheme.getsecoundTextThemeColor(),
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
                      backgroundColor:
                          AllCoustomTheme.getsecoundTextThemeColor(),
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
                      backgroundColor:
                          AllCoustomTheme.getsecoundTextThemeColor(),
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
                    padding: EdgeInsets.only(top: 10.0),
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
                  onTap: () {
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
                    padding: EdgeInsets.only(top: 10.0),
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
                  onTap: () {
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
                  padding: EdgeInsets.only(top: 10.0),
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
                  padding: EdgeInsets.only(top: 10.0),
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
                      padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                      child: Center(
                        child: Text(
                          'Create a poll',
                          style: TextStyle(
                            color: AllCoustomTheme.getTextThemeColors(),
                            fontSize: ConstanceData.SIZE_TITLE18,
                          ),
                        ),
                      ),
                    ))
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

  Widget getInceptionMemberView(data) {
    return new ListView.builder(
      itemCount: data.length,
      // physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Card(
          // color: AllCoustomTheme.getsecoundTextThemeColor(),
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
                      color: AllCoustomTheme.getTextThemeColor(),
                      fontSize: ConstanceData.SIZE_TITLE16,
                      fontFamily: "Roboto",
                      package: 'Roboto-Regular',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
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
                    onTap: () {},
                    child: Image(
                      image: AssetImage('assets/badgeStar.jpg'),
                      fit: BoxFit.fill,
                      height: 30,
                      width: 40,
                    ),
                  ),
                ],
              ),
              onTap: () {}),
        );
      },
    );
  }

  Widget getWeeklyLeagueMemberView(data) {
    return new ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Card(
          // color: AllCoustomTheme.getsecoundTextThemeColor(),
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
                      color: AllCoustomTheme.getTextThemeColor(),
                      fontSize: ConstanceData.SIZE_TITLE16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Image(
                      image: AssetImage('assets/buttonBadge.png'),
                      fit: BoxFit.fill,
                      height: 30,
                      width: 30,
                    ),
                  ),
                ],
              ),
              onTap: () {}),
        );
      },
    );
  }

  Widget fifthScreen() {
    List<String> snapShotFields = [
      "user_easy_terms",
      "user_intermedate_terms",
      "user_hard_terms",
    ];
    List<ChartData> renderedChartData = [];
    List<ChartData> chartData = [
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
      {"name": "green", "measure": "741 XP"},
      {"name": "alena", "measure": "716 XP"},
      {"name": "tat 1 anna", "measure": "488 XP"},
      {"name": "kristie", "measure": "413 XP"},
      {"name": "piotr", "measure": "304 XP"},
    ];

    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          // auro stars section

          //Pvt deals section
          Visibility(
              visible: globals.isGoldBlack,
              child: PrivateDealsIntro(
                goToMarketplaceCallback: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PrivateDealsMarketplaceMainPage(),
                    ),
                  );
                },
              )),

          //crypto market place section
          Visibility(visible: globals.isGoldBlack, child: CryptoMarketplace()),

          // public equities section

          // score board section start
          Visibility(
              visible: globals.isGoldBlack == false ? true : false,
              child: Column(
                children: [
                  Container(
                    height: 30,
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
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.25,
                        right: MediaQuery.of(context).size.width * 0.25),
                    padding: EdgeInsets.only(
                      bottom: 3, // space between underline and text
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: AllCoustomTheme.getHeadingThemeColors(),
                      width: 1.0, // Underline width
                    ))),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  //donut chart box
                  FutureBuilder(
                    future: _featuredCompaniesProvider.getUserCoinsScoreData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        int index = 0;
                        print(snapshot.data);
                        chartData.forEach((element) {
                          // if (index == 0) {
                          //   print("ignore field");
                          // } else {
                          renderedChartData.add(
                            ChartData(
                              element.x,
                              (snapshot.data[snapShotFields[index]].length - 1)
                                  .toDouble(),
                              element.color,
                            ),
                          );
                          // }
                        });

                        if (snapshot.data["user_score"] == 0) {
                          return Container(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.10,
                                right: MediaQuery.of(context).size.width * 0.10,
                                top: MediaQuery.of(context).size.height * 0.04,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.04),
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color(0xFF7499C6),
                                width: 1,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(2.0),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 15.0,
                                ),
                                InkWell(
                                    child: Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.28,
                                      right: MediaQuery.of(context).size.width *
                                          0.28),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                    size: 70,
                                  ),
                                )),
                                SizedBox(
                                  height: 25.0,
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.03),
                                    child: Text(
                                      "Answer your first question and start earning Auro coins",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: AllCoustomTheme
                                              .getNewSecondTextThemeColor(),
                                          fontSize: 14.5,
                                          fontFamily: "Roboto",
                                          fontStyle: FontStyle.normal,
                                          letterSpacing: 0.2),
                                    )),
                                SizedBox(
                                  height: 10.0,
                                ),
                                // Container(
                                //   height: MediaQuery.of(context).size.height *
                                //       0.053,
                                //   width:
                                //       MediaQuery.of(context).size.width * 0.40,
                                //   margin: EdgeInsets.only(
                                //       left: MediaQuery.of(context).size.width *
                                //           0.24,
                                //       right: MediaQuery.of(context).size.width *
                                //           0.24),
                                //   decoration: BoxDecoration(
                                //       borderRadius:
                                //           BorderRadius.all(Radius.circular(20)),
                                //       border: new Border.all(
                                //           color: AllCoustomTheme
                                //               .getButtonBoxColor(),
                                //           width: 1.5),
                                //       color:
                                //           AllCoustomTheme.getButtonBoxColor()),
                                //   child: MaterialButton(
                                //     splashColor: Colors.grey,
                                //     child: Text(
                                //       "Earn Coins",
                                //       style: TextStyle(
                                //         color: AllCoustomTheme
                                //             .getButtonTextThemeColors(),
                                //         fontSize: ConstanceData.SIZE_TITLE13,
                                //         fontFamily: "Roboto",
                                //         fontWeight: FontWeight.bold,
                                //       ),
                                //     ),
                                //     onPressed: () async {
                                //       Navigator.of(context).push(
                                //         CupertinoPageRoute(
                                //           builder: (BuildContext context) =>
                                //               PortfolioPitch(),
                                //         ),
                                //       );
                                //     },
                                //   ),
                                // ),
                                SizedBox(
                                  height: 10.0,
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.30,
                              margin: EdgeInsets.only(left: 15.0, right: 5.0),
                              child: Stack(
                                children: [
                                  SfCircularChart(
                                    series: <CircularSeries>[
                                      // Renders doughnut chart
                                      DoughnutSeries<ChartData, String>(
                                        dataSource: renderedChartData,
                                        pointColorMapper: (ChartData data, _) =>
                                            data.color,
                                        xValueMapper: (ChartData data, _) =>
                                            data.x,
                                        yValueMapper: (ChartData data, _) =>
                                            data.y,
                                        dataLabelSettings: DataLabelSettings(
                                          showZeroValue: true,
                                          isVisible: true,
                                          borderColor: Colors.green,
                                        ),
                                      )
                                    ],
                                  ),
                                  new Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.11),
                                        child: Column(
                                          children: [
                                            Center(
                                              child: Text(
                                                '${snapshot.data["user_score"]}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: AllCoustomTheme
                                                      .getTextThemeColor(),
                                                  fontSize: ConstanceData
                                                      .SIZE_TITLE16,
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
                                                  color: AllCoustomTheme
                                                      .getTextThemeColor(),
                                                  fontSize: ConstanceData
                                                      .SIZE_TITLE16,
                                                  fontFamily: "Roboto",
                                                  package: 'Roboto-Regular',
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                  InkWell(
                                    child: new Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                          height: 30,
                                          width: 70,
                                          margin: EdgeInsets.only(
                                              top: 20.0, bottom: 20.0),
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
                                                color: AllCoustomTheme
                                                    .getsecoundTextThemeColor(),
                                                fontSize:
                                                    ConstanceData.SIZE_TITLE16,
                                                fontFamily: "Roboto",
                                                package: 'Roboto-Regular',
                                              ),
                                            ),
                                          )),
                                    ),
                                    onTap: () {
                                      // goToQuestionTemp();
                                    },
                                  ),
                                  new Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Container(
                                        height: 30,
                                        width: 110,
                                        margin: EdgeInsets.only(
                                            top: 20.0, bottom: 20.0),
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
                                              color: AllCoustomTheme
                                                  .getsecoundTextThemeColor(),
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE15,
                                              fontFamily: "Roboto",
                                              package: 'Roboto-Regular',
                                            ),
                                          ),
                                        )),
                                  ),
                                  new Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                        height: 30,
                                        width: 70,
                                        margin: EdgeInsets.only(
                                            top: 60.0, bottom: 40.0),
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
                                              color: AllCoustomTheme
                                                  .getsecoundTextThemeColor(),
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE16,
                                              fontFamily: "Roboto",
                                              package: 'Roboto-Regular',
                                            ),
                                          ),
                                        )),
                                  )
                                ],
                              ));
                        }
                      } else {
                        return Container(
                          child: Text("Fetching your Auro Score..."),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                              height: 30,
                              decoration: new BoxDecoration(
                                color:
                                    AllCoustomTheme.getsecoundTextThemeColor(),
                                border: Border.all(
                                  color: AllCoustomTheme
                                      .getsecoundTextThemeColor(),
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
                                    color: AllCoustomTheme
                                        .getSubHeadingThemeColors(),
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                    fontFamily: "Roboto",
                                    package: 'Roboto-Regular',
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            child: InkWell(
                          onTap: () async {
                            HelperClass.showLoading(context);
                            Question questions = await getQuestions();
                            if (questions == null) {
                              Navigator.pop(context);
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (_) => ErrorPage(
                                        message:
                                            "There are not enough questions yet.",
                                      )));
                              return;
                            }
                            Navigator.pop(context);
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (BuildContext context) =>
                                    QuestionTemplate(questions: questions),
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
                              )),
                        )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                ],
              )),
          // score board section end

          // investment track record
/*          Padding(
              padding: EdgeInsets.only(top: 0.0),
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
              )),
          Container(
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.10,
                right: MediaQuery.of(context).size.width * 0.10),
            padding: EdgeInsets.only(
              bottom: 3, // space between underline and text
            ),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: AllCoustomTheme.getHeadingThemeColors(),
              width: 1.0, // Underline width
            ))),
          ),
          SizedBox(
            height: 10,
          ),
          //pie chart with tabs
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.65,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (BuildContext context) =>
                                    AuroStrikeBadges(),
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
                    width: MediaQuery.of(context).size.width * 0.4,
                    margin: EdgeInsets.only(left: 180.0, right: 3.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TabBar(
                          controller: _tabController,
                          isScrollable: true,
                          onTap: (index) {
                            selectedTabIndex = index;
                          },
                          labelColor: AllCoustomTheme.getTextThemeColor(),
                          labelStyle:
                              TextStyle(fontSize: 16.0, letterSpacing: 0.2),
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
                                        textStyle: TextStyle(
                                            color: AllCoustomTheme
                                                .getTextThemeColor()),
                                        alignment: ChartAlignment.center,
                                        position: LegendPosition.bottom,
                                        overflowMode:
                                            LegendItemOverflowMode.wrap,
                                        itemPadding: 10.0),
                                    series: <CircularSeries>[
                                      // Render pie chart
                                      DoughnutSeries<ChartData, String>(
                                        dataSource: trackChartData,
                                        pointColorMapper: (ChartData data, _) =>
                                            data.color,
                                        xValueMapper: (ChartData data, _) =>
                                            data.x,
                                        yValueMapper: (ChartData data, _) =>
                                            data.y,
                                        dataLabelSettings: DataLabelSettings(
                                          isVisible: true,
                                        ),
                                      )
                                    ]),
                                new Align(
                                    alignment: Alignment.topCenter,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          CupertinoPageRoute(
                                            builder: (BuildContext context) =>
                                                InvestedAssetModule(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        // margin: EdgeInsets.only(top:115),
                                        margin: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.18),
                                        child: Column(
                                          children: [
                                            Center(
                                              child: Text(
                                                '800',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: AllCoustomTheme
                                                      .getTextThemeColor(),
                                                  fontSize: ConstanceData
                                                      .SIZE_TITLE16,
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
                                                  color: AllCoustomTheme
                                                      .getTextThemeColor(),
                                                  fontSize: ConstanceData
                                                      .SIZE_TITLE16,
                                                  fontFamily: "Roboto",
                                                  package: 'Roboto-Regular',
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          );
                        }).toList(),
                        physics: ScrollPhysics(),
                      ),
                    ),
                  ),
                ],
              )),
          // inception to data league
          SizedBox(
            height: 20,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 16, right: 5.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
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
                        )),
                    Container(
                      // margin: EdgeInsets.only(right: 130.0),
                      margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.28),

                      padding: EdgeInsets.only(
                        bottom: 3, // space between underline and text
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: AllCoustomTheme.getHeadingThemeColors(),
                        width: 1.0, // Underline width
                      ))),
                    ),
                  ],
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 13, right: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 160,
                ),
                Expanded(child: new FormField(
                  builder: (FormFieldState state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueGrey, width: 1.0),
                        ),
                        labelStyle:
                            AllCoustomTheme.getDropDownFieldLabelStyleTheme(),
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
                            items: <String>[
                              'Total Coins',
                              'Invest Edu coins',
                              'Track Record coins',
                              'Stock Pitch coins',
                              'Invest Q&A coins',
                              'Social Invest coins'
                            ].map((String value) {
                              return new DropdownMenuItem(
                                value: value,
                                child: new Text(value,
                                    style: AllCoustomTheme
                                        .getDropDownMenuItemStyleTheme()),
                              );
                            }).toList(),
                          ),
                        ),
                      )),
                    );
                  },
                )),
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
            padding: const EdgeInsets.only(left: 13, right: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: Scrollbar(
                        child: getInceptionMemberView(inceptionMemberList),
                      )),
                ),
              ],
            ),
          ),*/
          //Auro Streak section start
          Visibility(
              visible: globals.isGoldBlack == false ? true : false,
              child: Column(
                children: [
                  // weekly auro strike
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 16, right: 5.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
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
                                )),
                            Container(
                              margin: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width * 0.42),
                              padding: EdgeInsets.only(
                                bottom: 3, // space between underline and text
                              ),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                color: AllCoustomTheme.getHeadingThemeColors(),
                                width: 1.0, // Underline width
                              ))),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13, right: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.10,
                              child: Scrollbar(
                                child: ListView.builder(
                                  itemCount: 10,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                          var tempField = {
                                            "rankingNum": "1",
                                            "name": "Warren Buffet",
                                            "philosophy":
                                                "Buy companies at a low price, improve them via management and make long term gains",
                                            "trackRecord":
                                                "He has a 30-year-plus track record making on average 20 percent a year",
                                            "image": "WarrenBuffet"
                                          };
                                          print("tempfield: $tempField");
                                          Navigator.of(context).push(
                                            CupertinoPageRoute(
                                              builder: (BuildContext context) =>
                                                  ClubDetail(
                                                      allField: tempField),
                                            ),
                                          );
                                        },
                                        child: Container(
                                            child: Row(
                                          children: [
                                            Stack(
                                              alignment: Alignment.topLeft,
                                              children: <Widget>[
                                                CircleAvatar(
                                                  radius: 25.0,
                                                  backgroundImage: index == 0
                                                      ? new AssetImage(
                                                          'assets/filledweeklyAuroBadge.png')
                                                      : new AssetImage(
                                                          'assets/weeklyAuroBadge.png'),
                                                  backgroundColor:
                                                      Colors.transparent,
                                                ),
                                                Positioned(
                                                  bottom: 25,
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.blue,
                                                    radius: 12.0,
                                                    child: Text(
                                                      "${index + 1}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFFD8AF4F),
                                                        fontSize: ConstanceData
                                                            .SIZE_TITLE18,
                                                        fontFamily: "Roboto",
                                                        package:
                                                            'Roboto-Regular',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                /*                                          FractionalTranslation(
                                              translation: Offset(0.0, -0.99),
                                              child: CircleAvatar(
                                                backgroundColor: Colors.blue,
                                                radius: 12.0,
                                                child: Text(
                                                  "${index + 1}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xFFD8AF4F),
                                                    fontSize: ConstanceData.SIZE_TITLE18,
                                                    fontFamily: "Roboto",
                                                    package: 'Roboto-Regular',
                                                  ),
                                                ),
                                              ),
                                            )*/
                                              ],
                                            ),
                                            SizedBox(
                                              width: 10,
                                            )
                                          ],
                                        )));
                                  },
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),

                  //weekly league
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 16, right: 5.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
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
                                )),
                            Container(
                              // margin: EdgeInsets.only(right: 210.0),
                              margin: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width * 0.55),
                              padding: EdgeInsets.only(
                                bottom: 3, // space between underline and text
                              ),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                color: AllCoustomTheme.getHeadingThemeColors(),
                                width: 1.0, // Underline width
                              ))),
                            ),
                          ],
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 13, right: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 110,
                        ),
                        Expanded(child: new FormField(
                          builder: (FormFieldState state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey, width: 1.0),
                                ),
                                labelStyle: AllCoustomTheme
                                    .getDropDownFieldLabelStyleTheme(),
                                errorText:
                                    state.hasError ? state.errorText : null,
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
                                    items: <String>[
                                      'Adaptive Investment Learning',
                                      'Investment Track Record',
                                      'Investment Stock Pitch',
                                      'Investment QnA',
                                      'Social Investment Score'
                                    ].map((String value) {
                                      return new DropdownMenuItem(
                                        value: value,
                                        child: new Text(value,
                                            style: AllCoustomTheme
                                                .getDropDownMenuItemStyleTheme()),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              )),
                            );
                          },
                        )),
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
                    padding: const EdgeInsets.only(left: 13, right: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.35,
                              child: Scrollbar(
                                child: getWeeklyLeagueMemberView(
                                    inceptionMemberList),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          //Auro Streak section end

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

  List<dynamic> questionsList;
  var portfolioChartData;

  // api calls section start
  Future<void> getQuestionsData() async {
    questionsList = [];
    var response = await request.getRequest('forum/get_questions');
    print("qus list: $response");
    if (response != null && response != false) {
      setState(() {
        // _AnswerList = response['answers'];
        questionsList = response['message'];
      });
    }
  }

  Future<void> getDoughnutPortfolioData() async {
    print("getDoughnutPortfolioData called");
    var response =
        await request.getRunAlgoExistingPortfolio('users/create_portfolio');
    print("portfolio chart list: $response");
    if (response != null &&
        response != false &&
        response.containsKey('auth') &&
        response['auth'] == true) {
      setState(() {
        homeDonutArray = [];
        homeDonutArray.add(1);
        homeDonutArray.add(2);
        homeDonutArray.add(3);
        homeDonutArray.add(4);
        portfolioChartData = null;
        portfolioChartData =
            response['message'] != null && response['message']['data'] != null
                // &&
                //     response['message']['algo_result'] != null
                ? response['message']
                : null;
        setHomeDoughnutChartData();
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
        homeDonutArray = [];
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
      getQuestionsData();
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
