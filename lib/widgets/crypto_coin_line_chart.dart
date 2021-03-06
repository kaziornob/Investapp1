import 'package:auroim/model/tagAndChartData.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'crypto_coin_price_data.dart';

class CryptoCoinLineCharts extends StatefulWidget {
  // final List<Color> color;
  // final List<double> stops;
  final List<CryptoCoinPriceData> pricesData;
  // final double year;
  // final double price;

  CryptoCoinLineCharts({
    // this.color,
    this.pricesData,
    // this.stops,
    // this.year,
    // this.price,
  });

  @override
  _CryptoCoinLineChartsState createState() => _CryptoCoinLineChartsState();
}

class _CryptoCoinLineChartsState extends State<CryptoCoinLineCharts> {
  // LinearGradient gradientColors;
  ZoomPanBehavior _zoomPanBehavior;
  TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    // gradientColors = LinearGradient(
    //   colors: widget.color,
    //   stops: widget.stops,
    // );
    _tooltipBehavior = TooltipBehavior(enable: true);
    _zoomPanBehavior = ZoomPanBehavior(enablePinching: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      // SizedBox(
      //   width: MediaQuery.of(context).size.width - 50,
      //   height: 70,
      //   child: Container(
      //     decoration: BoxDecoration(
      //       // border: Border.all(),
      //       color: Colors.white,
      //     ),
      //     // margin: EdgeInsets.only(left: 10.0),
      //     child:
      Container(
        height: 200,
        // alignment: AlignmentGeometry.lerp(a, b, t),
        child: SfCartesianChart(
          // legend: Legend(
          //   isVisible: true,
          // ),
          // backgroundColor: Colors.b,
          zoomPanBehavior: _zoomPanBehavior,
          tooltipBehavior: _tooltipBehavior,
          title: ChartTitle(
            text: "30D Price Change",
          ),
          primaryXAxis: DateTimeAxis(
            // title: AxisTitle(
            //   text: "Date",
            // ),
          ),
          primaryYAxis: NumericAxis(
            title: AxisTitle(text: "Price"),
            // numberFormat: NumberFormat.currency(
            //   locale: "en_US",
            // ),
            // minimum: 0.2,
          ),
          series: <ChartSeries>[
            LineSeries<CryptoCoinPriceData, dynamic>(
              name: "Price On",
              dataSource: widget.pricesData,
              xValueMapper: (CryptoCoinPriceData data, _) => data.x,
              yValueMapper: (CryptoCoinPriceData data, _) => data.y,
              // opacity: 0.5,
              color: Color(0xff5A56B9),
              // gradient: gradientColors,
            ),
            // HiloOpenCloseSeries<PriceModel, dynamic>(
            //   // name: "Crypto Prices",
            //   dataSource: getColumnData(),
            //   xValueMapper: (PriceModel data, _) => data.x,
            //   highValueMapper: (PriceModel data, _) => data.high,
            //   lowValueMapper: (PriceModel data, _) => data.low,
            //   openValueMapper: (PriceModel data, _) => data.open,
            //   closeValueMapper: (PriceModel data, _) => data.close,
            //   // yValueMapper: (PriceModel data, _) => data.y,
            //   dataLabelSettings: DataLabelSettings(
            //     isVisible: true,
            //     labelPosition: ChartDataLabelPosition.outside,
            //   ),
            // ),
          ],
        ),
      );
    // SfCartesianChart(
    //     primaryXAxis: NumericAxis(
    //       isVisible: false,
    //     ),
    //     primaryYAxis: NumericAxis(isVisible: false),
    //     series: <ChartSeries>[
    //       StackedAreaSeries<NewCryptoPricesData, double>(
    //         dataSource: widget.newSalesData,
    //         xValueMapper: (NewCryptoPricesData data, _) => data.year,
    //         yValueMapper: (NewCryptoPricesData data, _) => data.price,
    //         gradient: gradientColors,
    //         borderColor: Colors.white,
    //       ),
    //     ]),
    // ));
  }
}
