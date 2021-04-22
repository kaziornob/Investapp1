import 'dart:math';
import 'dart:ui';

import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/api/future_return.dart';
import 'package:auroim/api/reusable_functions.dart';
import 'package:auroim/auth/investorType.dart';
import 'package:auroim/auth/userPersonalDetails.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/modules/bussPost/wishList.dart';
import 'package:auroim/modules/investRelatedPages/riskOnboardingPages/golive_screen.dart';
import 'package:auroim/modules/investRelatedPages/riskOnboardingPages/onBoardingFirst.dart';
import 'package:auroim/provider_abhinav/portfolio_provider.dart';
import 'package:auroim/provider_abhinav/user_details.dart';
import 'package:auroim/widgets/crypto_coin_price_data.dart';
import 'package:auroim/widgets/payment_pages/payment_purchase.dart';
import 'package:auroim/widgets/payment_pages/payment_types.dart';
import 'package:auroim/widgets/public_company/auro_paper_portfolio_performance.dart';
import 'package:auroim/widgets/small_get_area_chart_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:auroim/constance/global.dart' as globals;

import '../../main.dart';

class MainHomeTab extends StatefulWidget {
  @override
  _MainHomeTabState createState() => _MainHomeTabState();
}

class _MainHomeTabState extends State<MainHomeTab> {
  ApiProvider request = new ApiProvider();
  var portfolioChartData;
  int homeDonutCurrentIndex = 0;
  List homeDonutArray = [];
  List<ChartData> homeChartData = [];
  var userExpectedReturnData;
  bool _isinit = true;
  CarouselController _carouselController = CarouselController();
  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();
  FutureReturn _futureReturn = FutureReturn();
  ReusableFunctions _reusableFunctions = ReusableFunctions();

  @override
  void initState() {
    onInitDisplayBootomSheet();
    getExpectedRiskData();
    super.initState();
  }

  getExpectedRiskData() async {
    userExpectedReturnData =
        await _featuredCompaniesProvider.getGoproRiskMetricsForUser();
  }

  getUserDetails() async {
    print("getting user Details");
    ApiProvider request = new ApiProvider();
    // print("call set screen");
    var response = await request.getRequest('users/get_details');
    print("user detail response: $response");
    if (response != null && response != false) {
      userAllDetail = response['data'];

      Provider.of<UserDetails>(context, listen: false)
          .setUserDetails(userAllDetail);
      print(userAllDetail.toString());
    } else {
      print("Not got user data");
    }
  }

  @override
  void didChangeDependencies() async {
    if (_isinit) {
      Provider.of<PortfolioProvider>(context, listen: false).getPortfolioData();
      // Provider.of<PortfolioProvider>(context, listen: false)
      //     .getDailyReturnPortfolio();
      getUserDetails();
      _isinit = false;
    }
    super.didChangeDependencies();
  }

  onInitDisplayBootomSheet() async {
    // print();
    int showPopupData = await _reusableFunctions.homePagePopupGetData();
    print("home page popppopop $showPopupData}");
    if (showPopupData == null || showPopupData == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await showDialog(
          context: context,
          builder: (builder) {
            return AlertDialog(
              content: Text(
                "Voila! \n Auro has customized a sophisticated institutional grade portfolio for you based on your sign-up inputs. You can invest this portfolio by clicking on the Invest button below, or just follow it until you’re comfortable to invest.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  letterSpacing: 0.8,
                ),
                textAlign: TextAlign.center,
              ),
              backgroundColor: Color(0xff161946),
              actions: [
                FlatButton(
                  child: Text(
                    "OK",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    print("home page OK pressed");
                    await _reusableFunctions.homePagePopupPressed();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return cc();
    //   FutureBuilder(
    //   future: getDoughnutPortfolioData(),
    //   builder: (context, snapshot) {
    //     if()
    //   },
    // );
  }

  cc() {
    // return FutureBuilder(
    //   future: Provider.of<PortfolioProvider>(context, listen: false)
    //       .getDailyReturnPortfolio(),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //
    //
    //       return ;
    //     } else {
    //       return SizedBox();
    //     }
    //   },
    // );
    return Consumer<PortfolioProvider>(
      builder: (context, portfolioProvider, _) {
        if (portfolioProvider.portfolioData != null) {
          homeDonutArray = [1, 2, 3, 4, 5, 6, 7];
          setHomeDoughnutChartData(portfolioProvider.portfolioData);

          // var allPriceData = [];
          // var allPriceUsDollar = [];
          // var allReturnPerc = [];
          // portfolioProvider.dailyPortfolioReturnData.forEach((element) {
          //   DateTime date =
          //       DateFormat("yyyy-MM-ddTHH:mm:ss").parse(element["date"]);
          //   if (element["cumm_return_perc"] != null) {
          //     allPriceData.add(
          //       CryptoCoinPriceData(
          //           x: date, y: element["cumm_return_perc"] * 100),
          //     );
          //     allPriceUsDollar.add(
          //       CryptoCoinPriceData(x: date, y: element["cumm_return"]),
          //     );
          //     allReturnPerc.add(
          //       CryptoCoinPriceData(x: date, y: element["daily_return"]),
          //     );
          //   }
          // });

          // var inception_to_date_return_pct = allPriceData.length == 0
          //     ? 0.0
          //     : allPriceData[allPriceData.length - 1].y;
          // var inception_to_date_return_dollar =
          //     inception_to_date_return_pct * 1000000;
          // DateTime date_of_creation =
          //     allPriceData.length == 0 ? DateTime.now() : allPriceData[0].x;
          // var days_diff = DateTime.now().difference(date_of_creation).inDays;
          // print("days diff : " + days_diff.toString());
          // var inceptionToDateAnnualizedReturnPct =
          //     (pow(1 + inception_to_date_return_pct, (365 / days_diff)) - 1);
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Consumer<UserDetails>(
                  builder: (context, userDetailsProvider, _) {
                    if (userDetailsProvider.userDetails != null &&
                        userDetailsProvider.userDetails["f_name"] != null) {
                      return Container(
                        alignment: Alignment.center,
                        child: Text(
                          portfolioProvider.portfolioData == null
                              ? ""
                              : portfolioProvider.portfolioData[
                                          "has_gopro_portfolio"] ==
                                      0
                                  ? "${userDetailsProvider.userDetails["f_name"]}'s Auro Portfolio"
                                  : "${userDetailsProvider.userDetails["f_name"]}'s Auro Custom Portfolio",
                          style: TextStyle(
                              color: AllCoustomTheme
                                  .getOtherTabHeadingThemeColors(),
                              fontSize: ConstanceData.SIZE_TITLE20,
                              fontFamily: "Rosarivo",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.normal,
                              letterSpacing: 0.1),
                        ),
                      );
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        child: Text(
                          portfolioProvider.portfolioData == null
                              ? ""
                              : portfolioProvider.portfolioData[
                                          "has_gopro_portfolio"] ==
                                      0
                                  ? "Auro Portfolio"
                                  : "Auro custom portfolio",
                          style: TextStyle(
                              color: AllCoustomTheme
                                  .getOtherTabHeadingThemeColors(),
                              fontSize: ConstanceData.SIZE_TITLE20,
                              fontFamily: "Rosarivo",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.normal,
                              letterSpacing: 0.1),
                        ),
                      );
                    }
                  },
                ),
                Container(
                  // margin: EdgeInsets.only(left: 80.0,right: 80.0),
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.07,
                      right: MediaQuery.of(context).size.width * 0.07),
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                    bottom: 3, // space between underline and text
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 1.6, // Underline width
                      ),
                    ),
                  ),
                ),
                StatefulBuilder(builder: (context, setCarouselState) {
                  return Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 250,
                            // decoration: BoxDecoration(border: Border.all()),
                            child: CarouselSlider.builder(
                              carouselController: _carouselController,
                              itemCount: 7,
                              options: CarouselOptions(
                                  autoPlay: false,
                                  viewportFraction: 1,
                                  onPageChanged: (index, reason) {
                                    setCarouselState(() {
                                      homeDonutCurrentIndex = index;
                                      if ([0, 1, 2].contains(index)) {
                                        setHomeDoughnutChartData(
                                            portfolioProvider.portfolioData);
                                      }
                                    });
                                  }),
                              itemBuilder: (context, index) {
                                print("itembuilder $index");
                                if (index == 6) {
                                  return Container(
                                    // decoration: BoxDecoration(border: Border.all()),
                                    height: 300,
                                    width: MediaQuery.of(context).size.width *
                                        0.80,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.65,
                                          child: Image.asset('assets/logo.png'),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PaymentPurchaseScreen(),
                                              ),
                                              // MaterialPageRoute(
                                              //   builder: (context) => PaymentTypes(),
                                              // ),
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: Color(0xFFD8AF4F),
                                                ),
                                              ),
                                            ),
                                            child: Text(
                                              "Click here to see entire portfolio",
                                              style: TextStyle(
                                                color: Color(0xFFD8AF4F),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else if (index == 3 ||
                                    index == 4 ||
                                    index == 5) {
                                  var securityData;
                                  if (index == 3) {
                                    securityData = portfolioProvider
                                        .portfolioData["lowest_securities"][0];
                                  } else if (index == 4) {
                                    securityData = portfolioProvider
                                        .portfolioData["lowest_securities"][1];
                                  } else {
                                    securityData = portfolioProvider
                                        .portfolioData["lowest_securities"][2];
                                  }
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SmallGetAreaChartView(
                                        newSalesData: [
                                          NewSalesData(2010, 35),
                                          NewSalesData(2011, 28),
                                          NewSalesData(2012, 34),
                                          NewSalesData(2013, 32),
                                          NewSalesData(2014, 40),
                                        ],
                                        color: [
                                          Colors.blue[50],
                                          Colors.blue[200],
                                          Colors.blue,
                                        ],
                                        stops: [0.0, 0.5, 1.0],
                                        ticker: securityData["ticker"],
                                        companyData: securityData,
                                      ),
                                    ],
                                  );
                                } else {
                                  return SfCircularChart(
                                    // tooltipBehavior: ,
                                    title: ChartTitle(
                                      text: getChartTitle(),
                                      textStyle: TextStyle(
                                        fontFamily: "Ubuntu",
                                      ),
                                    ),
                                    // margin: EdgeInsets.all(4),
                                    annotations: <CircularChartAnnotation>[
                                      CircularChartAnnotation(
                                        widget: Container(
                                          // decoration: BoxDecoration(
                                          //   border: Border.all(),
                                          // ),
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Text(
                                                  homeDonutCurrentIndex == 0
                                                      ? '\$ ${_reusableFunctions.formatCurrencyNo(portfolioProvider.portfolioData["portfolio_return_dollar"].toStringAsFixed(0)).split(".")[0]}'
                                                      : homeDonutCurrentIndex ==
                                                              1
                                                          ? "${portfolioProvider.portfolioData["portfolio_return"].toStringAsFixed(0).split(".")[0]}%"
                                                          : '${portfolioProvider.portfolioData["portfolio_inception_return"].toStringAsFixed(2)}%',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  homeDonutCurrentIndex == 0
                                                      ? 'US \$ Profit'
                                                      : homeDonutCurrentIndex ==
                                                              1
                                                          ? "Annualized \nreturn %"
                                                          : "Inception-to-date return %",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 10,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        verticalAlignment: ChartAlignment.near,
                                        horizontalAlignment:
                                            ChartAlignment.near,
                                        height: "60.0",
                                        width: "90.0",
                                        angle: 200,
                                        radius: "47",
                                      )
                                    ],
                                    legend: Legend(
                                      isVisible: true,
                                      // textStyle: TextStyle(
                                      //   color: Colors.black,
                                      // ),
                                      overflowMode: LegendItemOverflowMode.wrap,
                                      itemPadding: 5.0,
                                      legendItemBuilder:
                                          (name, series, point, index) {
                                        var changesString = name
                                            .replaceAll("_", " ")
                                            .toLowerCase();
                                        // print("legend");
                                        DoughnutSeriesRenderer ss = series;
                                        ChartPoint<dynamic> dd = point;
                                        // print(series.runtimeType.toString());
                                        // print(point.runtimeType.toString());
                                        return Container(
                                          padding: EdgeInsets.all(1.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.quinscape,
                                                color: dd.color,
                                                size: 15,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                changesString,
                                                style: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontFamily: "Ubuntu",
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    series: <CircularSeries>[
                                      DoughnutSeries<ChartData, String>(
                                        radius: "110%",
                                        innerRadius: '60%',
                                        dataSource: homeChartData,
                                        xValueMapper: (ChartData data, _) =>
                                            data.x,
                                        yValueMapper: (ChartData data, _) =>
                                            data.y,
                                        dataLabelSettings: DataLabelSettings(
                                          isVisible: true,
                                          useSeriesColor: true,
                                          showCumulativeValues: true,
                                          showZeroValue: true,
                                        ),
                                      )
                                    ],
                                  );
                                }
                              },
                            ),
                          ),
                          Positioned(
                            top: 100,
                            right: 0,
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                if (homeDonutCurrentIndex == 6) {
                                  homeDonutCurrentIndex = 0;
                                  _carouselController
                                      .animateToPage(homeDonutCurrentIndex);
                                } else {
                                  homeDonutCurrentIndex =
                                      homeDonutCurrentIndex + 1;
                                  _carouselController
                                      .animateToPage(homeDonutCurrentIndex);
                                }
                              },
                            ),
                          ),
                          Positioned(
                            top: 100,
                            left: 0,
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                if (homeDonutCurrentIndex == 0) {
                                  homeDonutCurrentIndex = 6;
                                  _carouselController
                                      .animateToPage(homeDonutCurrentIndex);
                                } else {
                                  homeDonutCurrentIndex =
                                      homeDonutCurrentIndex - 1;
                                  _carouselController
                                      .animateToPage(homeDonutCurrentIndex);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: homeDonutArray.map((url) {
                            int index = url - 1;
                            return Container(
                              width: 10.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: homeDonutCurrentIndex == index
                                    // ? Color(0xFFFFFFFF)
                                    ? Color(0xFFD8AF4F)
                                    : Colors.white,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  );
                }),
                Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.07,
                    right: MediaQuery.of(context).size.width * 0.03,
                  ),
                  child: Text(
                    "Voila! Auro has customized a sophisticated institutional grade portfolio for you based on your sign-up inputs. You can invest this portfolio or just follow-it until you’re comfortable to invest",
                    // "Please note that this is NOT our recommended investment portfolio for which you need to complete additional risk onbording.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: AllCoustomTheme.getNewSecondTextThemeColor(),
                      fontSize: 14.5,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                // ),
                SizedBox(
                  height: 10.0,
                ),
                // go pro,live button
                Container(
                  // decoration: BoxDecoration(border: Border.all()),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: portfolioProvider.portfolioData == null
                        ? MainAxisAlignment.center
                        : portfolioProvider
                                    .portfolioData["has_gopro_portfolio"] ==
                                0
                            ? MainAxisAlignment.spaceEvenly
                            : MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.width * 0.32,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  border: new Border.all(
                                    color: AllCoustomTheme
                                        .getOtherTabButtonBoxColor(),
                                    width: 1.5,
                                  ),
                                  color: AllCoustomTheme
                                      .getOtherTabButtonBoxColor()),
                              child: MaterialButton(
                                splashColor: Colors.grey,
                                child: Text(
                                  "INVEST",
                                  style: AllCoustomTheme
                                      .getOtherTabButtonSelectedTextStyleTheme(),
                                  textAlign: TextAlign.center,
                                ),
                                onPressed: () async {
                                  // Navigator.of(context).push(new MaterialPageRoute(
                                  //     builder: (BuildContext context) =>
                                  //         new WishList()));
                                  Navigator.of(context).push(
                                    // MaterialPageRoute(
                                    //   builder: (BuildContext context) =>
                                    //       UserPersonalDetails(),
                                    // ),
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          GoLiveScreen(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      portfolioProvider.portfolioData == null
                          ? SizedBox()
                          : portfolioProvider
                                      .portfolioData["has_gopro_portfolio"] ==
                                  0
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.06,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.32,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          border: new Border.all(
                                              color: AllCoustomTheme
                                                  .getOtherTabButtonBoxColor(),
                                              width: 1.5),
                                        ),
                                        child: MaterialButton(
                                          splashColor: Colors.grey,
                                          child: Text("CUSTOMIZE PORTFOLIO",
                                              style: AllCoustomTheme
                                                  .getOtherTabButtonNonSelectedTextStyleTheme()),
                                          onPressed: () async {
                                            Navigator.of(context).push(
                                              new MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        new OnBoardingFirst(
                                                  logo: "logo.png",
                                                  callingFrom:
                                                      "Accredited Investor",
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox(),
                    ],
                  ),
                ),

                // portfolio component box
                SizedBox(
                  height: 30,
                ),

                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 1300,
                  child: Container(
                    margin: EdgeInsets.only(left: 5.0, right: 5.0),
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Center(
                            child: Text(
                              'AURO PORTFOLIO COMPONENTS',
                              style: new TextStyle(
                                color: AllCoustomTheme
                                    .getOtherTabHeadingThemeColors(),
                                fontSize: ConstanceData.SIZE_TITLE18,
                                fontFamily: "Rosarivo",
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.02,
                              right: MediaQuery.of(context).size.width * 0.02),
                          padding: EdgeInsets.only(
                            bottom: 3, // space between underline and text
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AllCoustomTheme
                                    .getOtherTabHeadingThemeColors(),
                                width: 1.0, // Underline width
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          // decoration: BoxDecoration(border: Border.all()),
                          height: 30,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Full List of Securities",
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // height: 200,
                          // decoration: BoxDecoration(border: Border.all()),
                          width: MediaQuery.of(context).size.width - 10,
                          child: singleTableForPortFolio(
                              portfolioProvider.portfolioData),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        portfolioProvider.portfolioData != null
                            ? AuroPaperPortfolioPerformace(
                                portfolioReturnDollar: portfolioProvider
                                    .portfolioData["portfolio_return_dollar"]
                                    .toStringAsFixed(2),
                                percAnnualReturn: portfolioProvider
                                    .portfolioData["portfolio_return"]
                                    .toStringAsFixed(2),
                                percInceptionReturn: portfolioProvider
                                    .portfolioData["portfolio_inception_return"]
                                    .toStringAsFixed(2),
                                userExpectedReturnData: userExpectedReturnData,
                                userInceptionDate: portfolioProvider
                                    .portfolioData["portfolio_creation_date"],
                              )
                            : SizedBox(),
                      ],
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
    );
  }

  ss() {
    return StatefulBuilder(
      builder: (context, setHomeTabState) {
        if (_isinit) {
          getDoughnutPortfolioData(setHomeTabState);
          _isinit = false;
        }
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Consumer<UserDetails>(
                builder: (context, userDetailsProvider, _) {
                  if (userDetailsProvider.userDetails != null &&
                      userDetailsProvider.userDetails["f_name"] != null) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                        portfolioChartData == null
                            ? ""
                            : portfolioChartData["has_gopro_portfolio"] == 0
                                ? "${userDetailsProvider.userDetails["f_name"]}'s Auro Portfolio"
                                : "${userDetailsProvider.userDetails["f_name"]}'s Auro Custom Portfolio",
                        style: TextStyle(
                            color:
                                AllCoustomTheme.getOtherTabHeadingThemeColors(),
                            fontSize: ConstanceData.SIZE_TITLE20,
                            fontFamily: "Rosarivo",
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0.1),
                      ),
                    );
                  } else {
                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                        portfolioChartData == null
                            ? ""
                            : portfolioChartData["has_gopro_portfolio"] == 0
                                ? "Auro Portfolio"
                                : "Auro custom portfolio",
                        style: TextStyle(
                            color:
                                AllCoustomTheme.getOtherTabHeadingThemeColors(),
                            fontSize: ConstanceData.SIZE_TITLE20,
                            fontFamily: "Rosarivo",
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0.1),
                      ),
                    );
                  }
                },
              ),
              Container(
                // margin: EdgeInsets.only(left: 80.0,right: 80.0),
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.07,
                    right: MediaQuery.of(context).size.width * 0.07),
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                  bottom: 3, // space between underline and text
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1.6, // Underline width
                    ),
                  ),
                ),
              ),
              StatefulBuilder(builder: (context, setCarouselState) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 250,
                          // decoration: BoxDecoration(border: Border.all()),
                          child: CarouselSlider.builder(
                            carouselController: _carouselController,
                            itemCount: 7,
                            options: CarouselOptions(
                                autoPlay: false,
                                viewportFraction: 1,
                                onPageChanged: (index, reason) {
                                  setCarouselState(() {
                                    homeDonutCurrentIndex = index;
                                    if ([0, 1, 2].contains(index)) {
                                      setHomeDoughnutChartData(
                                          portfolioChartData);
                                    }
                                  });
                                }),
                            itemBuilder: (context, index) {
                              print("itembuilder $index");
                              if (index == 6) {
                                return Container(
                                  // decoration: BoxDecoration(border: Border.all()),
                                  height: 300,
                                  width:
                                      MediaQuery.of(context).size.width * 0.80,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.65,
                                        child: Image.asset('assets/logo.png'),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PaymentPurchaseScreen(),
                                            ),
                                            // MaterialPageRoute(
                                            //   builder: (context) => PaymentTypes(),
                                            // ),
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Color(0xFFD8AF4F),
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            "Click here to see entire portfolio",
                                            style: TextStyle(
                                              color: Color(0xFFD8AF4F),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else if (index == 3 ||
                                  index == 4 ||
                                  index == 5) {
                                var securityData;
                                if (index == 3) {
                                  securityData =
                                      portfolioChartData["lowest_securities"]
                                          [0];
                                } else if (index == 4) {
                                  securityData =
                                      portfolioChartData["lowest_securities"]
                                          [1];
                                } else {
                                  securityData =
                                      portfolioChartData["lowest_securities"]
                                          [2];
                                }
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SmallGetAreaChartView(
                                      newSalesData: [
                                        NewSalesData(2010, 35),
                                        NewSalesData(2011, 28),
                                        NewSalesData(2012, 34),
                                        NewSalesData(2013, 32),
                                        NewSalesData(2014, 40),
                                      ],
                                      color: [
                                        Colors.blue[50],
                                        Colors.blue[200],
                                        Colors.blue,
                                      ],
                                      stops: [0.0, 0.5, 1.0],
                                      ticker: securityData["ticker"],
                                      companyData: securityData,
                                    ),
                                  ],
                                );
                              } else {
                                return SfCircularChart(
                                  // tooltipBehavior: ,
                                  title: ChartTitle(
                                    text: getChartTitle(),
                                    textStyle: TextStyle(
                                      fontFamily: "Ubuntu",
                                    ),
                                  ),
                                  // margin: EdgeInsets.all(4),
                                  annotations: <CircularChartAnnotation>[
                                    CircularChartAnnotation(
                                      widget: Container(
                                        // decoration: BoxDecoration(
                                        //   border: Border.all(),
                                        // ),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                homeDonutCurrentIndex == 0
                                                    ? '\$ ${_reusableFunctions.formatCurrencyNo(portfolioChartData["portfolio_return_dollar"].toStringAsFixed(0)).split(".")[0]}'
                                                    : homeDonutCurrentIndex == 1
                                                        ? "${portfolioChartData["portfolio_return"].toStringAsFixed(0).split(".")[0]}%"
                                                        : '${portfolioChartData["portfolio_inception_return"].toStringAsFixed(2)}%',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                homeDonutCurrentIndex == 0
                                                    ? 'US \$ Profit'
                                                    : homeDonutCurrentIndex == 1
                                                        ? "Annualized \nreturn %"
                                                        : "Inception-to-date return %",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      verticalAlignment: ChartAlignment.near,
                                      horizontalAlignment: ChartAlignment.near,
                                      height: "60.0",
                                      width: "90.0",
                                      angle: 200,
                                      radius: "47",
                                    )
                                  ],
                                  legend: Legend(
                                    isVisible: true,
                                    // textStyle: TextStyle(
                                    //   color: Colors.black,
                                    // ),
                                    overflowMode: LegendItemOverflowMode.wrap,
                                    itemPadding: 5.0,
                                    legendItemBuilder:
                                        (name, series, point, index) {
                                      var changesString = name
                                          .replaceAll("_", " ")
                                          .toLowerCase();
                                      // print("legend");
                                      DoughnutSeriesRenderer ss = series;
                                      ChartPoint<dynamic> dd = point;
                                      // print(series.runtimeType.toString());
                                      // print(point.runtimeType.toString());
                                      return Container(
                                        padding: EdgeInsets.all(1.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.quinscape,
                                              color: dd.color,
                                              size: 15,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              changesString,
                                              style: TextStyle(
                                                color: Colors.grey[800],
                                                fontFamily: "Ubuntu",
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  series: <CircularSeries>[
                                    DoughnutSeries<ChartData, String>(
                                      radius: "110%",
                                      innerRadius: '60%',
                                      dataSource: homeChartData,
                                      xValueMapper: (ChartData data, _) =>
                                          data.x,
                                      yValueMapper: (ChartData data, _) =>
                                          data.y,
                                      dataLabelSettings: DataLabelSettings(
                                        isVisible: true,
                                        useSeriesColor: true,
                                        showCumulativeValues: true,
                                        showZeroValue: true,
                                      ),
                                    )
                                  ],
                                );
                              }
                            },
                          ),
                        ),
                        Positioned(
                          top: 100,
                          right: 0,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              if (homeDonutCurrentIndex == 6) {
                                homeDonutCurrentIndex = 0;
                                _carouselController
                                    .animateToPage(homeDonutCurrentIndex);
                              } else {
                                homeDonutCurrentIndex =
                                    homeDonutCurrentIndex + 1;
                                _carouselController
                                    .animateToPage(homeDonutCurrentIndex);
                              }
                            },
                          ),
                        ),
                        Positioned(
                          top: 100,
                          left: 0,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              if (homeDonutCurrentIndex == 0) {
                                homeDonutCurrentIndex = 6;
                                _carouselController
                                    .animateToPage(homeDonutCurrentIndex);
                              } else {
                                homeDonutCurrentIndex =
                                    homeDonutCurrentIndex - 1;
                                _carouselController
                                    .animateToPage(homeDonutCurrentIndex);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: homeDonutArray.map((url) {
                          int index = url - 1;
                          return Container(
                            width: 10.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: homeDonutCurrentIndex == index
                                  // ? Color(0xFFFFFFFF)
                                  ? Color(0xFFD8AF4F)
                                  : Colors.white,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                );
              }),
              // ),
              // Visibility(
              //   visible: homeDonutArray.length != 0 ? true : false,
              //   child:

              // ),
              // Visibility(
              //   visible: homeDonutArray.length != 0 ? true : false,
              //   child:
              Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.07,
                  right: MediaQuery.of(context).size.width * 0.03,
                ),
                child: Text(
                  "Voila! Auro has customized a sophisticated institutional grade portfolio for you based on your sign-up inputs. You can invest this portfolio or just follow-it until you’re comfortable to invest",
                  // "Please note that this is NOT our recommended investment portfolio for which you need to complete additional risk onbording.",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AllCoustomTheme.getNewSecondTextThemeColor(),
                    fontSize: 14.5,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              // ),
              SizedBox(
                height: 10.0,
              ),
              // go pro,live button
              Container(
                // decoration: BoxDecoration(border: Border.all()),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: portfolioChartData == null
                      ? MainAxisAlignment.center
                      : portfolioChartData["has_gopro_portfolio"] == 0
                          ? MainAxisAlignment.spaceEvenly
                          : MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.32,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: new Border.all(
                                  color: AllCoustomTheme
                                      .getOtherTabButtonBoxColor(),
                                  width: 1.5,
                                ),
                                color: AllCoustomTheme
                                    .getOtherTabButtonBoxColor()),
                            child: MaterialButton(
                              splashColor: Colors.grey,
                              child: Text(
                                "INVEST",
                                style: AllCoustomTheme
                                    .getOtherTabButtonSelectedTextStyleTheme(),
                                textAlign: TextAlign.center,
                              ),
                              onPressed: () async {
                                // Navigator.of(context).push(new MaterialPageRoute(
                                //     builder: (BuildContext context) =>
                                //         new WishList()));
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        UserPersonalDetails(),
                                  ),
                                  // MaterialPageRoute(
                                  //   builder: (BuildContext context) =>
                                  //       GoLiveScreen(),
                                  // ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    portfolioChartData == null
                        ? SizedBox()
                        : portfolioChartData
                                    .portfolioData["has_gopro_portfolio"] ==
                                0
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      width: MediaQuery.of(context).size.width *
                                          0.32,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        border: new Border.all(
                                            color: AllCoustomTheme
                                                .getOtherTabButtonBoxColor(),
                                            width: 1.5),
                                      ),
                                      child: MaterialButton(
                                        splashColor: Colors.grey,
                                        child: Text("CUSTOMIZE PORTFOLIO",
                                            style: AllCoustomTheme
                                                .getOtherTabButtonNonSelectedTextStyleTheme()),
                                        onPressed: () async {
                                          Navigator.of(context).push(
                                            new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  new OnBoardingFirst(
                                                logo: "logo.png",
                                                callingFrom:
                                                    "Accredited Investor",
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(),
                  ],
                ),
              ),

              // portfolio component box
              SizedBox(
                height: 30,
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 1300,
                child: Container(
                  margin: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Center(
                          child: Text(
                            'AURO PORTFOLIO COMPONENTS',
                            style: new TextStyle(
                              color: AllCoustomTheme
                                  .getOtherTabHeadingThemeColors(),
                              fontSize: ConstanceData.SIZE_TITLE18,
                              fontFamily: "Rosarivo",
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.02,
                            right: MediaQuery.of(context).size.width * 0.02),
                        padding: EdgeInsets.only(
                          bottom: 3, // space between underline and text
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AllCoustomTheme
                                  .getOtherTabHeadingThemeColors(),
                              width: 1.0, // Underline width
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        // decoration: BoxDecoration(border: Border.all()),
                        height: 30,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Full List of Securities",
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // height: 200,
                        // decoration: BoxDecoration(border: Border.all()),
                        width: MediaQuery.of(context).size.width - 10,
                        child: singleTableForPortFolio(portfolioChartData),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      portfolioChartData != null
                          ? AuroPaperPortfolioPerformace(
                              portfolioReturnDollar:
                                  portfolioChartData["portfolio_return_dollar"]
                                      .toStringAsFixed(2),
                              percAnnualReturn:
                                  portfolioChartData["portfolio_return"]
                                      .toStringAsFixed(2),
                              percInceptionReturn: portfolioChartData[
                                      "portfolio_inception_return"]
                                  .toStringAsFixed(2),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> getDoughnutPortfolioData(setHomeTabState) async {
    print("getDoughnutPortfolioData called");
    var response =
        await request.getRunAlgoExistingPortfolio('users/create_portfolio');
    print("portfolio chart list: $response");
    if (response != null &&
        response != false &&
        response.containsKey('auth') &&
        response['auth'] == true) {
      setHomeTabState(() {
        homeDonutArray = [];
        homeDonutArray.add(1);
        homeDonutArray.add(2);
        homeDonutArray.add(3);
        homeDonutArray.add(4);
        homeDonutArray.add(5);
        homeDonutArray.add(6);
        homeDonutArray.add(7);
        portfolioChartData = null;
        portfolioChartData =
            response['message'] != null && response['message']['data'] != null
                // &&
                //     response['message']['algo_result'] != null
                ? response['message']
                : null;
        // setHomeDoughnutChartData();
      });
    }
  }

  setHomeDoughnutChartData(portfolioChartData) {
    print("portfolioChartData: $portfolioChartData");
    print("homeDonutCurrentIndex: $homeDonutCurrentIndex");

    if (portfolioChartData != null && portfolioChartData != false) {
      print("herererer");
      if (homeDonutCurrentIndex == 0 && portfolioChartData["data"] != null) {
        // var tempWeightsData =
        //     portfolioChartData['weights_assetclass']['weights'];
        print("in bro index 0");
        homeChartData = [];
        // Map countMap = {};
        //
        // portfolioChartData["data"].forEach(
        //   (element) {
        //     if (countMap.containsKey(element["asset_class"])) {
        //       int earlyCount = countMap[element["asset_class"]];
        //       countMap[element["asset_class"]] = earlyCount + 1;
        //     } else {
        //       countMap[element["asset_class"]] = 1;
        //     }
        //   },
        // );

        portfolioChartData["assetClass"].forEach((key, value) {
          homeChartData.add(ChartData(
              '$key',
              double.parse((value.toDouble() * 100).toInt().toString()),

              // double.parse(tempDouble.toStringAsFixed(4)),
              globals.isGoldBlack ? Color(0xFFE8E2DB) : Color(0xFF1D6177)));
        });
        return homeChartData;
        // final
      } else if (homeDonutCurrentIndex == 2) {
        print("in bro index 1");
        homeChartData = [];
        // Map countMap = {};
        //
        // portfolioChartData["data"].forEach(
        //   (element) {
        //     if (countMap.containsKey(element["country"])) {
        //       int earlyCount = countMap[element["country"]];
        //       countMap[element["country"]] = earlyCount + 1;
        //     } else {
        //       countMap[element["country"]] = 1;
        //     }
        //   },
        // );
        portfolioChartData["country"].forEach((key, value) {
          homeChartData.add(ChartData(
              '$key',
              double.parse((value.toDouble() * 100).toInt().toString()),
              // double.parse(tempDouble.toStringAsFixed(4)),
              globals.isGoldBlack ? Color(0xFFE8E2DB) : Color(0xFF1D6177)));
        });
        return homeChartData;
        // countMap.forEach((key, value) {
        //   homeChartData.add(ChartData(
        //       '$key',
        //       value.toDouble(),
        //       // double.parse(tempDouble.toStringAsFixed(4)),
        //       globals.isGoldBlack ? Color(0xFFE8E2DB) : Color(0xFF1D6177)));
        // });
      } else if (homeDonutCurrentIndex == 1) {
        print("in bro index 2");
        homeChartData = [];
        // Map countMap = {};
        //
        // portfolioChartData["data"].forEach(
        //   (element) {
        //     if (countMap.containsKey(element["sector"])) {
        //       int earlyCount = countMap[element["sector"]];
        //       countMap[element["sector"]] = earlyCount + 1;
        //     } else {
        //       countMap[element["sector"]] = 1;
        //     }
        //   },
        // );

        portfolioChartData["sector"].forEach((key, value) {
          homeChartData.add(ChartData(
              '$key',
              double.parse((value.toDouble() * 100).toInt().toString()),
              // double.parse(tempDouble.toStringAsFixed(4)),
              globals.isGoldBlack ? Color(0xFFE8E2DB) : Color(0xFF1D6177)));
        });

        return homeChartData;
      }
    }
  }

  singleTableForPortFolio(portfolioChartData) {
    var index = 0;
    if (portfolioChartData != null) {
      return Container(
        child: Column(
          children: [
            singleRow(context, "Security", 'Weight', 'In-Price',
                'Current Price', '% Return', Colors.indigo[100], 15.0),
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
                      index % 2 == 0 ? Colors.indigo[100] : Colors.indigo[50],
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
                                //   builder: (context) => PaymentTypes(),
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
                                  color: Colors.blue,
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
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: color,
          ),
          child: Center(
            child: Text(
              "$security",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
          ),
        ),
        Container(
          width: (MediaQuery.of(context).size.width - 20) / 5,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: color,
          ),
          child: Center(
            child: Text(
              "$share",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
          ),
        ),
        Container(
          width: (MediaQuery.of(context).size.width - 20) / 5,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: color,
          ),
          child: Center(
            child: Text(
              "$ip",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
          ),
        ),
        Container(
          width: (MediaQuery.of(context).size.width - 20) / 5,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: color,
          ),
          child: Center(
            child: Text(
              cp,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
          ),
        ),
        Container(
          width: (MediaQuery.of(context).size.width - 20) / 5,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: color,
          ),
          child: Center(
            child: Text(
              perReturn,
              style: TextStyle(
                fontSize: fontSize,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  getChartTitle() {
    switch (homeDonutCurrentIndex) {
      case 0:
        return "% mix by asset class";
      case 1:
        return "% mix by asset class & sector";
      case 2:
        return "% mix by geography";
      case 3:
        return "Security 1";
      case 4:
        return "Security 2";
      case 5:
        return "Security 3";
      default:
        return null;
    }
  }
}
