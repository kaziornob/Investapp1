import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/modules/home/widgets/portfolio_return_bar_chart.dart';
import 'package:auroim/modules/home/widgets/portfolio_return_chart.dart';
import 'package:auroim/provider_abhinav/portfolio_provider.dart';
import 'package:auroim/reusable_widgets/screen_title_appbar.dart';
import 'package:auroim/widgets/crypto_coin_price_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AuroPortfolioReturn extends StatefulWidget {
  const AuroPortfolioReturn({Key key}) : super(key: key);

  @override
  _AuroPortfolioReturnState createState() => _AuroPortfolioReturnState();
}

class _AuroPortfolioReturnState extends State<AuroPortfolioReturn> {
  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder(
          future: _featuredCompaniesProvider.getGoproRiskMetricsForUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var userExpectedReturnData = snapshot.data;
              return Consumer<PortfolioProvider>(
                builder: (context, portfolioProvider, _) {
                  print("daily portfolio data gott");
                  var allPriceData = [];
                  var allPriceUsDollar = [];
                  var allReturnPerc = [];
                  portfolioProvider.dailyPortfolioReturnData.forEach((element) {
                    DateTime date = DateFormat("yyyy-MM-ddTHH:mm:ss")
                        .parse(element["date"]);
                    if (element["cumm_return_perc"] != null) {
                      allPriceData.add(
                        CryptoCoinPriceData(
                            x: date, y: element["cumm_return_perc"]),
                      );
                      allPriceUsDollar.add(
                        CryptoCoinPriceData(x: date, y: element["cumm_return"]),
                      );
                      allReturnPerc.add(
                        CryptoCoinPriceData(
                            x: date, y: element["daily_return"]),
                      );
                    }
                  });
                  List allPriceData2 = allPriceData
                      .map((e) => CryptoCoinPriceData(x: e.x, y: e.y * 100))
                      .toList();
                  return Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20.0,
                            ),
                            child: ScreenTitleAppbar(
                              colorText: Color(0xFFD8AF4F),
                              title: "PORTFOLIO MIX",
                            ),
                          ),
                          PortfolioReturnChart(
                            pricesData: allPriceData2,
                            userExpectedRiskData: userExpectedReturnData,
                          ),
                          PortfolioReturnBarChart(
                            userExpectedRiskData: userExpectedReturnData,
                            userAnnualizedReturnDollar: portfolioProvider
                                .portfolioData["portfolio_return_dollar"]
                                .toStringAsFixed(2),
                            userAnnualizedReturnPerc: portfolioProvider
                                .portfolioData["portfolio_return"]
                                .toStringAsFixed(2),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
