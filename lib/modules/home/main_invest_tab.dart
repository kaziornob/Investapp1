import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/investRelatedPages/searchFirstPage.dart';
import 'package:auroim/widgets/auro_stars.dart';
import 'package:auroim/widgets/crypto_marketplace/crypto_marketplace_main_page.dart';
import 'package:auroim/widgets/goLiveInvest/personalSleeve.dart';
import 'package:auroim/widgets/go_to_marketplace_button.dart';
import 'package:auroim/widgets/private_deals_marketplace/private_deals_intro.dart';
import 'package:auroim/widgets/private_deals_marketplace/private_deals_main_page.dart';
import 'package:auroim/widgets/public_companies_list.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:auroim/widgets/public_company/public_company_marketplace.dart';
import 'package:flutter/material.dart';

class MainInvestTab extends StatefulWidget {
  @override
  _MainInvestTabState createState() => _MainInvestTabState();
}

class _MainInvestTabState extends State<MainInvestTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SearchFirstPage(),
          // personal sleeve section
          PersonalSleeve(
            goToPersonalSleeveCallback: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PersonalSleeve(),
                ),
              );
            },
          ),
          // auro stars section
          Visibility(
            visible: globals.isGoldBlack ? true : false,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      padding: const EdgeInsets.only(
                        bottom: 8,
                      ),
                      child: Center(
                        child: Text(
                          "Auro Stars",
                          style: TextStyle(
                              color: AllCoustomTheme.getHeadingThemeColors(),
                              fontSize: ConstanceData.SIZE_TITLE20,
                              fontFamily: "Rosarivo",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.1),
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AllCoustomTheme.getHeadingThemeColors(),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                AuroStars(),
              ],
            ),
          ),
          //public equities section
          SizedBox(
            height: 10,
          ),
          Visibility(
            visible: globals.isGoldBlack ? true : false,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      padding: const EdgeInsets.only(
                        bottom: 8,
                      ),
                      child: Center(
                        child: Text(
                          "Listed Company Marketplace",
                          style: TextStyle(
                              color: AllCoustomTheme.getHeadingThemeColors(),
                              fontSize: ConstanceData.SIZE_TITLE20,
                              fontFamily: "Rosarivo",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.1),
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AllCoustomTheme.getHeadingThemeColors(),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                PublicCompaniesList(),
                GoToMarketplaceButton(
                  buttonColor: AllCoustomTheme.getButtonBoxColor(),
                  textColor: globals.isGoldBlack ? Colors.black : Colors.white,
                  callback: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PublicCompanyMarketPlace(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          //crypto market place section
          Visibility(
            visible: globals.isGoldBlack ? true : false,
            child: CryptoMarketplace(),
          ),
          //Pvt deals section
          Visibility(
            visible: globals.isGoldBlack ? true : false,
            child: PrivateDealsIntro(
              goToMarketplaceCallback: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PrivateDealsMarketplaceMainPage(),
                  ),
                );
              },
            ),
          ),
          // investment guru component box
          // SizedBox(
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height * 0.57,
          //   child: Container(
          //       margin: EdgeInsets.only(left: 5.0, right: 5.0),
          //       child: ListView(
          //         physics: NeverScrollableScrollPhysics(),
          //         children: <Widget>[
          //           Padding(
          //             padding: EdgeInsets.only(top: 10.0),
          //             child: Center(
          //                 child: Text(
          //               'INVESTMENT GURUS',
          //               style: new TextStyle(
          //                 color: AllCoustomTheme.getHeadingThemeColors(),
          //                 fontSize: ConstanceData.SIZE_TITLE18,
          //                 fontFamily: "Rosarivo",
          //               ),
          //             )),
          //           ),
          //           Container(
          //             margin: EdgeInsets.only(
          //                 left: MediaQuery.of(context).size.width * 0.12,
          //                 right: MediaQuery.of(context).size.width * 0.12),
          //             padding: EdgeInsets.only(
          //               bottom: 3, // space between underline and text
          //             ),
          //             decoration: BoxDecoration(
          //                 border: Border(
          //                     bottom: BorderSide(
          //               color: AllCoustomTheme.getHeadingThemeColors(),
          //               width: 1.0, // Underline width
          //             ))),
          //           ),
          //           SizedBox(
          //               width: MediaQuery.of(context).size.width,
          //               height: MediaQuery.of(context).size.height * 0.34,
          //               child: Container(
          //                 margin: EdgeInsets.only(
          //                     top: 15.0, left: 5.0, right: 5.0, bottom: 5.0),
          //                 child: getAreaChartView(),
          //               )),
          //           Container(
          //               child: Row(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: <Widget>[
          //               Padding(
          //                   padding: EdgeInsets.only(
          //                       left: 230.0, bottom: 5.0, top: 3.0),
          //                   child: Text(
          //                     'See More',
          //                     style: new TextStyle(
          //                       color: AllCoustomTheme.getSeeMoreThemeColor(),
          //                       fontSize: ConstanceData.SIZE_TITLE15,
          //                       fontFamily: "Roboto",
          //                     ),
          //                   )),
          //             ],
          //           )),
          //           SizedBox(
          //             height: 20,
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.only(
          //                 bottom: 20, left: 20, right: 20),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: <Widget>[
          //                 SizedBox(
          //                   height:
          //                       MediaQuery.of(context).size.height * 0.065,
          //                   child: Container(
          //                     height:
          //                         MediaQuery.of(context).size.height * 0.065,
          //                     width: MediaQuery.of(context).size.width * 0.45,
          //                     decoration: BoxDecoration(
          //                         borderRadius:
          //                             BorderRadius.all(Radius.circular(20)),
          //                         border: new Border.all(
          //                             color:
          //                                 AllCoustomTheme.getButtonBoxColor(),
          //                             width: 1.5),
          //                         color: AllCoustomTheme.getButtonBoxColor()),
          //                     child: MaterialButton(
          //                       splashColor: Colors.grey,
          //                       child: Text(
          //                         "START NOW",
          //                         style: TextStyle(
          //                           color: AllCoustomTheme
          //                               .getButtonTextThemeColors(),
          //                           fontSize: ConstanceData.SIZE_TITLE13,
          //                           fontFamily: "Roboto",
          //                           fontWeight: FontWeight.bold,
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       )),
          // ),
          // pe/vc/re component box
          // SizedBox(
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height * 0.27,
          //   child: Container(
          //       margin: EdgeInsets.only(left: 5.0, right: 5.0),
          //       child: ListView(
          //         physics: NeverScrollableScrollPhysics(),
          //         children: <Widget>[
          //           Padding(
          //             padding: EdgeInsets.only(top: 5.0),
          //             child: Center(
          //                 child: Text(
          //               'PE/VC/RE/ESG',
          //               style: new TextStyle(
          //                 color: AllCoustomTheme.getHeadingThemeColors(),
          //                 fontSize: ConstanceData.SIZE_TITLE18,
          //                 fontFamily: "Rosarivo",
          //               ),
          //             )),
          //           ),
          //           Container(
          //             // margin: EdgeInsets.only(left: 90.0,right: 90.0),
          //             margin: EdgeInsets.only(
          //                 left: MediaQuery.of(context).size.width * 0.25,
          //                 right: MediaQuery.of(context).size.width * 0.25),
          //
          //             padding: EdgeInsets.only(
          //               bottom: 3, // space between underline and text
          //             ),
          //             decoration: BoxDecoration(
          //                 border: Border(
          //                     bottom: BorderSide(
          //               color: AllCoustomTheme.getHeadingThemeColors(),
          //               width: 1.0, // Underline width
          //             ))),
          //           ),
          //           SizedBox(
          //             height: 30,
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.only(
          //                 bottom: 20, left: 20, right: 20),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: <Widget>[
          //                 SizedBox(
          //                   height:
          //                       MediaQuery.of(context).size.height * 0.065,
          //                   child: Container(
          //                     height:
          //                         MediaQuery.of(context).size.height * 0.065,
          //                     width: MediaQuery.of(context).size.width * 0.45,
          //                     decoration: BoxDecoration(
          //                         borderRadius:
          //                             BorderRadius.all(Radius.circular(20)),
          //                         border: new Border.all(
          //                             color:
          //                                 AllCoustomTheme.getButtonBoxColor(),
          //                             width: 1.5),
          //                         color: AllCoustomTheme.getButtonBoxColor()),
          //                     child: MaterialButton(
          //                       splashColor: Colors.grey,
          //                       child: Text(
          //                         "START NOW",
          //                         style: TextStyle(
          //                           color: AllCoustomTheme
          //                               .getButtonTextThemeColors(),
          //                           fontSize: ConstanceData.SIZE_TITLE13,
          //                           fontFamily: "Roboto",
          //                           fontWeight: FontWeight.bold,
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Padding(
          //               padding: EdgeInsets.only(left: 235.0),
          //               child: Text(
          //                 'See More',
          //                 style: new TextStyle(
          //                   color: AllCoustomTheme.getSeeMoreThemeColor(),
          //                   fontSize: ConstanceData.SIZE_TITLE15,
          //                   fontFamily: "Roboto",
          //                 ),
          //               )),
          //         ],
          //       )),
          // ),
          // last start now component box
          // SizedBox(
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height * 0.27,
          //   child: Container(
          //       margin: EdgeInsets.only(left: 5.0, right: 5.0),
          //       child: ListView(
          //         physics: NeverScrollableScrollPhysics(),
          //         children: <Widget>[
          //           Padding(
          //             padding: EdgeInsets.only(top: 5.0),
          //             child: Center(
          //                 child: Text(
          //               'STUDENT',
          //               style: new TextStyle(
          //                 color: AllCoustomTheme.getHeadingThemeColors(),
          //                 fontSize: ConstanceData.SIZE_TITLE18,
          //                 fontFamily: "Rosarivo",
          //               ),
          //             )),
          //           ),
          //           Container(
          //             // margin: EdgeInsets.only(left: 110.0,right: 110.0),
          //             margin: EdgeInsets.only(
          //                 left: MediaQuery.of(context).size.width * 0.30,
          //                 right: MediaQuery.of(context).size.width * 0.30),
          //
          //             padding: EdgeInsets.only(
          //               bottom: 3, // space between underline and text
          //             ),
          //             decoration: BoxDecoration(
          //                 border: Border(
          //                     bottom: BorderSide(
          //               color: AllCoustomTheme.getHeadingThemeColors(),
          //               width: 1.0, // Underline width
          //             ))),
          //           ),
          //           SizedBox(
          //             height: 30,
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.only(
          //                 bottom: 20, left: 20, right: 20),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: <Widget>[
          //                 SizedBox(
          //                   height:
          //                       MediaQuery.of(context).size.height * 0.065,
          //                   child: Container(
          //                     height:
          //                         MediaQuery.of(context).size.height * 0.065,
          //                     width: MediaQuery.of(context).size.width * 0.45,
          //                     decoration: BoxDecoration(
          //                         borderRadius:
          //                             BorderRadius.all(Radius.circular(20)),
          //                         border: new Border.all(
          //                             color:
          //                                 AllCoustomTheme.getButtonBoxColor(),
          //                             width: 1.5),
          //                         color: AllCoustomTheme.getButtonBoxColor()),
          //                     child: MaterialButton(
          //                       splashColor: Colors.grey,
          //                       child: Text(
          //                         "START NOW",
          //                         style: TextStyle(
          //                           color: AllCoustomTheme
          //                               .getButtonTextThemeColors(),
          //                           fontSize: ConstanceData.SIZE_TITLE13,
          //                           fontFamily: "Roboto",
          //                           fontWeight: FontWeight.bold,
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       )),
          // ),
        ],
      ),
    );
  }
}
