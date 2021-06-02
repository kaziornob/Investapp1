import 'dart:math';

import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/provider_abhinav/public_company_historical_pricing.dart';
import 'package:auroim/widgets/crypto_coin_price_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CompanyPriceCharts extends StatefulWidget {
  final companyData;

  const CompanyPriceCharts({
    Key key,
    this.companyData,
  }) : super(key: key);

  @override
  _CompanyPriceChartsState createState() => _CompanyPriceChartsState();
}

class _CompanyPriceChartsState extends State<CompanyPriceCharts> {
  ZoomPanBehavior _zoomPanBehavior;
  TooltipBehavior _tooltipBehavior;
  LinearGradient gradientColors;
  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();
  bool _isInit = true;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
      enable: true,
    );
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
    );
    gradientColors = LinearGradient(
      colors: [
        Color(0xFFCCDBED),
        Color(0xFF71BBF6),
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      print("did change comany price chart");
      Provider.of<PublicCompanyHistoricalPricing>(context)
          .getSinglePublicCompanyData(widget.companyData["ticker"], 365);

      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _featuredCompaniesProvider
          .getSinglePublicCompanyDataFromStatic(widget.companyData["ticker"]),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(widget.companyData["ticker"]);
          return Container(
            // decoration: BoxDecoration(border: Border.all()),
            height: 320,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    bottom: 20,
                  ),
                  child: Text(
                    widget.companyData["security_name"],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Consumer<PublicCompanyHistoricalPricing>(
                    builder: (context, historicalPricingProvider, _) {
                  if (historicalPricingProvider
                          .historicalPriceData[widget.companyData["ticker"]] !=
                      null) {
                    var allPriceData = [];
                    List<double> onlyPriceList = [];
                    historicalPricingProvider
                        .historicalPriceData[widget.companyData["ticker"]]
                        .forEach((element) {
                      DateTime date =
                          DateFormat("yyyy-MM-dd").parse(element["date"]);
                      allPriceData.add(
                        CryptoCoinPriceData(
                            x: date, y: element["price"].toDouble()),
                      );
                      onlyPriceList.add(element["price"].toDouble());
                    });
                    double maxVal = onlyPriceList.reduce(max);
                    double minVal = onlyPriceList.reduce(min);
                    double lastItem = allPriceData.length == 0
                        ? 0.0
                        : allPriceData[allPriceData.length - 1].y;
                    double secondLastItem = allPriceData.length <= 1
                        ? 0.0
                        : allPriceData[allPriceData.length - 2].y;
                    print(secondLastItem);
                    var companyPrice = lastItem;
                    var companyPriceDifference =
                        secondLastItem != 0 ? (lastItem - secondLastItem) : 0.0;
                    print(companyPriceDifference);
                    print(companyPrice);
                    var companyPercentageDifference =
                        companyPriceDifference == 0.0
                            ? 0.0
                            : companyPrice / companyPriceDifference;
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "High / Low (52W)",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: maxVal == null
                                            ? "0.00"
                                            : "${maxVal.toStringAsFixed(2)}",
                                        // snapshot.data[""],
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 14,
                                          fontFamily: "Roboto",
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: " / ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: minVal == null
                                            ? "0.00"
                                            : "${minVal.toStringAsFixed(2)}",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                          fontFamily: "Roboto",
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          VerticalDivider(
                            thickness: 1.5,
                            endIndent: 5,
                            indent: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Closing Price",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "${companyPrice.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    color: Color(0xFF05599B),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                }),
                Consumer<PublicCompanyHistoricalPricing>(
                  builder: (context, historicalPricingProvider, _) {
                    if (historicalPricingProvider.historicalPriceData[
                            widget.companyData["ticker"]] ==
                        null) {
                      return Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          height: 90,
                          child: Container(
                            margin: EdgeInsets.only(left: 10.0),
                            child: Center(child: Text("No Chart to show")),
                          ),
                        ),
                      );
                    } else {
                      List<CryptoCoinPriceData> allPriceData = [];
                      List<double> onlyPriceList = [];
                      historicalPricingProvider
                          .historicalPriceData[widget.companyData["ticker"]]
                          .forEach((element) {
                        DateTime date =
                            DateFormat("yyyy-MM-dd").parse(element["date"]);
                        allPriceData.add(
                          CryptoCoinPriceData(
                              x: date, y: element["price"].toDouble()),
                        );
                        onlyPriceList.add(element["price"].toDouble());
                      });
                      double maxVal = onlyPriceList.reduce(max);
                      double minVal = onlyPriceList.reduce(min);
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        child: Container(
                          child: SfCartesianChart(
                            tooltipBehavior: _tooltipBehavior,
                            zoomPanBehavior: _zoomPanBehavior,
                            primaryXAxis: DateTimeAxis(
                              isVisible: true,
                              majorGridLines: MajorGridLines(
                                color: Colors.white,
                              ),
                              majorTickLines: MajorTickLines(
                                color: Colors.white,
                              ),
                            ),
                            primaryYAxis: NumericAxis(
                              isVisible: true,
                              // title: AxisTitle(text: "Price"),
                              maximum: maxVal + (maxVal / 10),
                              minimum: minVal,
                              majorGridLines: MajorGridLines(
                                color: Colors.white,
                              ),
                              majorTickLines: MajorTickLines(
                                color: Colors.white,
                              ),
                            ),
                            series: <ChartSeries>[
                              StackedAreaSeries<CryptoCoinPriceData, dynamic>(
                                dataSource: allPriceData,
                                xValueMapper: (CryptoCoinPriceData data, _) =>
                                    data.x,
                                yValueMapper: (CryptoCoinPriceData data, _) =>
                                    data.y,
                                gradient: gradientColors,
                                name: "Price On",
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }



}
