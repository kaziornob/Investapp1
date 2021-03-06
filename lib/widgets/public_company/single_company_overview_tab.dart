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
  // double _voteValue = 3.0;
  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Padding(
          //   padding: EdgeInsets.only(
          //     top: 5.0,
          //     left: 10.0,
          //   ),
          //   child: Container(
          //     width: 200,
          //     decoration: BoxDecoration(
          //       border: Border(
          //         bottom: BorderSide(
          //           width: 2,
          //           color: Color(0xFFfec20f),
          //         ),
          //       ),
          //     ),
          //     padding: EdgeInsets.only(bottom: 8.0),
          //     child: Text(
          //       'Investors you follow',
          //       style: new TextStyle(
          //         fontFamily: "Poppins",
          //         fontSize: 18.0,
          //         letterSpacing: 0.2,
          //         color: Colors.black,
          //       ),
          //     ),
          //   ),
          // ),
          // // investor slider
          //
          // Padding(
          //   padding: const EdgeInsets.only(left: 13, right: 5.0),
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Expanded(
          //         child: Container(
          //             width: MediaQuery.of(context).size.width,
          //             height: MediaQuery.of(context).size.height * 0.10,
          //             child: Scrollbar(
          //               child: ListView.builder(
          //                 itemCount: 10,
          //                 scrollDirection: Axis.horizontal,
          //                 itemBuilder: (context, index) {
          //                   return InkWell(
          //                     child: Container(
          //                       child: Row(
          //                         children: [
          //                           CircleAvatar(
          //                             radius: 25.0,
          //                             backgroundImage: index == 0
          //                                 ? new AssetImage(
          //                                     'assets/filledweeklyAuroBadge.png')
          //                                 : new AssetImage(
          //                                     'assets/weeklyAuroBadge.png'),
          //                             backgroundColor: Colors.transparent,
          //                           ),
          //                           SizedBox(
          //                             width: 10,
          //                           )
          //                         ],
          //                       ),
          //                     ),
          //                   );
          //                 },
          //               ),
          //             )),
          //       ),
          //     ],
          //   ),
          // ),
          SinglePublicCompanyAllStatsList(
            marketCapital: widget.data["market_cap_usd_mn"],
            netDebt: widget.data["net_debt_usd_mn"],
            roe3yr: widget.data["roe_3yr"],
            currency: widget.data["currency"],
            equityBeta: widget.data["equity_beta"],
            marketCapLocal: widget.data["market_cap_local_mn"],
            fixRate: widget.data["fx_rate"],
          ),

          //compare section
          CompareChartForPublicCompany(
            ticker: widget.data["ticker"],
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
          // voting bar box
          // Padding(
          //   padding: EdgeInsets.only(top: 5.0, left: 10.0),
          //   child: Container(
          //     width: 100,
          //     decoration: BoxDecoration(
          //       border: Border(
          //         bottom: BorderSide(
          //           width: 2,
          //           color: Color(0xFFfec20f),
          //         ),
          //       ),
          //     ),
          //     padding: EdgeInsets.only(bottom: 8.0),
          //     child: Text(
          //       'Voting bar',
          //       style: new TextStyle(
          //         fontFamily: "Poppins",
          //         color: Colors.black,
          //         fontSize: 18.0,
          //         letterSpacing: 0.2,
          //       ),
          //     ),
          //   ),
          // ),
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height * 0.05,
          //   margin: EdgeInsets.all(7.0),
          //   decoration: new BoxDecoration(
          //     // border: Border.all(
          //     //   color: Color(0xFFfec20f),
          //     //   width: 1,
          //     // ),
          //     borderRadius: BorderRadius.all(
          //       Radius.circular(2.0),
          //     ),
          //   ),
          //   child: SliderTheme(
          //     data: SliderTheme.of(context).copyWith(
          //       activeTrackColor: Colors.green,
          //       inactiveTrackColor: Colors.red[100],
          //       trackShape: RoundedRectSliderTrackShape(),
          //       trackHeight: 4.0,
          //       thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
          //       thumbColor: Colors.green,
          //       overlayColor: Colors.red.withAlpha(32),
          //       overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
          //       tickMarkShape: RoundSliderTickMarkShape(),
          //       activeTickMarkColor: Colors.green,
          //       inactiveTickMarkColor: Colors.red[100],
          //       valueIndicatorShape: PaddleSliderValueIndicatorShape(),
          //       valueIndicatorColor: Colors.green,
          //       valueIndicatorTextStyle: TextStyle(
          //         color: Colors.white,
          //       ),
          //     ),
          //     child: Slider(
          //       value: _voteValue,
          //       min: 0,
          //       max: 100,
          //       divisions: 10,
          //       label: '$_voteValue',
          //       onChanged: (value) {
          //         setState(
          //           () {
          //             _voteValue = value;
          //           },
          //         );
          //       },
          //     ),
          //   ),
          // ),
//           Container(
// /*            width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height*0.06,*/
//             margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 Container(
//                     width: MediaQuery.of(context).size.width * 0.48,
//                     decoration: new BoxDecoration(
//                       border: Border.all(
//                         color: Color(0xFFfec20f),
//                         width: 1,
//                       ),
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(2.0),
//                       ),
//                     ),
//                     child: Container(
//                       width: MediaQuery.of(context).size.width * 0.10,
//                       margin:
//                           EdgeInsets.only(left: 27.0, top: 7.0, right: 27.0),
//                       decoration: new BoxDecoration(
//                         border: Border.all(
//                           color: Color(0xFFfec20f),
//                           width: 1,
//                         ),
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(2.0),
//                         ),
//                       ),
//                       child: Center(
//                         child: Text(
//                           'Long',
//                           style: new TextStyle(
//                             fontFamily: "WorkSansSemiBold",
//                             color: Color(0xFFFFFFFF),
//                             fontSize: 15.0,
//                           ),
//                         ),
//                       ),
//                     )),
//                 Container(
//                     width: MediaQuery.of(context).size.width * 0.48,
//                     decoration: new BoxDecoration(
//                       border: Border.all(
//                         color: Color(0xFFfec20f),
//                         width: 1,
//                       ),
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(2.0),
//                       ),
//                     ),
//                     child: Container(
//                       width: MediaQuery.of(context).size.width * 0.10,
//                       margin:
//                           EdgeInsets.only(left: 27.0, top: 7.0, right: 27.0),
//                       decoration: new BoxDecoration(
//                         border: Border.all(
//                           color: Color(0xFFfec20f),
//                           width: 1,
//                         ),
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(2.0),
//                         ),
//                       ),
//                       child: Center(
//                         child: Text(
//                           'Short',
//                           style: new TextStyle(
//                             fontFamily: "WorkSansSemiBold",
//                             color: Color(0xFFFFFFFF),
//                             fontSize: 15.0,
//                           ),
//                         ),
//                       ),
//                     ))
//               ],
//             ),
//           ),
//           Container(
//             // width: MediaQuery.of(context).size.width,
//             // height: MediaQuery.of(context).size.height*0.07,
//             margin: EdgeInsets.only(
//                 left: MediaQuery.of(context).size.width * 0.02,
//                 right: MediaQuery.of(context).size.width * 0.02),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Container(
//                   height: MediaQuery.of(context).size.height * 0.07,
//                   width: MediaQuery.of(context).size.width * 0.48,
//                   decoration: new BoxDecoration(
//                     border: Border.all(
//                       color: Color(0xFFfec20f),
//                       width: 1,
//                     ),
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(2.0),
//                     ),
//                   ),
//                   child: Center(
//                     child: Text(
//                       'Article 1',
//                       style: new TextStyle(
//                         fontFamily: "WorkSansSemiBold",
//                         color: Color(0xFFFFFFFF),
//                         fontSize: 15.0,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: MediaQuery.of(context).size.height * 0.07,
//                   width: MediaQuery.of(context).size.width * 0.48,
//                   decoration: new BoxDecoration(
//                     border: Border.all(
//                       color: Color(0xFFfec20f),
//                       width: 1,
//                     ),
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(2.0),
//                     ),
//                   ),
//                   child: Center(
//                     child: Text(
//                       'Article 2',
//                       style: new TextStyle(
//                         fontFamily: "WorkSansSemiBold",
//                         color: Color(0xFFFFFFFF),
//                         fontSize: 15.0,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
// /*            width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height*0.07,
//             margin: EdgeInsets.only(left:7.0,right:7.0),*/
//             margin: EdgeInsets.only(
//                 left: MediaQuery.of(context).size.width * 0.02,
//                 right: MediaQuery.of(context).size.width * 0.02),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Container(
//                   height: MediaQuery.of(context).size.height * 0.07,
//                   width: MediaQuery.of(context).size.width * 0.48,
//                   decoration: new BoxDecoration(
//                     border: Border.all(
//                       color: Color(0xFFfec20f),
//                       width: 1,
//                     ),
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(2.0),
//                     ),
//                   ),
//                   child: Center(
//                     child: Text(
//                       'Article 3',
//                       style: new TextStyle(
//                         fontFamily: "WorkSansSemiBold",
//                         color: Color(0xFFFFFFFF),
//                         fontSize: 15.0,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: MediaQuery.of(context).size.height * 0.07,
//                   width: MediaQuery.of(context).size.width * 0.48,
//                   decoration: new BoxDecoration(
//                     border: Border.all(
//                       color: Color(0xFFfec20f),
//                       width: 1,
//                     ),
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(2.0),
//                     ),
//                   ),
//                   child: Center(
//                     child: Text(
//                       'Article 4',
//                       style: new TextStyle(
//                         fontFamily: "WorkSansSemiBold",
//                         color: Color(0xFFFFFFFF),
//                         fontSize: 15.0,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height * 0.06,
//             margin: EdgeInsets.only(left: 7.0, right: 7.0),
//             child: Container(
//                 width: MediaQuery.of(context).size.width * 0.48,
//                 decoration: new BoxDecoration(
//                   border: Border.all(
//                     color: Color(0xFFfec20f),
//                     width: 1,
//                   ),
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(2.0),
//                   ),
//                 ),
//                 child: Container(
//                   width: MediaQuery.of(context).size.width * 0.10,
//                   margin: EdgeInsets.only(
//                       left: 47.0, top: 7.0, right: 47.0, bottom: 3.0),
//                   decoration: new BoxDecoration(
//                     border: Border.all(
//                       color: Color(0xFFfec20f),
//                       width: 1,
//                     ),
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(2.0),
//                     ),
//                   ),
//                   child: Center(
//                     child: Text(
//                       'Explore',
//                       style: new TextStyle(
//                         fontFamily: "WorkSansSemiBold",
//                         color: Color(0xFFFFFFFF),
//                         fontSize: 15.0,
//                       ),
//                     ),
//                   ),
//                 )),
//           ),
//           Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height * 0.18,
//             margin: EdgeInsets.all(7.0),
//             decoration: new BoxDecoration(
//               border: Border.all(
//                 color: Color(0xFFfec20f),
//                 width: 1,
//               ),
//               borderRadius: BorderRadius.all(
//                 Radius.circular(2.0),
//               ),
//             ),
//             child: Center(
//               child: Text(
//                 'Company Sponsored Content',
//                 style: new TextStyle(
//                     fontFamily: "Poppins",
//                     color: Color(0xFFFFFFFF),
//                     fontSize: 14.0,
//                     letterSpacing: 0.2),
//               ),
//             ),
//           ),
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
                                return
                                    // Row(
                                    // children: [
                                    Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SecurityPageFirst(
                                            companyTicker:
                                                widget.data["ticker"],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 80.0,
                                      height: 80.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(snapshot
                                              .data[index]["logo_img_name"]),
                                          fit: BoxFit.fill,
                                        ),
                                        shape: BoxShape.circle,
                                        // borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
                                        border: new Border.all(
                                          color: Color(0xff5A56B9),
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                                //     SizedBox(
                                //       width: 10,
                                //     )
                                //   ],
                                // );
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
