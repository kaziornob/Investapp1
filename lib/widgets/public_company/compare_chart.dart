import 'package:auroim/api/featured_companies_provider.dart';
import 'package:flutter/material.dart';

class CompareChartForPublicCompany extends StatelessWidget {
  final ticker;
  final companyData;

  CompareChartForPublicCompany({this.ticker, this.companyData});

  final FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          _featuredCompaniesProvider.getCompareChartForPublicCompany(ticker),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print("Compare Chart");
          print(snapshot.data);
          if (snapshot.data.length == 0) {
            return SizedBox();
          } else {
            return Container(
              height: 260,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, left: 10.0),
                    child: Container(
                      width: 120,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: Color(0xFFfec20f),
                          ),
                        ),
                      ),
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Compare',
                        style: new TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.black,
                          fontSize: 18.0,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  singleRow(
                    context,
                    "",
                    "",
                    "5y perf",
                    "1y perf",
                    "52w High",
                    "Low",
                    "5y High",
                    "Low",
                    Colors.indigo[50],
                  ),
                  singleRow(
                    context,
                    companyData["company_name"],
                    "",
                    snapshot.data["ticker_5y_performance"],
                    snapshot.data["ticker_1y_performance"],
                    // snapshot.data["52_week_high_index"],
                    // snapshot.data["52_week_low_index"],
                    snapshot.data["ticker_52_week_high"],
                    snapshot.data["ticker_52_week_low"],
                    snapshot.data["ticker_5y_high"],
                    snapshot.data["ticker_5y_low"],
                    Colors.indigo[100],
                  ),
                  singleRow(
                    context,
                    snapshot.data["sector"],
                    snapshot.data["related_index_name"],
                    snapshot.data["related_index_5y_return"],
                    snapshot.data["related_index_1y_return"],
                    // snapshot.data["52_week_high_index"],
                    // snapshot.data["52_week_low_index"],
                    snapshot.data["related_index_52_week_high"],
                    snapshot.data["related_index_52_week_low"],
                    "",
                    "",
                    Colors.indigo[100],
                  ),
                  singleRow(
                    context,
                    snapshot.data["country"],
                    snapshot.data["country_index_name"],
                    snapshot.data["country_index_5y_return"],
                    snapshot.data["country_index_1y_return"],
                    // snapshot.data["52_week_high_index"],
                    // snapshot.data["52_week_low_index"],
                    snapshot.data["country_index_52_week_high"],
                    snapshot.data["country_index_52_week_low"],
                    "",
                    "",
                    Colors.indigo[100],
                  ),
                ],
              ),
            );
          }
        } else {
          return SizedBox();
        }
      },
    );
  }

  singleRow(
    context,
    title,
    index_name,
    performance_5y,
    performance_1y,
    week_high_52,
    week_low_52,
    high_5y,
    low_5y,
    color,
  ) {
    // print("baba");
    print(week_low_52.runtimeType.toString());
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: color,
        ),
        height: 50,
        width: MediaQuery.of(context).size.width - 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
              width: (MediaQuery.of(context).size.width - 15) / 5,
              // height: 50,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text(
                      "$title",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "$index_name",
                      style: TextStyle(
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
              width: (MediaQuery.of(context).size.width - 15) / 5,
              // height: 50,
              child: Center(
                child: Text(
                  "$performance_5y",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
              width: (MediaQuery.of(context).size.width - 15) / 5,
              // height: 50,
              child: Center(
                child: Text(
                  "$performance_1y",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
              width: (MediaQuery.of(context).size.width - 15) / 5,
              child: Center(
                child: week_low_52.runtimeType.toString() == "double"
                    ? Text(
                        "${week_high_52.toStringAsFixed(2)}" +
                            "/" +
                            "${week_low_52.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        "$week_high_52" + "/" + "$week_low_52",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
              ),
            ),
            Container(
              // decoration: BoxDecoration(border: Border.all()),
              width: (MediaQuery.of(context).size.width - 15) / 5,
              child: Center(
                child: high_5y.runtimeType.toString() == "double"
                    ? Text(
                        "${high_5y.toStringAsFixed(2)}" +
                            "/" +
                            "${low_5y.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        "$high_5y" + "/" + "$low_5y",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
