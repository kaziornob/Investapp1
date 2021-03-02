import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SinglePublicCompanyAllStatsList extends StatefulWidget {
  final marketCapital;
  final netDebt;
  final roe3yr;
  final currency;
  final equityBeta;
  final marketCapLocal;
  final fixRate;

  SinglePublicCompanyAllStatsList({
    this.marketCapital,
    this.currency,
    this.equityBeta,
    this.netDebt,
    this.roe3yr,
    this.marketCapLocal,
    this.fixRate,
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
        width: MediaQuery.of(context).size.width - 15,
        child: Column(
          children: [
            SizedBox(
              height: 230,
              width: MediaQuery.of(context).size.width - 15,
              child: CarouselSlider.builder(
                itemCount: slideArray.length,
                options: CarouselOptions(
                    autoPlay: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        slideIndex = index;
                      });
                    }),
                itemBuilder: (context, index) {
                  return Container(
                    // margin: EdgeInsets.only(
                    //     left: MediaQuery.of(context).size.width * 0.048,
                    //     right: MediaQuery.of(context).size.width * 0.048),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0,
                        right: 8.0,
                        left: 8.0,
                      ),
                      child: Material(
                        elevation: 10,
                        child: Container(
                          width: 350,
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
          width: 330,
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
          width: 330,
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
          width: 330,
          height: 40,
          child: Center(
            child: Row(
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
        Padding(
          padding: EdgeInsets.only(top: 5.0, left: 8.0),
          child: Row(
            children: [
              Container(
                width: 100,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 2,
                      color: Color(0xFFfec20f),
                    ),
                  ),
                ),
                padding: EdgeInsets.only(bottom: 8.0),
                child: Center(
                  child: Text(
                    'Voting bar',
                    style: new TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.black,
                      fontSize: 18.0,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.05,
          margin: EdgeInsets.all(7.0),
          decoration: new BoxDecoration(
            border: Border.all(
              color: Color(0xFFfec20f),
              width: 1,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(2.0),
            ),
          ),
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.green,
              inactiveTrackColor: Colors.red[100],
              trackShape: RoundedRectSliderTrackShape(),
              trackHeight: 4.0,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
              thumbColor: Colors.green,
              overlayColor: Colors.red.withAlpha(32),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
              tickMarkShape: RoundSliderTickMarkShape(),
              activeTickMarkColor: Colors.green,
              inactiveTickMarkColor: Colors.red[100],
              valueIndicatorShape: PaddleSliderValueIndicatorShape(),
              valueIndicatorColor: Colors.green,
              valueIndicatorTextStyle: TextStyle(
                color: Colors.white,
              ),
            ),
            child: Slider(
              value: _voteValue,
              min: 0,
              max: 100,
              divisions: 10,
              label: '$_voteValue',
              onChanged: (value) {
                setState(() {
                  _voteValue = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  listItem3() {
    return Column(
      children: [
        Container(
          // decoration: BoxDecoration(border: Border.all()),
          width: 330,
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
            padding: const EdgeInsets.only(left: 8.0),
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
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 4),
            child: singleRow(context, "Key Stats : ", Colors.white, ""),
          ),
          singleRow(context, "Market Cap(USD)", Colors.indigo[50],
              "${widget.marketCapital}" + "M"),
          widget.currency == "USD"
              ? SizedBox()
              : singleRow(context, "Market Cap(${widget.currency})",
                  Colors.indigo[100], "${widget.marketCapLocal}" + "M"),
          singleRowWithToolTip(
              context,
              "Enterprise Value(USD)",
              widget.currency == "USD" ? Colors.indigo[100] : Colors.indigo[50],
              "58.78"),
          singleRowWithToolTip(
              context,
              "Net Debt(USD)",
              widget.currency == "USD" ? Colors.indigo[50] : Colors.indigo[100],
              "${widget.netDebt}" + "M"),
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
        width: 340,
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
}
