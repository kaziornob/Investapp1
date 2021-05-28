import 'dart:convert';

import 'package:auroim/provider_abhinav/long_short_provider.dart';
import 'package:auroim/widgets/public_company/single_finbert_article.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DebateTabSeeMore extends StatefulWidget {
  final String companyName;

  const DebateTabSeeMore({Key key, this.companyName}) : super(key: key);

  @override
  _DebateTabSeeMoreState createState() => _DebateTabSeeMoreState();
}

class _DebateTabSeeMoreState extends State<DebateTabSeeMore> {
  @override
  Widget build(BuildContext context) {
    var longShortProvider =
        Provider.of<LongShortProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.companyName}",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 5,
              ),
              longShortSection(longShortProvider.proConsForPublicCompany),
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
              finbertSection(
                longShortProvider
                    .sortedFinbertArticleByNegativeSentimentScore(),
                longShortProvider
                    .sortedFinbertArticleByPositiveSentimentScore(),
              ),
              consensusSection(longShortProvider.longShortComments),
            ],
          ),
        ),
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
      child: Center(
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
                        bulletPoints(
                          "${data["pro_two"]}",
                          "Pro One",
                          Icon(
                            FontAwesomeIcons.checkDouble,
                            color: Colors.green,
                          ),
                        ),
                        bulletPoints(
                          "${data["pro_three"]}",
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
                        bulletPoints(
                          "${data["con_two"]}",
                          "Con One",
                          Icon(
                            FontAwesomeIcons.checkDouble,
                            color: Colors.red,
                          ),
                        ),
                        bulletPoints(
                          "${data["con_three"]}",
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
      ),
    );
  }

  finbertSection(List negativeArticles, List positiveArticles) {
    return Container(
      width: MediaQuery.of(context).size.width - 15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: (MediaQuery.of(context).size.width - 20) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: positiveArticles
                      .map<Widget>(
                        (positiveArticle) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: SingleFinbertArticle(
                            head: positiveArticle["subject"]
                                .toString()
                                .substring(3),
                            icon: Icon(
                              FontAwesomeIcons.newspaper,
                              color: Colors.green,
                            ),
                            relatedLinks: jsonDecode(
                                positiveArticle["related_links"]
                                    .replaceAll("\'", "\"")),
                            sentimentScore:
                                (positiveArticle["sentiment_score"] * 100)
                                    .toStringAsFixed(1),
                            date: positiveArticle["article_date"],
                            tickers: jsonDecode(positiveArticle["tickers"]),
                            bloombergLink: positiveArticle["link"],
                            peoples: jsonDecode(positiveArticle["people"]),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Container(
                // decoration: BoxDecoration(border: Border.all()),
                width: (MediaQuery.of(context).size.width - 20) / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: negativeArticles
                      .map<Widget>(
                        (negativeArticle) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: SingleFinbertArticle(
                            head: negativeArticle["subject"]
                                .toString()
                                .substring(3),
                            icon: Icon(
                              FontAwesomeIcons.newspaper,
                              color: Colors.red,
                            ),
                            relatedLinks: jsonDecode(
                                negativeArticle["related_links"]
                                    .replaceAll("\'", "\"")),
                            sentimentScore:
                                (negativeArticle["sentiment_score"] * 100)
                                    .toStringAsFixed(1),
                            date: negativeArticle["article_date"],
                            bloombergLink: negativeArticle["link"],
                            tickers: jsonDecode(negativeArticle["tickers"]),
                            peoples: jsonDecode(negativeArticle["people"]),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ],
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
