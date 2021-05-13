import 'dart:convert';
import 'dart:io';
import 'package:auroim/widgets/aws/aws_client.dart';
import 'package:auroim/widgets/stock_and_portfolio_pitch/return_drawdown_widget.dart';
import 'package:auroim/widgets/stock_and_portfolio_pitch/stock_pitch_return_chart.dart';
import 'package:auroim/widgets/stock_and_portfolio_pitch/topic_tags.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ShowStockPitchPage extends StatefulWidget {
  final stockPitchData;

  const ShowStockPitchPage({Key key, this.stockPitchData}) : super(key: key);

  @override
  _ShowStockPitchPageState createState() => _ShowStockPitchPageState();
}

class _ShowStockPitchPageState extends State<ShowStockPitchPage> {
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

  AWSClient awsClient = AWSClient();

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(widget.stockPitchData["date"]);
    print("date : ${date.year}");
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
                          "${widget.stockPitchData["title"]}",
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                          "Created on ${date.day}th ${monthList[date.month - 1]}, ${date.year}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        widget.stockPitchData["isLong"] == 0
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
                  showMore: false,
                  data: widget.stockPitchData,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Text("Investment Thesis"),
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
                          "${widget.stockPitchData["investment_thesis"]}",
                        ),
                      ),
                      width: MediaQuery.of(context).size.width - 30,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TopicTags(
                        listOfTags: jsonDecode(
                          widget.stockPitchData["topic_tags"],
                        ),
                      ),
                      Visibility(
                        visible: widget.stockPitchData["docUrl"] == ""
                            ? false
                            : true,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () async {
                              print("download file save");
                              Toast.show(
                                "Downloading...",
                                context,
                              );
                              File file = await awsClient.downloadFile("",
                                  "auro_stock_pitch${widget.stockPitchData["pitch_number"]}");
                              if (await file.length() != 0) {
                                Toast.show(
                                  "File Successfully Downloaded",
                                  context,
                                );
                              } else {
                                Toast.show(
                                  "Some Error Occurred",
                                  context,
                                );
                              }
                              print(file.path);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Download investment thesis PDF doc",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(Icons.download_sharp),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                StockPitchReturnChart(
                  userEmail: widget.stockPitchData["email"],
                  userInceptionDate: widget.stockPitchData["date"],
                  pitchNumber: widget.stockPitchData["pitch_number"],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
