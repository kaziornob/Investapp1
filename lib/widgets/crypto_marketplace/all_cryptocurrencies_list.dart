import 'dart:convert';

import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/provider_abhinav/coin_url.dart';
import 'package:auroim/widgets/crypto_marketplace/crypto_coins_marketplace.dart';
import 'package:auroim/widgets/go_to_marketplace_button.dart';
import 'package:auroim/widgets/crypto_marketplace/single_crypto_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class AllCryptocurrenciesList extends StatefulWidget {
  @override
  _AllCryptocurrenciesListState createState() =>
      _AllCryptocurrenciesListState();
}

class _AllCryptocurrenciesListState extends State<AllCryptocurrenciesList> {
  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              // print("cryptocurrencies");
              // print(snapshot.data);
              if (snapshot.hasData) {
                return dd(snapshot.data);
              } else {
                return SizedBox();
              }
            },
          ),


        ],
      ),
    );
  }

  dd(data) {
    // var dataCut = data.sublist(1);
    return Container(
      height: 265,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return CryptocurrencyItem(
            coinDetails: data[index],
          );
        },
      ),
    );
  }

  getData() async {
    print("in get data");
    // var tempJsonReq = {};

    // String jsonReq = jsonEncode(tempJsonReq);

    var jsonReqResp = await _featuredCompaniesProvider
        .coinDetails('https://api.coingecko.com/api/v3/coins/list');

    var result = jsonDecode(jsonReqResp.body);
    // print("coin details response: $result");

    if (jsonReqResp.statusCode == 200 || jsonReqResp.statusCode == 201) {
      // print("ggggg");
      // print("result");
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
}

class CryptocurrencyItem extends StatelessWidget {
  // ApiProvider request = new ApiProvider();
  // var userAllDetail;
  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();

  final coinDetails;

  CryptocurrencyItem({this.coinDetails});

  @override
  Widget build(BuildContext context) {
    Provider.of<CoinUrl>(context, listen: false).getImageUrl(coinDetails["id"]);
    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
      ),
      child: LayoutBuilder(builder: (context, boxConstraints) {
        // print(boxConstraints.maxHeight);
        // print(boxConstraints.maxWidth);
        return Container(
          height: boxConstraints.maxHeight,
          width: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Color(0xff5A56B9),
            ),
            color: Colors.white,
            // color: AllCoustomTheme.getNewSecondTextThemeColor(),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                // decoration: BoxDecoration(border: Border.all()),
                padding: EdgeInsets.all(5.0),
                child: Consumer<CoinUrl>(
                  builder: (context, urlProvider, _) {
                    return Row(
                      mainAxisAlignment:
                          !urlProvider.imageUrl.containsKey(coinDetails["id"])
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Text(
                            coinDetails["name"],
                            style: TextStyle(
                              color: Color(0xff1D6177),
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.clip,
                          ),
                          width: boxConstraints.maxHeight / 3,
                        ),
                        !urlProvider.imageUrl.containsKey(coinDetails["id"])
                            ? SizedBox()
                            : Container(
                                height: boxConstraints.maxHeight / 4,
                                width: boxConstraints.maxHeight / 4,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xff5A56B9),
                                  ),
                                ),
                                child: Image.network(
                                    urlProvider.imageUrl[coinDetails["id"]]),
                              ),
                      ],
                    );
                  },
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(
              //     companyData["company_description"],
              //     style: TextStyle(
              //         color: AllCoustomTheme.getNewSecondTextThemeColor(),
              //         fontFamily: "Roboto",
              //         fontSize: 14.5,
              //         fontStyle: FontStyle.normal,
              //         fontWeight: FontWeight.normal,
              //         letterSpacing: 0.1),
              //   ),
              // ),
              FutureBuilder(
                future: getCoinData(context),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var metrics = jsonDecode(snapshot.data["metrics"]);
                    var percentageChange =
                        jsonDecode(snapshot.data["percentage_change"]);
                    return Column(
                      children: [
                        Text(
                          "Price : ${getPriceOfCoin(metrics)}",
                          style: TextStyle(
                              color: Color(0xff5A56B9),
                              fontSize: 16,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.1),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "24h Change : ${get24hChange(percentageChange)}",
                          style: TextStyle(
                              color: Color(0xff5A56B9),
                              fontSize: 16,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.1),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Market Cap Rank : ${getMarketCapRank(metrics)}",
                          style: TextStyle(
                              color: Color(0xff5A56B9),
                              fontSize: 16,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.1),
                        ),
                      ],
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () {
                    // getUserDetails();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SingleCryptoCurrencyDetails(
                          coinDetails: coinDetails,
                        ),
                      ),
                    );
                  },
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Color(0xff7499C6),
                      )),
                  color: Color(0xff7499C6),
                  child: Text(
                    "Buy",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.1),
                  ),
                ),
              )
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     height: 40,
              //     width: 100,
              //     child: FlatButton(
              //       color: Color(0xff7499C6),
              //       onPressed: () {
              //         // getUserDetails();
              //         Navigator.of(context).push(
              //           MaterialPageRoute(
              //             builder: (context) => SingleCryptoCurrencyDetails(
              //               coinDetails: coinDetails,
              //             ),
              //           ),
              //         );
              //       },
              //       // shape: OutlineInputBorder(
              //       //   borderRadius: BorderRadius.circular(15),
              //       //   borderSide: BorderSide(
              //       //     color: Color(0xff7499C6),
              //       //   ),
              //       // ),
              //
              //       child: Text(
              //         "Buy",
              //         style: TextStyle(
              //             color: Color(0xffFF4544),
              //             fontFamily: "Roboto",
              //             fontSize: 20,
              //             fontStyle: FontStyle.normal,
              //             fontWeight: FontWeight.bold,
              //             letterSpacing: 0.1),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      }),
    );
  }

  getCoinData(context) async {
    print("in get data");
    print(coinDetails["id"]);
    // var tempJsonReq = {"coin": "${coinDetails["id"]}"};
    //
    // String jsonReq = jsonEncode(tempJsonReq);

    var jsonReqResp = await _featuredCompaniesProvider.getSingleCoinDetails(
        'company_details/cryptoInfo?coin_id=${coinDetails["id"]}');

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

  getMarketCapRank(coinDetails) {
    List list = [];
    if (coinDetails != null) {
      list = coinDetails[7].split("Market Cap Rank");
      var marketCapRank = list[list.length - 1];
      print("marketCapRank: $marketCapRank");
      return marketCapRank;
    } else {
      return "";
    }
  }

  get24hChange(coinDetails) {
    // List list = [];
    if (coinDetails != null) {
      String coin24hChange = coinDetails["24h"];
      // var coin24hChange = list[list.length - 1];
      print("coin24hChange: $coin24hChange");
      return coin24hChange;
    } else {
      return "";
    }
  }

  getPriceOfCoin(coinDetails) {
    List list = [];
    if (coinDetails != null) {
      list = coinDetails[0].split("\$");
      var price = list[list.length - 1];
      print("price: $price");
      return price;
    } else {
      return "";
    }
  }
}
