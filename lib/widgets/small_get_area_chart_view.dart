import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/modules/investRelatedPages/riskOnboardingPages/onBoardingFirst.dart';
import 'package:auroim/modules/investRelatedPages/securityFirstPage.dart';
import 'package:auroim/provider_abhinav/public_company_historical_pricing.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'crypto_coin_price_data.dart';

class SmallGetAreaChartView extends StatefulWidget {
  final List<Color> color;
  final List<double> stops;
  final List<NewSalesData> newSalesData;
  final ticker;

  SmallGetAreaChartView({
    this.color,
    this.newSalesData,
    this.stops,
    this.ticker,
  });

  @override
  _SmallGetAreaChartViewState createState() => _SmallGetAreaChartViewState();
}

class _SmallGetAreaChartViewState extends State<SmallGetAreaChartView> {
  LinearGradient gradientColors;
  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();
  List<CryptoCoinPriceData> allPriceData = [];
  bool _isInit = true;

  @override
  void initState() {
    gradientColors = LinearGradient(
      colors: widget.color,
      stops: widget.stops,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      print("did change small get area view");
      Provider.of<PublicCompanyHistoricalPricing>(context)
          .getSinglePublicCompanyData(widget.ticker, 30);
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.companyData);

    return FutureBuilder(
      future: _featuredCompaniesProvider.getSinglePublicCompanyData(
          widget.ticker, "head"),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print("data is got for securities baba");
          return Container(
            height: 220,
            child: Container(
              // decoration: BoxDecoration(border: Border.all(color: Colors.white,),),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                      height: 210,
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
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
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, left: 5.0),
                              child: Container(
                                // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                                height:
                                    MediaQuery.of(context).size.height * 0.10,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          snapshot.data["company_name"] == null
                                              ? ""
                                              : snapshot.data["company_name"],
                                          style: TextStyle(
                                            color: AllCoustomTheme
                                                .getChartBoxTextThemeColor(),
                                            fontSize:
                                                ConstanceData.SIZE_TITLE18,
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
                                            fontSize:
                                                ConstanceData.SIZE_TITLE18,
                                            fontFamily: "Roboto",
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                fontSize:
                                                    ConstanceData.SIZE_TITLE10,
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
                                                fontSize:
                                                    ConstanceData.SIZE_TITLE10,
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
                                                fontSize:
                                                    ConstanceData.SIZE_TITLE10,
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
                                                fontSize:
                                                    ConstanceData.SIZE_TITLE10,
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
                            Consumer<PublicCompanyHistoricalPricing>(
                              builder: (context, historicalPricingProvider, _) {
                                if (historicalPricingProvider
                                        .historicalPriceData[widget.ticker] ==
                                    null) {
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.80,
                                    height: MediaQuery.of(context).size.height *
                                        0.10,
                                    child: Container(
                                      margin: EdgeInsets.only(left: 10.0),
                                    ),
                                  );
                                } else {
                                  allPriceData = [];
                                  historicalPricingProvider.historicalPriceData[
                                          widget.ticker]
                                      .forEach((element) {
                                    DateTime date = DateFormat("yyyy-MM-dd")
                                        .parse(element["date"]);
                                    allPriceData.add(
                                      CryptoCoinPriceData(
                                          x: date,
                                          y: element["price"].toDouble()),
                                    );
                                  });
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.80,
                                    height: MediaQuery.of(context).size.height *
                                        0.10,
                                    child: Container(
                                      margin: EdgeInsets.only(left: 10.0),
                                      child: SfCartesianChart(
                                          primaryXAxis: DateTimeAxis(
                                            isVisible: false,
                                          ),
                                          primaryYAxis:
                                              NumericAxis(isVisible: false),
                                          series: <ChartSeries>[
                                            StackedAreaSeries<
                                                CryptoCoinPriceData, dynamic>(
                                              dataSource: allPriceData,
                                              xValueMapper:
                                                  (CryptoCoinPriceData data,
                                                          _) =>
                                                      data.x,
                                              yValueMapper:
                                                  (CryptoCoinPriceData data,
                                                          _) =>
                                                      data.y,
                                              gradient: gradientColors,
                                            ),
                                          ]),
                                    ),
                                  );
                                }
                              },
                            ),
                            SizedBox(
                              // height: MediaQuery.of(context).size.height*0.10,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.20,
                                    height: MediaQuery.of(context).size.height *
                                        0.030,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        border: new Border.all(
                                            color: AllCoustomTheme
                                                .getChartBoxThemeColor(),
                                            width: 1.5),
                                        color: AllCoustomTheme
                                            .getChartBoxThemeColor(),
                                      ),
                                      child: MaterialButton(
                                        // splashColor: Colors.grey,
                                        child: Text(
                                          "BUY",
                                          style: TextStyle(
                                            color: AllCoustomTheme
                                                .getButtonTextThemeColors(),
                                            fontSize:
                                                ConstanceData.SIZE_TITLE13,
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
                                                    "Accredited Investor",
                                                companyTicker:
                                                    snapshot.data["ticker"],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.21,
                                    height: MediaQuery.of(context).size.height *
                                        0.030,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
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
                                            fontSize:
                                                ConstanceData.SIZE_TITLE13,
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
                                                          "Accredited Investor"),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.30,
                                    height: MediaQuery.of(context).size.height *
                                        0.030,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        border: new Border.all(
                                            color: AllCoustomTheme
                                                .getChartBoxThemeColor(),
                                            width: 1.5),
                                        // color: AllCoustomTheme.getChartBoxThemeColor(),
                                      ),
                                      child: MaterialButton(
                                        splashColor: Colors.grey,
                                        child: Text(
                                          "FOLLOW",
                                          style: TextStyle(
                                            color: AllCoustomTheme
                                                .getChartBoxTextThemeColor(),
                                            fontSize:
                                                ConstanceData.SIZE_TITLE13,
                                            fontFamily: "Roboto",
                                          ),
                                        ),
                                        onPressed: () async {
                                          Navigator.of(context).push(
                                              new MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
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
            ),
          );
        } else {
          return Container(
            child: Center(
              child: Text("Fetching Security Data..."),
            ),
          );
        }
      },
    );
  }
}
