import 'package:auroim/constance/themes.dart';
import 'package:auroim/provider_abhinav/long_short_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_long_short_vote_comment.dart';
import 'custom_slider_thumb_circle.dart';

class SinglePublicCompanyAllStatsList extends StatefulWidget {
  final marketCapital;
  final netDebt;
  final roe3yr;
  final currency;
  final equityBeta;
  final marketCapLocal;
  final fixRate;
  final ticker;

  SinglePublicCompanyAllStatsList({
    this.marketCapital,
    this.currency,
    this.equityBeta,
    this.netDebt,
    this.roe3yr,
    this.marketCapLocal,
    this.fixRate,
    this.ticker,
  });

  @override
  _SinglePublicCompanyAllStatsListState createState() =>
      _SinglePublicCompanyAllStatsListState();
}

class _SinglePublicCompanyAllStatsListState
    extends State<SinglePublicCompanyAllStatsList> {
  int slideIndex = 0;
  List slideArray;
  bool _isInit = true;
  double _totalVotes;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      slideArray = [
        listItem1(),
        listItem2(),
        listItem3(),
        listItem4(),
        listItem5(),
        listItem6(),
      ];
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 7.5, right: 7.5),
      child: Container(
        height: 260,
        // color: Colors.blue,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: 230,
              width: MediaQuery.of(context).size.width,
              // decoration:
              //     BoxDecoration(border: Border.all(color: Colors.black)),
              child: CarouselSlider.builder(
                itemCount: slideArray.length,
                options: CarouselOptions(
                    autoPlay: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        slideIndex = index;
                      });
                    }),
                itemBuilder: (context, index, _) {
                  return Container(
                    // decoration:
                    //     BoxDecoration(border: Border.all(color: Colors.black)),
                    // width: MediaQuery.of(context).size.width-15,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0,
                        right: 2.0,
                        left: 2.0,
                      ),
                      child: Material(
                        elevation: 2,
                        child: Container(
                          // decoration: BoxDecoration(
                          //   border: Border.all(color: Colors.black),
                          // ),
                          width: MediaQuery.of(context).size.width,
                          // color: Colors.green,
                          child: slideArray[index],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: slideArray.map((url) {
                  int index = slideArray.indexOf(url);
                  return Container(
                    width: 10.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          slideIndex == index ? Color(0xff5A56B9) : Colors.grey,
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
        // Center(
        //   child: ListView(
        //     scrollDirection: Axis.horizontal,
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.only(
        //           top: 8.0,
        //           bottom: 8.0,
        //           right: 8.0,
        //           left: 8.0,
        //         ),
        //         child: Material(
        //           elevation: 10,
        //           child: Container(
        //             width: 300,
        //             // color: Colors.green,
        //             child: Center(
        //               child: Text("Stats"),
        //             ),
        //           ),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Material(
        //           elevation: 10,
        //           child: Container(
        //             width: 300,
        //             // height: 160,
        //             // color: Colors.green,
        //             child: Center(
        //               child: Text("Stats"),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  listItem5() {
    return Column(
      children: [
        Container(
          // decoration: BoxDecoration(border: Border.all()),
          width: MediaQuery.of(context).size.width - 15,
          height: 40,
          child: Center(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Shareholding",
                  ),
                ),
              ],
            ),
          ),
        ),
        singleRow(
            context, "Institutional Ownership (%)", Colors.indigo[50], "24%"),
        singleRow(context, "Top Shareholders", Colors.indigo[100], "Apple INC"),
        singleRow(context, "Inside Trading", Colors.indigo[50], "Yes"),
        singleRow(context, "Recent key changes", Colors.indigo[100], "10"),
      ],
    );
  }

  listItem6() {
    return Column(
      children: [
        Container(
          // decoration: BoxDecoration(border: Border.all()),
          width: MediaQuery.of(context).size.width - 15,
          height: 40,
          child: Center(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Shareholding",
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text:
                        "If you work for this Company's Investor Relation and  would like to Claim this page, please email us at ",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: "AI@auroim.com",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  TextSpan(
                    text:
                        " from your same company email account and we will allow you to post your own content.",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ],
    );
  }

  listItem4() {
    double _voteValue = 3.0;
    return Column(
      children: [
        Container(
          // decoration: BoxDecoration(border: Border.all()),
          width: MediaQuery.of(context).size.width - 15,
          height: 40,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Auro Sentiment Score",
                  ),
                ),
              ],
            ),
          ),
        ),
        StatefulBuilder(
          builder: (context, setSliderState) {
            return FutureBuilder(
              future: Provider.of<LongShortProvider>(context, listen: false)
                  .getLongShortVotes(widget.ticker),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print("in long short");
                  _totalVotes = (snapshot.data["long_votes"] +
                          snapshot.data["short_votes"])
                      .toDouble();
                  _voteValue = snapshot.data["long_votes"].toDouble();
                  // print(_voteValue);
                  // print(_totalVotes);
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          button(
                            "Vote Long",
                            Color(0xFF1D6177),
                            MediaQuery.of(context).size.width / 3,
                            true,
                            setSliderState,
                          ),
                          button(
                            "Vote Short",
                            Color(0xFFFAB95B),
                            MediaQuery.of(context).size.width / 3,
                            false,
                            setSliderState,
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 70,
                        // decoration: BoxDecoration(border: Border.all()),
                        margin: EdgeInsets.all(7.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: (MediaQuery.of(context).size.width *
                                          0.7) *
                                      (_voteValue / _totalVotes),
                                  height: 30,
                                  child: (_voteValue / _totalVotes) == 0.0
                                      ? null
                                      : Center(
                                          child: Text(
                                            "${((_voteValue / _totalVotes) * 100).toStringAsFixed(0).split(".")[0]}%",
                                            style: TextStyle(
                                              color: Color(0xFF414141),
                                              fontSize: 16,
                                              fontFamily: "RosarioMedium",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                ),
                                Container(
                                  height: 40,
                                  width: (MediaQuery.of(context).size.width *
                                          0.7) *
                                      (1 - (_voteValue / _totalVotes)),
                                  child: (1 - (_voteValue / _totalVotes)) == 0.0
                                      ? null
                                      : Center(
                                          child: Text(
                                            "${((_voteValue / _totalVotes) * 100).toStringAsFixed(0).split(".")[0]}%",
                                            style: TextStyle(
                                              color: Color(0xFF414141),
                                              fontSize: 16,
                                              fontFamily: "RosarioMedium",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Color(0xFF1D6177),
                                inactiveTrackColor: Color(0xFFFAB95B),
                                trackShape: RoundedRectSliderTrackShape(),
                                trackHeight: 4.0,
                                thumbShape: CustomSliderThumbCircle(
                                  thumbRadius: 12,
                                  min: 0,
                                  max: 100,
                                  borderColor: Color(0xFF1D6177),
                                ),
                                thumbColor: Color(0xFF1D6177),
                                overlayColor: Color(0xFFFAB95B),
                                overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 12.0),
                                tickMarkShape: RoundSliderTickMarkShape(),
                                activeTickMarkColor: Color(0xFF1D6177),
                                inactiveTickMarkColor: Color(0xFFFAB95B),
                                valueIndicatorShape:
                                    PaddleSliderValueIndicatorShape(),
                                valueIndicatorColor: Color(0xFF1D6177),
                                valueIndicatorTextStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                disabledThumbColor: Color(0xFF1D6177),
                              ),
                              child: Slider(
                                value: _voteValue,
                                min: 0,
                                max: _totalVotes,
                                label:
                                    '${((_voteValue / _totalVotes) * 100).toString().split(".")[0]}% Voted Long,${(((_totalVotes - _voteValue) / _totalVotes) * 100).toString().split(".")[0]}% Voted Short',
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return SizedBox();
                }
              },
            );
          },
        ),
      ],
    );
  }

  listItem3() {
    return Column(
      children: [
        Container(
          // decoration: BoxDecoration(border: Border.all()),
          width: MediaQuery.of(context).size.width - 15,
          height: 40,
          child: Center(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Auro Stock Pitches & Research",
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          // decoration: BoxDecoration(border: Border.all()),
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.green,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.green,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.green,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.green,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey),
                    ),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: Center(
                        child: Text(
                          "+9",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 8.0),
            child: Text(
              "Sky, Manuela (Ela), Lamia Lauren, Mathiues and 4 more",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  listItem2() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  "KEY FINANCIALS",
                  style: TextStyle(
                      // color: Colors.blue[800],
                      fontWeight: FontWeight.bold,
                      fontFamily: "Roboto"),
                ),
              ),
            ],
          ),
          singleRow(
              context, "Revenue Growth(3-years)", Colors.indigo[50], "3.7"),
          singleRow(context, "Eps Growth(3-years)", Colors.indigo[100], "3.7"),
          singleRow(context, "EBIDTA(TTM)", Colors.indigo[50], "32.78"),
          singleRow(context, "Revenue(TTM)", Colors.indigo[100], "294,13500M"),
          singleRow(
              context, "Gross Profit Margin(TTM)", Colors.indigo[50], "38.78"),
          singleRow(
              context, "Net Profit Margin(TTM)", Colors.indigo[100], "21.73%"),
          singleRow(
              context, "Earnings Per Share(TTM)", Colors.indigo[50], "82.9%"),
        ],
      ),
    );
  }

  // listItem1() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.only(top: 4),
  //         child: singleRow(context, "Key Stats : ", Colors.white, ""),
  //       ),
  //       singleRow(context, "Industry", Colors.indigo[50], "Computer Hardware"),
  //       singleRow(
  //           context, "Institutional Ownership", Colors.indigo[100], "58.78"),
  //       singleRow(context, "Market Cap", Colors.indigo[50], "2184.8B"),
  //       singleRow(context, "Sector", Colors.indigo[100], "Technology"),
  //       singleRow(context, "Shares Outstanding", Colors.indigo[50], "16.8B"),
  //     ],
  //   );
  // }

  listItem1() {
    // print("list item 1");
    // print(widget.marketCapital.runtimeType.toString());
    // print(widget.marketCapLocal.runtimeType.toString());

    // print();

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 4),
            child: singleRow(context, "Key Stats : ", Colors.white, ""),
          ),
          singleRow(context, "Market Cap(USD)", Colors.indigo[50],
              "${widget.marketCapital.toStringAsFixed(3)}" + "M"),
          widget.currency == "USD"
              ? SizedBox()
              : singleRow(
                  context,
                  "Market Cap(${widget.currency})",
                  Colors.indigo[100],
                  "${double.parse(widget.marketCapLocal.toString().replaceAll(",", "")).toStringAsFixed(3)}" +
                      "M"),
          singleRowWithToolTip(
              context,
              "Enterprise Value(USD)",
              widget.currency == "USD" ? Colors.indigo[100] : Colors.indigo[50],
              "58.78"),
          singleRowWithToolTip(
              context,
              "Net Debt(USD)",
              widget.currency == "USD" ? Colors.indigo[50] : Colors.indigo[100],
              "${widget.netDebt.toStringAsFixed(3)}" + "M"),
          singleRowWithToolTip(
              context,
              "RoE",
              widget.currency == "USD" ? Colors.indigo[100] : Colors.indigo[50],
              "${widget.roe3yr}"),
          singleRowWithToolTip(
              context,
              "Beta",
              widget.currency == "USD" ? Colors.indigo[50] : Colors.indigo[100],
              "1"),
          singleRowWithToolTip(
              context,
              "Dividend yield",
              widget.currency == "USD" ? Colors.indigo[100] : Colors.indigo[50],
              "2%"),
        ],
      ),
    );
  }

  singleRow(context, text, color, value) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: color),
          color: color,
        ),
        height: 25,
        width: MediaQuery.of(context).size.width - 15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Center(child: Text(text)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Center(child: Text(value)),
            ),
          ],
        ),
      ),
    );
  }

  singleRowWithToolTip(context, text, color, value) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: color),
          color: color,
        ),
        height: 25,
        width: MediaQuery.of(context).size.width - 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Center(
                  child: Row(
                children: [
                  Text(text),
                  Tooltip(
                    message: "$text",
                    child: Icon(
                      Icons.help,
                      size: 15,
                    ),
                  ),
                ],
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Center(child: Text(value)),
            ),
          ],
        ),
      ),
    );
  }

  button(text, color, width, isLong, setSliderState) {
    return Container(
      width: width,
      height: 40,
      child: RaisedButton(
        onPressed: () async {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
            builder: (builder) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: AddLongShortVoteComment(
                    heading: isLong
                        ? "If you are Positive on this stock’s return potential tell us why?"
                        : "If you are Negative on this stock’s return potential tell us why?",
                    ticker: widget.ticker,
                    isLong: isLong,
                    callback: () {
                      setSliderState(() {});
                    },
                  ),
                ),
              );
            },
          );
        },
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            fontFamily: "Roboto",
            color: Colors.white,
          ),
        ),
        color: color,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color),
        ),
      ),
    );
  }
}
