import 'package:auroim/api/future_return.dart';
import 'package:auroim/widgets/crypto_coin_price_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PortfolioReturnChart extends StatefulWidget {
  final userExpectedRiskData;
  final List<CryptoCoinPriceData> pricesData;

  PortfolioReturnChart({
    Key key,
    this.pricesData,
    this.userExpectedRiskData,
  }) : super(key: key);

  @override
  _PortfolioReturnChartState createState() => _PortfolioReturnChartState();
}

class _PortfolioReturnChartState extends State<PortfolioReturnChart> {
  ZoomPanBehavior _zoomPanBehavior;
  TooltipBehavior _tooltipBehavior;
  LinearGradient _linearGradient = LinearGradient(
    colors: [
      Color(0xFFCCDBED),
      Color(0xFF71BBF6),
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

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
      height: 300,
      width: MediaQuery.of(context).size.width - 20,
      child: SfCartesianChart(
        title: ChartTitle(
          text: "Realized Return",
          textStyle: TextStyle(
            fontWeight: FontWeight.w300,
          ),
        ),
        zoomPanBehavior: _zoomPanBehavior,
        tooltipBehavior: _tooltipBehavior,
        primaryXAxis: DateTimeAxis(),
        primaryYAxis: NumericAxis(
          isVisible: false,
        ),
        series: <ChartSeries>[
          SplineAreaSeries<CryptoCoinPriceData, dynamic>(
            name: "Price On",
            dataSource: widget.pricesData,
            xValueMapper: (CryptoCoinPriceData data, _) => data.x,
            yValueMapper: (CryptoCoinPriceData data, _) => data.y,
            gradient: _linearGradient,
          ),
        ],
      ),
    );
  }
}
