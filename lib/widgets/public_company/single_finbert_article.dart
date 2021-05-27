import 'package:auroim/api/featured_companies_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;

class SingleFinbertArticle extends StatefulWidget {
  final String head;
  final Icon icon;
  final List relatedLinks;
  final String sentimentScore;
  final String date;
  final String bloombergLink;
  final tickers;
  final peoples;

  const SingleFinbertArticle({
    Key key,
    this.head,
    this.icon,
    this.relatedLinks,
    this.sentimentScore,
    this.date,
    this.bloombergLink,
    this.tickers,
    this.peoples,
  }) : super(key: key);

  @override
  _SingleFinbertArticleState createState() => _SingleFinbertArticleState();
}

class _SingleFinbertArticleState extends State<SingleFinbertArticle> {
  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xffC4C4C4),
          width: 1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(2.0),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.height * 0.47,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0),
              child: Row(
                children: [
                  Container(
                    child: Text(
                      "Posted ${DateTime.now().difference(DateTime.parse(widget.date)).inDays} days ago",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                        fontSize: 14,
                        fontFamily: "Roboto",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: GestureDetector(
                      child: Container(
                        height: 17,
                        width: 17,
                        child: Image.asset("assets/link.png"),
                      ),
                      onTap: () => launch(widget.bloombergLink),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, top: 4.0),
              child: Row(
                children: [
                  Text(
                    "Sentiment Score : ${widget.sentimentScore}",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0),
                    child: widget.icon,
                  ),
                  Container(
                    child: Expanded(
                      child: Text(
                        "${widget.head}",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "RosarioSemiBold",
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1D6177),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: widget.relatedLinks
                    .map<Widget>(
                      (e) => IconButton(
                        icon: Icon(FontAwesomeIcons.link),
                        onPressed: () => launch(e),
                      ),
                    )
                    .toList(),
              ),
            ),
            widget.relatedLinks.length != 0
                ? Container(
                    height: 50,
                    child: Row(
                      children: widget.relatedLinks
                          .map<Widget>(
                            (e) => IconButton(
                              icon: Icon(FontAwesomeIcons.link),
                              onPressed: () => launch(e),
                            ),
                          )
                          .toList(),
                    ),
                  )
                : SizedBox(),
            widget.tickers.length != 0
                ? Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "Related Companies",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Roboto",
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.tickers.keys.toList().map<Widget>(
                            (ticker) {
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8.0,
                                        right: 4.0,
                                      ),
                                      child: CircleAvatar(
                                        radius: 2,
                                        backgroundColor: Color(0xFF555555),
                                      ),
                                    ),
                                    Text(
                                      "${widget.tickers[ticker]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF555555),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
            widget.peoples.length != 0
                ? Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "Related Peoples",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Roboto",
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.peoples.keys.toList().map<Widget>(
                            (person) {
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8.0,
                                        right: 4.0,
                                      ),
                                      child: CircleAvatar(
                                        radius: 2,
                                        backgroundColor: Color(0xFF555555),
                                      ),
                                    ),
                                    Text(
                                      "${widget.peoples[person]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF555555),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
