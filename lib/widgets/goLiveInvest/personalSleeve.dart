import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/api/reusable_functions.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/modules/bussPost/portfolioPitch.dart';
import 'package:auroim/provider_abhinav/personal_sleeve_provider.dart';
import 'package:auroim/widgets/invest_tab/personal_sleeve_return_chart.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

var securityBoxChartData;

class PersonalSleeve extends StatefulWidget {
  final VoidCallback goToPersonalSleeveCallback;

  PersonalSleeve({this.goToPersonalSleeveCallback});

  @override
  _PersonalSleeveState createState() => _PersonalSleeveState();
}

class _PersonalSleeveState extends State<PersonalSleeve>
    with SingleTickerProviderStateMixin {
  ApiProvider request = new ApiProvider();
  CarouselController _carouselController = CarouselController();
  ReusableFunctions _reusableFunctions = ReusableFunctions();
  int homeDonutCurrentIndex = 0;
  List homeDonutArray = [];
  List<ChartData> homeChartData = [];
  var investorType;
  bool _isInit = true;

  int selectedTabIndex;

  // SharedPreferences prefs;
  final List<Tab> tabList = <Tab>[
    new Tab(text: 'LIVE'),
    new Tab(text: 'PAPER'),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        new TabController(vsync: this, length: tabList.length, initialIndex: 1);
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      print("personal sleeve");
      Provider.of<PersonalSleeveProvider>(context, listen: false)
          .getPortfolioData();
      // Provider.of<PersonalSleeveProvider>(context, listen: false)
      //     .getDailyReturnPortfolio();
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 600,
      margin: EdgeInsets.only(left: 5.0, right: 5.0),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 0.0),
            child: Center(
              child: Text(
                'PERSONAL SLEEVE',
                style: new TextStyle(
                  color: AllCoustomTheme.getHeadingThemeColors(),
                  fontSize: ConstanceData.SIZE_TITLE18,
                  fontFamily: "Rosarivo",
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.18,
              right: MediaQuery.of(context).size.width * 0.18,
            ),
            padding: EdgeInsets.only(
              bottom: 3, // space between underline and text
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AllCoustomTheme.getHeadingThemeColors(),
                  width: 1.0, // Underline width
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 10.0, right: 3.0, top: 30.0),
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
                  labelColor: Colors.white,
                  labelStyle: TextStyle(fontSize: 14.0, letterSpacing: 0.2),
                  indicator: new BoxDecoration(
                    color: AllCoustomTheme.getButtonBoxColor(),
                    border: Border.all(
                      color: AllCoustomTheme.getButtonBoxColor(),
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.0),
                    ),
                  ),
                  indicatorColor: AllCoustomTheme.getButtonBoxColor(),
                  indicatorWeight: 4.0,
                  // unselectedLabelColor: StyleTheme.Colors.AppBarTabTextColor,
                  tabs: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      width: 120,
                      height: 40,
                      child: Center(
                        child: Text(
                          "LIVE",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      width: 120,
                      height: 40,
                      child: Center(
                        child: Text(
                          "PAPER",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                          ),
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
              child: TabBarView(
                controller: _tabController,
                children: [
                  noPortfolioToShow("LIVE"),
                  paperTab(),
                ],
              ),
            ),
            // Container(
            //   padding: EdgeInsets.only(top: 10.0),
            //   child: TabBarView(
            //     controller: _tabController,
            //     children: [
            //       noPortfolioToShow("LIVE"),
            //       paperTab(),
            //     ],
            //
            //     // tabList.map((Tab tab) {
            //     //   print("tab text: $tab");
            //     //   return ListView(
            //     //     physics: NeverScrollableScrollPhysics(),
            //     //     children: [
            //     //       // plus, search section
            //     //       Container(
            //     //         margin: EdgeInsets.only(
            //     //           left: MediaQuery.of(context).size.width * 0.10,
            //     //           right: MediaQuery.of(context).size.width * 0.10,
            //     //           top: MediaQuery.of(context).size.height * 0.04,
            //     //           bottom: MediaQuery.of(context).size.height * 0.04,
            //     //         ),
            //     //         decoration: new BoxDecoration(
            //     //           color: Colors.white,
            //     //           border: Border.all(
            //     //             color: Color(0xFF7499C6),
            //     //             width: 1,
            //     //             style: BorderStyle.solid,
            //     //           ),
            //     //           borderRadius: BorderRadius.all(
            //     //             Radius.circular(2.0),
            //     //           ),
            //     //         ),
            //     //         child: Column(
            //     //           crossAxisAlignment: CrossAxisAlignment.start,
            //     //           mainAxisAlignment: MainAxisAlignment.start,
            //     //           children: [
            //     //             SizedBox(
            //     //               height: 15.0,
            //     //             ),
            //     //             InkWell(
            //     //               child: Container(
            //     //                 margin: EdgeInsets.only(
            //     //                     left: MediaQuery.of(context).size.width *
            //     //                         0.28,
            //     //                     right: MediaQuery.of(context).size.width *
            //     //                         0.28),
            //     //                 child: Icon(
            //     //                   Icons.add,
            //     //                   color: Colors.black,
            //     //                   size: 70,
            //     //                 ),
            //     //               ),
            //     //             ),
            //     //             SizedBox(
            //     //               height: 25.0,
            //     //             ),
            //     //             Container(
            //     //               margin: EdgeInsets.only(
            //     //                   left: MediaQuery.of(context).size.width *
            //     //                       0.07,
            //     //                   right: MediaQuery.of(context).size.width *
            //     //                       0.03),
            //     //               child: Text(
            //     //                 tab.text == "LIVE"
            //     //                     ? "Buy your first Security. Clink on the button below to search for options"
            //     //                     : "Add a portfolio pitch to create an Auro track record",
            //     //                 textAlign: TextAlign.left,
            //     //                 style: TextStyle(
            //     //                     color: AllCoustomTheme
            //     //                         .getNewSecondTextThemeColor(),
            //     //                     fontSize: 14.5,
            //     //                     fontFamily: "Roboto",
            //     //                     fontStyle: FontStyle.normal,
            //     //                     letterSpacing: 0.2),
            //     //               ),
            //     //             ),
            //     //             SizedBox(
            //     //               height: 10.0,
            //     //             ),
            //     //             Container(
            //     //               height:
            //     //                   MediaQuery.of(context).size.height * 0.053,
            //     //               width: MediaQuery.of(context).size.width * 0.40,
            //     //               margin: EdgeInsets.only(
            //     //                   left: tab.text == "LIVE"
            //     //                       ? MediaQuery.of(context).size.width *
            //     //                           0.24
            //     //                       : MediaQuery.of(context).size.width *
            //     //                           0.20,
            //     //                   right: tab.text == "LIVE"
            //     //                       ? MediaQuery.of(context).size.width *
            //     //                           0.24
            //     //                       : MediaQuery.of(context).size.width *
            //     //                           0.20),
            //     //               decoration: BoxDecoration(
            //     //                   borderRadius:
            //     //                       BorderRadius.all(Radius.circular(20)),
            //     //                   border: new Border.all(
            //     //                       color:
            //     //                           AllCoustomTheme.getButtonBoxColor(),
            //     //                       width: 1.5),
            //     //                   color: AllCoustomTheme.getButtonBoxColor()),
            //     //               child: MaterialButton(
            //     //                 splashColor: Colors.grey,
            //     //                 child: Text(
            //     //                   tab.text == "LIVE" ? "Search" : "ADD PITCH",
            //     //                   style: TextStyle(
            //     //                     color: AllCoustomTheme
            //     //                         .getButtonTextThemeColors(),
            //     //                     fontSize: ConstanceData.SIZE_TITLE13,
            //     //                     fontFamily: "Roboto",
            //     //                     fontWeight: FontWeight.bold,
            //     //                   ),
            //     //                 ),
            //     //                 onPressed: () async {
            //     //                   if (tab.text == "PAPER") {
            //     //                     Navigator.of(context).push(
            //     //                       CupertinoPageRoute(
            //     //                         builder: (BuildContext context) =>
            //     //                             PortfolioPitch(),
            //     //                       ),
            //     //                     );
            //     //                   }
            //     //                 },
            //     //               ),
            //     //             ),
            //     //             SizedBox(
            //     //               height: 10.0,
            //     //             ),
            //     //           ],
            //     //         ),
            //     //       ),
            //     //
            //     //       // doughnut chart section start
            //     //       // Visibility(
            //     //       //   visible: false,
            //     //       //   child: Container(
            //     //       //     child: CarouselSlider.builder(
            //     //       //       itemCount: donutArray.length,
            //     //       //       options: CarouselOptions(
            //     //       //           autoPlay: false,
            //     //       //           viewportFraction:
            //     //       //               donutCurrentIndex == 1 ? 1.1 : 1,
            //     //       //           onPageChanged: (index, reason) {
            //     //       //             setState(() {
            //     //       //               donutCurrentIndex = index;
            //     //       //             });
            //     //       //           }),
            //     //       //       itemBuilder: (context, index) {
            //     //       //         return Container(
            //     //       //           child:
            //     //       //               SfCircularChart(series: <CircularSeries>[
            //     //       //             DoughnutSeries<ChartData, String>(
            //     //       //               dataSource: chartData,
            //     //       //               // pointColorMapper:(ChartData data,  _) => data.color,
            //     //       //               xValueMapper: (ChartData data, _) =>
            //     //       //                   data.x,
            //     //       //               yValueMapper: (ChartData data, _) =>
            //     //       //                   data.y,
            //     //       //               dataLabelSettings: DataLabelSettings(
            //     //       //                   isVisible: true,
            //     //       //                   // labelPosition: ChartDataLabelPosition.outside,
            //     //       //                   useSeriesColor: true,
            //     //       //                   showCumulativeValues: true,
            //     //       //                   showZeroValue: true),
            //     //       //             )
            //     //       //           ]),
            //     //       //         );
            //     //       //       },
            //     //       //     ),
            //     //       //   ),
            //     //       // ),
            //     //       // Visibility(
            //     //       //   visible: false,
            //     //       //   child: Container(
            //     //       //     child: Row(
            //     //       //       mainAxisAlignment: MainAxisAlignment.center,
            //     //       //       children: donutArray.map((url) {
            //     //       //         int index = donutArray.indexOf(url);
            //     //       //         return Container(
            //     //       //           width: 10.0,
            //     //       //           height: 8.0,
            //     //       //           margin: EdgeInsets.symmetric(
            //     //       //               vertical: 10.0, horizontal: 2.0),
            //     //       //           decoration: BoxDecoration(
            //     //       //             shape: BoxShape.circle,
            //     //       //             color: donutCurrentIndex == index
            //     //       //                 // ? Color(0xFFFFFFFF)
            //     //       //                 ? Color(0xFFD8AF4F)
            //     //       //                 : Color(0xffCBB4B4),
            //     //       //           ),
            //     //       //         );
            //     //       //       }).toList(),
            //     //       //     ),
            //     //       //   ),
            //     //       // ),
            //     //       Visibility(
            //     //         visible: tab.text == "PAPER" ? true : false,
            //     //         child: Container(
            //     //           height: MediaQuery.of(context).size.height * 0.053,
            //     //           width: MediaQuery.of(context).size.width * 0.40,
            //     //           margin: EdgeInsets.only(
            //     //               left: MediaQuery.of(context).size.width * 0.15,
            //     //               right:
            //     //                   MediaQuery.of(context).size.width * 0.15),
            //     //           decoration: BoxDecoration(
            //     //             borderRadius:
            //     //                 BorderRadius.all(Radius.circular(20)),
            //     //             border: new Border.all(
            //     //                 color: Color(0xFF7499C6), width: 1.5),
            //     //             color: Color(0xFF7499C6),
            //     //           ),
            //     //           child: MaterialButton(
            //     //             splashColor: Colors.grey,
            //     //             child: Text(
            //     //               "GO LIVE - Buy portfolio",
            //     //               style: TextStyle(
            //     //                 color: Colors.white,
            //     //                 fontSize: ConstanceData.SIZE_TITLE16,
            //     //               ),
            //     //             ),
            //     //             onPressed: () async {},
            //     //           ),
            //     //         ),
            //     //       ),
            //     //     ],
            //     //   );
            //     // }).toList(),
            //     // physics: ScrollPhysics(),
            //   ),
            // ),
            // ),
          ),
        ],
      ),
    );
  }

  paperTab() {
    return Consumer<PersonalSleeveProvider>(
      builder: (context, personalSleeveProvider, _) {
        if (personalSleeveProvider.portfolioData != null) {
          homeDonutArray = [1, 2, 3];
          setHomeDoughnutChartData(personalSleeveProvider.portfolioData);
          return StatefulBuilder(builder: (context, setCarouselState) {
            return Column(
              children: [
                Stack(
                  children: [
                    Container(
                      color: Colors.white,
                      height: 410,
                      // decoration: BoxDecoration(border: Border.all()),
                      child: Column(
                        children: [
                          CarouselSlider.builder(
                            carouselController: _carouselController,
                            itemCount: 3,
                            options: CarouselOptions(
                                height: 400,
                                autoPlay: false,
                                viewportFraction: 1,
                                onPageChanged: (index, reason) {
                                  setCarouselState(() {
                                    homeDonutCurrentIndex = index;
                                    if ([0, 1].contains(index)) {
                                      setHomeDoughnutChartData(
                                          personalSleeveProvider.portfolioData);
                                    }
                                  });
                                }),
                            itemBuilder: (context, index, _) {
                              print("itembuilder $index");
                              if (index == 2) {
                                return PersonalSleeveReturnChart(
                                  userInceptionDate: personalSleeveProvider
                                      .portfolioData["portfolio_creation_date"],
                                );
                              } else {
                                return SfCircularChart(
                                  title: ChartTitle(
                                    text: getChartTitle(),
                                    textStyle: TextStyle(
                                      fontFamily: "Ubuntu",
                                    ),
                                  ),
                                  annotations: <CircularChartAnnotation>[
                                    CircularChartAnnotation(
                                      widget: Container(
                                        // decoration: BoxDecoration(
                                        //   border: Border.all(),
                                        // ),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                homeDonutCurrentIndex == 0
                                                    ? '\$ ${_reusableFunctions.formatCurrencyNo(personalSleeveProvider.portfolioData["portfolio_return_dollar"].toStringAsFixed(0)).split(".")[0]}'
                                                    : "${personalSleeveProvider.portfolioData["portfolio_return"].toStringAsFixed(0).split(".")[0]}%",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                homeDonutCurrentIndex == 0
                                                    ? 'US \$ Profit'
                                                    : "Annualized \nreturn %",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      verticalAlignment: ChartAlignment.near,
                                      horizontalAlignment: ChartAlignment.near,
                                      height: "60.0",
                                      width: "90.0",
                                      angle: 200,
                                      radius: "47",
                                    )
                                  ],
                                  legend: Legend(
                                    isVisible: true,
                                    // textStyle: TextStyle(
                                    //   color: Colors.black,
                                    // ),
                                    overflowMode: LegendItemOverflowMode.wrap,
                                    itemPadding: 5.0,
                                    legendItemBuilder:
                                        (name, series, point, index) {
                                      var changesString = name
                                          .replaceAll("_", " ")
                                          .toLowerCase();
                                      // print("legend");
                                      // DoughnutSeriesRenderer ss = series;
                                      ChartPoint<dynamic> dd = point;
                                      // print(series.runtimeType.toString());
                                      // print(point.runtimeType.toString());
                                      return Container(
                                        padding: EdgeInsets.all(1.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.quinscape,
                                              color: dd.color,
                                              size: 15,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              changesString,
                                              style: TextStyle(
                                                color: Colors.grey[800],
                                                fontFamily: "Ubuntu",
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  series: <CircularSeries>[
                                    DoughnutSeries<ChartData, String>(
                                      radius: "90%",
                                      innerRadius: '60%',
                                      dataSource: homeChartData,
                                      xValueMapper: (ChartData data, _) =>
                                          data.x,
                                      yValueMapper: (ChartData data, _) =>
                                          data.y,
                                      dataLabelSettings: DataLabelSettings(
                                        isVisible: true,
                                        useSeriesColor: true,
                                        showCumulativeValues: true,
                                        showZeroValue: true,
                                      ),
                                    )
                                  ],
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    // Positioned(
                    //   top: 100,
                    //   right: 0,
                    //   child: IconButton(
                    //     icon: Icon(
                    //       Icons.arrow_forward_ios,
                    //       color: Colors.black,
                    //     ),
                    //     onPressed: () {
                    //       if (homeDonutCurrentIndex == 6) {
                    //         homeDonutCurrentIndex = 0;
                    //         _carouselController
                    //             .animateToPage(homeDonutCurrentIndex);
                    //       } else {
                    //         homeDonutCurrentIndex = homeDonutCurrentIndex + 1;
                    //         _carouselController
                    //             .animateToPage(homeDonutCurrentIndex);
                    //       }
                    //     },
                    //   ),
                    // ),
                    // Positioned(
                    //   top: 100,
                    //   left: 0,
                    //   child: IconButton(
                    //     icon: Icon(
                    //       Icons.arrow_back_ios,
                    //       color: Colors.black,
                    //     ),
                    //     onPressed: () {
                    //       if (homeDonutCurrentIndex == 0) {
                    //         homeDonutCurrentIndex = 6;
                    //         _carouselController
                    //             .animateToPage(homeDonutCurrentIndex);
                    //       } else {
                    //         homeDonutCurrentIndex = homeDonutCurrentIndex - 1;
                    //         _carouselController
                    //             .animateToPage(homeDonutCurrentIndex);
                    //       }
                    //     },
                    //   ),
                    // ),
                  ],
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: homeDonutArray.map((url) {
                      int index = url - 1;
                      return Container(
                        width: 10.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: homeDonutCurrentIndex == index
                              // ? Color(0xFFFFFFFF)
                              ? Color(0xFFD8AF4F)
                              : Colors.white,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          });
        } else {
          return noPortfolioToShow("PAPER");
        }
      },
    );
  }

  noPortfolioToShow(text) {
    return Column(
      // physics: NeverScrollableScrollPhysics(),
      children: [
        // plus, search section
        Container(
          margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.10,
            right: MediaQuery.of(context).size.width * 0.10,
            top: MediaQuery.of(context).size.height * 0.04,
            bottom: MediaQuery.of(context).size.height * 0.04,
          ),
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
                      left: MediaQuery.of(context).size.width * 0.28,
                      right: MediaQuery.of(context).size.width * 0.28),
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 70,
                  ),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.07,
                    right: MediaQuery.of(context).size.width * 0.03),
                child: Text(
                  text == "LIVE"
                      ? "Buy your first Security. Clink on the button below to search for options"
                      : "Add a portfolio pitch to create an Auro track record",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: AllCoustomTheme.getNewSecondTextThemeColor(),
                      fontSize: 14.5,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0.2),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.053,
                width: MediaQuery.of(context).size.width * 0.40,
                margin: EdgeInsets.only(
                    left: text == "LIVE"
                        ? MediaQuery.of(context).size.width * 0.24
                        : MediaQuery.of(context).size.width * 0.20,
                    right: text == "LIVE"
                        ? MediaQuery.of(context).size.width * 0.24
                        : MediaQuery.of(context).size.width * 0.20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: new Border.all(
                        color: AllCoustomTheme.getButtonBoxColor(), width: 1.5),
                    color: AllCoustomTheme.getButtonBoxColor()),
                child: MaterialButton(
                  splashColor: Colors.grey,
                  child: Text(
                    text == "LIVE" ? "Search" : "ADD PITCH",
                    style: TextStyle(
                      color: AllCoustomTheme.getButtonTextThemeColors(),
                      fontSize: ConstanceData.SIZE_TITLE13,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    if (text == "PAPER") {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (BuildContext context) => PortfolioPitch(),
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),

        // doughnut chart section start
        // Visibility(
        //   visible: false,
        //   child: Container(
        //     child: CarouselSlider.builder(
        //       itemCount: donutArray.length,
        //       options: CarouselOptions(
        //           autoPlay: false,
        //           viewportFraction:
        //               donutCurrentIndex == 1 ? 1.1 : 1,
        //           onPageChanged: (index, reason) {
        //             setState(() {
        //               donutCurrentIndex = index;
        //             });
        //           }),
        //       itemBuilder: (context, index) {
        //         return Container(
        //           child:
        //               SfCircularChart(series: <CircularSeries>[
        //             DoughnutSeries<ChartData, String>(
        //               dataSource: chartData,
        //               // pointColorMapper:(ChartData data,  _) => data.color,
        //               xValueMapper: (ChartData data, _) =>
        //                   data.x,
        //               yValueMapper: (ChartData data, _) =>
        //                   data.y,
        //               dataLabelSettings: DataLabelSettings(
        //                   isVisible: true,
        //                   // labelPosition: ChartDataLabelPosition.outside,
        //                   useSeriesColor: true,
        //                   showCumulativeValues: true,
        //                   showZeroValue: true),
        //             )
        //           ]),
        //         );
        //       },
        //     ),
        //   ),
        // ),
        // Visibility(
        //   visible: false,
        //   child: Container(
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: donutArray.map((url) {
        //         int index = donutArray.indexOf(url);
        //         return Container(
        //           width: 10.0,
        //           height: 8.0,
        //           margin: EdgeInsets.symmetric(
        //               vertical: 10.0, horizontal: 2.0),
        //           decoration: BoxDecoration(
        //             shape: BoxShape.circle,
        //             color: donutCurrentIndex == index
        //                 // ? Color(0xFFFFFFFF)
        //                 ? Color(0xFFD8AF4F)
        //                 : Color(0xffCBB4B4),
        //           ),
        //         );
        //       }).toList(),
        //     ),
        //   ),
        // ),
        Visibility(
          visible: text == "PAPER" ? true : false,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.053,
            width: MediaQuery.of(context).size.width * 0.40,
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.15,
                right: MediaQuery.of(context).size.width * 0.15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: new Border.all(color: Color(0xFF7499C6), width: 1.5),
              color: Color(0xFF7499C6),
            ),
            child: MaterialButton(
              splashColor: Colors.grey,
              child: Text(
                "GO LIVE - Buy portfolio",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ConstanceData.SIZE_TITLE16,
                ),
              ),
              onPressed: () async {},
            ),
          ),
        ),
      ],
    );
  }

  setHomeDoughnutChartData(portfolioChartData) {
    print("portfolioChartData: $portfolioChartData");
    print("homeDonutCurrentIndex: $homeDonutCurrentIndex");

    if (portfolioChartData != null && portfolioChartData != false) {
      if (homeDonutCurrentIndex == 0) {
        print("in bro index 0");
        print(portfolioChartData["country"]);
        homeChartData = [];
        portfolioChartData["country"].forEach((key, value) {
          homeChartData.add(
            ChartData(
              '$key',
              double.parse((value.toDouble() * 100).toInt().toString()),
              // double.parse(tempDouble.toStringAsFixed(4)),
              globals.isGoldBlack ? Color(0xFFE8E2DB) : Color(0xFF1D6177),
            ),
          );
        });
        print("home doughnut personal sleeve : $homeChartData");
        return homeChartData;
      } else if (homeDonutCurrentIndex == 1) {
        print("in bro index 1");
        homeChartData = [];
        portfolioChartData["sector"].forEach((key, value) {
          homeChartData.add(ChartData(
              '$key',
              double.parse((value.toDouble() * 100).toInt().toString()),
              // double.parse(tempDouble.toStringAsFixed(4)),
              globals.isGoldBlack ? Color(0xFFE8E2DB) : Color(0xFF1D6177)));
        });
        print("home doughnut personal sleeve : $homeChartData");
        return homeChartData;
      }
    }
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

  getChartTitle() {
    switch (homeDonutCurrentIndex) {
      case 0:
        return "% mix by country";
      case 1:
        return "% mix by sector";
      case 2:
        return "daily return chart";
      default:
        return null;
    }
  }
}
