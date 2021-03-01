import 'package:auroim/model/tagAndChartData.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CryptoCoinCharts extends StatefulWidget {
  final List<Color> color;
  final List<double> stops;
  final List<NewCryptoPricesData> newSalesData;
  final double year;
  final double price;

  CryptoCoinCharts({
    this.color,
    this.newSalesData,
    this.stops,
    this.year,
    this.price,
  });

  @override
  _CryptoCoinChartsState createState() => _CryptoCoinChartsState();
}

class _CryptoCoinChartsState extends State<CryptoCoinCharts> {
  LinearGradient gradientColors;

  @override
  void initState() {
    gradientColors = LinearGradient(
      colors: widget.color,
      stops: widget.stops,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
        width: MediaQuery.of(context).size.width - 50,
        height: 70,
        child: Container(
          decoration: BoxDecoration(
            // border: Border.all(),
            color: Colors.white,
          ),
          // margin: EdgeInsets.only(left: 10.0),
          child: SfCartesianChart(
              primaryXAxis: NumericAxis(
                isVisible: false,
              ),
              primaryYAxis: NumericAxis(isVisible: false),
              series: <ChartSeries>[
                StackedAreaSeries<NewCryptoPricesData, double>(
                  dataSource: widget.newSalesData,
                  xValueMapper: (NewCryptoPricesData data, _) => data.year,
                  yValueMapper: (NewCryptoPricesData data, _) => data.price,
                  gradient: gradientColors,
                  borderColor: Colors.white,
                ),
              ]),
        ));
  }
}
