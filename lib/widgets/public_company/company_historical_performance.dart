import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/provider_abhinav/public_company_historical_pricing.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../auro_paper_portfolio_performace_chart.dart';
import '../crypto_coin_price_data.dart';

class PublicCompanyHistoricalPerformance extends StatefulWidget {
  final ticker;

  PublicCompanyHistoricalPerformance({this.ticker});

  @override
  _PublicCompanyHistoricalPerformanceState createState() =>
      _PublicCompanyHistoricalPerformanceState();
}

class _PublicCompanyHistoricalPerformanceState
    extends State<PublicCompanyHistoricalPerformance> {
  Map<String, bool> selectedTabMap = {
    "6m": true,
    "1y": false,
    "2y": false,
    "3y": false,
    "5y": false,
    "max": false,
  };

  int noOfDays = 180;
  List<CryptoCoinPriceData> allPriceData = [];

  @override
  Widget build(BuildContext context) {
    Provider.of<PublicCompanyHistoricalPricing>(context, listen: false)
        .getSinglePublicCompanyData(widget.ticker, 180);
    return StatefulBuilder(
      builder: (context, setChartState) {
        return Material(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.white),
          ),
          elevation: 4,
          child: Container(
            height: 300,
            width: MediaQuery.of(context).size.width - 15,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 15,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Historical Pricing",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Roboto",
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Consumer<PublicCompanyHistoricalPricing>(
                  builder: (context, historicalPricingProvider, _) {
                    if (historicalPricingProvider.historicalPriceData.length ==
                        0) {
                      return Container(
                        child: Center(
                          child: Text("Fetching Prices.."),
                        ),
                      );
                    } else {
                      allPriceData = [];
                      historicalPricingProvider.historicalPriceData
                          .forEach((element) {
                        DateTime date =
                            DateFormat("yyyy-MM-dd").parse(element["date"]);
                        allPriceData.add(
                          CryptoCoinPriceData(
                              x: date, y: element["price"].toDouble()),
                        );
                      });

                      return AuroPaperPortfolioPerformaceChart(
                        pricesData: allPriceData,
                      );
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 8.0,
                  ),
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width - 15,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      children: [
                        selectedTab("6m", selectedTabMap["6m"], setChartState),
                        selectedTab("1y", selectedTabMap["1y"], setChartState),
                        selectedTab("2y", selectedTabMap["2y"], setChartState),
                        selectedTab("3y", selectedTabMap["3y"], setChartState),
                        selectedTab("5y", selectedTabMap["5y"], setChartState),
                        selectedTab(
                            "max", selectedTabMap["max"], setChartState),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  getNoOfDays(text) {
    switch (text) {
      case "6m":
        return 180;
      case "1y":
        return 365;
      case "2y":
        return 365 * 2;
      case "3y":
        return 365 * 3;
      case "5y":
        return 365 * 5;
      default:
        return 180;
    }
  }

  selectedTab(text, selected, setChartState) {
    return GestureDetector(
      onTap: () {
        print("tab pressed");
        setChartState(() {
          noOfDays = getNoOfDays(text);
          Provider.of<PublicCompanyHistoricalPricing>(context, listen: false)
              .getSinglePublicCompanyData(widget.ticker, noOfDays);
          selectedTabMap.forEach((key, value) {
            if (key == text) {
              selectedTabMap[key] = true;
            } else {
              selectedTabMap[key] = false;
            }
          });
        });
      },
      child: Material(
        elevation: selected ? 4 : 0,
        child: Container(
          width: (MediaQuery.of(context).size.width - 15) / 6,
          decoration: BoxDecoration(
            borderRadius:
                selected ? BorderRadius.circular(4) : BorderRadius.circular(0),
            color: selected ? Color(0xff5A56B9) : Colors.grey[200],
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: selected ? Colors.white : Colors.grey,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
