import 'package:auroim/model/tagAndChartData.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FutureReturnChart extends StatefulWidget {
  final colors;
  final stops;
  final List<NewSalesData> pricesData;
  final List<NewSalesData> pricesDataOnlyInitial;

  FutureReturnChart({
    this.pricesData,
    this.pricesDataOnlyInitial,
    this.colors,
    this.stops,
  });

  @override
  _FutureReturnChartState createState() => _FutureReturnChartState();
}

class _FutureReturnChartState extends State<FutureReturnChart> {
  ZoomPanBehavior _zoomPanBehavior;
  TooltipBehavior _tooltipBehavior;
  LinearGradient gradientColors1;
  LinearGradient gradientColors2;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
      enable: true,
    );
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
    );
    gradientColors1 = LinearGradient(
      colors: widget.colors,
      stops: widget.stops,
    );
    gradientColors2 = LinearGradient(
      colors: [
        Colors.blue[50],
        Colors.blue[100],
        Colors.blue[200],
      ],
      stops: widget.stops,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.only(
          left: 8,
        ),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Color(0xff5A56B9),
              width: 4,
            ),
            right: BorderSide(
              color: Color(0xff5A56B9),
              width: 4,
            ),
          ),
        ),
        height: 200,
        child: SfCartesianChart(
          zoomPanBehavior: _zoomPanBehavior,
          tooltipBehavior: _tooltipBehavior,
          primaryXAxis: NumericAxis(
            title: AxisTitle(
              text: "Year",
              textStyle: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          primaryYAxis: NumericAxis(
            isVisible: false,
            maximum: widget.pricesData.length == 0
                ? null
                : widget.pricesData[widget.pricesData.length - 1].sales,
            minimum: widget.pricesDataOnlyInitial.length == 0
                ? null
                : widget.pricesDataOnlyInitial[0].sales,
          ),
          series: <ChartSeries>[
            SplineAreaSeries<NewSalesData, dynamic>(
              name: "Return on",
              dataSource: widget.pricesData,
              xValueMapper: (NewSalesData data, _) => data.year,
              yValueMapper: (NewSalesData data, _) => data.sales,
              // opacity: 0.5,
              gradient: gradientColors1,
              borderWidth: 2,
              borderColor: Colors.blueAccent,
            ),
            SplineAreaSeries<NewSalesData, dynamic>(
              name: "Return on",
              dataSource: widget.pricesDataOnlyInitial,
              xValueMapper: (NewSalesData data, _) => data.year,
              yValueMapper: (NewSalesData data, _) => data.sales,
              dashArray: <double>[5, 5],
              gradient: gradientColors2,
              borderWidth: 2,
              borderColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
