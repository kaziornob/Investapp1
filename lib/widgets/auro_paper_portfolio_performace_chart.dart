import 'package:auroim/api/future_return.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'crypto_coin_price_data.dart';

class AuroPaperPortfolioPerformaceChart extends StatefulWidget {
  // final List<Color> color;
  // final List<double> stops;
  final userExpectedRiskData;
  final List<CryptoCoinPriceData> pricesData;

  // final double year;
  // final double price;

  AuroPaperPortfolioPerformaceChart({
    // this.color,
    this.pricesData,
    this.userExpectedRiskData,
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
  FutureReturn _futureReturn = FutureReturn();

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

  calculate() {
    print("calculate");
    List<CryptoCoinPriceData> listOfChartData = [];
    var dateList = widget.pricesData.length == 0
        ? [
            DateTime.now(),
            DateTime.now().add(Duration(days: 91)),
            DateTime.now().add(Duration(days: 91 * 2)),
            DateTime.now().add(Duration(days: 91 * 3)),
            DateTime.now().add(Duration(days: 91 * 4)),
          ]
        : [
            widget.pricesData[0].x,
            widget.pricesData[0].x.add(Duration(days: 91)),
            widget.pricesData[0].x.add(Duration(days: 91 * 2)),
            widget.pricesData[0].x.add(Duration(days: 91 * 3)),
            widget.pricesData[0].x.add(Duration(days: 91 * 4)),
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
    return listOfChartData;
  }

  @override
  Widget build(BuildContext context) {
    // double val = 0.0;
    // List h = [];
    // widget.pricesData.forEach((element) {
    //  h.add(1 + (element.y/100));
    // });
    // var ff;
    // print(h);
    // int i=0;
    // h.forEach((element) {
    //   if(i==0){
    //     ff = element;
    //   }else{
    //     ff = element*ff;
    //   }
    //   i++;
    // });
    // print("cummulative sum : $ff");
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
        axes: <ChartAxis>[
          // DateTimeAxis(
          //   name: 'xAxis',
          //   opposedPosition: false,
          //   interval: 1,
          //   // title: AxisTitle(text: 'Year'),
          // ),
          NumericAxis(
            name: 'yAxis',
            opposedPosition: true,
            title: AxisTitle(
              text: 'Expected Return In US \$',
              textStyle: TextStyle(
                color: Colors.redAccent[400],
                fontSize: 12,
              ),
            ),
          )
        ],
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
          SplineSeries<CryptoCoinPriceData, dynamic>(
            name: "Return on",
            dataSource: calculate(),
            xValueMapper: (CryptoCoinPriceData data, _) => data.x,
            yValueMapper: (CryptoCoinPriceData data, _) => data.y,
            dashArray: <double>[5, 5],
            // gradient: gradientColors2,
            // borderWidth: 2,
            // borderColor: Colors.grey,
            color: Colors.redAccent[400],
            xAxisName: 'xAxis',
            yAxisName: 'yAxis',
          ),
        ],
      ),
    );
  }
}
