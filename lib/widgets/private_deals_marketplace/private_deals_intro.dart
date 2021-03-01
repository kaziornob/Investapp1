import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/widgets/private_deals_marketplace/sample_featured_companies_list.dart';
import 'package:flutter/cupertino.dart';

class PrivateDealsIntro extends StatefulWidget {
  final VoidCallback goToMarketplaceCallback;

  PrivateDealsIntro({this.goToMarketplaceCallback});
  @override
  _PrivateDealsIntroState createState() => _PrivateDealsIntroState();
}

class _PrivateDealsIntroState extends State<PrivateDealsIntro> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 505,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 100,
              padding: const EdgeInsets.only(
                bottom: 8,
              ),
              child: Center(
                child: Text(
                  "Private Deals Marketplace",
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
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 8.0),
              child: Container(
                // margin: EdgeInsets.only(left: 35.0,right: 20.0),
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.07,
                    right: MediaQuery.of(context).size.width * 0.03),
                child: Text(
                  "The Private Deals Marketplace is your opportunity to invest in trending private companies. "
                      "All you need to do is select a company, notify your investment interest, and wait "
                      "as Auroville contacts you to close the call",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color:
                      AllCoustomTheme.getNewSecondTextThemeColor(),
                      fontSize: 14.5,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0.2),
                ),
              ),
            ),
            Container(
              // decoration: BoxDecoration(
              //     border: Border.all(
              //   color: Colors.white,
              // )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text(
                          "Sample Featured Companies",
                          style: TextStyle(
                              color:
                              AllCoustomTheme.getHeadingThemeColors(),
                              fontSize: ConstanceData.SIZE_TITLE20,
                              fontFamily: "Rosarivo",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.1),
                        ),
                      ),
                    ],
                  ),
                  SampleFeaturedCompaniesList(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: widget.goToMarketplaceCallback,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width - 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AllCoustomTheme.getButtonBoxColor(),
                        ),
                        child: Center(
                          child: Text(
                            "Go to Marketplace",
                            style: TextStyle(
                                color:
                                AllCoustomTheme.getButtonTextThemeColors(),
                                fontSize: ConstanceData.SIZE_TITLE20,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
