import 'package:auroim/api/reusable_functions.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/modules/investRelatedPages/riskOnboardingPages/onBoardingFirst.dart';
import 'package:auroim/provider_abhinav/portfolio_provider.dart';
import 'package:auroim/reusable_widgets/screen_title_appbar.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AuroPortfolioMix extends StatefulWidget {
  const AuroPortfolioMix({Key key}) : super(key: key);

  @override
  _AuroPortfolioMixState createState() => _AuroPortfolioMixState();
}

class _AuroPortfolioMixState extends State<AuroPortfolioMix> {
  List<ChartData> homeChartData;
  ReusableFunctions _reusableFunctions = ReusableFunctions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<PortfolioProvider>(
          builder: (context, portfolioProvider, _) {
            if (portfolioProvider.portfolioData != null) {
              var centerTextValueList = [
                "${_reusableFunctions.formatCurrencyNo(portfolioProvider.portfolioData["portfolio_return_dollar"].toStringAsFixed(0)).split(".")[0]}",
                '${portfolioProvider.portfolioData["portfolio_inception_return"].toStringAsFixed(2)}%',
                "${portfolioProvider.portfolioData["portfolio_return"].toStringAsFixed(0).split(".")[0]}%",
              ];
              var centerTextList = [
                "Profit",
                "Inception-to-date return %",
                "Annualized Return %",
              ];
              var chartDataList = [
                setHomeDoughnutChartData(portfolioProvider.portfolioData, 0),
                setHomeDoughnutChartData(portfolioProvider.portfolioData, 1),
                setHomeDoughnutChartData(portfolioProvider.portfolioData, 2),
              ];
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
                      charts(
                        centerTextValueList,
                        centerTextList,
                        chartDataList,
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Auro Portfolio Not Created"),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) =>
                                OnBoardingFirst(callingFrom: ""),
                          ),
                        );
                      },
                      child: Text(
                        "Customize Your Portfolio",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  charts(centerTextValueList, centerTextList, chartDataList) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        children: [
          chart(
            "% Asset Class",
            centerTextValueList[0],
            centerTextList[0],
            chartDataList[0],
          ),
          chart(
            "% Country",
            centerTextValueList[1],
            centerTextList[1],
            chartDataList[1],
          ),
          chart(
            "% Sector",
            centerTextValueList[2],
            centerTextList[2],
            chartDataList[2],
          ),
        ],
      ),
    );
  }

  chart(title, centerTextValue, centerText, chartData) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SfCircularChart(
        title: ChartTitle(
          alignment: ChartAlignment.center,
          text: title,
          textStyle: TextStyle(
            fontFamily: "Roboto",
            color: Colors.grey[800],
          ),
        ),
        annotations: <CircularChartAnnotation>[
          CircularChartAnnotation(
            widget: Container(
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "$centerTextValue",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "$centerText",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            verticalAlignment: ChartAlignment.near,
            horizontalAlignment: ChartAlignment.near,
            height: "60.0",
            width: "90.0",
            angle: 200,
            radius: "47",
          )
        ],
        legend: Legend(
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap,
          itemPadding: 5.0,
          legendItemBuilder: (name, series, point, index) {
            var changesString = name.replaceAll("_", " ").toLowerCase();
            // print("legend");
            DoughnutSeriesRenderer ss = series;
            ChartPoint<dynamic> dd = point;
            return Container(
              padding: EdgeInsets.all(1.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: dd.color,
                    radius: 5,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    changesString,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Ubuntu",
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        series: <CircularSeries>[
          DoughnutSeries<ChartData, String>(
            radius: "110%",
            innerRadius: '60%',
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              useSeriesColor: true,
              showCumulativeValues: true,
              showZeroValue: true,
            ),
          )
        ],
      ),
    );
  }

  setHomeDoughnutChartData(portfolioChartData, index) {
    if (portfolioChartData != null && portfolioChartData != false) {
      if (index == 0 && portfolioChartData["data"] != null) {
        print("in bro index 0");
        homeChartData = [];

        portfolioChartData["assetClass"].forEach((key, value) {
          homeChartData.add(
            ChartData(
              '$key',
              double.parse((value.toDouble() * 100).toInt().toString()),
              globals.isGoldBlack ? Color(0xFFE8E2DB) : Color(0xFF1D6177),
            ),
          );
        });
        print(homeChartData.length);
        return homeChartData;
        // final
      } else if (index == 1) {
        print("in bro index 1");
        homeChartData = [];
        portfolioChartData["country"].forEach((key, value) {
          homeChartData.add(
            ChartData(
              '$key',
              double.parse((value.toDouble() * 100).toInt().toString()),
              globals.isGoldBlack ? Color(0xFFE8E2DB) : Color(0xFF1D6177),
            ),
          );
        });
        print(homeChartData.length);
        return homeChartData;
      } else if (index == 2) {
        print("in bro index 2");
        homeChartData = [];

        portfolioChartData["sector"].forEach((key, value) {
          homeChartData.add(
            ChartData(
              '$key',
              double.parse((value.toDouble() * 100).toInt().toString()),
              globals.isGoldBlack ? Color(0xFFE8E2DB) : Color(0xFF1D6177),
            ),
          );
        });
        print(homeChartData.length);
        return homeChartData;
      }
    }
  }
}
