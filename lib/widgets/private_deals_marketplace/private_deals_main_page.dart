import 'dart:convert';

import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/widgets/private_deals_marketplace/all_companies_widget.dart';
import 'package:auroim/widgets/private_deals_marketplace/appbar_widget.dart';
import 'package:auroim/widgets/private_deals_marketplace/get_single_company_details.dart';
import 'package:auroim/widgets/private_deals_marketplace/light_featured_companies.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/constance.dart';
import 'package:toast/toast.dart';

class PrivateDealsMarketplaceMainPage extends StatefulWidget {
  @override
  _PrivateDealsMarketplaceMainPageState createState() =>
      _PrivateDealsMarketplaceMainPageState();
}

class _PrivateDealsMarketplaceMainPageState
    extends State<PrivateDealsMarketplaceMainPage> {
  TextEditingController _textEditingController = TextEditingController();
  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();
  FocusNode _focusNode = FocusNode();
  bool searching = false;

  @override
  void initState() {
    _textEditingController.addListener(searchCompanyByName);
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  final scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
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
            textEditingController: _textEditingController,
            focusNode: _focusNode,
            hintText: "Search Private Companies",
          ),
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            print("toucjed kckjsbcs");
            if (_focusNode.hasFocus) {
              _focusNode.unfocus();
            }
          },
          child: Container(
            // color: AllCoustomTheme.getPageBackgroundThemeColor(),
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: !searching ? privateMainPage() : searchPage(),
          ),
        ),
      ),
    );
  }

  searchCompanyByName() {
    if (_textEditingController.text.length > 0) {
      setState(() {
        searching = true;
      });
    } else {
      setState(() {
        searching = false;
      });
    }

    // var allCompanies = getSearchData();
    // print("text feld");
    // if (_focusNode.hasFocus) {
    //   // print("text field  in focus");
    //   // scaffoldState.currentState.showBottomSheet(
    //   //   (context) => searchPage(),
    //   // );
    // } else {
    //   print("not has focus");
    //   // Navigator.of(context).pop();
    //   return;
    // }
  }

  getSearchData() async {
    print("private deals main page in get data");
    var tempJsonReq = {};

    String jsonReq = jsonEncode(tempJsonReq);

    var jsonReqResp = await _featuredCompaniesProvider.companyDetails(
        'company_details/pvtName?substr=${_textEditingController.text}',
        jsonReq);

    var result = jsonDecode(jsonReqResp.body);
    // print("company details response: $result");

    if (jsonReqResp.statusCode == 200 || jsonReqResp.statusCode == 201) {
      // print("ggggg");
      print("results ${result["message"]}");
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

  privateMainPage() {
    print("PRIVATE MAIN PAGE");
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 100,
            padding: const EdgeInsets.only(
              bottom: 8,
              top: 10,
            ),
            child: Center(
              child: Text(
                "Private Deals Marketplace",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: ConstanceData.SIZE_TITLE20,
                    fontFamily: "Rosarivo",
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
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
                    color: AllCoustomTheme.getNewSecondTextThemeColor(),
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
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        "Featured Companies",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: ConstanceData.SIZE_TITLE20,
                            fontFamily: "Rosarivo",
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0.1),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: Text(
                        "See all",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff7499C6),
                        ),
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                SizedBox(height: 5),
                FeaturedCompaniesList(),
                // PrivateDealsGraphs(),
                AllCompanies(),
                // CryptoMarketplace(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  searchPage() {
    print("SEARCH PAGE");
    return Container(
      height: MediaQuery.of(context).size.height - 65,
      child: FutureBuilder(
        future: getSearchData(),
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
                    _textEditingController.clear();
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
                      _textEditingController.text = "";
                      FocusScope.of(context).unfocus();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => GetSingleCompany(
                            companyData: snapshot.data[index],
                          ),
                        ),
                      );
                    },
                    title: Text(
                      snapshot.data[index]["company_name"],
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
}
