
import 'package:auroim/api/reusable_functions.dart';
import 'package:auroim/provider_abhinav/stock_pitch_provider.dart';
import 'package:auroim/widgets/stock_and_portfolio_pitch/stock_pitch_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../crypto_coin_price_data.dart';

class StockPitchReturnChart extends StatefulWidget {
  final userInceptionDate;
  final userEmail;
  final pitchNumber;

  const StockPitchReturnChart({
    Key key,
    this.userInceptionDate,
    this.userEmail,
    this.pitchNumber,
  }) : super(key: key);

  @override
  _StockPitchReturnChartState createState() => _StockPitchReturnChartState();
}

class _StockPitchReturnChartState extends State<StockPitchReturnChart> {
  ReusableFunctions _reusableFunctions = ReusableFunctions();
  var allPriceData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<StockPitchProvider>(context, listen: false)
          .getDailyReturnChartList({
        "email": widget.userEmail,
        "pitch_number": widget.pitchNumber,
      }),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
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
          var companyPriceDifference =
              secondLastItem != 0 ? (lastItem - secondLastItem) : 0.0;
          var companyPriceDifferenceDollars = secondLastItemUsDollar != 0
              ? (lastItemUsDollar - secondLastItemUsDollar)
              : 0.0;
          // cum return t - cumm return t-1
          var last1DayReturnDollar = companyPriceDifferenceDollars;
          print(last1DayReturnDollar);
          // cumm return pct last value of time series
          var inceptionToDateReturnPct = allPriceData.length == 0
              ? 0.0
              : allPriceData[allPriceData.length - 1].y;
          print("inception to date return pct : $inceptionToDateReturnPct");
          // cumm return perc * client initial inv
          var inceptionToDateReturnDollar = inceptionToDateReturnPct * 1000000;
          DateTime dateOfCreation = allPriceData.length == 0
              ? DateTime.now()
              : DateTime.parse(widget.userInceptionDate);
          var daysDiff = DateTime.now().difference(dateOfCreation).inDays;
          print("days diff: " + daysDiff.toString());

          return Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Pitch - Profit and Loss",
                            style: TextStyle(
                              fontFamily: "RosarioSemiBold",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Image.asset(
                              "assets/growth_arrow.png",
                              width: 25,
                              height: 25,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Material(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  elevation: 10,
                  child: Container(
                    height: 330,
                    width: MediaQuery.of(context).size.width - 30,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20.0,
                            left: 12.0,
                            right: 20.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Profit since pitch",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "\$ ${inceptionToDateReturnDollar.toStringAsFixed(0).split(".")[0]}",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                            left: 12.0,
                            right: 20.0,
                            bottom: 8.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Profit last 1-day",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "\$ ${last1DayReturnDollar.toStringAsFixed(0).split(".")[0]}",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        StockPitchChart(
                          pricesData: allPriceData2,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 12.0, right: 8.0),
                          child: Container(
                            // decoration: BoxDecoration(border: Border.all()),
                            height: 50,
                            width: MediaQuery.of(context).size.width - 15,
                            child: Padding(
                              padding: const EdgeInsets.only(right:20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/growth_arrow_with_bars.png",
                                    width: 30,
                                    height: 30,
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
                                              fontSize: 12,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "\$1,000,000 for ",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "Moderate ",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                          TextSpan(
                                            text: "Investment Preferences",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
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
                        ),
                      ],
                    ),
                  ),
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
