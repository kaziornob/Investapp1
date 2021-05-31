import 'package:auroim/static_data/static_data.dart';
import 'package:flutter/material.dart';

class StockPitchReturnDrawdown extends StatelessWidget {
  final DateTime date;
  final pitchData;

  StockPitchReturnDrawdown({
    Key key,
    this.date,
    this.pitchData,
  }) : super(key: key);

  final DateTime dateToday = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        width: MediaQuery.of(context).size.width - 30,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            box1(),
            box2(),
            box3(),
          ],
        ),
      ),
    );
  }

  box1() {
    var pitchDateReturn =
        ((pitchData["price_base"] - pitchData["inception_price"]) /
            pitchData["inception_price"]);
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWidget(
                    "@Pitched date: ${date.day}${StaticData.monthList[date.month - 1]}'${date.year.toString().substring(2, 4)}",
                    "RosarioSemiBold",
                    false,
                  ),
                  textWidget(
                    "Price",
                    "RosarioSemiBold",
                    false,
                  ),
                  textWidget(
                    "Return",
                    "RosarioSemiBold",
                    false,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWidget(
                    "1-yr Target",
                    "RosarioSemiBold",
                    true,
                  ),
                  textWidget(
                    "${pitchData["currency_selected"] ?? "USD"} ${pitchData["price_base"].toStringAsFixed(2)}",
                    "Roboto",
                    false,
                  ),
                  textWidget(
                    "${(pitchDateReturn * 100).toStringAsFixed(2)}%",
                    "Roboto",
                    false,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWidget(
                    "Current Price",
                    "RosarioSemiBold",
                    true,
                  ),
                  textWidget(
                    "${pitchData["currency_selected"] ?? "USD"} ${pitchData["inception_price"].toStringAsFixed(2)}",
                    "Roboto",
                    false,
                  ),
                  textWidget(
                    "",
                    "Roboto",
                    false,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  box2() {
    var todayDateReturn =
        ((pitchData["price_base"] - pitchData["current_price"]) /
            pitchData["current_price"]);
    var actualReturn =
        ((pitchData["current_price"] - pitchData["inception_price"]) /
            pitchData["inception_price"]);
    var drawdown = ((pitchData["price_bear"] - pitchData["current_price"]) /
        pitchData["current_price"]);
    return Container(
      color: Color(0xFFE2EFDB),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  textWidget(
                    "@Today's date: ${dateToday.day}${StaticData.monthList[dateToday.month - 1]}'${dateToday.year.toString().substring(2, 4)}",
                    "RosarioSemiBold",
                    false,
                  ),
                  textWidget(
                    "Price",
                    "RosarioSemiBold",
                    false,
                  ),
                  textWidget(
                    "Return",
                    "RosarioSemiBold",
                    false,
                  ),
                  textWidget(
                    "Drawdown",
                    "RosarioSemiBold",
                    false,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  textWidgetEmpty(
                    "1-yr Target",
                    "RosarioSemiBold",
                    true,
                  ),
                  textWidget(
                    "${pitchData["currency_selected"] ?? "USD"} ${pitchData["price_base"].toStringAsFixed(2)}",
                    "Roboto",
                    false,
                  ),
                  textWidget(
                    "${(todayDateReturn * 100).toStringAsFixed(2)}%",
                    "Roboto",
                    false,
                  ),
                  textWidget(
                    "${(drawdown * 100).toStringAsFixed(2)}%",
                    "Roboto",
                    false,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  textWidgetEmpty(
                    "Current Price",
                    "RosarioSemiBold",
                    true,
                  ),
                  textWidget(
                    "${pitchData["currency_selected"] ?? "USD"}  ${pitchData["current_price"].toStringAsFixed(2)}",
                    "Roboto",
                    false,
                  ),
                  textWidget(
                    "${(actualReturn * 100).toStringAsFixed(2)}%",
                    "Roboto",
                    false,
                  ),
                  textWidget(
                    "${double.parse(pitchData["drawdown"]).toStringAsFixed(2)}%",
                    "Roboto",
                    false,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  box3() {
    var todayDateReturn =
        ((pitchData["price_base"] - pitchData["current_price"]) /
            pitchData["current_price"]);
    var actualReturn =
        ((pitchData["current_price"] - pitchData["inception_price"]) /
            pitchData["inception_price"]);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: todayDateReturn > 0 && actualReturn > 0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/like_sharp_green.png",
                  height: 20,
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Pitch Working",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: !(todayDateReturn > 0 && actualReturn > 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/dislike_sharp_red.png",
                  height: 20,
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Pitch Not Working",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  textWidgetEmpty(text, fontFamily, underline) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        top: 8.0,
        bottom: 8.0,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: fontFamily,
          decoration: underline ? TextDecoration.underline : null,
          fontSize: 14,
          color: Color(0xFFE2EFDB),
        ),
      ),
    );
  }

  textWidget(text, fontFamily, underline) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        top: 8.0,
        bottom: 8.0,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: fontFamily,
          decoration: underline ? TextDecoration.underline : null,
          fontSize: 14,
        ),
      ),
    );
  }
}
