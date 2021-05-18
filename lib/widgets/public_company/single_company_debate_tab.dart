import 'dart:convert';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/provider_abhinav/long_short_provider.dart';
import 'package:auroim/widgets/public_company/add_long_short_vote_comment.dart';
import 'package:auroim/widgets/public_company/debate_tab_see_more.dart';
import 'package:auroim/widgets/public_company/single_finbert_article.dart';
import 'package:auroim/widgets/public_company/votes_quaterly_column_charts.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  double _totalVotes;
  bool _isinit = true;

  @override
  void didChangeDependencies() {
    if (_isinit) {
      Provider.of<LongShortProvider>(context, listen: false)
          .getProConsForPublicCompany(widget.data["ticker"]);
      Provider.of<LongShortProvider>(context, listen: false)
          .getFinbertArticleForPublicCompany(widget.data["ticker"]);
      Provider.of<LongShortProvider>(context, listen: false)
          .getComments(widget.data["ticker"]);
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
                // width: MediaQuery.of(context).size.width-20,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 2,
                      color: Color(0xFFfec20f),
                    ),
                  ),
                ),
                padding: EdgeInsets.only(bottom: 8.0),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Auro Sentiment Score - Voting Bar(",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.black,
                        fontSize: 16.0,
                        letterSpacing: 0.2,
                      ),
                    ),
                    TextSpan(
                      text:
                          "${(4 - (12 / DateTime.now().month)).ceil()}Q,${DateTime.now().year}",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.black,
                        fontSize: 15.0,
                        letterSpacing: 0.2,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => VotesQuarterlyColumnCharts(
                                ticker: widget.data["ticker"],
                              ),
                            ),
                          );
                        },
                    ),
                    TextSpan(
                      text: ")",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.black,
                        fontSize: 15.0,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
        StatefulBuilder(
          builder: (context, setSliderState) {
            return FutureBuilder(
              future: Provider.of<LongShortProvider>(context, listen: false)
                  .getLongShortVotes(widget.data["ticker"]),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print("in long short");
                  _totalVotes = (snapshot.data["long_votes"] +
                          snapshot.data["short_votes"])
                      .toDouble();
                  _voteValue = snapshot.data["long_votes"].toDouble();
                  return Column(
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
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 12.0),
                            thumbColor: Colors.green,
                            overlayColor: Colors.red.withAlpha(32),
                            overlayShape:
                                RoundSliderOverlayShape(overlayRadius: 28.0),
                            tickMarkShape: RoundSliderTickMarkShape(),
                            activeTickMarkColor: Colors.green,
                            inactiveTickMarkColor: Colors.red[100],
                            valueIndicatorShape:
                                PaddleSliderValueIndicatorShape(),
                            valueIndicatorColor: Colors.green,
                            valueIndicatorTextStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          child: Slider(
                            value: _voteValue,
                            min: 0,
                            max: _totalVotes,
                            divisions: 10,
                            label:
                                '${((_voteValue / _totalVotes) * 100).toString().split(".")[0]}% Voted Long,${(((_totalVotes - _voteValue) / _totalVotes) * 100).toString().split(".")[0]}% Voted Short',
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          button("Vote Long", Colors.green, 120.0, true,
                              setSliderState),
                          button("Vote Short", Colors.red, 120.0, false,
                              setSliderState),
                        ],
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
        SizedBox(
          height: 10.0,
        ),
        Consumer<LongShortProvider>(
          builder: (context, longShortProvider, _) {
            if (longShortProvider.proConsForPublicCompany != null) {
              return longShortSection(
                  longShortProvider.proConsForPublicCompany);
            } else {
              return SizedBox();
            }
          },
        ),
        Consumer<LongShortProvider>(
          builder: (context, longShortProvider, _) {
            if (longShortProvider.finbertArticles != null &&
                longShortProvider.finbertArticles.length != 0) {
              return finbertSection(
                longShortProvider.finbertArticleWithMostNegetiveSentiment(),
                longShortProvider.finbertArticleWithMostPositiveSentiment(),
              );
            } else {
              return SizedBox();
            }
          },
        ),
        SizedBox(
          height: 5,
        ),
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
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DebateTabSeeMore(
                      companyName: widget.data["company_name"],
                    ),
                  ),
                );
              },
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
              ),
            ),
          ),
        ),
        Consumer<LongShortProvider>(
          builder: (context, longShortProvider, _) {
            if (longShortProvider.longShortComments != null) {
              return consensusSection(longShortProvider.longShortComments);
            } else {
              return SizedBox();
            }
          },
        ),
      ],
    );

    //   },
    // );
  }

  button(text, color, width, isLong, setSliderState) {
    return Container(
      width: width,
      height: 40,
      child: RaisedButton(
        onPressed: () async {
          showModalBottomSheet(
            context: context,
            backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
            builder: (builder) {
              return AddLongShortVoteComment(
                heading: isLong
                    ? "If you are Positive on this stock’s return potential tell us why?"
                    : "If you are Negative on this stock’s return potential tell us why?",
                ticker: widget.data["ticker"],
                isLong: isLong,
                callback: () {
                  setSliderState(() {});
                },
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

  finbertSection(negativeArticle, positiveArticle) {
    print("negetive : ${negativeArticle["sentiment_score"].runtimeType}");
    return Container(
      width: MediaQuery.of(context).size.width - 15,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // decoration: BoxDecoration(border: Border.all()),
                width: (MediaQuery.of(context).size.width - 20) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SingleFinbertArticle(
                      head: positiveArticle["subject"].toString().substring(3),
                      icon: Icon(
                        FontAwesomeIcons.newspaper,
                        color: Colors.green,
                      ),
                      relatedLinks: jsonDecode(positiveArticle["related_links"]
                          .toString()
                          .replaceAll("\'", "\"")),
                      sentimentScore: (positiveArticle["sentiment_score"] * 100)
                          .toStringAsFixed(1),
                      date: positiveArticle["article_date"],
                      tickers: jsonDecode(positiveArticle["tickers"]),
                      bloombergLink: positiveArticle["link"],
                      peoples: jsonDecode(positiveArticle["people"]),
                    ),
                  ],
                ),
              ),
              Container(
                // decoration: BoxDecoration(border: Border.all()),
                width: (MediaQuery.of(context).size.width - 20) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SingleFinbertArticle(
                      head: negativeArticle["subject"].toString().substring(3),
                      icon: Icon(
                        FontAwesomeIcons.newspaper,
                        color: Colors.red,
                      ),
                      relatedLinks: jsonDecode(negativeArticle["related_links"]
                          .toString()
                          .replaceAll("\'", "\"")),
                      sentimentScore: (negativeArticle["sentiment_score"] * 100)
                          .toStringAsFixed(1),
                      date: negativeArticle["article_date"],
                      bloombergLink: negativeArticle["link"],
                      tickers: jsonDecode(negativeArticle["tickers"]),
                      peoples: jsonDecode(negativeArticle["people"]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  consensusSection(data) {
    return Container(
      // height: 400,
      width: MediaQuery.of(context).size.width - 15,
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              data["comments_long"].length == 0
                  ? SizedBox()
                  : Container(
                      decoration: new BoxDecoration(
                        border: Border.all(
                          color: Color(0xff5A56B9),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(2.0),
                        ),
                      ),
                      // decoration: BoxDecoration(border:Border.all()),
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      width: (MediaQuery.of(context).size.width - 20) / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              "Consensus +",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.bold,
                                color: Color(0xff1D6177),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          smallBulletPoints(data["comments_long"]),
                        ],
                      ),
                    ),
              data["comments_short"].length == 0
                  ? SizedBox()
                  : Container(
                      decoration: new BoxDecoration(
                        border: Border.all(
                          color: Color(0xff5A56B9),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(2.0),
                        ),
                      ),
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      // decoration: BoxDecoration(border:Border.all()),
                      width: (MediaQuery.of(context).size.width - 20) / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              "Consensus -",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.bold,
                                color: Color(0xff1D6177),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          smallBulletPoints(data["comments_short"]),
                        ],
                      ),
                    ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
        ],
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
                    bulletPoints(
                      "${data["pro_one"]}",
                      "Pro One",
                      Icon(
                        FontAwesomeIcons.checkDouble,
                        color: Colors.green,
                      ),
                    ),
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
                    bulletPoints(
                      "${data["con_one"]}",
                      "Con One",
                      Icon(
                        FontAwesomeIcons.timesCircle,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  smallBulletPoints(List allComments) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView(
        children: allComments.map<Widget>((comment) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: CircleAvatar(
                  backgroundColor: Color(0xff5A56B9),
                  radius: 5,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                // decoration: BoxDecoration(
                //   border: Border.all(),
                // ),
                width: MediaQuery.of(context).size.width * 0.45 - 15,
                child: Expanded(
                  child: Text(
                    "${comment["comment"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                    // textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  bulletPoints(text, head, icon) {
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
      width: MediaQuery.of(context).size.width * 0.48,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon == null ? SizedBox() : icon,
                  SizedBox(
                    width: 5,
                  ),
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
                ],
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
