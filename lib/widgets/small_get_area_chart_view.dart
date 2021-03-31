import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/modules/investRelatedPages/securityFirstPage.dart';
import 'package:auroim/provider_abhinav/follow_provider.dart';
import 'package:auroim/provider_abhinav/public_company_historical_pricing.dart';
import 'package:auroim/provider_abhinav/user_details.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../main.dart';
import 'crypto_coin_price_data.dart';

class SmallGetAreaChartView extends StatefulWidget {
  final List<Color> color;
  final List<double> stops;
  final List<NewSalesData> newSalesData;
  final ticker;
  final companyData;

  SmallGetAreaChartView({
    this.color,
    this.newSalesData,
    this.stops,
    this.ticker,
    this.companyData,
  });

  @override
  _SmallGetAreaChartViewState createState() => _SmallGetAreaChartViewState();
}

class _SmallGetAreaChartViewState extends State<SmallGetAreaChartView> {
  LinearGradient gradientColors;
  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();
  List<CryptoCoinPriceData> allPriceData = [];
  bool _isInit = true;
  ZoomPanBehavior _zoomPanBehavior;
  TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    // print(widget.companyData["ticker"]);
    _tooltipBehavior = TooltipBehavior(
      enable: true,
    );
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
    );
    gradientColors = LinearGradient(
      colors: widget.color,
      stops: widget.stops,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      print("did change small get area view");
      Provider.of<PublicCompanyHistoricalPricing>(context)
          .getSinglePublicCompanyData(widget.ticker, 30);
      getFollowing();
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return itemWidget();
  }

  getFollowing() async {
    print("getting single follow");
    var userEmail;
    if (Provider.of<UserDetails>(context, listen: false).userDetails["email"] !=
        null) {
      userEmail =
          Provider.of<UserDetails>(context, listen: false).userDetails["email"];
    } else {
      await getUserDetails();
      Provider.of<UserDetails>(context, listen: false)
          .setUserDetails(userAllDetail);
      userEmail =
          Provider.of<UserDetails>(context, listen: false).userDetails["email"];
    }
    await Provider.of<FollowProvider>(context, listen: false)
        .getFollowingForSingleItem(
            userEmail, "listed", widget.companyData["ticker"]);
  }

  itemWidget() {
    return FutureBuilder(
      future: _featuredCompaniesProvider
          .getSinglePublicCompanyDataFromStatic(widget.companyData["ticker"]),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print("data is got for securities baba");
          print(snapshot.data);
          return Container(
            child: Container(
              // decoration: BoxDecoration(
              //   border: Border.all(
              //     color: Colors.black,
              //   ),
              // ),
              padding: EdgeInsets.only(right: 6.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      height: 220,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: new Border.all(
                            color: Color(0xFF423EAF),
                            width: 1.0,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              // decoration: BoxDecoration(
                              //   border: Border.all(
                              //     color: Colors.black,
                              //   ),
                              // ),
                              height: 70,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.55,
                                        // decoration: BoxDecoration(border: Border.all()),
                                        child: Text(
                                          widget.companyData["security_name"],
                                          // snapshot.data["company_name"] == null
                                          //     ? ""
                                          //     : snapshot.data["company_name"],
                                          style: TextStyle(
                                            color: Color(0xFF423EAF),
                                            fontSize: 16,
                                            fontFamily: "Roboto",
                                          ),
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                      Consumer<PublicCompanyHistoricalPricing>(
                                        builder: (context, pricingProvider, _) {
                                          if (pricingProvider
                                                      .historicalPriceData[
                                                  widget.ticker] ==
                                              null) {
                                            return Column(
                                              children: [
                                                Text(
                                                  "",
                                                  style: TextStyle(
                                                    color: AllCoustomTheme
                                                        .getNewSecondTextThemeColor(),
                                                    fontSize: 10,
                                                    fontFamily: "Roboto",
                                                  ),
                                                ),
                                                Text(
                                                  "",
                                                  style: TextStyle(
                                                    color: Color(0xFF423EAF),
                                                    fontSize: 16,
                                                    fontFamily: "Roboto",
                                                  ),
                                                ),
                                              ],
                                            );
                                            // return Center(
                                            //   child: Container(
                                            //     width: MediaQuery.of(context)
                                            //             .size
                                            //             .width *
                                            //         0.75,
                                            //     // decoration:
                                            //     //     BoxDecoration(border: Border.all()),
                                            //     height: 90,
                                            //     child: Container(
                                            //       margin: EdgeInsets.only(
                                            //           left: 10.0),
                                            //       child: Center(
                                            //           child: Text(
                                            //               "No Chart to show")),
                                            //     ),
                                            //   ),
                                            // );
                                          } else {
                                            allPriceData = [];
                                            pricingProvider.historicalPriceData[
                                                    widget.ticker]
                                                .forEach((element) {
                                              DateTime date =
                                                  DateFormat("yyyy-MM-dd")
                                                      .parse(element["date"]);
                                              allPriceData.add(
                                                CryptoCoinPriceData(
                                                    x: date,
                                                    y: element["price"]
                                                        .toDouble()),
                                              );
                                            });
                                            double lastItem = allPriceData
                                                        .length ==
                                                    0
                                                ? 0.0
                                                : allPriceData[
                                                        allPriceData.length - 1]
                                                    .y;
                                            double secondLastItem = allPriceData
                                                        .length <=
                                                    1
                                                ? 0.0
                                                : allPriceData[
                                                        allPriceData.length - 2]
                                                    .y;
                                            print(secondLastItem);
                                            var companyPrice = lastItem;
                                            var companyPriceDifference =
                                                secondLastItem != 0
                                                    ? (lastItem -
                                                        secondLastItem)
                                                    : 0.0;
                                            print(companyPriceDifference);
                                            print(companyPrice);
                                            var companyPercentageDifference =
                                                companyPriceDifference == 0.0
                                                    ? 0.0
                                                    : companyPrice /
                                                        companyPriceDifference;
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${companyPriceDifference.toStringAsFixed(3)} (${(companyPercentageDifference / 100).toStringAsFixed(3)}%)",
                                                  style: TextStyle(
                                                    color: AllCoustomTheme
                                                        .getNewSecondTextThemeColor(),
                                                    fontSize: 10,
                                                    fontFamily: "Roboto",
                                                  ),
                                                ),
                                                Text(
                                                  '\$' +
                                                      " ${companyPrice.toStringAsFixed(3)}",
                                                  style: TextStyle(
                                                    color: Color(0xFF423EAF),
                                                    fontSize: 16,
                                                    fontFamily: "Roboto",
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "HIGH",
                                            style: TextStyle(
                                              color: Colors.grey[900],
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE10,
                                              fontFamily: "Roboto",
                                            ),
                                          ),
                                          Icon(
                                            FontAwesomeIcons.arrowUp,
                                            color: Colors.green,
                                            size: 10,
                                          ),
                                          Text(
                                            snapshot.data["30d_high"] == null
                                                ? "0.00"
                                                : "${snapshot.data["30d_high"]}",
                                            // snapshot.data[""],
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE10,
                                              fontFamily: "Roboto",
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "LOW",
                                            style: TextStyle(
                                              color: Colors.grey[900],
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE10,
                                              fontFamily: "Roboto",
                                            ),
                                          ),
                                          Icon(
                                            FontAwesomeIcons.arrowDown,
                                            color: Colors.red,
                                            size: 10,
                                          ),
                                          Text(
                                            snapshot.data["30d_low"] == null
                                                ? "0.00"
                                                : "${snapshot.data["30d_low"]}",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE10,
                                              fontFamily: "Roboto",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Consumer<PublicCompanyHistoricalPricing>(
                              builder: (context, historicalPricingProvider, _) {
                                if (historicalPricingProvider
                                        .historicalPriceData[widget.ticker] ==
                                    null) {
                                  return Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      // decoration:
                                      //     BoxDecoration(border: Border.all()),
                                      height: 90,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 10.0),
                                        child: Center(
                                            child: Text("No Chart to show")),
                                      ),
                                    ),
                                  );
                                } else {
                                  allPriceData = [];
                                  historicalPricingProvider
                                      .historicalPriceData[widget.ticker]
                                      .forEach((element) {
                                    DateTime date = DateFormat("yyyy-MM-dd")
                                        .parse(element["date"]);
                                    allPriceData.add(
                                      CryptoCoinPriceData(
                                          x: date,
                                          y: element["price"].toDouble()),
                                    );
                                  });

                                  return Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                      height: 90,
                                      child: Container(
                                        // margin: EdgeInsets.only(left: 10.0),
                                        child: SfCartesianChart(
                                            tooltipBehavior: _tooltipBehavior,
                                            zoomPanBehavior: _zoomPanBehavior,
                                            primaryXAxis: DateTimeAxis(
                                              isVisible: false,
                                              title: AxisTitle(text: "Date"),
                                            ),
                                            primaryYAxis: NumericAxis(
                                              isVisible: true,
                                              title: AxisTitle(text: "Price"),
                                            ),
                                            series: <ChartSeries>[
                                              StackedAreaSeries<
                                                      CryptoCoinPriceData,
                                                      dynamic>(
                                                  dataSource: allPriceData,
                                                  xValueMapper:
                                                      (CryptoCoinPriceData data,
                                                              _) =>
                                                          data.x,
                                                  yValueMapper:
                                                      (CryptoCoinPriceData data,
                                                              _) =>
                                                          data.y,
                                                  gradient: gradientColors,
                                                  name: "Price On"),
                                            ]),
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                            Container(
                              // decoration: BoxDecoration(border: Border.all()),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: (MediaQuery.of(context).size.width *
                                            0.80) /
                                        3,
                                    height: 20,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                        border: new Border.all(
                                            color: Color(0xFF423EAF),
                                            width: 1.5),
                                        color: Color(0xFF423EAF),
                                      ),
                                      child: MaterialButton(
                                        child: Text(
                                          "TRADE",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                ConstanceData.SIZE_TITLE13,
                                            fontFamily: "Roboto",
                                          ),
                                        ),
                                        onPressed: () async {
/*                                      Navigator.of(context).push(new MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                            new OnBoardingFirst(logo: "logo.png",callingFrom: "Accredited Investor",)));*/
                                          Navigator.of(context).push(
                                            new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  new SecurityPageFirst(
                                                logo: "logo.png",
                                                callingFrom:
                                                    "Accredited Investor",
                                                companyTicker:
                                                    snapshot.data["ticker"],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Consumer<FollowProvider>(
                                    builder: (context, followProvider, _) {
                                      var isFollowing = false;
                                      if (followProvider
                                                  .mapOfFollowingListedCompanies[
                                              widget.companyData["ticker"]] !=
                                          null) {
                                        isFollowing = followProvider
                                                .mapOfFollowingListedCompanies[
                                            widget.companyData["ticker"]];
                                      }
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Container(
                                          width: isFollowing
                                              ? (MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.80) /
                                                  2.3
                                              : (MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.80) /
                                                  3,
                                          height: 20,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                              border: new Border.all(
                                                  color: Color(0xFF423EAF),
                                                  width: 1.5),
                                              // color: AllCoustomTheme.getChartBoxThemeColor(),
                                            ),
                                            child: MaterialButton(
                                              splashColor: Colors.grey,
                                              child: Text(
                                                isFollowing
                                                    ? "UNFOLLOW"
                                                    : "FOLLOW",
                                                style: TextStyle(
                                                  color: Color(0xFF423EAF),
                                                  fontSize: ConstanceData
                                                      .SIZE_TITLE13,
                                                  fontFamily: "Roboto",
                                                ),
                                              ),
                                              onPressed: () =>
                                                  onPressedFollow(isFollowing),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            )
                          ],
                        ),
                      )),
                ],
              ),
            ),
          );
        } else {
          return Container(
            child: Center(
              child: Text("Fetching Security Data..."),
            ),
          );
        }
      },
    );
  }

  onPressedFollow(isFollowing) async {
    print("follow button pressed");
    var userEmail;
    if (Provider.of<UserDetails>(context, listen: false).userDetails["email"] !=
        null) {
      userEmail =
          Provider.of<UserDetails>(context, listen: false).userDetails["email"];
    } else {
      await getUserDetails();
      Provider.of<UserDetails>(context, listen: false)
          .setUserDetails(userAllDetail);
      userEmail =
          Provider.of<UserDetails>(context, listen: false).userDetails["email"];
    }

    if (isFollowing) {
      Provider.of<FollowProvider>(context, listen: false).unfollowSingleItem(
        userEmail,
        "listed",
        widget.companyData["ticker"],
      );
    } else {
      Provider.of<FollowProvider>(context, listen: false).setFollowing(
        userEmail,
        "listed",
        widget.companyData["ticker"],
      );
    }
  }

  getUserDetails() async {
    print("getting user Details");
    ApiProvider request = new ApiProvider();
    // print("call set screen");
    var response = await request.getRequest('users/get_details');
    print("user detail response: $response");
    if (response != null && response != false) {
      userAllDetail = response['data'];

      print(userAllDetail.toString());
    } else {
      print("Not got user data");
    }
  }
}
