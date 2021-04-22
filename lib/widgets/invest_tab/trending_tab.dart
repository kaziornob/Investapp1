import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/provider_abhinav/auro_stars_provider.dart';
import 'package:auroim/provider_abhinav/crypto_coins_provider.dart';
import 'package:auroim/provider_abhinav/listed_companies_provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../crypto_coin_price_data.dart';

class TrendingTab extends StatefulWidget {
  @override
  _TrendingTabState createState() => _TrendingTabState();
}

class _TrendingTabState extends State<TrendingTab> {
  final mapOfAuroStars = {
    "Auro Global Thematic Portfolio": {
      "aurostar_id": 6,
      "header_path": "assets/auro_global_thematic_portfolio_header.jpg",
      "path": "assets/auro_global_thematic_portfolio.jpg",
    },
    "Auro Asia Quantimental Portfolio": {
      "aurostar_id": 5,
      "header_path": "assets/auro_asia_quantimental_portfolio_header.jpg",
      "path": "assets/auro_asia_quantimental_portfolio.jpg",
    },
    "Auro Asia Technology Portfolio": {
      "aurostar_id": 4,
      "header_path": "assets/auro_asia_technology_portfolio_header.jpg",
      "path": "assets/auro_asia_technology_portfolio.jpg",
    },
    "Auro US Consumer Portfolio": {
      "aurostar_id": 3,
      "header_path": "assets/auro_us_consumer_portfolio_header.jpg",
      "path": "assets/auro_us_consumer_portfolio.jpg",
    },
    "Auro India Healthcare Portfolio": {
      "aurostar_id": 2,
      "header_path": "assets/auro_india_healthcare_portfolio_header.jpg",
      "path": "assets/auro_india_healthcare_portfolio.jpg",
    },
    "Auro Global Consumer Portfolio": {
      "aurostar_id": 1,
      "header_path": "assets/auro_global_consumer_portfolio_header.jpg",
      "path": "assets/auro_global_consumer_portfolio.jpgg",
    }
  };
  final List<Color> color = <Color>[];
  LinearGradient gradientColors;
  final List<double> stops = <double>[];
  var auroStarData;
  var cryptoCoinsDataList;
  var listedCompaniesDataList;
  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();

  final List<NewSalesData> newSalesData = [
    NewSalesData(2010, 35),
    NewSalesData(2011, 28),
    NewSalesData(2012, 34),
    NewSalesData(2013, 32),
    NewSalesData(2014, 40)
  ];

  @override
  void initState() {
    color.add(Colors.blue[50]);
    color.add(Colors.blue[200]);
    color.add(Colors.blue);
    stops.add(0.0);
    stops.add(0.5);
    stops.add(1.0);

    gradientColors = LinearGradient(colors: color, stops: stops);
    super.initState();
  }

  Future<bool> getTrendingData() async {
    auroStarData =
        await Provider.of<AuroStarProvider>(context).getRandomAuroStar();
    cryptoCoinsDataList =
        await Provider.of<CryptoCoinsProvider>(context).getTopXCryptoCoins(2);
    listedCompaniesDataList = await Provider.of<ListedCompanyProvider>(context)
        .getTopXListedCompanies(2);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        Provider.of<AuroStarProvider>(context).getRandomAuroStar(),
        Provider.of<CryptoCoinsProvider>(context).getTopXCryptoCoins(2),
        Provider.of<ListedCompanyProvider>(context).getTopXListedCompanies(2),
      ]),
      builder: (context, snapshot) {
        // print(snapshot.data);
        if (snapshot.hasData) {
          auroStarData = snapshot.data[0];
          cryptoCoinsDataList = snapshot.data[1];
          listedCompaniesDataList = snapshot.data[2];
          return Container(
            // decoration: BoxDecoration(border: Border.all()),
            margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(width: 0.5),
                Container(
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
                            smallItem(false, listedCompaniesDataList[0]),
                            SizedBox(
                              width: 4.0,
                            ),
                            //second  box of first row
                            smallItem(false, listedCompaniesDataList[1]),
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
                            smallItem(true, cryptoCoinsDataList[0]),
                            SizedBox(
                              width: 4.0,
                            ),
                            //second  box of first row
                            smallItem(true, cryptoCoinsDataList[1]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //Big Box
                bigItem(auroStarData),
                SizedBox(width: 5.0,),
              ],
            ),
          );
        } else {
          return Container(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.redAccent,
                valueColor: AlwaysStoppedAnimation(Colors.green),
                strokeWidth: 10,
              ),
            ),
          );
        }
      },
    );
  }

  smallItem(isCrypto, data) {
    return InkWell(
      onTap: () {},
      child: Container(
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
                    child: Container(
                      // width: MediaQuery.of(context).size.width * 0.22,
                      // height: 30,
                      // decoration: new BoxDecoration(
                      //   border: Border.all(),
                      // ),
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width * 0.22,
                        maxWidth: MediaQuery.of(context).size.width * 0.22,
                        minHeight: 20.0,
                        maxHeight: 50.0,
                      ),
                      child: AutoSizeText(
                        isCrypto
                            ? data["coin_id"].toUpperCase()
                            : data["company_name"],
                        style: TextStyle(
                            fontFamily: "Poppins",
                            color: Color(0xFF000000),
                            fontSize: 10.0,
                            letterSpacing: 0.2),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: isCrypto
                  ? _featuredCompaniesProvider.getCoinPrices(data["coin_id"])
                  : _featuredCompaniesProvider
                      .getSinglePublicCompanyHistoricalPricing(
                          data["ticker"], 30),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<CryptoCoinPriceData> allPriceData = [];
                  if (!isCrypto) {
                    snapshot.data.forEach((element) {
                      DateTime date =
                          DateFormat("yyyy-MM-dd").parse(element["date"]);
                      allPriceData.add(
                        CryptoCoinPriceData(
                            x: date, y: element["price"].toDouble()),
                      );
                    });
                  } else {
                    snapshot.data.forEach((element) {
                      DateTime date =
                          DateTime.fromMillisecondsSinceEpoch(element[0]);
                      // print(element[1]);
                      allPriceData.add(
                        CryptoCoinPriceData(x: date, y: element[1]),
                      );
                    });
                  }

                  return Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.22,
                        height: MediaQuery.of(context).size.height * 0.01,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'CHANGE(1D)',
                              style: new TextStyle(
                                  fontFamily: "Poppins",
                                  color: Color(0xFF000000),
                                  fontSize: 7.0,
                                  letterSpacing: 0.2),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 0.0),
                              child: Text(
                                companyPriceData(true, snapshot.data, isCrypto),
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
                          primaryXAxis: DateTimeAxis(isVisible: false),
                          primaryYAxis: NumericAxis(isVisible: false),
                          series: <ChartSeries>[
                            StackedAreaSeries<CryptoCoinPriceData, dynamic>(
                              dataSource: allPriceData,
                              xValueMapper: (CryptoCoinPriceData data, _) =>
                                  data.x,
                              yValueMapper: (CryptoCoinPriceData data, _) =>
                                  data.y,
                              gradient: gradientColors,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return SizedBox();
                }
              },
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

  bigItem(data) {
    return Container(
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
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
            // decoration: BoxDecoration(border: Border.all()),
            width: MediaQuery.of(context).size.width * 0.454,
            height: MediaQuery.of(context).size.height * 0.06,
            child: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Expanded(
                child: Text(
                  '${data[0]["name"]}',
                  style: new TextStyle(
                      fontFamily: "Poppins",
                      color: Color(0xFF000000),
                      fontSize: 15.0,
                      letterSpacing: 0.2),
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          // Container(
          //   width: MediaQuery.of(context).size.width * 0.454,
          //   height: MediaQuery.of(context).size.height * 0.03,
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: <Widget>[
          //       Padding(
          //         padding: EdgeInsets.only(top: 0.0, left: 8.0),
          //         child: Text(
          //           'CHANGE(1D)',
          //           style: new TextStyle(
          //               fontFamily: "Poppins",
          //               color: Color(0xFF000000),
          //               fontSize: 14.0,
          //               letterSpacing: 0.2),
          //         ),
          //       ),
          //       Padding(
          //         padding: EdgeInsets.only(top: 0.0, left: 15.0),
          //         child: Text(
          //           '27.18',
          //           style: new TextStyle(
          //               fontFamily: "Poppins",
          //               color: Color(0xFFe70b31),
          //               fontSize: 14.0,
          //               letterSpacing: 0.2),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Container(
            width: MediaQuery.of(context).size.width * 0.454,
            height: MediaQuery.of(context).size.height * 0.12,
            child: Image.asset(mapOfAuroStars[data[0]["name"]]["header_path"]),
          ),
          Container(
            // decoration: BoxDecoration(border: Border.all()),
            padding: EdgeInsets.only(top: 10.0),
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

  companyPriceData(diff, pricesData, isCrypto) {
    print(pricesData);

    if (pricesData == null || pricesData.length == 0) {
      if (diff) {
        return "0.00";
      } else {
        return "0.00(+0.00)";
      }
    } else {
      double lastItem = pricesData.length == 0
          ? 0.0
          : isCrypto
              ? pricesData[pricesData.length - 1][1]
              : pricesData[pricesData.length - 1]["price"];
      double secondLastItem = pricesData.length <= 1
          ? 0.0
          : isCrypto
              ? pricesData[pricesData.length - 2][1]
              : pricesData[pricesData.length - 2]["price"];
      print(secondLastItem);
      var companyPrice = lastItem;
      var companyPriceDifference =
          secondLastItem != 0 ? (lastItem - secondLastItem) : 0.0;
      print(companyPriceDifference);
      print(companyPrice);
      var companyPercentageDifference = companyPriceDifference == 0.0
          ? 0.0
          : companyPrice / companyPriceDifference;

      if (diff) {
        return '\$' + "${companyPrice.toStringAsFixed(1)}";
      } else {
        return "${companyPriceDifference.toStringAsFixed(1)} (${(companyPercentageDifference / 100).toStringAsFixed(1)}%)";
      }
    }
  }
}
