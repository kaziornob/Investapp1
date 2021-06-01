import 'package:auroim/api/future_return.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/widgets/crypto_coin_price_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PortfolioReturnBarChart extends StatefulWidget {
  final userExpectedRiskData;
  final userAnnualizedReturnPerc;
  final userAnnualizedReturnDollar;

  PortfolioReturnBarChart({
    Key key,
    this.userExpectedRiskData,
    this.userAnnualizedReturnDollar,
    this.userAnnualizedReturnPerc,
  }) : super(key: key);

  @override
  _PortfolioReturnBarChartState createState() =>
      _PortfolioReturnBarChartState();
}

class _PortfolioReturnBarChartState extends State<PortfolioReturnBarChart> {
  FutureReturn _futureReturn = FutureReturn();

  CryptoCoinPriceData calculate() {
    print("calculate");
    List<CryptoCoinPriceData> listOfChartData = [];
    var dateList = [
      DateTime.now(),
      DateTime.now().add(Duration(days: 91)),
      DateTime.now().add(Duration(days: 91 * 2)),
      DateTime.now().add(Duration(days: 91 * 3)),
      DateTime.now().add(Duration(days: 91 * 4)),
    ];
    for (int i = 0; i <= 1 * 4; i++) {
      listOfChartData.add(
        CryptoCoinPriceData(
          x: dateList[i],
          y: _futureReturn.calculate(
            widget.userExpectedRiskData != null
                ? widget.userExpectedRiskData["expected_return"]
                : 0.0,
            i / 4,
            0.0,
            1000000,
          ),
        ),
      );
    }
    print(listOfChartData.length);
    return listOfChartData[listOfChartData.length - 1];
  }

  @override
  Widget build(BuildContext context) {
    var chartData = [
      ChartData("Q4", calculate().y, Colors.green),
      // ChartData("Q4", 100000, Colors.red),
    ];
    return Container(
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <ChartSeries>[
          ColumnSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            pointColorMapper: (ChartData data, _) => data.color,
            name: "Q1",
          ),
          ColumnSeries<ChartData, String>(
            dataSource: [ChartData("Q4", 100000, Colors.red)],
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            pointColorMapper: (ChartData data, _) => data.color,
            name: "Q1",
          ),
        ],
      ),
    );
  }
}

