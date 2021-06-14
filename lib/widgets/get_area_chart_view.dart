import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/modules/investRelatedPages/securityFirstPage.dart';
import 'package:auroim/provider_abhinav/follow_provider.dart';
import 'package:auroim/provider_abhinav/public_company_historical_pricing.dart';
import 'package:auroim/provider_abhinav/user_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../main.dart';
import 'crypto_coin_price_data.dart';
import 'dart:math';

class GetAreaChartView extends StatefulWidget {
  final List<Color> color;
  final List<double> stops;
  final List<NewSalesData> newSalesData;
  final companyData;

  GetAreaChartView({
    this.color,
    this.newSalesData,
    this.stops,
    this.companyData,
  });

  @override
  _GetAreaChartViewState createState() => _GetAreaChartViewState();
}

class _GetAreaChartViewState extends State<GetAreaChartView> {
  LinearGradient gradientColors;
  List<CryptoCoinPriceData> allPriceData = [];
  ZoomPanBehavior _zoomPanBehavior;
  TooltipBehavior _tooltipBehavior;
  bool _isInit = true;

  @override
  void initState() {
    gradientColors = LinearGradient(
      colors: widget.color,
      stops: widget.stops,
    );
    _tooltipBehavior = TooltipBehavior(enable: true);
    _zoomPanBehavior = ZoomPanBehavior(enablePinching: true);
    getFollowing();
    super.initState();
  }

  getFollowing() async {
    print("getting single follow");
    var userEmail;
    if (Provider.of<UserDetails>(context, listen: false).userDetails != null &&
        Provider.of<UserDetails>(context, listen: false).userDetails["email"] !=
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

  companyPriceData(diff, pricesData) {
    if (pricesData == null) {
      if (diff) {
        return "0.00";
      } else {
        return "0.00(+0.00)";
      }
    } else {
      double lastItem = pricesData.length == 0
          ? 0.0
          : pricesData[pricesData.length - 1]["price"];
      double secondLastItem = pricesData.length <= 1
          ? 0.0
          : pricesData[pricesData.length - 2]["price"];
      print(secondLastItem);
      var companyPrice = lastItem;
      var companyPriceDifference =
          secondLastItem != 0 ? (lastItem - secondLastItem) : 0.0;
      print(companyPriceDifference);
      print(companyPrice);
      var companyPercentageDifference = companyPriceDifference == 0.0
          ? 0.0
          : companyPrice / companyPriceDifference;

      if (diff) {
        return '\$' + " ${companyPrice.toStringAsFixed(3)}";
      } else {
        return "${companyPriceDifference.toStringAsFixed(3)} (${(companyPercentageDifference / 100).toStringAsFixed(3)}%)";
      }
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<PublicCompanyHistoricalPricing>(context)
          .getSinglePublicCompanyData(widget.companyData["ticker"], 365);
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.companyData);

    return Container(
      height: 300,
      child: Container(
        // decoration: BoxDecoration(border: Border.all(color: Colors.white,),),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
                height: 292,
                width: MediaQuery.of(context).size.width * 0.96,
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: new Border.all(
                      color: AllCoustomTheme.getChartBoxThemeColor(),
                      width: 1.0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 5.0),
                        child: Container(
                          // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                          height: MediaQuery.of(context).size.height * 0.10,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.companyData == null
                                        ? ""
                                        : widget.companyData["company_name"],
                                    style: TextStyle(
                                      color: AllCoustomTheme
                                          .getChartBoxTextThemeColor(),
                                      fontSize: ConstanceData.SIZE_TITLE18,
                                      fontFamily: "Roboto",
                                    ),
                                  ),
                                  Consumer<PublicCompanyHistoricalPricing>(
                                    builder: (context,
                                        historicalPricingProvider, _) {
                                      return Column(
                                        children: [
                                          Text(
                                            "${companyPriceData(false, historicalPricingProvider.historicalPriceData[widget.companyData["ticker"]])}",
                                            style: TextStyle(
                                              color: AllCoustomTheme
                                                  .getNewSecondTextThemeColor(),
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE8,
                                              fontFamily: "Roboto",
                                            ),
                                          ),
                                          Text(
                                            "${companyPriceData(true, historicalPricingProvider.historicalPriceData[widget.companyData["ticker"]])}",
                                            style: TextStyle(
                                              color: AllCoustomTheme
                                                  .getChartBoxTextThemeColor(),
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE18,
                                              fontFamily: "Roboto",
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          color: AllCoustomTheme
                                              .getNewTextThemeColors(),
                                          fontSize: ConstanceData.SIZE_TITLE10,
                                          fontFamily: "Roboto",
                                        ),
                                      ),
                                      Icon(
                                        FontAwesomeIcons.arrowUp,
                                        color: Colors.green,
                                        size: 10,
                                      ),
                                      Text(
                                        "${widget.companyData["30d_high"].toStringAsFixed(2)}",
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: ConstanceData.SIZE_TITLE10,
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
                                          color: AllCoustomTheme
                                              .getNewTextThemeColors(),
                                          fontSize: ConstanceData.SIZE_TITLE10,
                                          fontFamily: "Roboto",
                                        ),
                                      ),
                                      Icon(
                                        FontAwesomeIcons.arrowDown,
                                        color: Colors.red,
                                        size: 10,
                                      ),
                                      Text(
                                        "${widget.companyData["30d_low"].toStringAsFixed(2)}",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: ConstanceData.SIZE_TITLE10,
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
                      ),
                      // FutureBuilder(
                      //   future:
                      //       Provider.of<PublicCompanyHistoricalPricing>(context)
                      //           .getSinglePublicCompanyData2(
                      //               widget.companyData["ticker"], 30),
                      //   builder: (context, snapshot) {
                      //     if (snapshot.hasData) {
                      //       allPriceData = [];
                      //       snapshot.data.forEach((element) {
                      //         DateTime date = DateFormat("yyyy-MM-dd")
                      //             .parse(element["date"]);
                      //         allPriceData.add(
                      //           CryptoCoinPriceData(
                      //               x: date, y: element["price"].toDouble()),
                      //         );
                      //       });
                      //       double lastItem = allPriceData.length == 0
                      //           ? 0.0
                      //           : allPriceData[allPriceData.length - 1].y;
                      //       double secondLastItem = allPriceData.length <= 1
                      //           ? 0.0
                      //           : allPriceData[allPriceData.length - 2].y;
                      //       print(secondLastItem);
                      //       var companyPrice = lastItem;
                      //       var companyPriceDifference = secondLastItem != 0
                      //           ? (lastItem - secondLastItem)
                      //           : 0.0;
                      //       print(companyPriceDifference);
                      //       print(companyPrice);
                      //       var companyPercentageDifference =
                      //           companyPriceDifference == 0.0
                      //               ? 0.0
                      //               : companyPrice / companyPriceDifference;
                      //       return SizedBox(
                      //           width: MediaQuery.of(context).size.width * 0.88,
                      //           height:
                      //               MediaQuery.of(context).size.height * 0.15,
                      //           child: Container(
                      //             margin: EdgeInsets.only(left: 10.0),
                      //             child: SfCartesianChart(
                      //                 primaryXAxis: DateTimeAxis(
                      //                   isVisible: true,
                      //                 ),
                      //                 // title: ChartTitle(text: "30D Pricing"),
                      //                 tooltipBehavior: _tooltipBehavior,
                      //                 zoomPanBehavior: _zoomPanBehavior,
                      //                 primaryYAxis:
                      //                     NumericAxis(isVisible: true),
                      //                 series: <ChartSeries>[
                      //                   StackedAreaSeries<CryptoCoinPriceData,
                      //                       dynamic>(
                      //                     dataSource: allPriceData,
                      //                     xValueMapper:
                      //                         (CryptoCoinPriceData data, _) =>
                      //                             data.x,
                      //                     yValueMapper:
                      //                         (CryptoCoinPriceData data, _) =>
                      //                             data.y,
                      //                     gradient: gradientColors,
                      //                   ),
                      //                 ]),
                      //           ));
                      //     } else {
                      //       return SizedBox(
                      //         width: MediaQuery.of(context).size.width * 0.88,
                      //         height: MediaQuery.of(context).size.height * 0.15,
                      //         child: Container(
                      //           margin: EdgeInsets.only(left: 10.0),
                      //           child: Center(
                      //             child: Text(
                      //               "No Chart To Show",
                      //               style: TextStyle(
                      //                 color: globals.isGoldBlack
                      //                     ? Colors.white
                      //                     : Colors.black,
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       );
                      //     }
                      //   },
                      // ),
                      Consumer<PublicCompanyHistoricalPricing>(
                        builder: (context, historicalPricingProvider, _) {
                          if (historicalPricingProvider.historicalPriceData[
                                  widget.companyData["ticker"]] ==
                              null) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.88,
                              height: MediaQuery.of(context).size.height * 0.15,
                              child: Container(
                                margin: EdgeInsets.only(left: 10.0),
                              ),
                            );
                          } else {
                            allPriceData = [];
                            List<double> onlyPriceList = [];
                            historicalPricingProvider.historicalPriceData[
                                    widget.companyData["ticker"]]
                                .forEach((element) {
                              DateTime date = DateFormat("yyyy-MM-dd")
                                  .parse(element["date"]);
                              allPriceData.add(
                                CryptoCoinPriceData(
                                    x: date, y: element["price"].toDouble()),
                              );
                              onlyPriceList.add(element["price"].toDouble());
                            });
                            double maxVal = onlyPriceList.reduce(max);
                            double minVal = onlyPriceList.reduce(min);

                            return SizedBox(
                              width: MediaQuery.of(context).size.width * 0.88,
                              height: MediaQuery.of(context).size.height * 0.15,
                              child: Container(
                                margin: EdgeInsets.only(left: 10.0),
                                child: SfCartesianChart(
                                    primaryXAxis: DateTimeAxis(
                                      isVisible: true,
                                    ),
                                    // title: ChartTitle(text: "30D Pricing"),
                                    tooltipBehavior: _tooltipBehavior,
                                    zoomPanBehavior: _zoomPanBehavior,
                                    primaryYAxis: NumericAxis(
                                      isVisible: true,
                                      maximum: maxVal + (maxVal / 10),
                                      minimum: minVal,
                                    ),
                                    series: <ChartSeries>[
                                      StackedAreaSeries<CryptoCoinPriceData,
                                          dynamic>(
                                        dataSource: allPriceData,
                                        xValueMapper:
                                            (CryptoCoinPriceData data, _) =>
                                                data.x,
                                        yValueMapper:
                                            (CryptoCoinPriceData data, _) =>
                                                data.y,
                                        gradient: gradientColors,
                                      ),
                                    ]),
                              ),
                            );
                          }
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width:
                                (MediaQuery.of(context).size.width - 100) / 2,
                            height: 35,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: new Border.all(
                                    color:
                                        AllCoustomTheme.getChartBoxThemeColor(),
                                    width: 1.5),
                                color: AllCoustomTheme.getChartBoxThemeColor(),
                              ),
                              child: MaterialButton(
                                // splashColor: Colors.grey,
                                child: Text(
                                  "TRADE",
                                  style: TextStyle(
                                    color: AllCoustomTheme
                                        .getButtonTextThemeColors(),
                                    fontSize: ConstanceData.SIZE_TITLE13,
                                    fontFamily: "Roboto",
                                  ),
                                ),
                                onPressed: () async {
                                  Navigator.of(context).push(
                                    new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new SecurityPageFirst(
                                        logo: "logo.png",
                                        callingFrom: "Accredited Investor",
                                        companyTicker:
                                            widget.companyData["ticker"],
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
                              if (followProvider.mapOfFollowingListedCompanies[
                                      widget.companyData["ticker"]] !=
                                  null) {
                                isFollowing = followProvider
                                        .mapOfFollowingListedCompanies[
                                    widget.companyData["ticker"]];
                              }
                              return Container(
                                width:
                                    (MediaQuery.of(context).size.width - 100) /
                                        2,
                                height: 35,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    border: new Border.all(
                                      color: AllCoustomTheme
                                          .getChartBoxThemeColor(),
                                      width: 1.5,
                                    ),
                                    // color: AllCoustomTheme.getChartBoxThemeColor(),
                                  ),
                                  child: MaterialButton(
                                    splashColor: Colors.grey,
                                    child: Text(
                                      isFollowing ? "UNFOLLOW" : "FOLLOW",
                                      style: TextStyle(
                                        color: AllCoustomTheme
                                            .getChartBoxTextThemeColor(),
                                        fontSize: ConstanceData.SIZE_TITLE13,
                                        fontFamily: "Roboto",
                                      ),
                                    ),
                                    onPressed: () =>
                                        onPressedFollow(isFollowing),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
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
        context,
      );
    } else {
      Provider.of<FollowProvider>(context, listen: false).setFollowing(
        userEmail,
        "listed",
        widget.companyData["ticker"],
        context,
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
