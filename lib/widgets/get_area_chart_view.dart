import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/modules/investRelatedPages/riskOnboardingPages/onBoardingFirst.dart';
import 'package:auroim/modules/investRelatedPages/securityFirstPage.dart';
import 'package:auroim/provider_abhinav/public_company_historical_pricing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'crypto_coin_price_data.dart';

class GetAreaChartView extends StatefulWidget {
  final List<Color> color;
  final List<double> stops;
  final List<NewSalesData> newSalesData;
  final companyData;

  GetAreaChartView({
    this.color,
    this.newSalesData,
    this.stops,
    this.companyData,
  });

  @override
  _GetAreaChartViewState createState() => _GetAreaChartViewState();
}

class _GetAreaChartViewState extends State<GetAreaChartView> {
  LinearGradient gradientColors;
  List<CryptoCoinPriceData> allPriceData = [];
  ZoomPanBehavior _zoomPanBehavior;
  TooltipBehavior _tooltipBehavior;
  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();

  @override
  void initState() {
    gradientColors = LinearGradient(
      colors: widget.color,
      stops: widget.stops,
    );
    _tooltipBehavior = TooltipBehavior(enable: true);
    _zoomPanBehavior = ZoomPanBehavior(enablePinching: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.companyData);
    // Provider.of<PublicCompanyHistoricalPricing>(context)
    //     .getSinglePublicCompanyData(widget.companyData["ticker"], 30);
    return Container(
      height: 300,
      child: Container(
        // decoration: BoxDecoration(border: Border.all(color: Colors.white,),),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
                height: 290,
                width: MediaQuery.of(context).size.width * 0.96,
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: new Border.all(
                      color: AllCoustomTheme.getChartBoxThemeColor(),
                      width: 1.0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 5.0),
                        child: Container(
                          // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
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
                                    widget.companyData == null
                                        ? ""
                                        : widget.companyData["company_name"],
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
                                        "${widget.companyData["30d_high"].toStringAsFixed(2)}",
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
                                        "${widget.companyData["30d_low"].toStringAsFixed(2)}",
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
                      ),
                      FutureBuilder(
                        future: _featuredCompaniesProvider
                            .getSinglePublicCompanyHistoricalPricing(
                                widget.companyData["ticker"], 30),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            allPriceData = [];
                            snapshot.data.forEach((element) {
                              DateTime date = DateFormat("yyyy-MM-dd")
                                  .parse(element["date"]);
                              allPriceData.add(
                                CryptoCoinPriceData(
                                    x: date, y: element["price"].toDouble()),
                              );
                            });
                            return SizedBox(
                                width: MediaQuery.of(context).size.width * 0.88,
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                child: Container(
                                  margin: EdgeInsets.only(left: 10.0),
                                  child: SfCartesianChart(
                                      primaryXAxis: DateTimeAxis(
                                        isVisible: false,
                                      ),
                                      title: ChartTitle(text: "30D Pricing"),
                                      tooltipBehavior: _tooltipBehavior,
                                      zoomPanBehavior: _zoomPanBehavior,
                                      primaryYAxis:
                                          NumericAxis(isVisible: false),
                                      series: <ChartSeries>[
                                        StackedAreaSeries<CryptoCoinPriceData,
                                            dynamic>(
                                          dataSource: allPriceData,
                                          xValueMapper:
                                              (CryptoCoinPriceData data, _) =>
                                                  data.x,
                                          yValueMapper:
                                              (CryptoCoinPriceData data, _) =>
                                                  data.y,
                                          gradient: gradientColors,
                                        ),
                                      ]),
                                ));
                          } else {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.88,
                              height: MediaQuery.of(context).size.height * 0.15,
                              child: Container(
                                margin: EdgeInsets.only(left: 10.0),
                                child: Center(
                                  child: Text(
                                    "No Chart To Show",
                                    style: TextStyle(
                                      color: globals.isGoldBlack
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      // Consumer<PublicCompanyHistoricalPricing>(
                      //   builder: (context, historicalPricingProvider, _) {
                      //     if (historicalPricingProvider.historicalPriceData[
                      //             widget.companyData["ticker"]] ==
                      //         null) {
                      //       return SizedBox(
                      //         width: MediaQuery.of(context).size.width * 0.88,
                      //         height: MediaQuery.of(context).size.height * 0.15,
                      //         child: Container(
                      //           margin: EdgeInsets.only(left: 10.0),
                      //         ),
                      //       );
                      //     } else {
                      //       allPriceData = [];
                      //       historicalPricingProvider.historicalPriceData[
                      //               widget.companyData["ticker"]]
                      //           .forEach((element) {
                      //         DateTime date = DateFormat("yyyy-MM-dd")
                      //             .parse(element["date"]);
                      //         allPriceData.add(
                      //           CryptoCoinPriceData(
                      //               x: date, y: element["price"].toDouble()),
                      //         );
                      //       });
                      //       return SizedBox(
                      //           width: MediaQuery.of(context).size.width * 0.88,
                      //           height:
                      //               MediaQuery.of(context).size.height * 0.15,
                      //           child: Container(
                      //             margin: EdgeInsets.only(left: 10.0),
                      //             child: SfCartesianChart(
                      //                 primaryXAxis: DateTimeAxis(
                      //                   isVisible: false,
                      //                 ),
                      //                 title: ChartTitle(text: "30D Pricing"),
                      //                 tooltipBehavior: _tooltipBehavior,
                      //                 zoomPanBehavior: _zoomPanBehavior,
                      //                 primaryYAxis:
                      //                     NumericAxis(isVisible: false),
                      //                 series: <ChartSeries>[
                      //                   StackedAreaSeries<CryptoCoinPriceData,
                      //                       dynamic>(
                      //                     dataSource: allPriceData,
                      //                     xValueMapper:
                      //                         (CryptoCoinPriceData data, _) =>
                      //                             data.x,
                      //                     yValueMapper:
                      //                         (CryptoCoinPriceData data, _) =>
                      //                             data.y,
                      //                     gradient: gradientColors,
                      //                   ),
                      //                 ]),
                      //           ));
                      //     }
                      //   },
                      // ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width:
                                (MediaQuery.of(context).size.width - 100) / 2,
                            height: 35,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: new Border.all(
                                    color:
                                        AllCoustomTheme.getChartBoxThemeColor(),
                                    width: 1.5),
                                color: AllCoustomTheme.getChartBoxThemeColor(),
                              ),
                              child: MaterialButton(
                                // splashColor: Colors.grey,
                                child: Text(
                                  "TRADE",
                                  style: TextStyle(
                                    color: AllCoustomTheme
                                        .getButtonTextThemeColors(),
                                    fontSize: ConstanceData.SIZE_TITLE13,
                                    fontFamily: "Roboto",
                                  ),
                                ),
                                onPressed: () async {
                                  Navigator.of(context).push(
                                    new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new SecurityPageFirst(
                                        logo: "logo.png",
                                        callingFrom: "Accredited Investor",
                                        companyTicker:
                                            widget.companyData["ticker"],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Container(
                            width:
                                (MediaQuery.of(context).size.width - 100) / 2,
                            height: 35,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: new Border.all(
                                  color:
                                      AllCoustomTheme.getChartBoxThemeColor(),
                                  width: 1.5,
                                ),
                                // color: AllCoustomTheme.getChartBoxThemeColor(),
                              ),
                              child: MaterialButton(
                                splashColor: Colors.grey,
                                child: Text(
                                  "FOLLOW",
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
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
