import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/provider_abhinav/long_short_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VotesQuarterlyColumnCharts extends StatefulWidget {
  final ticker;

  const VotesQuarterlyColumnCharts({Key key, this.ticker}) : super(key: key);

  @override
  _VotesQuarterlyColumnChartsState createState() =>
      _VotesQuarterlyColumnChartsState();
}

class _VotesQuarterlyColumnChartsState
    extends State<VotesQuarterlyColumnCharts> {
  @override
  Widget build(BuildContext context) {
    print("column");
    print(widget.ticker);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Long ",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    TextSpan(
                      text: "Short ",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    TextSpan(
                      text: "Votes(Quarterly)",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: Provider.of<LongShortProvider>(context, listen: false)
                    .getQuarterlyVotes(widget.ticker),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var chartData1 = [
                      ChartData(
                        "Q1",
                        snapshot.data["q1"]["long_votes"].toDouble(),
                        Colors.green,
                      ),
                      ChartData(
                          "Q1",
                          snapshot.data["q1"]["short_votes"].toDouble(),
                          Colors.red),
                    ];
                    var chartData2 = [
                      ChartData(
                          "Q2",
                          snapshot.data["q2"]["long_votes"].toDouble(),
                          Colors.green),
                      ChartData(
                          "Q2",
                          snapshot.data["q2"]["short_votes"].toDouble(),
                          Colors.red),
                    ];
                    var chartData3 = [
                      ChartData(
                          "Q3",
                          snapshot.data["q3"]["long_votes"].toDouble(),
                          Colors.green),
                      ChartData(
                          "Q3",
                          snapshot.data["q3"]["short_votes"].toDouble(),
                          Colors.red),
                    ];
                    var chartData4 = [
                      ChartData(
                          "Q4",
                          snapshot.data["q4"]["long_votes"].toDouble(),
                          Colors.green),
                      ChartData(
                          "Q4",
                          snapshot.data["q4"]["short_votes"].toDouble(),
                          Colors.red),
                    ];
                    return Container(
                      height: 200,
                      child: SfCartesianChart(
                        // title: ChartTitle(text: 'Long Short Votes Quarterly'),
                        primaryXAxis: CategoryAxis(),
                        series: <CartesianSeries>[
                          ColumnSeries<ChartData, String>(
                            dataSource: chartData1,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            pointColorMapper: (ChartData data, _) => data.color,
                            name: "Q1",
                          ),
                          ColumnSeries<ChartData, String>(
                            dataSource: chartData2,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            pointColorMapper: (ChartData data, _) => data.color,
                            name: "Q2",
                          ),
                          ColumnSeries<ChartData, String>(
                            dataSource: chartData3,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            pointColorMapper: (ChartData data, _) => data.color,
                            name: "Q3",
                          ),
                          ColumnSeries<ChartData, String>(
                            dataSource: chartData4,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            pointColorMapper: (ChartData data, _) => data.color,
                            name: "Q4",
                          ),
                        ],
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
