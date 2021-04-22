import 'package:flutter/material.dart';

class ReturnDrawdownWidget extends StatelessWidget {
  final showMore;
  final data;

  ReturnDrawdownWidget({Key key, this.showMore, this.data}) : super(key: key);

  final List monthList = [
    "Jan",
    "Feb",
    "Mar",
    "April",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Container(
                // decoration: BoxDecoration(
                //   border: Border.all(),
                // ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("Return "),
                          Tooltip(
                            message: "Return",
                            child: Icon(
                              Icons.help,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("Drawdown "),
                          Tooltip(
                            message: "Drawdown",
                            child: Icon(
                              Icons.help,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    showMore
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text("Volatility "),
                                Tooltip(
                                  message: "Volatility",
                                  child: Icon(
                                    Icons.help,
                                    size: 15,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(),
                    showMore
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text("Sharpe Ratio "),
                                Tooltip(
                                  message: "Sharpe Ratio",
                                  child: Icon(
                                    Icons.help,
                                    size: 15,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Target",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 4,
                    height: 50,
                  ),
                  Container(
                    height: showMore ? 140 : 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:15),
                          child: Text(
                              "${(data["target_return"] * 100).toStringAsFixed(2)} %"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:15.0),
                          child: Text(
                              "${(data["target_drawdown"] * 100).toStringAsFixed(2)} %"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Realization",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                      overflow: TextOverflow.clip,

                    ),
                  ),
                  Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(),
                    // ),
                    width: MediaQuery.of(context).size.width / 4,
                    height: 50,
                    child: Text(
                      "(base on current price as of \n${DateTime.now().day}th ${monthList[DateTime.now().month - 1]}, ${DateTime.now().year})",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Container(
                    height: showMore ? 140 : 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Text(
                              "${(data["realization_itd_perc"] * 100).toStringAsFixed(2)} %"),
                        ),
                        Text(
                          "ITD Return %",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Text(
                              "${(data["realization_annual_return_perc"] * 100).toStringAsFixed(2)} %"),
                        ),
                        Container(
                          width: 80,
                          child: Text(
                            "Annualized Return %",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
