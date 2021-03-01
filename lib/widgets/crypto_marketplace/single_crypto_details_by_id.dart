import 'dart:convert';

import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/widgets/article_static.dart';
import 'package:auroim/widgets/crypto_marketplace/all_crypto_metrics_data.dart';
import 'package:auroim/widgets/investors_in_your_network.dart';
import 'package:auroim/widgets/long_short.dart';
import 'package:auroim/widgets/voting_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:toast/toast.dart';

import '../private_deals_marketplace/appbar_widget.dart';

class SingleCryptoCurrencyDetailsById extends StatefulWidget {
  final coinId;

  SingleCryptoCurrencyDetailsById({this.coinId});

  @override
  _SingleCryptoCurrencyDetailsByIdState createState() =>
      _SingleCryptoCurrencyDetailsByIdState();
}

class _SingleCryptoCurrencyDetailsByIdState
    extends State<SingleCryptoCurrencyDetailsById> {
  FeaturedCompaniesProvider _featuredCompaniesProvider =
  FeaturedCompaniesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: AppBar(
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(3),
            child: Container(
              height: 4,
              color: Colors.grey[400],
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff7499C6),
          title: AppbarWidget(),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: getData(widget.coinId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ss(snapshot.data);
            } else {
              // return ss(null);
              return SizedBox();
            }
          },
        ),
      ),
    );
  }

  getData(coinId) async {
    print("in get data");
    // print(coinDetails["id"]);
    // var tempJsonReq = {"coin": "${coinDetails["id"]}"};
    //
    // String jsonReq = jsonEncode(tempJsonReq);

    var jsonReqResp = await _featuredCompaniesProvider.getSingleCoinDetails(
        'company_details/cryptoInfo?coin_id=$coinId');

    var result = jsonDecode(jsonReqResp.body);
    print("coin details response: $result");
    // print("gsnxvhjsvxhs");
    // print( "gagagagaga : "+result["message"]["percentage_change"].runtimeType.toString());
    // print(jsonDecode(result["message"]["percentage_change"])["1h"]);

    if (jsonReqResp.statusCode == 200 || jsonReqResp.statusCode == 201) {
      // print("ggggg");
      // print("result");
      // print(
      //   jsonDecode(result["message"]["percentage_change"].runtimeType.toString()),
      // );

      // print( "gagagagaga : "+result["message"]["percentage_change"]["1h"]);
      return result["message"];
      // return getCompaniesList(result["message"]);

      // if (result != null &&a
      //     result.containsKey('auth') &&
      //     result['auth'] == true) {
      //   Toast.show("${result['message']}", context,
      //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      // }
    } else if (result != null &&
        result.containsKey('auth') &&
        result['auth'] != true) {
    } else {
      Toast.show("Something went wrong!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  ss(coinData) {
    var metrics = jsonDecode(coinData["metrics"]);
    var percentageChange = jsonDecode(coinData["percentage_change"]);
    List list = [];
    list = metrics[0].split("Price");
    var price = list[list.length - 1];
    print("price: $price");

    list = metrics[1].split("Market Cap");
    var marketCap = list[list.length - 1];
    print("marketCap: $marketCap");

    list = metrics[7].split("Market Cap Rank");
    var marketCapRank = list[list.length - 1];
    print("marketCapRank: $marketCapRank");

    list = metrics[8].split("All-Time High");
    var allTimeHigh = list[list.length-1];
    print("allTimeHigh: $allTimeHigh");

    list = metrics[10].split("All-Time Low");
    var allTimeLow = list[list.length-1];
    print("allTimeLow: $allTimeLow");

    // list = metrics[10].split(" ");
    // var allTimeLow = list[2];
    // print("allTimeLow: $allTimeLow");

    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
              ),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xff5A56B9),
                  ),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width - 20,
                height: 700,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      // child:
                      // Image.network(widget.companyDetails["logo_link"]),
                    ),
                    Text(
                      coinData["coin_id"],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        fontFamily: 'Roboto',
                        color: Color(0xff5A56B9),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 25,
                        height: 60,
                        // decoration: BoxDecoration(
                        //   border: Border.all(),
                        // ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              // decoration: BoxDecoration(
                              //   border: Border.all(),
                              // ),
                              // height: 60,
                              child: Column(
                                children: [
                                  Text(
                                    "Price",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                  Text(
                                    // "",
                                    "$price",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.center,
                              ),
                            ),
                            Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      child: Text(
                                        "All Time High   :",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 4,
                                      child: Tooltip(
                                        message: "All time high",
                                        child: Icon(
                                          Icons.help,
                                          size: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  child: Text(
                                    // "",
                                    "$allTimeHigh",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 25,
                        height: 60,
                        // decoration: BoxDecoration(
                        //   border: Border.all(),
                        // ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              // decoration: BoxDecoration(
                              //   border: Border.all(),
                              // ),
                              height: 60,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Market Cap :",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                  Text(
                                    // "",
                                    "$marketCap",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      child: Text(
                                        "All Time Low   :",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 4,
                                      child: Tooltip(
                                        message: "All time high",
                                        child: Icon(
                                          Icons.help,
                                          size: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  child: Text(
                                    // "",
                                    "$allTimeLow",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 25,
                        height: 60,
                        // decoration: BoxDecoration(
                        //   border: Border.all(),
                        // ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              // decoration: BoxDecoration(
                              //   border: Border.all(),
                              // ),
                              height: 60,
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        child: Text(
                                          "Market Cap Rank   :",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Roboto',
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 4,
                                        child: Tooltip(
                                          message: "SOPR",
                                          child: Icon(
                                            Icons.help,
                                            size: 13,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    // "",
                                    "$marketCapRank",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      child: Text(
                                        "SOPR   :",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 4,
                                      child: Tooltip(
                                        message: "SOPR",
                                        child: Icon(
                                          Icons.help,
                                          size: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  child: Text(
                                    "1.4",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Return Percentage %",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ],
                    ),
                    chart(percentageChange),
                    Container(
                      height: 40,
                      width: 180,
                      decoration: BoxDecoration(
                        color: Color(0xff7499C6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Learn More",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: "Roboto",
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            followRow(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InvestorsInYourNetwork(
                text: "Investors You Follow",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  VotingBar(),
                  LongShort(),
                  ArticleStatic(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InvestorsInYourNetwork(text: "Similar Crypto Currency"),
            ),
            SizedBox(
              height: 10,
            ),
            AllCryptoMetricsData(
              metrics: metrics,
            ),
          ],
        ),
      ),
    );
  }

  followRow() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 10),
      child: Container(
        height: 150,
        child: Row(
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width / 2.3,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xff5A56B9),
                ),
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  "FOLLOW",
                  style: TextStyle(fontSize: 30, fontFamily: "Roboto"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Column(
                children: [
                  Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width / 2.3,
                    child: RaisedButton(
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color(0xff7499C6),
                        ),
                      ),
                      color: Color(0xff7499C6),
                      child: Text(
                        "BUY",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: "Roboto",
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width / 2.3,
                    child: RaisedButton(
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color(0xff7499C6),
                        ),
                      ),
                      color: Color(0xff7499C6),
                      child: Text(
                        "SELL",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: "Roboto",
                        ),
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {},
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

  double getDataDouble(value) {
    try {
      return double.parse("${value.toString().substring(0, value.length - 1)}");
    } catch (e) {
      print(e.toString());
      return 0.0;
    }
  }

  chart(percentageChange) {
    double oneHour = getDataDouble(percentageChange["1h"]);
    double twentyFourHour = getDataDouble(percentageChange["24h"]);
    double sevenDay = getDataDouble(percentageChange["7d"]);
    double fourteenDay = getDataDouble(percentageChange["14d"]);
    double thirtyThreeDay = getDataDouble(percentageChange["30d"]);
    double oneYear = getDataDouble(percentageChange["1y"]);

    return Padding(
      padding: const EdgeInsets.only(
        top: 15.0,
        bottom: 15,
      ),
      child: Container(
        padding: const EdgeInsets.all(4),
        child: Center(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(),
                    top: BorderSide(),
                    right: BorderSide(),
                    bottom: BorderSide(),
                  ),
                  // borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    oneValueString("1h", Colors.black),
                    oneValueString("24h", Colors.black),
                    oneValueString("7d", Colors.black),
                    oneValueString("14d", Colors.black),
                    oneValueString("30d", Colors.black),
                    oneValueString("1y", Colors.black),
                  ],
                ),
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(),
                    left: BorderSide(),
                    right: BorderSide(),
                    // top: BorderSide(color: Colors.white,),
                  ),
                  // borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    oneValue(oneHour == 0.0 ? "?" : "$oneHour",
                        oneHour < 0 ? Colors.red : Colors.green),
                    oneValue(twentyFourHour == 0.0 ? "?" : "$twentyFourHour",
                        twentyFourHour < 0 ? Colors.red : Colors.green),
                    oneValue(sevenDay == 0.0 ? "?" : "$sevenDay",
                        sevenDay < 0 ? Colors.red : Colors.green),
                    oneValue(fourteenDay == 0.0 ? "?" : "$fourteenDay",
                        fourteenDay < 0 ? Colors.red : Colors.green),
                    oneValue(thirtyThreeDay == 0.0 ? "?" : "$thirtyThreeDay",
                        thirtyThreeDay < 0 ? Colors.red : Colors.green),
                    oneValue(oneYear == 0.0 ? "?" : "$oneYear",
                        oneYear < 0 ? Colors.red : Colors.green),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  oneValue(String text, color) {
    return Container(
      width: (MediaQuery.of(context).size.width - 50) / 7,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          text,
          style: TextStyle(color: color, fontSize: 14),
        ),
      ),
    );
  }

  oneValueString(text, color) {
    return Container(
      width: (MediaQuery.of(context).size.width - 50) / 7,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          text,
          style: TextStyle(color: color, fontSize: 14),
        ),
      ),
    );
  }
}
