import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'crypto_coin_price_data.dart';

class AuroPaperPortfolioPerformaceChart extends StatefulWidget {
  // final List<Color> color;
  // final List<double> stops;
  final List<CryptoCoinPriceData> pricesData;

  // final double year;
  // final double price;

  AuroPaperPortfolioPerformaceChart({
    // this.color,
    this.pricesData,
    // this.stops,
    // this.year,
    // this.price,
  });

  @override
  _AuroPaperPortfolioPerformaceChartState createState() =>
      _AuroPaperPortfolioPerformaceChartState();
}

class _AuroPaperPortfolioPerformaceChartState
    extends State<AuroPaperPortfolioPerformaceChart> {
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
    double val = 0.0;
    List h = [];
    widget.pricesData.forEach((element) {
     h.add(1 + (element.y/100));
    });
    var ff;
    print(h);
    int i=0;
    h.forEach((element) {
      if(i==0){
        ff = element;
      }else{
        ff = element*ff;
      }
      i++;
    });
    print("cummulative sum : $ff");
    return Container(
      height: 200,
      child: SfCartesianChart(
        zoomPanBehavior: _zoomPanBehavior,
        tooltipBehavior: _tooltipBehavior,
        primaryXAxis: DateTimeAxis(),
        primaryYAxis: NumericAxis(),
        annotations: <CartesianChartAnnotation>[
          CartesianChartAnnotation(
            widget: Container(
              child: Text(
                'Annualized Portfolio Return - +12.06%',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            coordinateUnit: CoordinateUnit.logicalPixel,
            x: 20, // x position of annotation
            y: 40, // y position of annotation
          )
        ],
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
