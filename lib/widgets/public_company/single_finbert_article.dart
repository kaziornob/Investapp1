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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    "Posted ${timeago.format(
                      DateTime.parse(widget.date),
                    )}",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.link_outlined),
                  onPressed: () => launch(widget.bloombergLink),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                child: Text(
                  "Sentiment Score : ${widget.sentimentScore}",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.icon,
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    child: Expanded(
                      child: Text(
                        "${widget.head}",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Roboto",
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
                    height: 80,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 2,),
                            Icon(FontAwesomeIcons.industry),
                            SizedBox(width: 4,),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                "Related Companies",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: widget.tickers.keys.toList().map<Widget>(
                              (ticker) {
                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black,
                                    radius: 26,
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.white,
                                      // backgroundImage: NetworkImage(
                                      //     snapshot.data["logo_img_name"]),
                                      child: Text(
                                        "${widget.tickers[ticker]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                );
                                //   FutureBuilder(
                                //   future: _featuredCompaniesProvider
                                //       .getSinglePublicCompanyData(ticker, "head"),
                                //   builder: (context, snapshot) {
                                //     if (snapshot.hasData) {
                                //       // print(snapshot.data);
                                //       // print(snapshot.data.runtimeType);
                                //       return
                                //         // snapshot.data == "Ticker not in database"
                                //         //   ? SizedBox()
                                //         //   :
                                //         CircleAvatar(
                                //               radius: 25,
                                //               // backgroundImage: NetworkImage(
                                //               //     snapshot.data["logo_img_name"]),
                                //         child: Text("${widget.tickers[ticker]}"),
                                //             );
                                //     } else {
                                //       return SizedBox();
                                //     }
                                //   },
                                // );
                              },
                            ).toList(),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
            widget.tickers.length != 0
                ? Container(
              height: 80,
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 2,),
                      Icon(FontAwesomeIcons.userFriends),
                      SizedBox(width: 4,),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          "Related Peoples",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: widget.peoples.keys.toList().map<Widget>(
                            (person) {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 26,
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                // backgroundImage: NetworkImage(
                                //     snapshot.data["logo_img_name"]),
                                child: Text(
                                  "${widget.peoples[person]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );

                        },
                      ).toList(),
                    ),
                  ),
                ],
              ),
            )
                : SizedBox(),
            // Container(
            //   padding: EdgeInsets.only(left: 6),
            //   width: MediaQuery.of(context).size.height * 0.45,
            //   child: Text(
            //     // text.length > 60
            //     //     ? "${text.toString().substring(0, 60)}"
            //     //     :
            //     "$text",
            //     style: TextStyle(
            //       fontWeight: FontWeight.w400,
            //       color: Colors.grey[700],
            //       fontSize: 14,
            //     ),
            //     textAlign: TextAlign.center,
            //     overflow: TextOverflow.clip,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
