import 'package:auroim/widgets/stock_and_portfolio_pitch/return_drawdown_widget.dart';
import 'package:flutter/material.dart';

class ShowPortfolioPitchPage extends StatefulWidget {
  final portfolioData;

  const ShowPortfolioPitchPage({Key key, this.portfolioData}) : super(key: key);

  @override
  _ShowPortfolioPitchPageState createState() => _ShowPortfolioPitchPageState();
}

class _ShowPortfolioPitchPageState extends State<ShowPortfolioPitchPage> {
  List monthList = [
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
    DateTime date = DateTime.parse(widget.portfolioData["date"]);
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        Text(
                          "Portfolio Pitch",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: 60,
                      child: Image.asset('assets/logo.png'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                          "Created on ${date.day}th ${monthList[date.month - 1]}, ${date.year}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        widget.portfolioData["isLong"] == 0
                            ? "Short Pitch"
                            : "Long Pitch",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                ReturnDrawdownWidget(
                  showMore: true,
                  data: widget.portfolioData,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Text("Portfolio Strategy"),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "${widget.portfolioData["portfolio_strategy"]}"),
                      ),
                      width: MediaQuery.of(context).size.width - 30,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 30,
                              width:
                                  (MediaQuery.of(context).size.width - 60) / 3,
                              child: Center(
                                child: Text(
                                  "Securities",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 30,
                              width:
                                  (MediaQuery.of(context).size.width - 60) / 3,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Initial Wt",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Tooltip(
                                      message: "",
                                      child: Icon(
                                        Icons.help,
                                        size: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 30,
                              width:
                                  (MediaQuery.of(context).size.width - 60) / 3,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Current Wt",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Tooltip(
                                      message: "",
                                      child: Icon(
                                        Icons.help,
                                        size: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children:
                            (widget.portfolioData["all_tikers_data"] as List)
                                .map<Widget>((item) {
                          return securityListRow(item);
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 50,
                          width: (MediaQuery.of(context).size.width - 20) / 3,
                          // decoration: BoxDecoration(
                          //   border: Border.all(),
                          //   borderRadius: BorderRadius.circular(2),
                          // ),
                          child: Center(
                            child: Row(
                              children: [
                                Text(
                                  "Equity Invested",
                                  textAlign: TextAlign.center,
                                ),
                                Tooltip(
                                  message: "",
                                  child: Icon(
                                    Icons.help,
                                    size: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: (MediaQuery.of(context).size.width - 60) / 3,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Center(
                            child: Text(
                              "${widget.portfolioData["initial_investment_amount"]}",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  securityListRow(data) {
    return Container(
      // decoration: BoxDecoration(
      //   border: Border.all(),
      // ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 50,
              width: (MediaQuery.of(context).size.width - 60) / 3,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Center(
                child: Text(
                  "${data["company_name"]}",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              height: 50,
              width: (MediaQuery.of(context).size.width - 60) / 3,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Center(
                child: Text(
                  "${(data["previous_weight"] * 100).toStringAsFixed(2)}",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              height: 50,
              width: (MediaQuery.of(context).size.width - 60) / 3,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Center(
                child: Text(
                  "${(data["current_weight"] * 100).toStringAsFixed(2)}",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
