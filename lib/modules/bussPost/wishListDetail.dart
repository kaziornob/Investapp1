import 'dart:convert';
import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/global.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/graphDetail/OHLCVGraph.dart';
import 'package:auroim/graphDetail/QuickPercentChangeBar.dart';
import 'package:auroim/model/listingsModel.dart';
import 'package:auroim/modules/bussPost/tradeForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;


List marketListData = [];

class WishListDetail extends StatefulWidget {

  @override
  _WishListDetailState createState() => _WishListDetailState();
}

class _WishListDetailState extends State<WishListDetail> with SingleTickerProviderStateMixin {
  bool _isInProgress = false;

  int selectedTabIndex;


  final List<Tab> tabList = <Tab>[
    new Tab(text: 'Posts'),
    new Tab(text: 'Overview'),
    new Tab(text: 'Graph'),
    new Tab(text: 'Filter')
  ];

  TabController _tabController;

  String historyAmt = "720";
  String historyType = "minute";
  String historyTotal = "24h";
  String historyAgg = "2";
  String symbol = 'BTC';
  String _high = "0";
  String _low = "0";
  String _change = "0";
  bool allCoin = false;


  List historyOHLCV;
  USD generalStats;
  int currentOHLCVWidthSetting = 0;

  List<CryptoCoinDetail> lstCryptoCoinDetail = [];




  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: tabList.length);
    super.initState();
    loadDetails();
    callItself();
  }

  loadDetails() async {
    setState(() {
      _isInProgress = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      _isInProgress = false;
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

  Widget postView()
  {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 12.0,right: 3.0),
            decoration: BoxDecoration(
              color: AllCoustomTheme.getsecoundTextThemeColor(),
              border: new Border.all(
                  color: AllCoustomTheme.getsecoundTextThemeColor(),
                  width: 1.5),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  FontAwesomeIcons.pinterestP,
                  size: 20,
                  color: AllCoustomTheme.getTextThemeColors(),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Pinned Post',
                  style: new TextStyle(
                    color: AllCoustomTheme.getTextThemeColors(),
                    fontSize: ConstanceData.SIZE_TITLE14,
                  ),
                ),
                SizedBox(
                  width: 200,
                ),
                Icon(
                  FontAwesomeIcons.gripVertical,
                  size: 20,
                  color: Colors.grey,
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),//or 15.0
                    child: Container(
                      height: 40.0,
                      width: 50.0,
                      color: Color(0xffFF0E58),
                      child:  Image(
                        image: AssetImage('assets/download.jpeg'),
                        fit: BoxFit.fill,
                        height: 40,
                        width: 50,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "@ Andy Cleaver",
                                  style: new TextStyle(
                                    color: Colors.blue,
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                  ),
                                ),
                              ],
                            )
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "United Kingdom",
                                  style: new TextStyle(
                                    color: AllCoustomTheme.getTextThemeColors(),
                                    fontSize: ConstanceData.SIZE_TITLE12,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  FontAwesomeIcons.dotCircle,
                                  size: 10,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "6 days ago",
                                  style: new TextStyle(
                                    color: Colors.blue,
                                    fontSize: ConstanceData.SIZE_TITLE14,
                                  ),
                                ),
                              ],
                            )
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Is Tesla Overvalued ? ",
                    style: new TextStyle(
                      color: AllCoustomTheme.getTextThemeColors(),
                      fontSize: ConstanceData.SIZE_TITLE14,
                      fontStyle: FontStyle.italic
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ReadMoreText(
                    "One of the most common questions asked about is whether is not or not is overvalued",
                    trimLines: 2,
                    colorClickableText: Colors.blue,
                    style: TextStyle(
                      color: AllCoustomTheme.getTextThemeColors(),
                      fontSize: ConstanceData.SIZE_TITLE14,
                    ),
                    trimMode: TrimMode.Line,
                    trimCollapsedText: '...Show more',
                    trimExpandedText: ' Show less',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Image(
                fit: BoxFit.fill,
                image: new AssetImage('assets/handShake.png')
            ),
          ),
        ],
      ),
    );
  }

  Widget overView()
  {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0,left: 15.0),
            child: Text(
              'Overview',
              style: new TextStyle(
                color: AllCoustomTheme.getTextThemeColors(),
                fontSize: ConstanceData.SIZE_TITLE16,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 10.0,left: 15.0,right: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Prev Close',
                        style: new TextStyle(
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: ConstanceData.SIZE_TITLE14,
                        ),
                      ),
                      Text(
                        '854.41',
                        style: new TextStyle(
                          color: Colors.grey,
                          fontSize: ConstanceData.SIZE_TITLE14,
                        ),
                      ),
                    ],
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10.0,left: 15.0,right: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Day's Range",
                        style: new TextStyle(
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: ConstanceData.SIZE_TITLE14,
                        ),
                      ),
                      Text(
                        '854.41',
                        style: new TextStyle(
                          color: Colors.grey,
                          fontSize: ConstanceData.SIZE_TITLE14,
                        ),
                      ),
                    ],
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10.0,left: 15.0,right: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '52 Week Range',
                        style: new TextStyle(
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: ConstanceData.SIZE_TITLE14,
                        ),
                      ),
                      Text(
                        '854.41',
                        style: new TextStyle(
                          color: Colors.grey,
                          fontSize: ConstanceData.SIZE_TITLE14,
                        ),
                      ),
                    ],
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10.0,left: 15.0,right: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Average Volumne',
                        style: new TextStyle(
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: ConstanceData.SIZE_TITLE14,
                        ),
                      ),
                      Text(
                        '854.41',
                        style: new TextStyle(
                          color: Colors.grey,
                          fontSize: ConstanceData.SIZE_TITLE14,
                        ),
                      ),
                    ],
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10.0,left: 15.0,right: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '1-Year Return',
                        style: new TextStyle(
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: ConstanceData.SIZE_TITLE14,
                        ),
                      ),
                      Text(
                        '854.41',
                        style: new TextStyle(
                          color: Colors.grey,
                          fontSize: ConstanceData.SIZE_TITLE14,
                        ),
                      ),
                    ],
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10.0,left: 15.0,right: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Beta',
                        style: new TextStyle(
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: ConstanceData.SIZE_TITLE14,
                        ),
                      ),
                      Text(
                        '854.41',
                        style: new TextStyle(
                          color: Colors.grey,
                          fontSize: ConstanceData.SIZE_TITLE14,
                        ),
                      ),
                    ],
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10.0,left: 15.0,right: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Market Cap',
                        style: new TextStyle(
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: ConstanceData.SIZE_TITLE14,
                        ),
                      ),
                      Text(
                        '854.41',
                        style: new TextStyle(
                          color: Colors.grey,
                          fontSize: ConstanceData.SIZE_TITLE14,
                        ),
                      ),
                    ],
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10.0,left: 15.0,right: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'P/E Ratio',
                        style: new TextStyle(
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: ConstanceData.SIZE_TITLE14,
                        ),
                      ),
                      Text(
                        '854.41',
                        style: new TextStyle(
                          color: Colors.grey,
                          fontSize: ConstanceData.SIZE_TITLE14,
                        ),
                      ),
                    ],
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10.0,left: 15.0,right: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Revenue',
                        style: new TextStyle(
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: ConstanceData.SIZE_TITLE14,
                        ),
                      ),
                      Text(
                        '854.41',
                        style: new TextStyle(
                          color: Colors.grey,
                          fontSize: ConstanceData.SIZE_TITLE14,
                        ),
                      ),
                    ],
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10.0,left: 15.0,right: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'EPS',
                        style: new TextStyle(
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: ConstanceData.SIZE_TITLE14,
                        ),
                      ),
                      Text(
                        '854.41',
                        style: new TextStyle(
                          color: Colors.grey,
                          fontSize: ConstanceData.SIZE_TITLE14,
                        ),
                      ),
                    ],
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10.0,left: 15.0,right: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Dividend(Yield)',
                        style: new TextStyle(
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: ConstanceData.SIZE_TITLE14,
                        ),
                      ),
                      Text(
                        '854.41',
                        style: new TextStyle(
                          color: Colors.grey,
                          fontSize: ConstanceData.SIZE_TITLE14,
                        ),
                      ),
                    ],
                  )
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget graphView()
  {
    return Container(
      height: MediaQuery.of(context).size.height*1.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
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

  Widget filterView()
  {
    return Container(
      height: 0.0,
      width: 0.0,
      child: Center(
        child: Text(
          "Coming Soon..."
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();
    double appBarheight = appBar.preferredSize.height;
    return Stack(
      children: <Widget>[
        SafeArea(
            bottom: true,
            child: Scaffold(
              backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
              body: ModalProgressHUD(
                inAsyncCall: _isInProgress,
                opacity: 0,
                progressIndicator: CupertinoActivityIndicator(
                  radius: 12,
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: !_isInProgress
                      ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*1.2,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Row(
                              children: <Widget>[
                                InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Animator(
                                    tween: Tween<Offset>(
                                        begin: Offset(0, 0), end: Offset(0.2, 0)),
                                    duration: Duration(milliseconds: 500),
                                    cycles: 0,
                                    builder: (anim) => FractionalTranslation(
                                      translation: anim.value,
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color:
                                        AllCoustomTheme.getTextThemeColors(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),//or 15.0
                                    child: Container(
                                      height: 50.0,
                                      width: 50.0,
                                      color: Color(0xffFF0E58),
                                      child:  Image(
                                        image: AssetImage('assets/buttonBadge.png'),
                                        fit: BoxFit.fill,
                                        height: 40,
                                        width: 50,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "GREEN",
                                              style: new TextStyle(
                                                color: AllCoustomTheme.getTextThemeColors(),
                                                fontSize: ConstanceData.SIZE_TITLE16,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "|",
                                              style: new TextStyle(
                                                color: Colors.grey,
                                                fontSize: ConstanceData.SIZE_TITLE14,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Green Motors, Inc",
                                              style: new TextStyle(
                                                color: Colors.grey,
                                                fontSize: ConstanceData.SIZE_TITLE14,
                                              ),
                                            ),
                                          ],
                                        )
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "854.41",
                                              style: new TextStyle(
                                                color: AllCoustomTheme.getTextThemeColors(),
                                                fontSize: ConstanceData.SIZE_TITLE16,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "4.97 (0.57%)",
                                              style: new TextStyle(
                                                color: Colors.lightGreen,
                                                fontSize: ConstanceData.SIZE_TITLE14,
                                              ),
                                            ),
                                          ],
                                        )
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "PRICES BY NASDAQ, IN USD",
                                              style: new TextStyle(
                                                color: Colors.grey,
                                                fontSize: ConstanceData.SIZE_TITLE12,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              FontAwesomeIcons.timesCircle,
                                              size: 10,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "MARKET CLOSED",
                                              style: new TextStyle(
                                                color: Colors.grey,
                                                fontSize: ConstanceData.SIZE_TITLE10,
                                              ),
                                            ),
                                          ],
                                        )
                                      )
                                    ],
                                  )
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Container(
                                  child: Icon(
                                    FontAwesomeIcons.list,
                                    size: 25,
                                    color: Colors.grey,
                                  )
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Container(
                                  height: 30,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: AllCoustomTheme.getThemeData().textSelectionColor,
                                    border: new Border.all(color: Colors.white, width: 1.5),
                                  ),
                                  child: MaterialButton(
                                    splashColor: Colors.grey,
                                    child: Text(
                                      "TRADE",
                                      style: TextStyle(
                                        color: AllCoustomTheme.getTextThemeColors(),
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () {

                                      Navigator.of(context).push(
                                        CupertinoPageRoute(
                                          builder: (BuildContext context) => TradeForm(),
                                        ),
                                      );

                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5.0),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TabBar(
                                  controller: _tabController,
                                  onTap: (index)
                                  {
                                    selectedTabIndex = index;
                                  },
                                  labelColor: AllCoustomTheme.getTextThemeColors(),
                                  labelStyle: TextStyle(fontSize: 17.0,letterSpacing: 0.2),
                                  indicatorColor: AllCoustomTheme.getTextThemeColors(),
                                  indicatorWeight: 4.0,
                                  isScrollable: true,
                                  unselectedLabelColor: Colors.grey,
                                  tabs: <Widget>[
                                    Container(
                                      width: 50,
                                      height: 50,
                                      child: new Tab(
                                        icon: Icon(
                                            FontAwesomeIcons.briefcase
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 50,
                                      height: 50,
                                      child: new Tab(
                                        icon: Icon(
                                            FontAwesomeIcons.chartBar
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 50,
                                      height: 50,
                                      child: new Tab(
                                        icon: Icon(
                                            FontAwesomeIcons.arrowsAltV
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 50,
                                      height: 50,
                                      child: new Tab(
                                        icon: Icon(
                                            FontAwesomeIcons.filter
                                        ),
                                      ),
                                    ),
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
                          )
                        ],
                      )
                  )
                      : SizedBox(),
                ),
              ),
            )
        )
      ],
    );
  }

  // ignore: missing_return
  Widget _getPage(Tab tab){
    switch(tab.text){
      case 'Posts': return postView();
      case 'Overview': return overView();
      case 'Graph': return graphView();
      case 'Filter': return filterView();

    }
  }
}



enum TrimMode {
  Length,
  Line,
}

class ReadMoreText extends StatefulWidget {
  const ReadMoreText(
      this.data, {
        Key key,
        this.trimExpandedText = ' read less',
        this.trimCollapsedText = ' ...read more',
        this.colorClickableText,
        this.trimLength = 240,
        this.trimLines = 2,
        this.trimMode = TrimMode.Length,
        this.style,
        this.textAlign,
        this.textDirection,
        this.locale,
        this.textScaleFactor,
        this.semanticsLabel,
      })  : assert(data != null),
        super(key: key);

  final String data;
  final String trimExpandedText;
  final String trimCollapsedText;
  final Color colorClickableText;
  final int trimLength;
  final int trimLines;
  final TrimMode trimMode;
  final TextStyle style;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final Locale locale;
  final double textScaleFactor;
  final String semanticsLabel;

  @override
  ReadMoreTextState createState() => ReadMoreTextState();
}

const String _kEllipsis = '\u2026';

const String _kLineSeparator = '\u2028';

class ReadMoreTextState extends State<ReadMoreText> {
  bool _readMore = true;

  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle effectiveTextStyle = widget.style;
    if (widget.style == null || widget.style.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(widget.style);
    }

    final textAlign =
        widget.textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start;
    final textDirection = widget.textDirection ?? Directionality.of(context);
    final textScaleFactor =
        widget.textScaleFactor ?? MediaQuery.textScaleFactorOf(context);
    final overflow = defaultTextStyle.overflow;
    final locale =
        widget.locale ?? Localizations.localeOf(context, nullOk: true);

    final colorClickableText =
        widget.colorClickableText ?? Theme.of(context).accentColor;

    TextSpan link = TextSpan(
      text: _readMore ? widget.trimCollapsedText : widget.trimExpandedText,
      style: effectiveTextStyle.copyWith(
        color: colorClickableText,
      ),
      recognizer: TapGestureRecognizer()..onTap = _onTapLink,
    );

    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;

        // Create a TextSpan with data
        final text = TextSpan(
          style: effectiveTextStyle,
          text: widget.data,
        );

        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: link,
          textAlign: textAlign,
          textDirection: textDirection,
          textScaleFactor: textScaleFactor,
          maxLines: widget.trimLines,
          ellipsis: overflow == TextOverflow.ellipsis ? _kEllipsis : null,
          locale: locale,
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;

        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;


        // Get the endIndex of data
        bool linkLongerThanLine = false;
        int endIndex;

        if (linkSize.width < maxWidth) {
          final pos = textPainter.getPositionForOffset(Offset(
            textSize.width - linkSize.width,
            textSize.height,
          ));
          endIndex = textPainter.getOffsetBefore(pos.offset);
        } else {
          var pos = textPainter.getPositionForOffset(
            textSize.bottomLeft(Offset.zero),
          );
          endIndex = pos.offset;
          linkLongerThanLine = true;
        }

        var textSpan;
        switch (widget.trimMode) {
          case TrimMode.Length:
            if (widget.trimLength < widget.data.length) {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: _readMore
                    ? widget.data.substring(0, widget.trimLength)
                    : widget.data,
                children: <TextSpan>[link],
              );
            } else {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: widget.data,
              );
            }
            break;
          case TrimMode.Line:
            if (textPainter.didExceedMaxLines) {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: _readMore
                    ? widget.data.substring(0, endIndex) +
                    (linkLongerThanLine ? _kLineSeparator : '')
                    : widget.data,
                children: <TextSpan>[link],
              );
            } else {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: widget.data,
              );
            }
            break;
          default:
            throw Exception(
                'TrimMode type: ${widget.trimMode} is not supported');
        }

        return RichText(
          textAlign: textAlign,
          textDirection: textDirection,
          softWrap: true,
          //softWrap,
          overflow: TextOverflow.clip,
          //overflow,
          textScaleFactor: textScaleFactor,
          text: textSpan,
        );
      },
    );
    if (widget.semanticsLabel != null) {
      result = Semantics(
        label: widget.semanticsLabel,
        child: ExcludeSemantics(
          child: result,
        ),
      );
    }
    return result;
  }
}