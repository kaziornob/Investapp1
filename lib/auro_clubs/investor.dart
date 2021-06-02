import 'dart:math';
import 'package:flutter/material.dart';
import 'package:animator/animator.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';

class Investor extends StatefulWidget {
  final String person;

  Investor(this.person);

  @override
  _InvestorState createState() => _InvestorState(person);
}

class _InvestorState extends State<Investor> {
  String person;

  _InvestorState(this.person);

  final Map alldetailsForClubs = {
    "Warren Buffet": {
      "text1":
          "Buy companies at a low price, improve them via management and make long term gains",
      "text2":
          "He has a 30-year-plus track record making on average 20 percent a year.",
      "name": "Warren Buffet",
      'networth': '\$100.6 Billion',
      'pic': 'assets/buffet.png',
    },
    "Jim Simons": {
      "text1":
          "Jim Simons, one of the greatest investors of all time, built his market-beating strategy around taking the human element out of investing. He founded Renaissance Technologies, which uses quantitative models underpinned by massive amounts of data to identify and profit from patterns in the market",
      "text2":
          "66% before charging fees—39% after fees—racking up trading gains of more than dollar 100 billion.",
      "name": "Jim Simons",
      'networth': '\$25.2 Billion',
      'pic': 'assets/simons.png',
    },
    "Ray Dalio": {
      "text1":
          "Ray Dalio describes his guiding concept behind his investing is as making use of diversification with uncorrelated assets to lower the amount of risk to make a certain return. Dalio deploys multiple strategies within Bridgewater Associates, investing around economic trends, such as changes in exchange rates, inflation, and G.D.P. growth.",
      "text2":
          "Dalio’s main Pure Alpha hedge fund has returned 13% net of fees since inception in 1991. (Source: Forbes Magazine)",
      "name": "Ray Dalio",
      'networth': '\$5  Billion',
      'pic': 'assets/dalio.png',
    },
    "Masayoshi Son": {
      "text1":
          "Masayoshi Son  supports mid to late-stage companies who will enable the next stage of the information revolution. Hi Vision Fund spans 3 areas:1. Companies designed to bring new technologies to old industries, such as transportation and real estate.2. media and telecommunications.3. “Frontier” such as, the internet of things, robotics, computational biology, and genomics. Son San is obsessive over “Singularity” – the scenario when computer intelligence overtakes human kind. He has been known to make big bets on companies based upon what he once called his \“sense of smell.\” ",
      "text2":
          "Masayoshi Son founded and runs mobile telecom and investment giant SoftBank Group and The Vision Fund is the largest technology fund in the world. Son was an early investor in internet firms, investing in Yahoo! in 1995 and investing a \$20 million stake into Alibaba in 1999, both of which have been home runs, with the latter arguably being one of the best investments of all time.  ",
      "name": "Masayoshi Son",
      'networth': '\$35.8 Billion',
      'pic': 'assets/son.png',
    },
    "John Templeton": {
      "text1":
          "Look for companies globally- best value stocks are those that are most neglected",
      "text2":
          "Templeton’s Growth Fund, created in 1954, went on to earn about a 14% annual return over the next 38 years when he retired in 1992.",
      "name": "John Templeton",
      'networth': '\$270 Billion',
      'pic': 'assets/templeton.png',
    },
    "Michael Novogratz": {
      "text1":
          "Michael is often known as the Man Running Galaxy Digital, the ‘Goldman Sachs of Crypto’. He predicts a \$20T Crypto Industry saying that we're only in the early innings. He compares with the internet revolution in the 1990s, suggesting that digital currencies are a global revolution. Prior to his Crypto success, Micael ran a prominent Macro fund looking for broad social, political, and macroeconomic trends and, in effect, betting on the way they might affect financial markets using equities, bonds, currencies, commodities, and futures. ",
      "text2":
          "Novogratz, was prior the Chief investment officer of the macro fund, Fortress Investment Group, which he helped take public with \$17 billion in private equity funds, \$9.4 billion in hedge funds, and \$3 billion in real estate. Fortress was later acquired for \$3.3 billion by SoftBank.  ",
      "name": "Michael Novogratz",
      'networth': '\$7.3 Billion',
      'pic': 'assets/novogratz.png',
    },
    "Steve Mandel": {
      "text1":
          "He employs fundamental analysis and a bottom-up stock picking approach, meaning he focuses on individual companies instead of global macro trends and economic cycles.",
      "text2":
          "The Hedge Fund 'Lone Pine' has averaged 30% annualized returns since 1997.",
      "name": "Steve Mandel",
      'networth': '\$25.2 Billion',
      'pic': 'assets/mandel.png',
    },
    "George Soros": {
      "text1":
          "Identify macroeconomic trends Highly leveraged bets on bonds and commodities",
      "text2":
          "Soros Fund Management, LLC is a private American investment management firm. It is currently structured as a family office, but formerly as a hedge fund. The firm was founded in 1969 by George Soros[1] and, in 2010, was reported to be one of the most profitable firms in the hedge fund industry,[2] averaging a 20% annual rate of return over four decades.",
      "name": "George Soros",
      'networth': '\$25.2 Billion',
      'pic': 'assets/soros.png',
    },
    "Lei Zhang": {
      "text1":
          "Lei Zhang is a big believer in value investing, but where he deviates from the traditional value investing philosophy is that he likes investing in changes. He believes that it is change that derives value and he would like to invest in people driving them.",
      "text2":
          "Hillhouse has achieved investment returns of up to 52% annualized from inception in 2005 until 2012, even in spite of a 37% drop in 2008, making Hillhouse among the most profitable funds of its size in the world, and the leading fund in Asia",
      "name": "Lei Zhang",
      'pic': 'assets/zhang.png',
    },
    "Rakesh Jhunjhunwala": {
      "text1":
          "buy when the share is in uptrend and sell only when the share goes in the downtrend.",
      "text2":
          "In 1985, Jhunjhunwala invested Rs 5,000 (dollar 70) as capital. By September 2018, that capital had inflated to Rs 11,000 crore (dollar 1.5 bn).",
      "name": "Rakesh Jhunjhunwala",
      'networth': '\$4.2 Billion',
      'pic': 'assets/jhunhjhunwala.png',
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.arrow_back_sharp,
            color: Colors.white,
            size: 40,
          ),
          backgroundColor: Color(0xFF8A8A8A),
          onPressed: () => Navigator.of(context).pop(),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 80.0,
                                  child: ArcText(
                                      radius: 80,
                                      text: alldetailsForClubs[person]['name'],
                                      textStyle: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      startAngle: 0,
                                      startAngleAlignment:
                                          StartAngleAlignment.center,
                                      placement: Placement.outside,
                                      direction: Direction.clockwise),
                                  backgroundImage: new AssetImage(
                                      alldetailsForClubs[person]['pic']),
                                  backgroundColor: Colors.white,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "AURO CLUB",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontFamily: "Rosaviro"),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.chevron_left,
                                size: 50,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Investment Philosophy',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontFamily: "Rosario"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        alldetailsForClubs[person]['text1'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Investment Track Record',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontFamily: "Rosario"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        alldetailsForClubs[person]['text2'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Net Worth',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontFamily: "Rosario"),
                      ),
                      SizedBox(height: 10),
                      Text(
                        alldetailsForClubs[person]['networth'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
