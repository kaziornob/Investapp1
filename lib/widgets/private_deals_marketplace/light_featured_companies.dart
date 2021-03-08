import 'dart:convert';

import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/widgets/private_deals_marketplace/single_company_details.dart';
import 'package:auroim/widgets/private_deals_marketplace/single_company_details_page.dart';

import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class FeaturedCompaniesList extends StatefulWidget {
  @override
  _FeaturedCompaniesListState createState() => _FeaturedCompaniesListState();
}

class _FeaturedCompaniesListState extends State<FeaturedCompaniesList> {
  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          // print(snapshot.data);
          if (snapshot.hasData) {
            return dd(snapshot.data);
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }

  dd(data) {
    List allData = data;
    // allData = allData.reversed.toList();
    return Container(
      height: 265,
      decoration: BoxDecoration(border: Border.all()),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: allData.length,
        itemBuilder: (context, index) {
          return LightFeaturedCompaniesListItem(
            companyData: allData[index],
          );
        },
      ),
    );
  }

  getData() async {
    print("in get data");
    var tempJsonReq = {};

    String jsonReq = jsonEncode(tempJsonReq);

    var jsonReqResp = await _featuredCompaniesProvider.companyDetails(
        'company_details/pvtMain?list_type=all', jsonReq);

    var result = jsonDecode(jsonReqResp.body);
    // print("company details response: $result");

    if (jsonReqResp.statusCode == 200 || jsonReqResp.statusCode == 201) {
      // print("ggggg");
      return result["message"];
      // return getCompaniesList(result["message"]);

      // if (result != null &&
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

class LightFeaturedCompaniesListItem extends StatelessWidget {
  final companyData;

  LightFeaturedCompaniesListItem({this.companyData});

  @override
  Widget build(BuildContext context) {
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Text(
                        companyData["company_name"],
                        style: TextStyle(
                          color: Color(0xff5A56B9),
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                      width: boxConstraints.maxHeight / 3,
                    ),
                    Container(
                      height: boxConstraints.maxHeight / 4,
                      width: boxConstraints.maxHeight / 4,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Color(0xff5A56B9),
                      )),
                      child: Image.network(companyData["logo_link"]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  description(),
                  style: TextStyle(
                      color: AllCoustomTheme.getNewSecondTextThemeColor(),
                      fontFamily: "Roboto",
                      fontSize: 14.5,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.1),
                ),
              ),
              Text(
                companyData["valuation"] == ""
                    ? "N/A"
                    : companyData["valuation"],
                style: TextStyle(
                    color: Color(0xff5A56B9),
                    fontSize: 16,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.1),
              ),
              Text(
                "Last Valuation",
                style: TextStyle(
                    color: AllCoustomTheme.getNewSecondTextThemeColor(),
                    fontSize: 14.5,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.1),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SingleCompanyDetailsPage(
                          companyDetails: companyData,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Learn More",
                    style: TextStyle(
                        color: Color(0xff5A56B9),
                        fontSize: 16,
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.1),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  description() {
    if (companyData["company_description"].toString().length > 50) {
      return companyData["company_description"].toString().substring(0, 50) +
          "...";
    } else {
      return companyData["company_description"];
    }
  }
}
