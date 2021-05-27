import 'dart:convert';

import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/widgets/crypto_coin_chart.dart';
import 'package:auroim/widgets/crypto_coin_price_data.dart';
import 'package:auroim/widgets/crypto_marketplace/single_crypto_details_by_id.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class CryptoCoinBuyItem extends StatefulWidget {
  final coinDetails;
  final bool isOnScreen;

  CryptoCoinBuyItem({
    this.coinDetails,
    this.isOnScreen,
  });

  @override
  _CryptoCoinBuyItemState createState() => _CryptoCoinBuyItemState();
}

class _CryptoCoinBuyItemState extends State<CryptoCoinBuyItem> {
  final FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();

  var coinMetrics;

  @override
  Widget build(BuildContext context) {
    print("crypto coin buy item");
    // print(widget.coinDetails);
    // Provider.of<CoinUrl>(context, listen: false)
    //     .getImageUrl(widget.coinDetails["id"]);
    return FutureBuilder(
      future: getCoinPrices(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Color(0xff5A56B9),
                ),
                color: Colors.white,
              ),
              child: body(snapshot.data),
            ),
          );
        } else {
          // print("${widget.coinDetails}");
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Color(0xff5A56B9),
                ),
                color: Colors.white,
              ),
              child: body(null),
            ),
          );
        }
      },
    );
  }

  body(data) {
    if (data != null) {
      List<Color> graphColors = [
        Colors.green[50],
        Colors.green[200],
        Colors.green
      ];
      List<double> stops = [0.0, 0.5, 1.0];
      List<CryptoCoinPriceData> allPriceData = [];

      List prices = data["prices"];
      print(prices.toString());

      prices.forEach((element) {
        DateTime date = DateTime.fromMillisecondsSinceEpoch(element[0]);
        print(element[1]);
        allPriceData.add(
          CryptoCoinPriceData(x: date, y: element[1]),
        );
      });

      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 4.0,
              bottom: 4.0,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width - 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 4.0),
                      child: Container(
                        // width: MediaQuery.of(context).size.height / 8,
                        child: Text(
                          widget.coinDetails["coin_id"].toUpperCase(),
                          style: TextStyle(
                            color: Color(0xff1D6177),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex:2,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 16,
                        // width: boxConstraints.maxHeight / 4,
                        decoration: BoxDecoration(
                          // border: Border.all(
                          //   color: Color(0xff5A56B9),
                          // ),
                        ),
                        child: Image.network(widget.coinDetails["logo_link"]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Text("30D CHANGE"),
                Row(
                  children: [
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.red,
                    ),
                    Text(
                      "-2",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          CryptoCoinCharts(
            color: graphColors,
            stops: stops,
            pricesData: allPriceData,
          ),
          button(
            "SELL",
            () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SingleCryptoCurrencyDetailsById(
                    coinId: widget.coinDetails["coin_id"],
                  ),
                ),
              );
            },
            Colors.red,
          ),
          button(
            "BUY",
            () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SingleCryptoCurrencyDetailsById(
                    coinId: widget.coinDetails["coin_id"],
                  ),
                ),
              );
            },
            Colors.green,
          ),

          // button(""),
        ],
      );
    } else {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 4.0,
              bottom: 4.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Text(
                    widget.coinDetails["coin_id"],
                    style: TextStyle(
                        color: Color(0xff5A56B9),
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 16,
                  width: MediaQuery.of(context).size.height / 16,
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  // child: Image.network(widget.coinDetails["logo_link"]),
                ),
              ],
            ),
          ),
          // CryptoCoinCharts(
          //   color: graphColors,
          //   stops: stops,
          //   newSalesData: allSalesData,
          // ),
        ],
      );
    }
  }

  getCoinPrices() async {
    print("get coin prices");
    // var tempJsonReq = {};

    // String jsonReq = jsonEncode(tempJsonReq);

    var jsonReqResp = await _featuredCompaniesProvider.coinDetails(
        'https://api.coingecko.com/api/v3/coins/${widget.coinDetails["coin_id"]}/market_chart?vs_currency=usd&days=30');

    var result = jsonDecode(jsonReqResp.body);
    // print("coin prices response: $result");

    if (jsonReqResp.statusCode == 200 || jsonReqResp.statusCode == 201) {
      // print("ggggg");
      // print("result");
      // await getCoinData(context);
      return result;
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

  getCoinData(context) async {
    print("crypto coin in get data");
    print(widget.coinDetails["id"]);
    // var tempJsonReq = {"coin": "${coinDetails["id"]}"};
    //
    // String jsonReq = jsonEncode(tempJsonReq);

    var jsonReqResp = await _featuredCompaniesProvider.getSingleCoinDetails(
        'crypto_metric/metrics?coin=${widget.coinDetails["id"]}');

    var result = jsonDecode(jsonReqResp.body);
    // print("coin details response: $result");

    if (jsonReqResp.statusCode == 200 || jsonReqResp.statusCode == 201) {
      // print("ggggg");
      // print("result");

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

  button(text, callback, buttonColor) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: GestureDetector(
        onTap: callback,
        child: Container(
          height: 20,
          width: MediaQuery.of(context).size.width - 80,
          color: buttonColor,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
