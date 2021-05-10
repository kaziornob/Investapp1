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
            children: [
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${widget.companyName} Pros and Cons",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              longShortSection(longShortProvider.proConsForPublicCompany),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${widget.companyName} Related Articles",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              finbertSection(
                longShortProvider
                    .sortedFinbertArticleByNegativeSentimentScore(),
                longShortProvider
                    .sortedFinbertArticleByPositiveSentimentScore(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  longShortSection(data) {
    return Center(
      child: Container(
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
                      SizedBox(
                        height: 5,
                      ),
                      bulletPoints(
                        "${data["pro_two"]}",
                        "Pro Two",
                        Icon(
                          FontAwesomeIcons.checkDouble,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      bulletPoints(
                        "${data["pro_three"]}",
                        "Pro Three",
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
                      SizedBox(
                        height: 5,
                      ),
                      bulletPoints(
                        "${data["con_two"]}",
                        "Con Two",
                        Icon(
                          FontAwesomeIcons.timesCircle,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      bulletPoints(
                        "${data["con_three"]}",
                        "Con Three",
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
      ),
    );
  }

  finbertSection(List negativeArticles, List positiveArticles) {
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
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
}
