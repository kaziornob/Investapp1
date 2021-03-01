import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/widgets/private_deals_marketplace/light_featured_companies.dart';
import 'package:auroim/widgets/private_deals_marketplace/thank_you.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:toast/toast.dart';
import 'dart:convert';

import 'appbar_widget.dart';

class BuyCompanyStocks extends StatefulWidget {
  final companyDetails;

  BuyCompanyStocks({this.companyDetails});

  @override
  _BuyCompanyStocksState createState() => _BuyCompanyStocksState();
}

class _BuyCompanyStocksState extends State<BuyCompanyStocks> {
  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();

  TextEditingController _investTextEditingController =  TextEditingController();
  TextEditingController _valuationSuggestionTextEditingController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    double valuation = double.parse(
        widget.companyDetails["valuation"].toString().substring(1, 4));
    double auro_suggested_valuation = valuation + (valuation/10);
    _valuationSuggestionTextEditingController.text = "$auro_suggested_valuation"+"M";
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          color: Color(0xffD9E4E8),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                  ),
                  child: Container(
                    height: 170,
                    width: MediaQuery.of(context).size.width - 20,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xff5A56B9),
                      ),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Add your indication of investment interest",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "Please enter how much you would like to buy in USD",
                            style: TextStyle(
                                color: AllCoustomTheme
                                    .getNewSecondTextThemeColor(),
                                fontFamily: "Roboto",
                                fontSize: 14.5,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.normal,
                                letterSpacing: 0.1),
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          height: 35,
                          width: MediaQuery.of(context).size.width - 50,
                          child: TextField(
                            controller: _investTextEditingController,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Color(0xff5A56B9),
                              fontSize: 17,
                            ),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                borderSide: BorderSide(
                                  color: Color(0xff5A56B9),
                                  width: 1,
                                ),
                              ),
                              hintText: "Eg. \$300000",
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Color(0xff5A56B9),
                                fontSize: 17,
                              ),
                              prefix: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0,
                                    right: 8.0,
                                    bottom: 8.0,
                                    top: 8.0),
                                child: Text(
                                  "\$",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff5A56B9),
                                  ),
                                ),
                              ),
                              contentPadding: EdgeInsets.all(8.0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                borderSide: BorderSide(
                                  color: Color(0xff5A56B9),
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(
                //     top: 15,
                //   ),
                //   child: Container(
                //     height: 30,
                //     width: MediaQuery.of(context).size.width - 20,
                //     decoration: BoxDecoration(
                //       border: Border.all(
                //         color: Color(0xff5A56B9),
                //       ),
                //       borderRadius: BorderRadius.circular(15),
                //       color: Colors.white,
                //     ),
                //     child: Padding(
                //       padding: const EdgeInsets.only(left: 8.0),
                //       child: TextField(
                //         decoration: InputDecoration(
                //           prefix: Text(
                //             "\$",
                //             style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               color: Colors.black,
                //             ),
                //           ),
                //         ),
                //       ),
                //       // Row(
                //       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       //   children: [
                //       //     Text("\$"),
                //       //     Text("20000",
                //       //         style: TextStyle(
                //       //             color: AllCoustomTheme
                //       //                 .getNewSecondTextThemeColor(),
                //       //             fontFamily: "Roboto",
                //       //             fontSize: 16,
                //       //             fontStyle: FontStyle.normal,
                //       //             fontWeight: FontWeight.normal,
                //       //             letterSpacing: 0.1)),
                //       //     SizedBox(),
                //       //   ],
                //       // ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                  ),
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width - 20,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xff5A56B9),
                      ),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "Add Price Limit",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Text(
                            "Adjust your desired price or submit without pricing",
                            style: TextStyle(
                                color: AllCoustomTheme
                                    .getNewSecondTextThemeColor(),
                                fontFamily: "Roboto",
                                fontSize: 14.5,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.normal,
                                letterSpacing: 0.1),
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 80,
                                width: 100,
                                // decoration: BoxDecoration(
                                //   border: Border.all(),
                                // ),
                                child: Column(
                                  children: [
                                    Text(
                                      "Most Recent Valuation",
                                      style: TextStyle(
                                          color: AllCoustomTheme
                                              .getNewSecondTextThemeColor(),
                                          fontFamily: "Roboto",
                                          fontSize: 17,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.1),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "${widget.companyDetails["valuation"]}",
                                      style: TextStyle(
                                          color: Color(0xff5A56B9),
                                          fontFamily: "Roboto",
                                          fontSize: 26,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 0.1),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                // decoration: BoxDecoration(
                                //   border: Border.all(),
                                // ),
                                height: 80,
                                width: 120,
                                child: Column(
                                  children: [
                                    Text(
                                      "Auro Suggested Pricing*",
                                      style: TextStyle(
                                          color: AllCoustomTheme
                                              .getNewSecondTextThemeColor(),
                                          fontFamily: "Roboto",
                                          fontSize: 15,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.1),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "\$$auro_suggested_valuation"+"M",
                                      style: TextStyle(
                                          color: Color(0xff5A56B9),
                                          fontFamily: "Roboto",
                                          fontSize: 26,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 0.1),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "*Please feel free to change as per requirement. This is only a suggestion",
                          style: TextStyle(
                              color:
                                  AllCoustomTheme.getNewSecondTextThemeColor(),
                              fontFamily: "Roboto",
                              fontSize: 13,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.normal,
                              letterSpacing: 0.1),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text(
                        "Valuation you are willing to offer",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Roboto",
                            fontSize: 14.5,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        height: 35,
                        width: MediaQuery.of(context).size.width - 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            color: Colors.white),
                        child: TextField(
                          controller: _valuationSuggestionTextEditingController,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff5A56B9),
                            fontSize: 17,
                          ),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              borderSide: BorderSide(
                                color: Color(0xff5A56B9),
                                width: 1,
                              ),
                            ),
                            hintText: "  $auro_suggested_valuation"+"M",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Color(0xff5A56B9),
                              fontSize: 17,
                            ),
                            // prefixText: "\$",
                            prefixIcon: Icon(FontAwesomeIcons.dollarSign,size: 15,),
                            contentPadding: EdgeInsets.only(left: 16.0),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              borderSide: BorderSide(
                                color: Color(0xff5A56B9),
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text(
                        "Implied Share Price",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Roboto",
                            fontSize: 14.5,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width - 20,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xff5A56B9),
                          ),
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("\$"),
                              Text("12.5",
                                  style: TextStyle(
                                      color: AllCoustomTheme
                                          .getNewSecondTextThemeColor(),
                                      fontFamily: "Roboto",
                                      fontSize: 16,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.normal,
                                      letterSpacing: 0.1)),
                              SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text(
                        "Security Type Preference",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Roboto",
                            fontSize: 14.5,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width - 20,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xff5A56B9),
                          ),
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("\$"),
                              Text(
                                "Any",
                                style: TextStyle(
                                    color: AllCoustomTheme
                                        .getNewSecondTextThemeColor(),
                                    fontFamily: "Roboto",
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: 0.1),
                              ),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60,
                    width: 140,
                    child: RaisedButton(
                      color: Color(0xff7499C6),
                      onPressed: () {
                        // getData();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => ThankYou(),
                          ),
                        );
                      },
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color(0xff7499C6),
                        ),
                      ),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Roboto",
                            fontSize: 20,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
