import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/modules/bussPost/wishList.dart';
import 'package:auroim/modules/investRelatedPages/riskOnboardingPages/onBoardingFirst.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:auroim/constance/global.dart' as globals;

class MainHomeTab extends StatefulWidget {
  @override
  _MainHomeTabState createState() => _MainHomeTabState();
}

class _MainHomeTabState extends State<MainHomeTab> {
  ApiProvider request = new ApiProvider();
  var portfolioChartData;
  int homeDonutCurrentIndex = 0;
  List homeDonutArray = [];
  List<ChartData> homeChartData = [];
  bool _isinit=true;

  @override
  void initState() {
    print("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setHomeTabState) {
      if(_isinit){
        getDoughnutPortfolioData(setHomeTabState);
        _isinit = false;
      }
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
                child: Stack(
                  children: [
                    Container(
                      // decoration: BoxDecoration(border: Border.all()),
                      child: CarouselSlider.builder(
                        itemCount: homeDonutArray.length,
                        options: CarouselOptions(
                            autoPlay: false,
                            viewportFraction:
                                homeDonutCurrentIndex == 1 ? 1.1 : 1,
                            onPageChanged: (index, reason) {
                              setHomeTabState(() {
                                homeDonutCurrentIndex = index;
                                setHomeDoughnutChartData();
                              });
                            }),
                        itemBuilder: (context, index) {
                          return Container(
                            // decoration: BoxDecoration(border: Border.all()),
                            width: MediaQuery.of(context).size.width * 0.93,
                            child: SfCircularChart(
                              legend: Legend(
                                  isVisible: true,
                                  textStyle: TextStyle(
                                      color:
                                          AllCoustomTheme.getTextThemeColors()),
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
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 80,
                      right: 0,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setHomeTabState(() {
                            if (homeDonutCurrentIndex == 2) {
                              homeDonutCurrentIndex = 0;
                            } else {
                              homeDonutCurrentIndex = homeDonutCurrentIndex + 1;
                            }
                            setHomeDoughnutChartData();
                          });
                        },
                      ),
                    ),
                    Positioned(
                      top: 80,
                      left: 0,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setHomeTabState(() {
                            if (homeDonutCurrentIndex == 0) {
                              homeDonutCurrentIndex = 2;
                            } else {
                              homeDonutCurrentIndex = homeDonutCurrentIndex - 1;
                            }
                            setHomeDoughnutChartData();
                          });
                        },
                      ),
                    ),
                  ],
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
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
                        // Padding(
                        //     padding: EdgeInsets.only(top: 10.0),
                        //     child: Row(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: <Widget>[
                        //         Padding(
                        //             padding:
                        //                 EdgeInsets.only(left: 95.0, bottom: 5.0),
                        //             child: Text(
                        //               'Auro Portfolio',
                        //               style: new TextStyle(
                        //                 color: AllCoustomTheme
                        //                     .getSubHeadingThemeColors(),
                        //                 fontSize: ConstanceData.SIZE_TITLE15,
                        //                 fontFamily: "Roboto",
                        //                 package: 'Roboto-Regular',
                        //               ),
                        //             )),
                        //         Padding(
                        //             padding:
                        //                 EdgeInsets.only(left: 30.0, top: 3.0),
                        //             child: Text(
                        //               'SEE ALL',
                        //               style: new TextStyle(
                        //                 decoration: TextDecoration.underline,
                        //                 color: AllCoustomTheme
                        //                     .getSeeMoreThemeColor(),
                        //                 fontSize: ConstanceData.SIZE_TITLE15,
                        //                 fontFamily: "Roboto",
                        //               ),
                        //             ))
                        //       ],
                        //     )),
                        // PublicCompaniesList(),
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width - 20,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
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
    });
  }

  Future<void> getDoughnutPortfolioData(setHomeTabState) async {
    print("getDoughnutPortfolioData called");
    var response =
        await request.getRunAlgoExistingPortfolio('users/create_portfolio');
    print("portfolio chart list: $response");
    if (response != null &&
        response != false &&
        response.containsKey('auth') &&
        response['auth'] == true) {
      setHomeTabState(() {
        homeDonutArray = [];
        homeDonutArray.add(1);
        homeDonutArray.add(2);
        homeDonutArray.add(3);
        // homeDonutArray.add(4);
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
      } else if (homeDonutCurrentIndex == 2) {
        print("in bro index 2");
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
}
