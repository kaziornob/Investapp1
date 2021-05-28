import 'dart:convert';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/provider_abhinav/long_short_provider.dart';
import 'package:auroim/reusable_widgets/customButton.dart';
import 'package:auroim/widgets/public_company/add_long_short_vote_comment.dart';
import 'package:auroim/widgets/public_company/custom_slider_thumb_circle.dart';
import 'package:auroim/widgets/public_company/debate_tab_see_more.dart';
import 'package:auroim/widgets/public_company/single_finbert_article.dart';
import 'package:auroim/widgets/public_company/votes_quaterly_column_charts.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:auroim/constance/global.dart' as globals;

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
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Long, Short Debate",
                    style: TextStyle(
                      fontFamily: "RosarioSemiBold",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 15.0, left: 8.0, bottom: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 8.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Auro Sentiment Score - Voting Bar(",
                        style: TextStyle(
                          fontFamily: "RosarioRegular",
                          color: Colors.black,
                          fontSize: 18.0,
                          letterSpacing: 0.2,
                        ),
                      ),
                      TextSpan(
                        text:
                            "${(4 - (12 / DateTime.now().month)).ceil()}Q,${DateTime.now().year}",
                        style: TextStyle(
                          fontFamily: "RosarioRegular",
                          color: Colors.black,
                          fontSize: 18.0,
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    VotesQuarterlyColumnCharts(
                                  ticker: widget.data["ticker"],
                                ),
                              ),
                            );
                          },
                      ),
                      TextSpan(
                        text: ")",
                        style: TextStyle(
                          fontFamily: "RosarioRegular",
                          color: Colors.black,
                          fontSize: 18.0,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
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
                            MediaQuery.of(context).size.width / 2.2,
                            true,
                            setSliderState,
                          ),
                          button(
                            "Vote Short",
                            Color(0xFFFAB95B),
                            MediaQuery.of(context).size.width / 2.2,
                            false,
                            setSliderState,
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 20,
                        height: 70,
                        // decoration: BoxDecoration(border: Border.all()),
                        margin: EdgeInsets.all(7.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 30) *
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
                                  width:
                                      (MediaQuery.of(context).size.width - 30) *
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
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Auro Rating ",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "RosarioSemiBold",
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                TextSpan(
                  text: "- Out-Perform",
                  style: TextStyle(
                    color: Color(0xFFD8AF4F),
                    fontFamily: "RosarioSemiBold",
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
        ),
        Consumer<LongShortProvider>(
          builder: (context, longShortProvider, _) {
            if (longShortProvider.proConsForPublicCompany != null) {
              return longShortSection(
                longShortProvider.proConsForPublicCompany,
              );
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
        Consumer<LongShortProvider>(
          builder: (context, longShortProvider, _) {
            if (longShortProvider.longShortComments != null) {
              return consensusSection(longShortProvider.longShortComments);
            } else {
              return SizedBox();
            }
          },
        ),
        SizedBox(
          height: 10,
        ),
        CustomButton(
          callback: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DebateTabSeeMore(
                  companyName: widget.data["company_name"],
                ),
              ),
            );
          },
          color: globals.isGoldBlack ? Color(0xFFD8AF4F) : Color(0xFF1D6177),
          text: "See More",
          borderColor:
              globals.isGoldBlack ? Color(0xFFD8AF4F) : Color(0xFF1D6177),
          textColor: Colors.white,
        ),
      ],
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
                    ticker: widget.data["ticker"],
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

  finbertSection(negativeArticle, positiveArticle) {
    // print("negetive : ${negativeArticle["sentiment_score"].runtimeType}");
    return Container(
      width: MediaQuery.of(context).size.width - 15,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Auro News",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
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
                        FontAwesomeIcons.solidNewspaper,
                        color: Color(0xFF24FF00),
                      ),
                      relatedLinks: jsonDecode(
                        positiveArticle["related_links"]
                            .toString()
                            .replaceAll("\'", "\""),
                      ),
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
                        FontAwesomeIcons.solidNewspaper,
                        color: Color(0xFFFF0000),
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
    return data["comments_long"].length == 0 &&
            data["comments_short"].length == 0
        ? SizedBox()
        : Padding(
            padding: const EdgeInsets.only(
              bottom: 10.0,
              top: 10,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width - 15,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFFFAB95B),
                  width: 1,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(3.0),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Auro Consensus",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      data["comments_long"].length == 0
                          ? SizedBox()
                          : data["comments_long"][0]["comment"].length == 0
                              ? SizedBox()
                              : Container(
                                  // decoration: BoxDecoration(border:Border.all()),
                                  width:
                                      (MediaQuery.of(context).size.width - 20) /
                                          2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      bulletPoints(
                                        "${data["comments_long"][0]["comment"]}",
                                        "Pro One",
                                        Icon(
                                          FontAwesomeIcons.checkDouble,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                      data["comments_short"].length == 0
                          ? SizedBox()
                          : data["comments_short"][0]["comment"].length == 0
                              ? SizedBox()
                              : Container(
                                  // decoration: BoxDecoration(border:Border.all()),
                                  width:
                                      (MediaQuery.of(context).size.width - 20) /
                                          2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      bulletPoints(
                                        "${data["comments_short"][0]["comment"]}",
                                        "Con One",
                                        Icon(
                                          FontAwesomeIcons.checkDouble,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }

  longShortSection(data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width - 15,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFFAB95B),
            width: 1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(3.0),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Analyst Debate",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // decoration: BoxDecoration(border:Border.all()),
                  width: (MediaQuery.of(context).size.width - 20) / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                      bulletPoints(
                        "${data["con_one"]}",
                        "Con One",
                        Icon(
                          FontAwesomeIcons.checkDouble,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
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
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.48,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: 6,
                  top: 10.0,
                ),
                width: MediaQuery.of(context).size.height * 0.45,
                height: MediaQuery.of(context).size.height * 0.18,
                child: SingleChildScrollView(
                  child: Text(
                    "            $text",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 6,
                child: icon,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFF868686),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3.0),
                        child: CircleAvatar(
                          radius: 3,
                          backgroundColor: Color(0xFF868686),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3, bottom: 3.0),
                        child: CircleAvatar(
                          radius: 3,
                          backgroundColor: Color(0xFF868686),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3, bottom: 3.0),
                        child: CircleAvatar(
                          radius: 3,
                          backgroundColor: Color(0xFF868686),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
