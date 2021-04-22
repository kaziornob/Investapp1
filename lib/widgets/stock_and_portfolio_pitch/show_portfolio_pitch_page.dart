import 'package:auroim/widgets/stock_and_portfolio_pitch/return_drawdown_widget.dart';
import 'package:flutter/material.dart';

class ShowPortfolioPitchPage extends StatefulWidget {
  final List listOfSecurities;

  const ShowPortfolioPitchPage({Key key, this.listOfSecurities})
      : super(key: key);

  @override
  _ShowPortfolioPitchPageState createState() => _ShowPortfolioPitchPageState();
}

class _ShowPortfolioPitchPageState extends State<ShowPortfolioPitchPage> {
  @override
  Widget build(BuildContext context) {
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
                      child: Text("Created on 16th April, 2021"),
                    ),
                  ],
                ),
                ReturnDrawdownWidget(
                  showMore: true,
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
                            "I invest in the IT sector with low risk in general, with trades taking from a few days up to several months."),
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
                                child: Text(
                                  "Initial Wt",
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
                                child: Text(
                                  "Current Wt",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: widget.listOfSecurities.map<Widget>((item) {
                          return securityListRow();
                        }).toList(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  securityListRow() {
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
              ),
            ),
            Container(
              height: 50,
              width: (MediaQuery.of(context).size.width - 60) / 3,
              decoration: BoxDecoration(
                border: Border.all(),
              ),
            ),
            Container(
              height: 50,
              width: (MediaQuery.of(context).size.width - 60) / 3,
              decoration: BoxDecoration(
                border: Border.all(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
