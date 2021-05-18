import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../crypto_coin_price_data.dart';

class PublicCompanyHistoricalPerformanceChart extends StatefulWidget {
  final List<CryptoCoinPriceData> pricesData;

  const PublicCompanyHistoricalPerformanceChart({Key key, this.pricesData})
      : super(key: key);

  @override
  _PublicCompanyHistoricalPerformanceChartState createState() =>
      _PublicCompanyHistoricalPerformanceChartState();
}

class _PublicCompanyHistoricalPerformanceChartState
    extends State<PublicCompanyHistoricalPerformanceChart> {
  ZoomPanBehavior _zoomPanBehavior;
  TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    // print(widget.pricesData[0].y);
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
        primaryXAxis: DateTimeAxis(),
        primaryYAxis: NumericAxis(
          title: AxisTitle(
            text: "Price",
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
