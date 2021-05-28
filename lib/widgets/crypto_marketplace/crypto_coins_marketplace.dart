

import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/widgets/crypto_marketplace/crypto_coin_buy_item.dart';
import 'package:auroim/widgets/crypto_marketplace/single_crypto_details_by_id.dart';
import 'package:auroim/widgets/private_deals_marketplace/appbar_widget.dart';
import 'package:flutter/material.dart';


class CryptoCoinsMarketplace extends StatefulWidget {
  @override
  _CryptoCoinsMarketplaceListState createState() =>
      _CryptoCoinsMarketplaceListState();
}

class _CryptoCoinsMarketplaceListState extends State<CryptoCoinsMarketplace> {
  Map<String, bool> allTabsBool = {
    "trending": true,
    "live": false,
    "all": false,
    "icon": false,
  };

  String filter = "trending";
  int noOfDays = 30;
  String vsCurrency = "usd";

  TextEditingController _appbarTextController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  bool searching = false;

  final FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();

  @override
  void initState() {
    _appbarTextController.addListener(() {
      if (_appbarTextController.text.length > 0) {
        setState(() {
          searching = true;
        });
      } else {
        setState(() {
          searching = false;
        });
      }
    });
    super.initState();
  }

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
          title: AppbarWidget(
            textEditingController: _appbarTextController,
            focusNode: _focusNode,
            hintText: "Search Crypto",
          ),
        ),
      ),
      body: searching
          ? searchPage()
          : SafeArea(
              child: StatefulBuilder(
                builder: (context, setWidgetState) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Color(0xFFfec20f),
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "All Crypto",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                ConstanceData.SIZE_TITLE20,
                                            fontFamily: "Rosarivo",
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.normal,
                                            letterSpacing: 0.1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 10),
                            //   child: Container(
                            //     height: 30,
                            //     // color: Colors.green,
                            //     width: MediaQuery.of(context).size.width,
                            //     child: Center(
                            //       child: ListView(
                            //         scrollDirection: Axis.horizontal,
                            //         padding: EdgeInsets.only(left: 8.0, right: 8.0),
                            //         children: [
                            //           TabChip(
                            //             child: Text(
                            //               "Trending",
                            //               style: TextStyle(
                            //                 fontFamily: 'Roboto',
                            //                 color: allTabsBool["trending"] == true
                            //                     ? Colors.white
                            //                     : Colors.black,
                            //                 fontWeight: FontWeight.bold,
                            //               ),
                            //             ),
                            //             backgroundColor:
                            //                 allTabsBool["trending"] == true
                            //                     ? Color(0xff7499C6)
                            //                     : Colors.white,
                            //             callback: () =>
                            //                 selectedTab("trending", setWidgetState),
                            //           ),
                            //           TabChip(
                            //             child: Text(
                            //               "Live",
                            //               style: TextStyle(
                            //                 color: allTabsBool["live"] == true
                            //                     ? Colors.white
                            //                     : Colors.black,
                            //                 fontFamily: 'Roboto',
                            //                 fontWeight: FontWeight.bold,
                            //               ),
                            //             ),
                            //             backgroundColor: allTabsBool["live"] == true
                            //                 ? Color(0xff7499C6)
                            //                 : Colors.white,
                            //             callback: () =>
                            //                 selectedTab("live", setWidgetState),
                            //           ),
                            //           TabChip(
                            //             child: Text(
                            //               "All",
                            //               style: TextStyle(
                            //                 color: allTabsBool["all"] == true
                            //                     ? Colors.white
                            //                     : Colors.black,
                            //                 fontFamily: 'Roboto',
                            //                 fontWeight: FontWeight.bold,
                            //               ),
                            //             ),
                            //             backgroundColor: allTabsBool["all"] == true
                            //                 ? Color(0xff7499C6)
                            //                 : Colors.white,
                            //             callback: () =>
                            //                 selectedTab("all", setWidgetState),
                            //           ),
                            //           TabChip(
                            //             child: Icon(
                            //               Icons.filter_alt_sharp,
                            //               color: allTabsBool["icon"] == true
                            //                   ? Colors.white
                            //                   : Colors.black,
                            //             ),
                            //             backgroundColor: allTabsBool["icon"] == true
                            //                 ? Color(0xff7499C6)
                            //                 : Colors.white,
                            //             callback: () =>
                            //                 selectedTab("icon", setWidgetState),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: FutureBuilder(
                                future: _featuredCompaniesProvider
                                    .getCoinsListSorted("market_cap"),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    // List allWidgets = [];
                                    // allWidgets = [...snapshot.data].sublist(
                                    //   1,
                                    // );

                                    // if (allTabsBool["icon"] == true) {
                                    //   allWidgets.insert(0, filterBox());
                                    // }
                                    // print("length of snapshot : ${allWidgets.length}");
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width -
                                          40,
                                      child: ListView.builder(
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (context, index) {
                                          // if (allTabsBool["icon"] == true && index == 0) {
                                          //   return filterBox();
                                          // } else {
                                          print("single coin data ");
                                          print(snapshot.data[index]["coin_id"]);
                                          if (snapshot.data[index]["coin_id"] != null ||
                                              snapshot.data[index]["coin_id"] != "") {
                                            return CryptoCoinBuyItem(
                                              coinDetails: snapshot.data[index],
                                            );
                                          } else {
                                            return SizedBox();
                                          }
                                          // }
                                        },
                                      ),
                                    );
                                  } else {
                                    return SizedBox();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  selectedTab(selectedKey, setWidgetState) {
    // print(selectedKey);
    setWidgetState(() {
      allTabsBool.forEach((key, value) {
        if (selectedKey == key) {
          allTabsBool[key] = true;

          if (key == "icon") {
            filter = "all";
          } else {
            filter = key;
          }
        } else {
          allTabsBool[key] = false;
        }
      });
    });
  }

  searchPage() {
    print("SEARCH PAGE");
    return Container(
      height: MediaQuery.of(context).size.height - 65,
      child: FutureBuilder(
        future: _featuredCompaniesProvider
            .searchCryptoCoins(_appbarTextController.text),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data.length == 0) {
              return ListTile(
                onTap: () {
                  setState(() {
                    _appbarTextController.clear();
                  });
                },
                title: Text(
                  "No Results",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                trailing: Icon(Icons.close_rounded),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      _appbarTextController.text = "";
                      FocusScope.of(context).unfocus();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SingleCryptoCurrencyDetailsById(
                            coinId: snapshot.data[index]["coin_id"],
                          ),
                        ),
                      );
                    },
                    title: Text(
                      snapshot.data[index]["coin_id"],
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }

// getData() async {
//   print("in get data");
//   var tempJsonReq = {};
//
//   // String jsonReq = jsonEncode(tempJsonReq);
//
//   var jsonReqResp = await _featuredCompaniesProvider
//       .coinDetails('https://api.coingecko.com/api/v3/coins/list');
//
//   var result = jsonDecode(jsonReqResp.body);
//   // print("coin details response: $result");
//
//   if (jsonReqResp.statusCode == 200 || jsonReqResp.statusCode == 201) {
//     // print("ggggg");
//     // print("result");
//     return result;
//     // return getCompaniesList(result["message"]);
//
//     // if (result != null &&a
//     //     result.containsKey('auth') &&
//     //     result['auth'] == true) {
//     //   Toast.show("${result['message']}", context,
//     //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//     // }
//   } else if (result != null &&
//       result.containsKey('auth') &&
//       result['auth'] != true) {
//   } else {
//     Toast.show("Something went wrong!", context,
//         duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//   }
// }
}
