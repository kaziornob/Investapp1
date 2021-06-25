import 'package:auroim/widgets/crypto_marketplace/crypto_coins_marketplace.dart';
import 'package:auroim/widgets/invest_tab/auro_star/auro_stars.dart';
import 'package:auroim/widgets/private_deals_marketplace/private_deals_main_page.dart';
import 'package:auroim/widgets/public_company/public_company_marketplace.dart';
import 'package:flutter/material.dart';

class MainInvestTab extends StatefulWidget {
  @override
  _MainInvestTabState createState() => _MainInvestTabState();
}

class _MainInvestTabState extends State<MainInvestTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PublicCompanyMarketPlace(),
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color(0xffd8af4f),
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Image.asset(
                              'assets/listed_icon.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'LISTED',
                              style: TextStyle(
                                  color: Color(0xffd8af4f), fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              PrivateDealsMarketplaceMainPage(),
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color(0xffd8af4f),
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Image.asset(
                              'assets/unlisted_icon.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'UNLISTED',
                              style: TextStyle(
                                  color: Color(0xffd8af4f), fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CryptoCoinsMarketplace(),
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color(0xffd8af4f),
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Image.asset(
                              'assets/crypto_icon.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'CRYPTO',
                              style: TextStyle(
                                  color: Color(0xffd8af4f), fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => QuizScreen(
                      //         )));
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AuroStar()));
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color(0xffd8af4f),
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Center(
                              child: Image.asset(
                                'assets/auro_star.png',
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'AURO STAR',
                              style: TextStyle(
                                  color: Color(0xffd8af4f), fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color(0xffd8af4f),
                      ),
                    ),
                    child: Stack(
                      overflow: Overflow.visible,
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              'TRENDING',
                              style: TextStyle(
                                  color: Color(0xffd8af4f), fontSize: 18),
                            ),
                          ),
                        ),
                        Positioned(
                          top: -42,
                          left: 45,
                          right: 0,
                          child: Image.asset(
                            'assets/trending.png',
                            width: 90,
                            height: 90,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:auroim/constance/constance.dart';
// import 'package:auroim/constance/themes.dart';
// import 'package:auroim/modules/investRelatedPages/searchFirstPage.dart';
// import 'package:auroim/widgets/auro_stars.dart';
// import 'package:auroim/widgets/crypto_marketplace/crypto_coins_marketplace.dart';
// import 'package:auroim/widgets/crypto_marketplace/crypto_marketplace_main_page.dart';
// import 'package:auroim/widgets/goLiveInvest/personalSleeve.dart';
// import 'package:auroim/widgets/go_to_marketplace_button.dart';
// import 'package:auroim/widgets/private_deals_marketplace/private_deals_intro.dart';
// import 'package:auroim/widgets/private_deals_marketplace/private_deals_main_page.dart';
// import 'package:auroim/widgets/public_companies_list.dart';
// import 'package:auroim/constance/global.dart' as globals;
// import 'package:auroim/widgets/public_company/public_company_marketplace.dart';
// import 'package:flutter/material.dart';
//
// class MainInvestTab extends StatefulWidget {
//   @override
//   _MainInvestTabState createState() => _MainInvestTabState();
// }
//
// class _MainInvestTabState extends State<MainInvestTab> {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       physics: BouncingScrollPhysics(),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           SearchFirstPage(callingFrom: "",),
//           // personal sleeve section
//           PersonalSleeve(
//             goToPersonalSleeveCallback: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => PersonalSleeve(),
//                 ),
//               );
//             },
//           ),
//           // auro stars section
//           Visibility(
//             visible: globals.isGoldBlack ? true : false,
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: 150,
//                       padding: const EdgeInsets.only(
//                         bottom: 8,
//                       ),
//                       child: Center(
//                         child: Text(
//                           "Auro Stars",
//                           style: TextStyle(
//                               color: AllCoustomTheme.getHeadingThemeColors(),
//                               fontSize: ConstanceData.SIZE_TITLE20,
//                               fontFamily: "Rosarivo",
//                               fontStyle: FontStyle.normal,
//                               fontWeight: FontWeight.bold,
//                               letterSpacing: 0.1),
//                         ),
//                       ),
//                       decoration: BoxDecoration(
//                         border: Border(
//                           bottom: BorderSide(
//                             color: AllCoustomTheme.getHeadingThemeColors(),
//                             width: 2,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 10.0, bottom: 8.0),
//                   child: Container(
//                     // margin: EdgeInsets.only(left: 35.0,right: 20.0),
//                     margin: EdgeInsets.only(
//                         left: MediaQuery.of(context).size.width * 0.07,
//                         right: MediaQuery.of(context).size.width * 0.03),
//                     child: Text(
//                       "Invest in actively managed portfolios created by Auroville Investment Management" +
//                           " team of licensed professionals",
//                       textAlign: TextAlign.left,
//                       style: TextStyle(
//                           color: AllCoustomTheme.getNewSecondTextThemeColor(),
//                           fontSize: 14.5,
//                           fontFamily: "Roboto",
//                           fontStyle: FontStyle.normal,
//                           letterSpacing: 0.2),
//                     ),
//                   ),
//                 ),
//                 AuroStars(),
//               ],
//             ),
//           ),
//           //public equities section
//           SizedBox(
//             height: 10,
//           ),
//           Visibility(
//             visible: globals.isGoldBlack ? true : false,
//             child: Column(
//               // crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: MediaQuery.of(context).size.width - 100,
//                       padding: const EdgeInsets.only(
//                         bottom: 8,
//                       ),
//                       child: Center(
//                         child: Text(
//                           "Listed Company Marketplace",
//                           style: TextStyle(
//                               color: AllCoustomTheme.getHeadingThemeColors(),
//                               fontSize: ConstanceData.SIZE_TITLE20,
//                               fontFamily: "Rosarivo",
//                               fontStyle: FontStyle.normal,
//                               fontWeight: FontWeight.bold,
//                               letterSpacing: 0.1),
//                         ),
//                       ),
//                       decoration: BoxDecoration(
//                         border: Border(
//                           bottom: BorderSide(
//                             color: AllCoustomTheme.getHeadingThemeColors(),
//                             width: 2,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 PublicCompaniesList(),
//                 GoToMarketplaceButton(
//                   buttonColor: AllCoustomTheme.getButtonBoxColor(),
//                   textColor: globals.isGoldBlack ? Colors.black : Colors.white,
//                   callback: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => PublicCompanyMarketPlace(),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//           //crypto market place section
//           Visibility(
//             visible: globals.isGoldBlack ? true : false,
//             child: Column(
//               children: [
//                 CryptoMarketplace(),
//                 GoToMarketplaceButton(
//                   buttonColor: AllCoustomTheme.getButtonBoxColor(),
//                   textColor: globals.isGoldBlack ? Colors.black : Colors.white,
//                   callback: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => CryptoCoinsMarketplace(),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//           //Pvt deals section
//           Visibility(
//             visible: globals.isGoldBlack ? true : false,
//             child: PrivateDealsIntro(
//               goToMarketplaceCallback: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => PrivateDealsMarketplaceMainPage(),
//                   ),
//                 );
//               },
//             ),
//           ),
//           SizedBox(height: 10,),
//           // investment guru component box
//           // SizedBox(
//           //   width: MediaQuery.of(context).size.width,
//           //   height: MediaQuery.of(context).size.height * 0.57,
//           //   child: Container(
//           //       margin: EdgeInsets.only(left: 5.0, right: 5.0),
//           //       child: ListView(
//           //         physics: NeverScrollableScrollPhysics(),
//           //         children: <Widget>[
//           //           Padding(
//           //             padding: EdgeInsets.only(top: 10.0),
//           //             child: Center(
//           //                 child: Text(
//           //               'INVESTMENT GURUS',
//           //               style: new TextStyle(
//           //                 color: AllCoustomTheme.getHeadingThemeColors(),
//           //                 fontSize: ConstanceData.SIZE_TITLE18,
//           //                 fontFamily: "Rosarivo",
//           //               ),
//           //             )),
//           //           ),
//           //           Container(
//           //             margin: EdgeInsets.only(
//           //                 left: MediaQuery.of(context).size.width * 0.12,
//           //                 right: MediaQuery.of(context).size.width * 0.12),
//           //             padding: EdgeInsets.only(
//           //               bottom: 3, // space between underline and text
//           //             ),
//           //             decoration: BoxDecoration(
//           //                 border: Border(
//           //                     bottom: BorderSide(
//           //               color: AllCoustomTheme.getHeadingThemeColors(),
//           //               width: 1.0, // Underline width
//           //             ))),
//           //           ),
//           //           SizedBox(
//           //               width: MediaQuery.of(context).size.width,
//           //               height: MediaQuery.of(context).size.height * 0.34,
//           //               child: Container(
//           //                 margin: EdgeInsets.only(
//           //                     top: 15.0, left: 5.0, right: 5.0, bottom: 5.0),
//           //                 child: getAreaChartView(),
//           //               )),
//           //           Container(
//           //               child: Row(
//           //             crossAxisAlignment: CrossAxisAlignment.start,
//           //             children: <Widget>[
//           //               Padding(
//           //                   padding: EdgeInsets.only(
//           //                       left: 230.0, bottom: 5.0, top: 3.0),
//           //                   child: Text(
//           //                     'See More',
//           //                     style: new TextStyle(
//           //                       color: AllCoustomTheme.getSeeMoreThemeColor(),
//           //                       fontSize: ConstanceData.SIZE_TITLE15,
//           //                       fontFamily: "Roboto",
//           //                     ),
//           //                   )),
//           //             ],
//           //           )),
//           //           SizedBox(
//           //             height: 20,
//           //           ),
//           //           Padding(
//           //             padding: const EdgeInsets.only(
//           //                 bottom: 20, left: 20, right: 20),
//           //             child: Row(
//           //               mainAxisAlignment: MainAxisAlignment.center,
//           //               children: <Widget>[
//           //                 SizedBox(
//           //                   height:
//           //                       MediaQuery.of(context).size.height * 0.065,
//           //                   child: Container(
//           //                     height:
//           //                         MediaQuery.of(context).size.height * 0.065,
//           //                     width: MediaQuery.of(context).size.width * 0.45,
//           //                     decoration: BoxDecoration(
//           //                         borderRadius:
//           //                             BorderRadius.all(Radius.circular(20)),
//           //                         border: new Border.all(
//           //                             color:
//           //                                 AllCoustomTheme.getButtonBoxColor(),
//           //                             width: 1.5),
//           //                         color: AllCoustomTheme.getButtonBoxColor()),
//           //                     child: MaterialButton(
//           //                       splashColor: Colors.grey,
//           //                       child: Text(
//           //                         "START NOW",
//           //                         style: TextStyle(
//           //                           color: AllCoustomTheme
//           //                               .getButtonTextThemeColors(),
//           //                           fontSize: ConstanceData.SIZE_TITLE13,
//           //                           fontFamily: "Roboto",
//           //                           fontWeight: FontWeight.bold,
//           //                         ),
//           //                       ),
//           //                     ),
//           //                   ),
//           //                 ),
//           //               ],
//           //             ),
//           //           ),
//           //         ],
//           //       )),
//           // ),
//           // pe/vc/re component box
//           // SizedBox(
//           //   width: MediaQuery.of(context).size.width,
//           //   height: MediaQuery.of(context).size.height * 0.27,
//           //   child: Container(
//           //       margin: EdgeInsets.only(left: 5.0, right: 5.0),
//           //       child: ListView(
//           //         physics: NeverScrollableScrollPhysics(),
//           //         children: <Widget>[
//           //           Padding(
//           //             padding: EdgeInsets.only(top: 5.0),
//           //             child: Center(
//           //                 child: Text(
//           //               'PE/VC/RE/ESG',
//           //               style: new TextStyle(
//           //                 color: AllCoustomTheme.getHeadingThemeColors(),
//           //                 fontSize: ConstanceData.SIZE_TITLE18,
//           //                 fontFamily: "Rosarivo",
//           //               ),
//           //             )),
//           //           ),
//           //           Container(
//           //             // margin: EdgeInsets.only(left: 90.0,right: 90.0),
//           //             margin: EdgeInsets.only(
//           //                 left: MediaQuery.of(context).size.width * 0.25,
//           //                 right: MediaQuery.of(context).size.width * 0.25),
//           //
//           //             padding: EdgeInsets.only(
//           //               bottom: 3, // space between underline and text
//           //             ),
//           //             decoration: BoxDecoration(
//           //                 border: Border(
//           //                     bottom: BorderSide(
//           //               color: AllCoustomTheme.getHeadingThemeColors(),
//           //               width: 1.0, // Underline width
//           //             ))),
//           //           ),
//           //           SizedBox(
//           //             height: 30,
//           //           ),
//           //           Padding(
//           //             padding: const EdgeInsets.only(
//           //                 bottom: 20, left: 20, right: 20),
//           //             child: Row(
//           //               mainAxisAlignment: MainAxisAlignment.center,
//           //               children: <Widget>[
//           //                 SizedBox(
//           //                   height:
//           //                       MediaQuery.of(context).size.height * 0.065,
//           //                   child: Container(
//           //                     height:
//           //                         MediaQuery.of(context).size.height * 0.065,
//           //                     width: MediaQuery.of(context).size.width * 0.45,
//           //                     decoration: BoxDecoration(
//           //                         borderRadius:
//           //                             BorderRadius.all(Radius.circular(20)),
//           //                         border: new Border.all(
//           //                             color:
//           //                                 AllCoustomTheme.getButtonBoxColor(),
//           //                             width: 1.5),
//           //                         color: AllCoustomTheme.getButtonBoxColor()),
//           //                     child: MaterialButton(
//           //                       splashColor: Colors.grey,
//           //                       child: Text(
//           //                         "START NOW",
//           //                         style: TextStyle(
//           //                           color: AllCoustomTheme
//           //                               .getButtonTextThemeColors(),
//           //                           fontSize: ConstanceData.SIZE_TITLE13,
//           //                           fontFamily: "Roboto",
//           //                           fontWeight: FontWeight.bold,
//           //                         ),
//           //                       ),
//           //                     ),
//           //                   ),
//           //                 ),
//           //               ],
//           //             ),
//           //           ),
//           //           Padding(
//           //               padding: EdgeInsets.only(left: 235.0),
//           //               child: Text(
//           //                 'See More',
//           //                 style: new TextStyle(
//           //                   color: AllCoustomTheme.getSeeMoreThemeColor(),
//           //                   fontSize: ConstanceData.SIZE_TITLE15,
//           //                   fontFamily: "Roboto",
//           //                 ),
//           //               )),
//           //         ],
//           //       )),
//           // ),
//           // last start now component box
//           // SizedBox(
//           //   width: MediaQuery.of(context).size.width,
//           //   height: MediaQuery.of(context).size.height * 0.27,
//           //   child: Container(
//           //       margin: EdgeInsets.only(left: 5.0, right: 5.0),
//           //       child: ListView(
//           //         physics: NeverScrollableScrollPhysics(),
//           //         children: <Widget>[
//           //           Padding(
//           //             padding: EdgeInsets.only(top: 5.0),
//           //             child: Center(
//           //                 child: Text(
//           //               'STUDENT',
//           //               style: new TextStyle(
//           //                 color: AllCoustomTheme.getHeadingThemeColors(),
//           //                 fontSize: ConstanceData.SIZE_TITLE18,
//           //                 fontFamily: "Rosarivo",
//           //               ),
//           //             )),
//           //           ),
//           //           Container(
//           //             // margin: EdgeInsets.only(left: 110.0,right: 110.0),
//           //             margin: EdgeInsets.only(
//           //                 left: MediaQuery.of(context).size.width * 0.30,
//           //                 right: MediaQuery.of(context).size.width * 0.30),
//           //
//           //             padding: EdgeInsets.only(
//           //               bottom: 3, // space between underline and text
//           //             ),
//           //             decoration: BoxDecoration(
//           //                 border: Border(
//           //                     bottom: BorderSide(
//           //               color: AllCoustomTheme.getHeadingThemeColors(),
//           //               width: 1.0, // Underline width
//           //             ))),
//           //           ),
//           //           SizedBox(
//           //             height: 30,
//           //           ),
//           //           Padding(
//           //             padding: const EdgeInsets.only(
//           //                 bottom: 20, left: 20, right: 20),
//           //             child: Row(
//           //               mainAxisAlignment: MainAxisAlignment.center,
//           //               children: <Widget>[
//           //                 SizedBox(
//           //                   height:
//           //                       MediaQuery.of(context).size.height * 0.065,
//           //                   child: Container(
//           //                     height:
//           //                         MediaQuery.of(context).size.height * 0.065,
//           //                     width: MediaQuery.of(context).size.width * 0.45,
//           //                     decoration: BoxDecoration(
//           //                         borderRadius:
//           //                             BorderRadius.all(Radius.circular(20)),
//           //                         border: new Border.all(
//           //                             color:
//           //                                 AllCoustomTheme.getButtonBoxColor(),
//           //                             width: 1.5),
//           //                         color: AllCoustomTheme.getButtonBoxColor()),
//           //                     child: MaterialButton(
//           //                       splashColor: Colors.grey,
//           //                       child: Text(
//           //                         "START NOW",
//           //                         style: TextStyle(
//           //                           color: AllCoustomTheme
//           //                               .getButtonTextThemeColors(),
//           //                           fontSize: ConstanceData.SIZE_TITLE13,
//           //                           fontFamily: "Roboto",
//           //                           fontWeight: FontWeight.bold,
//           //                         ),
//           //                       ),
//           //                     ),
//           //                   ),
//           //                 ),
//           //               ],
//           //             ),
//           //           ),
//           //         ],
//           //       )),
//           // ),
//         ],
//       ),
//     );
//   }
// }
