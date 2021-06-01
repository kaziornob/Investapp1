import 'dart:math';
import 'package:auroim/provider_abhinav/portfolio_provider.dart';
import 'package:auroim/widgets/crypto_coin_price_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AuroAiPortfolioValues extends StatefulWidget {
  const AuroAiPortfolioValues({Key key}) : super(key: key);

  @override
  _AuroAiPortfolioValuesState createState() => _AuroAiPortfolioValuesState();
}

class _AuroAiPortfolioValuesState extends State<AuroAiPortfolioValues> {
  bool _isinit = true;

  TextStyle smallTextStyle = TextStyle(
    color: Colors.black,
    fontFamily: "Roboto",
    fontSize: 12,
  );
  TextStyle smallTextStyleColored = TextStyle(
    color: Color(0xFF71A00C),
    fontFamily: "Roboto",
    fontSize: 12,
  );
  TextStyle bigTextStyle = TextStyle(
    color: Colors.black,
    fontFamily: "Roboto",
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  @override
  void didChangeDependencies() {
    if (_isinit) {
      Provider.of<PortfolioProvider>(context, listen: false)
          .getDailyReturnPortfolio();
      Provider.of<PortfolioProvider>(context, listen: false).getPortfolioData();
      _isinit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PortfolioProvider>(
      builder: (context, portfolioProvider, _) {
        if (portfolioProvider.dailyPortfolioReturnData != null &&
            portfolioProvider.portfolioData != null) {
          print("daily portfolio data gott");
          var allPriceData = [];
          var allPriceUsDollar = [];
          var allReturnPerc = [];
          portfolioProvider.dailyPortfolioReturnData.forEach((element) {
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
          List allPriceData2 = allPriceData
              .map(
                (e) => CryptoCoinPriceData(x: e.x, y: e.y * 100),
              )
              .toList();
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
          // print(secondLastItem);
          var companyPrice = lastItem;
          var companyPriceDifference =
              secondLastItem != 0 ? (lastItem - secondLastItem) : 0.0;
          var companyPriceDifferenceUsDollar = secondLastItemUsDollar != 0
              ? (lastItemUsDollar - secondLastItemUsDollar)
              : 0.0;
          var companyPercentageDifference = companyPriceDifference == 0.0
              ? 0.0
              : (lastItemUsDollar - secondLastItemUsDollar) /
                  secondLastItemUsDollar;
          var inception_to_date_return_pct = allPriceData.length == 0
              ? 0.0
              : allPriceData[allPriceData.length - 1].y;
          print("inception to date return pct : $inception_to_date_return_pct");
          // cumm return perc * client initial inv
          var inception_to_date_return_dollar =
              inception_to_date_return_pct * 1000000;
          DateTime date_of_creation = allPriceData.length == 0
              ? DateTime.now()
              : DateTime.parse(
                  portfolioProvider.portfolioData["portfolio_creation_date"]);
          var days_diff = DateTime.now().difference(date_of_creation).inDays;
          print("days diff: " + days_diff.toString());
          var inceptionToDateAnnualizedReturnPct =
              (pow(1 + inception_to_date_return_pct, (365 / days_diff)) - 1);

          return Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 40,
                height: MediaQuery.of(context).size.height / 5,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        "Auro.AI Portoflio",
                        style: bigTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${portfolioProvider.portfolioData["portfolio_creation_date"].toString().substring(0, 10)}",
                            style: smallTextStyle,
                          ),
                          Text(
                            "Auro portfolio creation date",
                            style: smallTextStyle,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${inceptionToDateAnnualizedReturnPct.toStringAsFixed(2)}%",
                            style: smallTextStyleColored,
                          ),
                          Text(
                            "Inception-to-date annualized return / Profits",
                            style: smallTextStyle,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${inception_to_date_return_pct.toStringAsFixed(2)}% / ${inception_to_date_return_dollar.toStringAsFixed(2).split(".")[0]}",
                            style: smallTextStyleColored,
                          ),
                          Text(
                            "Inception-to-date return / Profits",
                            style: smallTextStyle,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${companyPercentageDifference.toStringAsFixed(2)}% / ${companyPriceDifferenceUsDollar.toStringAsFixed(2).split(".")[0]}",
                            style: smallTextStyleColored,
                          ),
                          Text(
                            "Last 1 day return / Profits",
                            style: smallTextStyle,
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              Divider(thickness: 2,),
            ],
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
