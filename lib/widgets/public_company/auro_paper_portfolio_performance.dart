import 'package:auroim/widgets/auro_paper_portfolio_performace_chart.dart';
import 'package:auroim/widgets/crypto_coin_price_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuroPaperPortfolioPerformace extends StatefulWidget {
  @override
  _AuroPaperPortfolioPerformaceState createState() =>
      _AuroPaperPortfolioPerformaceState();
}

class _AuroPaperPortfolioPerformaceState
    extends State<AuroPaperPortfolioPerformace> {
  List<CryptoCoinPriceData> allPriceData = [];
  var dd = [
    [1614246476997, 0.0032989056913397363],
    [1614249313651, 0.0036464179889973136],
    [1614252897564, 0.003744994305001977],
    [1614256641485, 0.003531700152924923],
    [1614260082180, 0.0037606899942424265],
    [1614263645381, 0.003590841774402246],
    [1614267268348, 0.0036363207803451034],
    [1614270855321, 0.00387639125500825],
    [1614274500370, 0.0036161407269799163],
    [1614278088424, 0.003732607806510909],
    [1614281671900, 0.003682477612407755],
  ];

  @override
  Widget build(BuildContext context) {
    dd.forEach((element) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(element[0]);
      print(element[1]);
      allPriceData.add(
        CryptoCoinPriceData(x: date, y: element[1]),
      );
    });

    return Material(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.white),
      ),
      elevation: 4,
      child: Container(
        height: 520,
        width: MediaQuery.of(context).size.width - 15,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 15,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Your Auro Paper Portfolio Performace",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto",
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "\$14,236",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ".00",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                        ),
                      ),
                    ]),
                  ),
                  Text(
                    "(+42.36% - Since Inception Return)",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 12.0, right: 8.0, bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "\$",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "0.29",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "(+0.30% - day's return)",
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 12.0,
                bottom: 8.0,
              ),
              child: Row(
                children: [
                  Text(
                    "05 Mar 2021",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            AuroPaperPortfolioPerformaceChart(
              pricesData: allPriceData,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
              ),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width - 15,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                ),
                child: Row(
                  children: [
                    selectedTab("6m", false),
                    selectedTab("1y", false),
                    selectedTab("2y", false),
                    selectedTab("3y", true),
                    selectedTab("5y", false),
                    selectedTab("max", false),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:12.0,right: 8.0),
              child: Container(
                // decoration: BoxDecoration(border: Border.all()),
                height: 50,
                width: MediaQuery.of(context).size.width-15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      FontAwesomeIcons.chartLine,
                      color: Color(0xff5A56B9),
                    ),
                    SizedBox(width: 8.0,),
                    Expanded(
                      child: RichText(
                        softWrap: true,
                        overflow: TextOverflow.clip,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  "Historical returns displayed for Investment of ",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            TextSpan(
                              text: "\$",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: "100,000 for ",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            TextSpan(
                              text: "Moderate ",
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                            TextSpan(
                              text: "Investment Preferences",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 35,
              height: 50,
              child: RaisedButton(
                elevation: 10,
                onPressed: () {},
                child: Text(
                  "INVEST NOW",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                color: Color(0xff7499C6),
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Color(0xff7499C6),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  selectedTab(text, selected) {
    return Material(
      elevation: selected ? 4 : 0,
      child: Container(
        width: (MediaQuery.of(context).size.width - 15) / 6,
        decoration: BoxDecoration(
          borderRadius: selected ? BorderRadius.circular(4) : BorderRadius.circular(0),
          color: selected ? Color(0xff5A56B9) : Colors.grey[200],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: selected ? Colors.white : Colors.grey,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
