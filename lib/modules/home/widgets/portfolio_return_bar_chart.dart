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
    var chartDataExpectedDollars = [
      ChartData(
        "Expected",
        calculate().y-1000000.0,
        Color(0xFFCCDBED),
      ),
    ];
    var chartDataAnnualizedDollars = [
      ChartData(
        "Annualized",
        double.parse(widget.userAnnualizedReturnDollar),
        Color(0xFF71BBF6),
      ),
    ];
    var chartDataAnnualizedExpectedPerc = [
      ChartData(
        "Expected",
        ((calculate().y - 1000000) / 1000000) * 100,
        Color(0xFFCCDBED),
      ),
    ];
    var chartDataAnnualizedPerc = [
      ChartData(
        "Annualized",
        double.parse(widget.userAnnualizedReturnPerc),
        Color(0xFF71BBF6),
      ),
    ];
    return Padding(
      padding: const EdgeInsets.only(top:20.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Expanded(
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  labelStyle: TextStyle(
                    fontSize: 10,
                  ),
                  majorGridLines: MajorGridLines(
                    color: Colors.white,
                  ),
                  majorTickLines: MajorTickLines(
                    color: Colors.white,
                  ),
                  labelAlignment: LabelAlignment.end,
                ),
                primaryYAxis: NumericAxis(
                  labelStyle: TextStyle(
                    fontSize: 10,
                  ),
                  majorTickLines: MajorTickLines(
                    color: Colors.white,
                  ),
                ),
                series: <ChartSeries>[
                  ColumnSeries<ChartData, String>(
                    dataSource: chartDataAnnualizedDollars,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    pointColorMapper: (ChartData data, _) => data.color,
                  ),
                  ColumnSeries<ChartData, String>(
                    dataSource: chartDataExpectedDollars,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    pointColorMapper: (ChartData data, _) => data.color,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  labelStyle: TextStyle(
                    fontSize: 10,
                  ),
                  majorTickLines: MajorTickLines(
                    color: Colors.white,
                  ),
                  majorGridLines: MajorGridLines(
                    color: Colors.white,
                  ),
                  labelAlignment: LabelAlignment.end,

                ),
                primaryYAxis: NumericAxis(
                  labelStyle: TextStyle(
                    fontSize: 10,
                  ),
                  majorTickLines: MajorTickLines(
                    color: Colors.white,
                  ),
                  labelFormat: "{value}%",
                ),
                series: <ChartSeries>[
                  ColumnSeries<ChartData, String>(
                    dataSource: chartDataAnnualizedPerc,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    pointColorMapper: (ChartData data, _) => data.color,
                  ),
                  ColumnSeries<ChartData, String>(
                    dataSource: chartDataAnnualizedExpectedPerc,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    pointColorMapper: (ChartData data, _) => data.color,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
