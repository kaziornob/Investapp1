import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/investRelatedPages/riskOnboardingPages/onBoardingFirst.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuroStars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          smallImage(
              context,
              "assets/auro_asia_quantimental_portfolio_header.jpg",
              "assets/auro_asia_quantimental_portfolio.jpg"),
          smallImage(
              context,
              "assets/auro_asia_technology_portfolio_header.jpg",
              "assets/auro_asia_technology_portfolio.jpg"),
          smallImage(
              context,
              "assets/auro_global_consumer_portfolio_header.jpg",
              "assets/auro_global_consumer_portfolio.jpg"),
          smallImage(
              context,
              "assets/auro_global_thematic_portfolio_header.jpg",
              "assets/auro_global_thematic_portfolio.jpg"),
          smallImage(
              context,
              "assets/auro_india_healthcare_portfolio_header.jpg",
              "assets/auro_india_healthcare_portfolio.jpg"),
          smallImage(context, "assets/auro_us_consumer_portfolio_header.jpg",
              "assets/auro_us_consumer_portfolio.jpg"),
        ],
      ),
    );
  }

  // AssetImage('assets/logo.png')

  smallImage(context, imagePath, bigImagePath) {
    return Padding(
      padding: const EdgeInsets.only(left:8.0,right: 8.0,bottom: 0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => bigImage(bigImagePath, context),
            ),
          );
        },
        child: Column(
          children: [
            Container(
              // decoration: BoxDecoration(
              //   border: Border.all(),
              // ),
              height: 170,
              width: 250,
              child: Image.asset(imagePath),
            ),
            SizedBox(
              width: 120,
              height: 30,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(20)),
                  border: new Border.all(
                      color: AllCoustomTheme
                          .getChartBoxThemeColor(),
                      width: 1.5),
                  // color: AllCoustomTheme.getChartBoxThemeColor(),
                ),
                child: MaterialButton(
                  splashColor: Colors.grey,
                  child: Text(
                    "BUY",
                    style: TextStyle(
                      color: AllCoustomTheme
                          .getChartBoxTextThemeColor(),
                      fontSize: ConstanceData.SIZE_TITLE13,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bigImage(imagePath, context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height - 20,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
