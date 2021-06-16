import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/investRelatedPages/securityFirstPage.dart';
import 'package:auroim/widgets/public_company/compare_chart.dart';
import 'package:auroim/widgets/public_company/single_public_company_all_stats.dart';
import 'package:flutter/material.dart';
import '../single_public_company_videos.dart';

class SinglePublicCompanyOverviewTab extends StatefulWidget {
  final data;

  SinglePublicCompanyOverviewTab({this.data});

  @override
  _SinglePublicCompanyOverviewTabState createState() =>
      _SinglePublicCompanyOverviewTabState();
}

class _SinglePublicCompanyOverviewTabState
    extends State<SinglePublicCompanyOverviewTab> {
  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SinglePublicCompanyAllStatsList(
            marketCapital: widget.data["market_cap_usd_mn"],
            netDebt: widget.data["net_debt_usd_mn"],
            roe3yr: widget.data["roe_3yr"],
            currency: widget.data["currency"],
            equityBeta: widget.data["equity_beta"],
            marketCapLocal: widget.data["market_cap_local_mn"],
            fixRate: widget.data["fx_rate"],
            ticker: widget.data["ticker"],
          ),
          //compare section
          CompareChartForPublicCompany(
            ticker: widget.data["ticker"],
            companyData: widget.data,
          ),
          // description section
          Padding(
            padding: EdgeInsets.only(top: 5.0, left: 10.0),
            child: Container(
              width: 120,
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
                'Description',
                style: new TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.black,
                  fontSize: 18.0,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(7.0),
            decoration: new BoxDecoration(
              // border: Border.all(
              //   color: Color(0xFFfec20f),
              //   width: 1,
              // ),
              borderRadius: BorderRadius.all(
                Radius.circular(2.0),
              ),
            ),
            child: Text(
              widget.data["company_description"],
              style: TextStyle(
                color: AllCoustomTheme.getNewSecondTextThemeColor(),
              ),
            ),
          ),
          //video sliders
          SinglePublicCompanyVideos(
            allVideosLinkString: widget.data["youtube_videos"],
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0, left: 10.0),
            child: Container(
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
                'Similar Companies',
                style: new TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.black,
                    fontSize: 18.0,
                    letterSpacing: 0.2),
              ),
            ),
          ),
          FutureBuilder(
            future: _featuredCompaniesProvider
                .getSimilarPublicCompaniesImageUrl(widget.data["ticker"]),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(left: 13, right: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          // decoration: BoxDecoration(
                          //   border: Border.all(
                          //     color: Colors.black,
                          //   ),
                          // ),
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          child: Scrollbar(
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SecurityPageFirst(
                                            callingFrom: "",
                                            companyTicker: snapshot.data[index]
                                                ["ticker"],
                                          ),
                                        ),
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: 40,
                                      child: CircleAvatar(
                                        radius: 38,
                                        backgroundColor: Colors.white,
                                        backgroundImage: NetworkImage(
                                          snapshot.data[index]["logo_img_name"],
                                        ),
                                        onBackgroundImageError:
                                            (err, stackTrace) {
                                          print(
                                            "Image Error Occurred for link : ${snapshot.data[index]["logo_img_name"]}",
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return SizedBox();
              }
            },
          )
        ],
      ),
    );
  }
}
