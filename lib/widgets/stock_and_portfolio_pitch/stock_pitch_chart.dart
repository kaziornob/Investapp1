import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../crypto_coin_price_data.dart';

class StockPitchChart extends StatefulWidget {
  final List<CryptoCoinPriceData> pricesData;

  StockPitchChart({
    this.pricesData,
  });
  @override
  _StockPitchChartState createState() => _StockPitchChartState();
}

class _StockPitchChartState extends State<StockPitchChart>{
  ZoomPanBehavior _zoomPanBehavior;
  TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
      enable: true,
    );
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
    );
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: SfCartesianChart(
        zoomPanBehavior: _zoomPanBehavior,
        tooltipBehavior: _tooltipBehavior,
        primaryXAxis: DateTimeAxis(
          title: AxisTitle(text: "Date"),
          maximum: widget.pricesData.length == 0
              ? null
              : widget.pricesData[0].x.add(
            Duration(days: 365),
          ),
          interval: 1,
        ),
        primaryYAxis: NumericAxis(
          title: AxisTitle(
            text: "Inception-to-date Annualized Return %",
            textStyle: TextStyle(
              color: Color(0xff5A56B9),
              fontSize: 10,
            ),
          ),
        ),

        series: <ChartSeries>[
          SplineSeries<CryptoCoinPriceData, dynamic>(
            name: "Price On",
            dataSource: widget.pricesData,
            xValueMapper: (CryptoCoinPriceData data, _) => data.x,
            yValueMapper: (CryptoCoinPriceData data, _) => data.y,
            // opacity: 0.5,
            color: Color(0xff5A56B9),
            // gradient: gradientColors,
          ),
        ],
      ),
    );
  }
}
