import 'dart:math';

import 'package:auroim/api/reusable_functions.dart';
import 'package:auroim/provider_abhinav/personal_sleeve_provider.dart';
import 'package:auroim/widgets/stock_and_portfolio_pitch/stock_pitch_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../crypto_coin_price_data.dart';

class PersonalSleeveReturnChart extends StatefulWidget {
  final userInceptionDate;

  const PersonalSleeveReturnChart({
    Key key,
    this.userInceptionDate,
  }) : super(key: key);

  @override
  _PersonalSleeveReturnChartState createState() =>
      _PersonalSleeveReturnChartState();
}

class _PersonalSleeveReturnChartState extends State<PersonalSleeveReturnChart> {
  ReusableFunctions _reusableFunctions = ReusableFunctions();
  var allPriceData;

  @override
  Widget build(BuildContext context) {
    // print("stock_pitch return ");
    // print(widget.userEmail);
    return FutureBuilder(
      future: Provider.of<PersonalSleeveProvider>(context, listen: false)
          .getDailyReturnPortfolio(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print("daily portfolio data gott");
          allPriceData = [];
          var allPriceUsDollar = [];
          var allReturnPerc = [];
          var returnData = snapshot.data;
          returnData.forEach((element) {
            DateTime date =
                DateFormat("yyyy-MM-ddTHH:mm:ss").parse(element["date"]);
            if (element["cumm_return_perc"] != null) {
              allPriceData.add(
                CryptoCoinPriceData(x: date, y: element["cumm_return_perc"]),
              );
              allPriceUsDollar.add(
                CryptoCoinPriceData(x: date, y: element["cumm_return"]),
              );
              allReturnPerc.add(
                CryptoCoinPriceData(x: date, y: element["daily_return"]),
              );
            }
          });
          List<CryptoCoinPriceData> allPriceData2 = allPriceData
              .map<CryptoCoinPriceData>(
                (e) => CryptoCoinPriceData(x: e.x, y: e.y * 100),
              )
              .toList();
          print("length: ${allPriceData.length}");
          double lastItem = allPriceData.length == 0
              ? 0.0
              : allPriceData[allPriceData.length - 1].y;
          double lastItemUsDollar = allPriceUsDollar.length == 0
              ? 0.0
              : allPriceUsDollar[allPriceUsDollar.length - 1].y;
          double secondLastItem = allPriceData.length <= 1
              ? 0.0
              : allPriceData[allPriceData.length - 2].y;
          double secondLastItemUsDollar = allPriceUsDollar.length <= 1
              ? 0.0
              : allPriceUsDollar[allPriceUsDollar.length - 2].y;
          print(secondLastItem);
          var companyPrice = lastItem;
          var companyPriceDifference =
              secondLastItem != 0 ? (lastItem - secondLastItem) : 0.0;
          var companyPriceDifferenceUsDollar = secondLastItemUsDollar != 0
              ? (lastItemUsDollar - secondLastItemUsDollar)
              : 0.0;
          print(companyPriceDifference);
          print(companyPrice);
          print("seconds: $secondLastItemUsDollar");
          var companyPercentageDifference = companyPriceDifference == 0.0
              ? 0.0
              : (lastItemUsDollar - secondLastItemUsDollar) /
                  secondLastItemUsDollar;

          // last return perc value
          var last_1_day_return_pct = companyPercentageDifference;
          // cum return t - cumm return t-1
          var last_1_day_return_dollar = companyPriceDifference;
          // cumm return pct last value of time series
          var inception_to_date_return_pct = allPriceData.length == 0
              ? 0.0
              : allPriceData[allPriceData.length - 1].y;
          print("inception to date return pct : $inception_to_date_return_pct");
          // cumm return perc * client initial inv
          var inception_to_date_return_dollar =
              inception_to_date_return_pct * 1000000;
          DateTime date_of_creation = allPriceData.length == 0
              ? DateTime.now()
              : DateTime.parse(widget.userInceptionDate);
          // String date_of_creation_string = "${date_of_creation.day} " +
          //     "${months[date_of_creation.month - 1]}," +
          //     "${date_of_creation.year}";
          var days_diff = DateTime.now().difference(date_of_creation).inDays;
          print("days diff: " + days_diff.toString());
          // var client_portfolio_creation_date;
          // ((1+inception_to_date_return_pct) ** (365/total_duration_of_investment))-1
          var inceptionToDateAnnualizedReturnPct =
              (pow(1 + inception_to_date_return_pct, (365 / days_diff)) - 1);

          // print(
          //     "inception to date annualized return : ${pow(1 + inception_to_date_return_pct, (365 / days_diff))}");
          print(
              "inception to date annualized return : $inceptionToDateAnnualizedReturnPct");
          // var h = [];
          // portfolioProvider.dailyPortfolioReturnData.forEach((element) {
          //   h.add(1 + element["daily_return"] / 100);
          // });
          // var ff;
          // print(h);
          // var k = 0;
          // h.forEach((element) {
          //   if (k == 0) {
          //     ff = element;
          //   } else {
          //     ff = element * ff;
          //   }
          //   k++;
          // });
          // print("cummulative sum : $ff");
          return Container(
            height: 400,
            width: MediaQuery.of(context).size.width - 30,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 15,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Your Portfolio Pitch Performance",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Roboto",
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 12.0,
                    right: 8.0,
                    bottom: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: inceptionToDateAnnualizedReturnPct > 0
                                  ? "+"
                                  : "",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "${(inceptionToDateAnnualizedReturnPct * 100).toStringAsFixed(2)}%",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Inception-to-date annualized return",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, right: 8.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: widget.userInceptionDate
                                  .toString()
                                  .substring(0, 10),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Auro Portfolio creation date",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 12.0,
                    right: 8.0,
                    bottom: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  inception_to_date_return_pct > 0 ? "+" : "",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "${(inception_to_date_return_pct * 100).toStringAsFixed(2)}% / \$${_reusableFunctions.formatCurrencyNo("${inception_to_date_return_dollar.toStringAsFixed(0)}").split(".")[0]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Inception-to-date return (% / \$)",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, right: 8.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  companyPercentageDifference > 0 ? "+" : "",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "${(companyPercentageDifference * 100).toStringAsFixed(2)}% / \$${_reusableFunctions.formatCurrencyNo(companyPriceDifferenceUsDollar.toStringAsFixed(2)).split(".")[0]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Last 1 day return (% / \$)",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                StockPitchChart(
                  pricesData: allPriceData2,
                  // userExpectedRiskData: widget.userExpectedReturnData,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                  child: Container(
                    // decoration: BoxDecoration(border: Border.all()),
                    height: 50,
                    width: MediaQuery.of(context).size.width - 15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          FontAwesomeIcons.chartLine,
                          color: Color(0xff5A56B9),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: RichText(
                            softWrap: true,
                            overflow: TextOverflow.clip,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      "Historical returns displayed for Investment of ",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                TextSpan(
                                  text: "\$",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: "1,000,000 for ",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                TextSpan(
                                  text: "Moderate ",
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                  ),
                                ),
                                TextSpan(
                                  text: "Investment Preferences",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Container(
                //   width: MediaQuery.of(context).size.width - 35,
                //   height: 50,
                //   child: RaisedButton(
                //     elevation: 10,
                //     onPressed: () {},
                //     child: Text(
                //       "INVEST NOW",
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //         fontSize: 15,
                //       ),
                //     ),
                //     color: Color(0xff7499C6),
                //     shape: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(5),
                //       borderSide: BorderSide(
                //         color: Color(0xff7499C6),
                //       ),
                //     ),
                //   ),
                // )
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
