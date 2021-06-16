import 'dart:ui';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/home/widgets/company_price_charts.dart';
import 'package:auroim/modules/investRelatedPages/riskOnboardingPages/onBoardingFirst.dart';
import 'package:auroim/provider_abhinav/portfolio_provider.dart';
import 'package:auroim/reusable_widgets/screen_title_appbar.dart';
import 'package:auroim/widgets/payment_pages/payment_purchase.dart';
import 'package:auroim/widgets/payment_pages/payment_types.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuroAiPortfolio extends StatefulWidget {
  const AuroAiPortfolio({Key key}) : super(key: key);

  @override
  _AuroAiPortfolioState createState() => _AuroAiPortfolioState();
}

class _AuroAiPortfolioState extends State<AuroAiPortfolio> {
  CarouselController _carouselController = CarouselController();
  var carouselIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<PortfolioProvider>(
          builder: (context, portfolioProvider, _) {
            if (portfolioProvider.portfolioData != null) {
              return Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                          bottom: 20.0,
                        ),
                        child: ScreenTitleAppbar(
                          colorText: Color(0xFFD8AF4F),
                          title: "AURO.AI PORTFOLIO",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "This is an institutional grade portfolio created only for you.",
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Roboto",
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Row(
                          children: [
                            Text(
                              "View 3 Securities in the portfolio for free",
                              style: TextStyle(
                                color: Colors.grey,
                                fontFamily: "Roboto",
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      carousel(
                        portfolioProvider.portfolioData["lowest_securities"],
                      ),
                      Divider(
                        thickness: 4,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 4.0,
                                bottom: 4.0,
                              ),
                              child: Text(
                                "We have created a portfolio based on your Sign up",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  fontFamily: "Roboto",
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 4.0,
                                bottom: 4.0,
                              ),
                              child: Text(
                                "inputs. You can invest in this portfolio or just follow it",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  fontFamily: "Roboto",
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 4.0,
                                bottom: 4.0,
                              ),
                              child: Text(
                                "until you are comfortable",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  fontFamily: "Roboto",
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 15.0,
                                bottom: 15.0,
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: RaisedButton(
                                  shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: Color(0xFFD8AF4F),
                                    ),
                                  ),
                                  elevation: 10,
                                  color: Color(0xFFD8AF4F),
                                  onPressed: () {},
                                  child: Text(
                                    "INVEST",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      portfolioComponents(portfolioProvider.portfolioData),
                    ],
                  ),
                ),
              );
            } else {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Auro Portfolio Not Created"),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) =>
                                OnBoardingFirst(callingFrom: ""),
                          ),
                        );
                      },
                      child: Text(
                        "Customize Your Portfolio",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  portfolioComponents(data) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 800,
      child: Container(
        margin: EdgeInsets.only(left: 5.0, right: 5.0),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 5.0,
                bottom: 10.0,
              ),
              child: Center(
                child: Text(
                  'AURO PORTFOLIO COMPONENTS',
                  style: TextStyle(
                    color: AllCoustomTheme.getOtherTabHeadingThemeColors(),
                    fontSize: ConstanceData.SIZE_TITLE18,
                    fontFamily: "Roboto",
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 10,
              child: singleTableForPortFolio(data),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  carousel(data) {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: 3,
          itemBuilder: (context, int index) {
            return sliderItem(data[index]);
          },
          options: CarouselOptions(
            height: 320,
            autoPlay: false,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                carouselIndex = index;
              });
            },
          ),
        ),
        carouselIndexIndicator(),
      ],
    );
  }

  carouselIndexIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 10,
                backgroundColor:
                    carouselIndex == 0 ? Color(0xFFD8AF4F) : Colors.grey,
                child: Text(
                  "1",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 10,
                backgroundColor:
                    carouselIndex == 1 ? Color(0xFFD8AF4F) : Colors.grey,
                child: Text(
                  "2",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 10,
                backgroundColor:
                    carouselIndex == 2 ? Color(0xFFD8AF4F) : Colors.grey,
                child: Text(
                  "3",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  sliderItem(data) {
    return Container(
      child: CompanyPriceCharts(
        companyData: data,
      ),
    );
  }

  singleTableForPortFolio(portfolioChartData) {
    var index = 0;
    if (portfolioChartData != null) {
      return Container(
        child: Column(
          children: [
            Divider(
              thickness: 1,
              indent: 5,
            ),
            singleRow(context, "Security", 'Weight', 'In-Price',
                'Current Price', '% Return', Color(0xFFD8AF4F), 15.0),
            Divider(
              thickness: 1,
              indent: 5,
            ),
            Container(
              height: 180,
              child: ListView(
                children: portfolioChartData["lowest_securities"].map<Widget>(
                  (rowData) {
                    index = index + 1;
                    return singleRow(
                      context,
                      rowData["security_name"],
                      (rowData["weight"] * 100).toStringAsFixed(2),
                      rowData["inprice"].toStringAsFixed(2),
                      rowData["current_price"].toStringAsFixed(2),
                      rowData["return"] == null
                          ? "0.00"
                          : (((rowData["current_price"] / rowData["inprice"]) -
                                      1) *
                                  100)
                              .toStringAsFixed(2),
                      Colors.black,
                      12.0,
                    );
                  },
                ).toList(),
              ),
            ),
            Center(
              child: Container(
                height: 360,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Center(
                      child: Column(
                        children: (portfolioChartData["lowest_securities"] +
                                portfolioChartData["lowest_securities"])
                            .map<Widget>(
                          (rowData) {
                            index = index + 1;
                            return singleRow(
                              context,
                              rowData["ticker"],
                              (rowData["weight"] * 100).toStringAsFixed(2),
                              rowData["inprice"].toStringAsFixed(2),
                              rowData["current_price"].toStringAsFixed(2),
                              rowData["return"] == null
                                  ? "0.00"
                                  : rowData["return"].toStringAsFixed(2),
                              index % 2 == 0
                                  ? Colors.indigo[100]
                                  : Colors.indigo[50],
                              12.0,
                            );
                          },
                        ).toList(),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 15,
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 5.0,
                            sigmaY: 5.0,
                          ),
                          child: Container(
                            color: Colors.grey.withOpacity(0.1),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.55,
                            child: Image.asset('assets/logo.png'),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PaymentPurchaseScreen(),
                                ),
                                // MaterialPageRoute(
                                //   builder: (context) =>
                                //       FullListOfSecurities(
                                //     allSecurities: portfolioChartData["data"],
                                //   ),
                                // ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              child: Text(
                                "Click here to see entire portfolio",
                                style: TextStyle(
                                  color: Color(0xFF71BBF6),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget singleRow(
      context, security, share, ip, cp, perReturn, color, fontSize) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: (MediaQuery.of(context).size.width - 20) / 5,
          height: 60,
          child: Center(
            child: Text(
              "$security",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                color: color,
              ),
            ),
          ),
        ),
        Container(
          width: (MediaQuery.of(context).size.width - 20) / 5,
          height: 60,
          child: Center(
            child: Text(
              "$share",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                color: color,
              ),
            ),
          ),
        ),
        Container(
          width: (MediaQuery.of(context).size.width - 20) / 5,
          height: 60,
          child: Center(
            child: Text(
              "$ip",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                color: color,
              ),
            ),
          ),
        ),
        Container(
          width: (MediaQuery.of(context).size.width - 20) / 5,
          height: 60,
          child: Center(
            child: Text(
              cp,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                color: color,
              ),
            ),
          ),
        ),
        Container(
          width: (MediaQuery.of(context).size.width - 20) / 5,
          height: 60,
          child: Center(
            child: Text(
              perReturn,
              style: TextStyle(
                fontSize: fontSize,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
