import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CustomProgressBar extends StatefulWidget {
  final percentage;
  final width;

  const CustomProgressBar({
    Key key,
    this.width,
    this.percentage,
  }) : super(key: key);

  @override
  _CustomProgressBarState createState() => _CustomProgressBarState();
}

class _CustomProgressBarState extends State<CustomProgressBar> {
  LinearGradient progressGradient = LinearGradient(
    colors: [
      Color(0xFF235E77),
      Color(0xFF1A3263),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LinearPercentIndicator(
          // restartAnimation: false,
          // animation: true,
          percent: widget.percentage / 100,
          linearGradient: progressGradient,
          lineHeight: 9,
          width: widget.width,
          trailing: Text("${widget.percentage.toString().split(".")[0]}%"),
        ),
      ],
    );
    ;
  }
}
