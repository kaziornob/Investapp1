import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/home/add_comment_bottom_sheet_widget.dart';
import 'package:auroim/provider_abhinav/long_short_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SinglePublicCompaniesDebateTab extends StatefulWidget {
  final data;

  SinglePublicCompaniesDebateTab({this.data});

  @override
  _SinglePublicCompaniesDebateTabState createState() =>
      _SinglePublicCompaniesDebateTabState();
}

class _SinglePublicCompaniesDebateTabState
    extends State<SinglePublicCompaniesDebateTab> {
  double _voteValue = 3.0;
  bool _isinit = true;

  @override
  void didChangeDependencies() {
    if (_isinit) {
      Provider.of<LongShortProvider>(context)
          .getProConsForPublicCompany(widget.data["ticker"]);
      _isinit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return
        // StatefulBuilder(
        // builder: (context, setVotingBarState) {
        //   return

        Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 50,
          height: 40,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 2,
                color: Color(0xFFfec20f),
              ),
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Long(Buy), Short(Sell) Debate",
                    style: TextStyle(
                      fontFamily: "Rosarivo",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 15.0, left: 8.0),
          child: Row(
            children: [
              Container(
                width: 300,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 2,
                      color: Color(0xFFfec20f),
                    ),
                  ),
                ),
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Auro Sentiment Score - Voting Bar',
                  style: new TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.black,
                    fontSize: 18.0,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.05,
              margin: EdgeInsets.all(7.0),
              decoration: new BoxDecoration(
                border: Border.all(
                  color: Color(0xff5A56B9),
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
                    // setVotingBarState(() {
                    //   _voteValue = value;
                    // });
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button("Vote Long", Colors.green, 120.0, true),
                button("Vote Short", Colors.red, 120.0, false),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Consumer<LongShortProvider>(builder: (context, longShortProvider, _) {
          if (longShortProvider.proConsForPublicCompany != null) {
            return longShortSection(longShortProvider.proConsForPublicCompany);
          } else {
            return SizedBox();
          }
        }),

        // articleSection(""),
        // Consumer<LongShortProvider>(
        //   builder: (context, longShortProvider, _) {
        //     if (longShortProvider.proConsForPublicCompany != null) {
        //       return articleSection(longShortProvider.proConsForPublicCompany);
        //     } else {
        //       return SizedBox();
        //     }
        //   },
        // ),
        // Row(
        //   children: [
        //     Padding(
        //       padding: EdgeInsets.only(top: 5.0, left: 10.0),
        //       child: Container(
        //         width: 200,
        //         decoration: BoxDecoration(
        //           border: Border(
        //             bottom: BorderSide(
        //               width: 2,
        //               color: Color(0xFFfec20f),
        //             ),
        //           ),
        //         ),
        //         padding: EdgeInsets.only(bottom: 8.0),
        //         child: Text(
        //           'Auro News Score',
        //           style: new TextStyle(
        //             fontFamily: "Rosarivo",
        //             color: Colors.black,
        //             fontSize: 20.0,
        //             letterSpacing: 0.2,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        // SizedBox(
        //   height: 10,
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     button("Long News", Colors.green, 150.0, () {}),
        //     button("Short News", Colors.red, 150.0, () {}),
        //   ],
        // ),
        // SizedBox(
        //   height: 10,
        // ),
        // articleSection(""),
        // SizedBox(
        //   height: 10,
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     button("Long Trending", Colors.green, 150.0, () {}),
        //     button("Short Trending", Colors.red, 150.0, () {}),
        //   ],
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(top:10.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: [
        //       Container(
        //         decoration: new BoxDecoration(
        //           border: Border.all(
        //             color: Color(0xff5A56B9),
        //             width: 1,
        //           ),
        //           borderRadius: BorderRadius.all(
        //             Radius.circular(2.0),
        //           ),
        //         ),
        //         width: (MediaQuery.of(context).size.width/2)-10,
        //         height: 80,
        //       ),
        //       Container(
        //         decoration: new BoxDecoration(
        //           border: Border.all(
        //             color: Color(0xff5A56B9),
        //             width: 1,
        //           ),
        //           borderRadius: BorderRadius.all(
        //             Radius.circular(2.0),
        //           ),
        //         ),
        //         width: (MediaQuery.of(context).size.width/2)-10,
        //         height: 80,
        //       )
        //     ],
        //   ),
        // )
      ],
    );

    //   },
    // );
  }

  button(text, color, width, isLong) {
    return Container(
      width: width,
      height: 40,
      child: RaisedButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
            builder: (builder) {
              return AddCommentBottomSheetWidget(
                heading: isLong
                    ? "If you are Positive on this stock’s return potential tell us why?"
                    : "If you are Negative on this stock’s return potential tell us why?",
              );
            },
          );
        },
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
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

  longShortSection(data) {
    return Container(
      // height: 400,
      width: MediaQuery.of(context).size.width - 15,
      // decoration: new BoxDecoration(
      //   border: Border.all(
      //     color: Color(0xff5A56B9),
      //     width: 1,
      //   ),
      //   borderRadius: BorderRadius.all(
      //     Radius.circular(2.0),
      //   ),
      // ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // decoration: BoxDecoration(border:Border.all()),
                width: (MediaQuery.of(context).size.width - 20) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Container(
                    //   child: Text(
                    //     "Pros",
                    //     style: TextStyle(
                    //       fontSize: 16,
                    //       fontFamily: "Roboto",
                    //       fontWeight: FontWeight.bold,
                    //       color: Color(0xff1D6177),
                    //     ),
                    //   ),
                    // ),
                    bulletPoints("${data["pro_one"]}","Pro One"),
                    SizedBox(height: 5,),
                    bulletPoints("${data["pro_two"]}","Pro Two"),
                    SizedBox(height: 5,),
                    bulletPoints("${data["pro_three"]}", "Pro Three"),
                  ],
                ),
              ),
              Container(
                // decoration: BoxDecoration(border:Border.all()),
                width: (MediaQuery.of(context).size.width - 20) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Container(
                    //   child: Text(
                    //     "Cons",
                    //     style: TextStyle(
                    //       fontSize: 16,
                    //       fontFamily: "Roboto",
                    //       fontWeight: FontWeight.bold,
                    //       color: Color(0xff1D6177),
                    //     ),
                    //   ),
                    // ),
                    bulletPoints("${data["con_one"]}","Con One"),
                    SizedBox(height: 5,),
                    bulletPoints("${data["con_two"]}","Con Two"),
                    SizedBox(height: 5,),
                    bulletPoints("${data["con_three"]}","Con Three"),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 5,),
          Container(
            width: MediaQuery.of(context).size.width - 15,
            height: MediaQuery.of(context).size.height * 0.06,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.48,
                decoration: new BoxDecoration(
                  border: Border.all(
                    color: Color(0xff5A56B9),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(2.0),
                  ),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.10,
                  margin: EdgeInsets.only(
                      left: 47.0, top: 7.0, right: 47.0, bottom: 3.0),
                  decoration: new BoxDecoration(
                    border: Border.all(
                      color: Color(0xff5A56B9),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'SEE MORE',
                      style: new TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        color: Colors.black,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  // prosConsList(text1) {
  //   return Column(
  //     children: [
  //       bulletPoints("$text1"),
  //     ],
  //   );
  // }

  bulletPoints(text,head) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xff5A56B9),
          width: 1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(2.0),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.height * 0.48,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Text(
                "$head",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1D6177),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 6),
              width: MediaQuery.of(context).size.height * 0.45,
              child: Text(
                // text.length > 60
                //     ? "${text.toString().substring(0, 60)}"
                //     :
                "$text",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[700],
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
      ),
    );
    //   Padding(
    //   padding: const EdgeInsets.all(4.0),
    //   child: Row(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Container(
    //         // decoration: BoxDecoration(border: Border.all()),
    //         padding: EdgeInsets.only(top: 6),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             CircleAvatar(
    //               backgroundColor: Color(0xff5A56B9),
    //               radius: 3.0,
    //             ),
    //           ],
    //         ),
    //       ),
    //
    //       ,
    //     ],
    //   ),
    // );
  }

  articleSection(proconsData) {
    return Column(
      children: [
        Container(
          // width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height*0.07,
          margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.02,
              right: MediaQuery.of(context).size.width * 0.02),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.48,
                decoration: new BoxDecoration(
                  border: Border.all(
                    color: Color(0xff5A56B9),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(2.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Article 1',
                    style: new TextStyle(
                      fontFamily: "WorkSansSemiBold",
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.48,
                decoration: new BoxDecoration(
                  border: Border.all(
                    color: Color(0xff5A56B9),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(2.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Article 2',
                    style: new TextStyle(
                      fontFamily: "WorkSansSemiBold",
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
/*            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.07,
            margin: EdgeInsets.only(left:7.0,right:7.0),*/
          margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.02,
              right: MediaQuery.of(context).size.width * 0.02),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.48,
                decoration: new BoxDecoration(
                  border: Border.all(
                    color: Color(0xff5A56B9),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(2.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Article 3',
                    style: new TextStyle(
                      fontFamily: "WorkSansSemiBold",
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.48,
                decoration: new BoxDecoration(
                  border: Border.all(
                    color: Color(0xff5A56B9),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(2.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Article 4',
                    style: new TextStyle(
                      fontFamily: "WorkSansSemiBold",
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.06,
          margin: EdgeInsets.only(left: 7.0, right: 7.0),
          child: Container(
              width: MediaQuery.of(context).size.width * 0.48,
              decoration: new BoxDecoration(
                border: Border.all(
                  color: Color(0xff5A56B9),
                  width: 1,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(2.0),
                ),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.10,
                margin: EdgeInsets.only(
                    left: 47.0, top: 7.0, right: 47.0, bottom: 3.0),
                decoration: new BoxDecoration(
                  border: Border.all(
                    color: Color(0xff5A56B9),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(2.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Explore',
                    style: new TextStyle(
                      fontFamily: "WorkSansSemiBold",
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
