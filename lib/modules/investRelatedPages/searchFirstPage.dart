
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/widgets/auro_stars.dart';
import 'package:auroim/widgets/crypto_marketplace/all_crypto_list.dart';
import 'package:auroim/widgets/crypto_marketplace/all_cryptocurrencies_list.dart';
import 'package:auroim/widgets/private_deals_marketplace/light_featured_companies.dart';
import 'package:auroim/widgets/private_deals_marketplace/sample_featured_companies_list.dart';
import 'package:auroim/widgets/public_companies_list.dart';
import 'package:auroim/widgets/small_tab_chip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SearchFirstPage extends StatefulWidget {
  final String callingFrom;
  final String logo;

  const SearchFirstPage({Key key, @required this.callingFrom, this.logo})
      : super(key: key);

  @override
  _SearchFirstPageState createState() => _SearchFirstPageState();
}

class _SearchFirstPageState extends State<SearchFirstPage>
    with SingleTickerProviderStateMixin {
  bool _isInProgress = false;

  int selectedTabIndex;
  String selectedTabString = "Trending";

  Map<String, bool> allTabsBool = {
    "Trending": true,
    "Unlisted": false,
    "Crypto": false,
    "Listed": false,
    "AuroStars": false,
  };

  final List<Color> color = <Color>[];
  LinearGradient gradientColors;
  final List<double> stops = <double>[];

  final List<NewSalesData> newSalesData = [
    NewSalesData(2010, 35),
    NewSalesData(2011, 28),
    NewSalesData(2012, 34),
    NewSalesData(2013, 32),
    NewSalesData(2014, 40)
  ];

  // final List<Tab> tabList = <Tab>[
  //   new Tab(text: 'Trending'),
  //   new Tab(text: 'Unlisted'),
  //   new Tab(text: 'Crypto'),
  //   new Tab(text: 'Listed'),
  //   new Tab(text: 'AuroStars'),
  // ];

  // TabController _tabController;

  @override
  void initState() {
    // _tabController = new TabController(vsync: this, length: tabList.length);
    color.add(Colors.blue[50]);
    color.add(Colors.blue[200]);
    color.add(Colors.blue);
    stops.add(0.0);
    stops.add(0.5);
    stops.add(1.0);

    gradientColors = LinearGradient(colors: color, stops: stops);
    super.initState();
    loadDetails();
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

  Widget topTrendingNews() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10.0, left: 12.0),
            child: Text(
              'Click on any of the following to start adding to your personal sleeve!',
              style: new TextStyle(
                color: AllCoustomTheme.getTextThemeColors(),
                fontSize: ConstanceData.SIZE_TITLE14,
              ),
            ),
          ),
          Container(
            // decoration: BoxDecoration(border: Border.all()),
            margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
/*            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.40,*/
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(width: 0.5),
                Container(
/*                  width: MediaQuery.of(context).size.width*0.45,
                  height: MediaQuery.of(context).size.height*0.41,*/
                  margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      //first row of small box
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            //first box of first row
                            smallItem(),
                            SizedBox(
                              width: 4.0,
                            ),
                            //second  box of first row
                            smallItem(),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.0),
                      //second row of small box
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            //first box of first row
                            smallItem(),
                            SizedBox(
                              width: 4.0,
                            ),
                            //second  box of first row
                            smallItem(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //Big Box
                bigItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setWidgetState) {
      return Container(
          // width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              height: 30,
              // color: Colors.green,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SmallTabChip(
                      tabText: "Trending",
                      selected: allTabsBool["Trending"] == true,
                      callback: () => selectedTab("Trending", setWidgetState),
                      width: 75.0,
                    ),
                    SmallTabChip(
                      tabText: "Unlisted",
                      selected: allTabsBool["Unlisted"] == true,
                      callback: () => selectedTab("Unlisted", setWidgetState),
                      width: 70.0,
                    ),
                    SmallTabChip(
                      tabText: "Crypto",
                      selected: allTabsBool["Crypto"] == true,
                      callback: () => selectedTab("Crypto", setWidgetState),
                      width: 60.0,
                    ),
                    SmallTabChip(
                      tabText: "Listed",
                      selected: allTabsBool["Listed"] == true,
                      callback: () => selectedTab("Listed", setWidgetState),
                      width: 60.0,
                    ),
                    SmallTabChip(
                      tabText: "AuroStars",
                      selected: allTabsBool["AuroStars"] == true,
                      callback: () => selectedTab("AuroStars", setWidgetState),
                      width: 80.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          _getPage(selectedTabString),
        ],
      ));
    });
  }

  selectedTab(selectedKey, setWidgetState) {
    // print(selectedKey);
    setWidgetState(() {
      allTabsBool.forEach((key, value) {
        if (selectedKey == key) {
          allTabsBool[key] = true;
          selectedTabString = key;
        } else {
          allTabsBool[key] = false;
        }
      });
    });
  }

  Widget unlistedTab() {
    return Container(
      height: 265,
      // decoration: BoxDecoration(border: Border.all()),
      child: globals.isGoldBlack
          ? SampleFeaturedCompaniesList()
          : FeaturedCompaniesList(),
    );
  }

  Widget crypto() {
    return Container(
      height: 275,
      child: globals.isGoldBlack
          ? AllCryptoListBlack(sortingType: "1d",)
          : AllCryptocurrenciesList(sortingType: "1d",),
    );
  }

  Widget listed() {
    return Container(
      height: 310,
      child: PublicCompaniesList(),
    );
  }

  Widget auroStars() {
    return Container(
      height: 210,
      child: AuroStars(),
    );
  }

  Widget _getPage(String tab) {
    switch (tab) {
      case 'Trending':
        return topTrendingNews();
      case 'Unlisted':
        return unlistedTab();
      case 'Crypto':
        return crypto();
      case 'Listed':
        return listed();
      case 'AuroStars':
        return auroStars();
    }
  }

  smallItem() {
    return InkWell(
      onTap: () {
        // Navigator.of(context).push(new MaterialPageRoute(
        //     builder: (BuildContext context) =>
        //     new SecurityPageFirst(logo: widget.logo,callingFrom: widget.callingFrom,)));
      },
      child: Container(
/*                                margin: EdgeInsets.only(left: 5.0,top: 5.0),
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.19,*/
        decoration: new BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          border: Border.all(
            color: Color(0xff696969),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              // margin: EdgeInsets.only(left: 3.5),
              width: MediaQuery.of(context).size.width * 0.22,
              height: MediaQuery.of(context).size.height * 0.05,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: new Image(
                        width: 35.0,
                        fit: BoxFit.fill,
                        image: new AssetImage('assets/logo.png')),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Title',
                      style: new TextStyle(
                          fontFamily: "Poppins",
                          color: Color(0xFF000000),
                          fontSize: 12.0,
                          letterSpacing: 0.2),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: new Icon(
                      Icons.menu,
                      color: Colors.black,
                      size: 10,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // margin: EdgeInsets.only(left: 3.5),
              width: MediaQuery.of(context).size.width * 0.22,
              height: MediaQuery.of(context).size.height * 0.01,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 0.0),
                    child: Text(
                      'CHANGE(1D)',
                      style: new TextStyle(
                          fontFamily: "Poppins",
                          color: Color(0xFF000000),
                          fontSize: 7.0,
                          letterSpacing: 0.2),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 0.0),
                    child: Text(
                      '27.18',
                      style: new TextStyle(
                          fontFamily: "Poppins",
                          color: Color(0xFFe70b31),
                          fontSize: 8.0,
                          letterSpacing: 0.2),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.22,
              height: MediaQuery.of(context).size.height * 0.09,
              child: SfCartesianChart(
                primaryXAxis: NumericAxis(
                  isVisible: false,
                ),
                primaryYAxis: NumericAxis(isVisible: false),
                series: <ChartSeries>[
                  StackedAreaSeries<NewSalesData, double>(
                    dataSource: newSalesData,
                    xValueMapper: (NewSalesData data, _) => data.year,
                    yValueMapper: (NewSalesData data, _) => data.sales,
                    gradient: gradientColors,
                  ),
                ],
              ),
            ),
            Container(
              // decoration: BoxDecoration(border: Border.all()),
              width: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 40,
                    height: 15,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: new Border.all(
                            color: AllCoustomTheme.getChartBoxThemeColor(),
                            width: 1.5),
                        // color: AllCoustomTheme.getChartBoxThemeColor(),
                      ),
                      child: Center(
                        child: Text(
                          "BUY",
                          style: TextStyle(
                            color: AllCoustomTheme.getChartBoxTextThemeColor(),
                            fontSize: 8,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    height: 15,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: new Border.all(
                            color: AllCoustomTheme.getChartBoxThemeColor(),
                            width: 1.5),
                        // color: AllCoustomTheme.getChartBoxThemeColor(),
                      ),
                      child: Center(
                        child: Text(
                          "SELL",
                          style: TextStyle(
                            color: AllCoustomTheme.getChartBoxTextThemeColor(),
                            fontSize: 8,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }


  bigItem() {
    return Container(
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
/*                  width: MediaQuery.of(context).size.width*0.45,
                  height: MediaQuery.of(context).size.height*0.41,*/
      decoration: new BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        border: Border.all(
          color: Color(0xff696969),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.454,
            height: MediaQuery.of(context).size.height * 0.10,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: new Image(
                      width: 80.0,
                      fit: BoxFit.fill,
                      image: new AssetImage('assets/logo.png')),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    'Title',
                    style: new TextStyle(
                        fontFamily: "Poppins",
                        color: Color(0xFF000000),
                        fontSize: 18.0,
                        letterSpacing: 0.2),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: new Icon(
                    Icons.menu,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.454,
            height: MediaQuery.of(context).size.height * 0.03,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 0.0, left: 8.0),
                  child: Text(
                    'CHANGE(1D)',
                    style: new TextStyle(
                        fontFamily: "Poppins",
                        color: Color(0xFF000000),
                        fontSize: 14.0,
                        letterSpacing: 0.2),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.0, left: 15.0),
                  child: Text(
                    '27.18',
                    style: new TextStyle(
                        fontFamily: "Poppins",
                        color: Color(0xFFe70b31),
                        fontSize: 14.0,
                        letterSpacing: 0.2),
                  ),
                ),
              ],
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.454,
              height: MediaQuery.of(context).size.height * 0.12,
              child: Container(
                child: SfCartesianChart(
                    primaryXAxis: NumericAxis(
                      isVisible: false,
                    ),
                    primaryYAxis: NumericAxis(isVisible: false),
                    series: <ChartSeries>[
                      StackedAreaSeries<NewSalesData, double>(
                        dataSource: newSalesData,
                        xValueMapper: (NewSalesData data, _) => data.year,
                        yValueMapper: (NewSalesData data, _) => data.sales,
                        gradient: gradientColors,
                      ),
                    ]),
              )),
          Container(
            // decoration: BoxDecoration(border: Border.all()),
            width: 180,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 80,
                  height: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: new Border.all(
                          color: AllCoustomTheme.getChartBoxThemeColor(),
                          width: 1.5),
                      // color: AllCoustomTheme.getChartBoxThemeColor(),
                    ),
                    child: Center(
                      child: Text(
                        "BUY",
                        style: TextStyle(
                          color: AllCoustomTheme.getChartBoxTextThemeColor(),
                          fontSize: ConstanceData.SIZE_TITLE13,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 80,
                  height: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: new Border.all(
                          color: AllCoustomTheme.getChartBoxThemeColor(),
                          width: 1.5),
                      // color: AllCoustomTheme.getChartBoxThemeColor(),
                    ),
                    child: Center(
                      child: Text(
                        "SELL",
                        style: TextStyle(
                          color: AllCoustomTheme.getChartBoxTextThemeColor(),
                          fontSize: ConstanceData.SIZE_TITLE13,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
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
        ],
      ),
    );
  }
}
