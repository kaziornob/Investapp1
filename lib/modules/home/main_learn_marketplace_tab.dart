import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/api/reusable_functions.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/global.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/modules/home/investment_masterclass.dart';
import 'package:auroim/investment_masterclass/retail_learn_tab.dart';
import 'package:auroim/modules/questionAndAnswerModule/models/question.dart';
import 'package:auroim/modules/questionAndAnswerModule/resources/question_api_provider.dart';
import 'package:auroim/modules/questionAndAnswerModule/ui/pages/error.dart';
import 'package:auroim/modules/questionAndAnswerModule/ui/pages/questionTemplate.dart';
import 'package:auroim/modules/socialInvestRelatedPages/clubDetail.dart';
import 'package:auroim/widgets/auro_stars.dart';
import 'package:auroim/widgets/crypto_marketplace/crypto_coins_marketplace.dart';
import 'package:auroim/widgets/crypto_marketplace/crypto_marketplace_main_page.dart';
import 'package:auroim/widgets/go_to_marketplace_button.dart';
import 'package:auroim/widgets/payment_pages/payment_types.dart';
import 'package:auroim/widgets/private_deals_marketplace/private_deals_intro.dart';
import 'package:auroim/widgets/private_deals_marketplace/private_deals_main_page.dart';
import 'package:auroim/widgets/public_companies_list.dart';
import 'package:auroim/widgets/public_company/public_company_marketplace.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:syncfusion_flutter_charts/charts.dart';

class MainLearnMarketTab extends StatefulWidget {
  @override
  _MainLearnMarketTabState createState() => _MainLearnMarketTabState();
}

class _MainLearnMarketTabState extends State<MainLearnMarketTab> {
  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();
  ScrollController _scrollController = ScrollController();
  ReusableFunctions _reusableFunctions = ReusableFunctions();
  String selectedWeeklyLeague;
  var userData;

  List names = [
    "Warren Buffet",
    "Jim Simons",
    "Benjamin Graham",
    "Bill Gross",
    "John Templeton",
    "Steve Mandel",
    "Peter Lynch",
    "George Soros",
    "Lei Zhang",
    "Rakesh Jhunjhunwala"
  ];

  final Map alldetailsForClubs = {
    "Warren Buffet": {
      "text1":
      "Buy companies at a low price, improve them via management and make long term gains",
      "text2":
      "He has a 30-year-plus track record making on average 20 percent a year.",
      "name": "Warren Buffet",
    },
    "Jim Simons": {
      "text1":
      "Jim Simons, one of the greatest investors of all time, built his market-beating strategy around taking the human element out of investing. He founded Renaissance Technologies, which uses quantitative models underpinned by massive amounts of data to identify and profit from patterns in the market",
      "text2":
      "66% before charging fees—39% after fees—racking up trading gains of more than dollar 100 billion.",
      "name": "Jim Simons",
    },
    "Benjamin Graham": {
      "text1":
      "value investing using fundamental analysis, whereby investors analyze stock data to find assets that have been systematically undervalued.",
      "text2":
      "Graham's investment firm posted annualized returns of about 20% from 1936 to 1956, far outpacing the 12.2% average return for the broader market over that time",
      "name": "Benjamin Graham",
    },
    "Bill Gross": {
      "text1":
      "“King of bonds”- focus on buying individual bonds with a long-term (3-5 year) outlook",
      "text2":
      "Gross’ compounded annual return over the 27 year period was 7.52%, versus 6.44% for the Barclay’s Aggregate US Index.",
      "name": "Bill Gross",
    },
    "John Templeton": {
      "text1":
      "1.Diversification 2.Look for companies globally- best value stocks are those that are most neglected",
      "text2":
      "Templeton’s Growth Fund, created in 1954, went on to earn about a 14% annual return over the next 38 years when he retired in 1992.",
      "name": "John Templeton",
    },
    "Steve Mandel": {
      "text1":
      "He employs fundamental analysis and a bottom-up stock picking approach, meaning he focuses on individual companies instead of global macro trends and economic cycles.",
      "text2":
      "The Hedge Fund 'Lone Pine' has averaged 30% annualized returns since 1997.",
      "name": "Steve Mandel",
    },
    "Peter Lynch": {
      "text1":
      "1.Be 100% sure. 2.It’s impossible to predict the economy and interest rates. 3.Take your time to identify exceptional companies 4.buy good businesses5.Be aware of the risks of your purchase",
      "text2":
      "As the manager of the Magellan Fund at Fidelity Investments between 1977 and 1990, Lynch averaged a 29.2% annual return, consistently more than double the S&P 500 stock market index and making it the best-performing mutual fund in the world.",
      "name": "Peter Lynch",
    },
    "George Soros": {
      "text1":
      "Identify macroeconomic trends Highly leveraged bets on bonds and commodities",
      "text2":
      "Soros Fund Management, LLC is a private American investment management firm. It is currently structured as a family office, but formerly as a hedge fund. The firm was founded in 1969 by George Soros[1] and, in 2010, was reported to be one of the most profitable firms in the hedge fund industry,[2] averaging a 20% annual rate of return over four decades.",
      "name": "George Soros",
    },
    "Lei Zhang": {
      "text1":
      "Lei Zhang is a big believer in value investing, but where he deviates from the traditional value investing philosophy is that he likes investing in changes. He believes that it is change that derives value and he would like to invest in people driving them.",
      "text2":
      "Hillhouse has achieved investment returns of up to 52% annualized from inception in 2005 until 2012, even in spite of a 37% drop in 2008, making Hillhouse among the most profitable funds of its size in the world, and the leading fund in Asia",
      "name": "Lei Zhang",
    },
    "Rakesh Jhunjhunwala": {
      "text1":
      "buy when the share is in uptrend and sell only when the share goes in the downtrend.",
      "text2":
      "In 1985, Jhunjhunwala invested Rs 5,000 (dollar 70) as capital. By September 2018, that capital had inflated to Rs 11,000 crore (dollar 1.5 bn).",
      "name": "Rakesh Jhunjhunwala",
    },
  };

  onInitDisplayBootomSheet() async {
    int showPopupData = await _reusableFunctions.learnMarketplacePagePopupGetData();
    // print("learn marketplace tab popppopop $showPopupData}");
    if (showPopupData == null || showPopupData == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await showDialog(
          context: context,
          builder: (builder) {
            return AlertDialog(
              content: Text(
                "Welcome to Auro’s Adaptive Learning. You will get Questions teaching you investment concepts based on your difficulty level, and allow you to earn Auro Coins, based on which you'll become a member of different investment clubs!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  letterSpacing: 0.8,
                ),
                textAlign: TextAlign.center,
              ),
              backgroundColor: Color(0xff161946),
              actions: [
                FlatButton(
                  child: Text(
                    "OK",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    print("exchange OK pressed");
                    await _reusableFunctions.learnMarketplacePagePopupPressed();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      });
    }
  }


  @override
  void initState() {
    onInitDisplayBootomSheet();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    List<String> snapShotFields = [
      "user_easy_terms",
      "user_intermedate_terms",
      "user_hard_terms",
    ];
    List<ChartData> renderedChartData = [];
    List<ChartData> chartData = [
      ChartData('', 35, Color(0xFFc7ebdf)),
      ChartData('', 38, Color(0xFF008080)),
      ChartData('', 34, Color(0xFFFF8C00)),
    ];

    List<dynamic> inceptionMemberList = <dynamic>[
      {"name": "green", "measure": "741 XP"},
      {"name": "alena", "measure": "716 XP"},
      {"name": "tat 1 anna", "measure": "488 XP"},
      {"name": "kristie", "measure": "413 XP"},
      {"name": "piotr", "measure": "304 XP"},
    ];

    return SingleChildScrollView(
      controller: _scrollController,
      child:
      globals.isGoldBlack ? RetailLeanTab() : Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          // auro stars section
          Visibility(
            visible: globals.isGoldBlack ? false : true,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      padding: const EdgeInsets.only(
                        bottom: 8,
                      ),
                      child: Center(
                        child: Text(
                          "Auro Stars",
                          style: TextStyle(
                              color: AllCoustomTheme.getHeadingThemeColors(),
                              fontSize: ConstanceData.SIZE_TITLE20,
                              fontFamily: "Rosarivo",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
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
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 8.0),
                  child: Container(
                    // margin: EdgeInsets.only(left: 35.0,right: 20.0),
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.07,
                        right: MediaQuery.of(context).size.width * 0.03),
                    child: Text(
                      "Invest in actively managed portfolios created by Auroville Investment Management" +
                          " team of licensed professionals",
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
                AuroStars(),
              ],
            ),
          ),
          //Pvt deals section
          Visibility(
            visible: globals.isGoldBlack ? false : true,
            child: PrivateDealsIntro(
              goToMarketplaceCallback: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PrivateDealsMarketplaceMainPage(),
                  ),
                );
              },
            ),
          ),

          //crypto market place section
          Visibility(
            visible: globals.isGoldBlack ? false : true,
            child: Column(
              children: [
                CryptoMarketplace(),
                GoToMarketplaceButton(
                  buttonColor: AllCoustomTheme.getButtonBoxColor(),
                  textColor: globals.isGoldBlack ? Colors.black : Colors.white,
                  callback: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CryptoCoinsMarketplace(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // public equities section
          Visibility(
            visible: globals.isGoldBlack ? false : true,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      padding: const EdgeInsets.only(
                        bottom: 8,
                      ),
                      child: Center(
                        child: Text(
                          "Listed Company Marketplace",
                          style: TextStyle(
                              color: AllCoustomTheme.getHeadingThemeColors(),
                              fontSize: ConstanceData.SIZE_TITLE20,
                              fontFamily: "Rosarivo",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
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
                  ],
                ),
                PublicCompaniesList(),
                GoToMarketplaceButton(
                  buttonColor: AllCoustomTheme.getButtonBoxColor(),
                  textColor: globals.isGoldBlack ? Colors.black : Colors.white,
                  callback: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PublicCompanyMarketPlace(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // score board section start
          Visibility(
            visible: !globals.isGoldBlack == false ? true : false,
            child: Column(
              children: [
                Container(
                  height: 30,
                  child: Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text(
                      'SCOREBOARD',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AllCoustomTheme.getHeadingThemeColors(),
                        fontSize: ConstanceData.SIZE_TITLE18,
                        fontFamily: "Rosarivo",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.25,
                      right: MediaQuery.of(context).size.width * 0.25),
                  padding: EdgeInsets.only(
                    bottom: 3, // space between underline and text
                  ),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                            color: AllCoustomTheme.getHeadingThemeColors(),
                            width: 1.0, // Underline width
                          ))),
                ),
                SizedBox(
                  height: 4,
                ),
                //donut chart box
                FutureBuilder(
                  future: _featuredCompaniesProvider.getUserCoinsScoreData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      int index = 0;
                      print(snapshot.data);
                      userData = snapshot.data;
                      chartData.forEach((element) {
                        // if (index == 0) {
                        //   print("ignore field");
                        // } else {

                        renderedChartData.add(
                          ChartData(
                            element.x,
                            (snapshot.data[snapShotFields[index]].length - 1)
                                .toDouble(),
                            element.color,
                          ),
                        );
                        index = index + 1;
                        // }
                      });

                      if (snapshot.data["user_score"] == 0) {
                        return Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.10,
                              right: MediaQuery.of(context).size.width * 0.10,
                              top: MediaQuery.of(context).size.height * 0.04,
                              bottom:
                              MediaQuery.of(context).size.height * 0.04),
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Color(0xFF7499C6),
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(2.0),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15.0,
                              ),
                              InkWell(
                                onTap: increaseYourScore,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.28,
                                      right: MediaQuery.of(context).size.width *
                                          0.28),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                    size: 70,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.07,
                                    right: MediaQuery.of(context).size.width *
                                        0.03),
                                child: Text(
                                  "Answer your first question and start earning Auro coins",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: AllCoustomTheme
                                          .getNewSecondTextThemeColor(),
                                      fontSize: 14.5,
                                      fontFamily: "Roboto",
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: 0.2),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              // Container(
                              //   height: MediaQuery.of(context).size.height *
                              //       0.053,
                              //   width:
                              //       MediaQuery.of(context).size.width * 0.40,
                              //   margin: EdgeInsets.only(
                              //       left: MediaQuery.of(context).size.width *
                              //           0.24,
                              //       right: MediaQuery.of(context).size.width *
                              //           0.24),
                              //   decoration: BoxDecoration(
                              //       borderRadius:
                              //           BorderRadius.all(Radius.circular(20)),
                              //       border: new Border.all(
                              //           color: AllCoustomTheme
                              //               .getButtonBoxColor(),
                              //           width: 1.5),
                              //       color:
                              //           AllCoustomTheme.getButtonBoxColor()),
                              //   child: MaterialButton(
                              //     splashColor: Colors.grey,
                              //     child: Text(
                              //       "Earn Coins",
                              //       style: TextStyle(
                              //         color: AllCoustomTheme
                              //             .getButtonTextThemeColors(),
                              //         fontSize: ConstanceData.SIZE_TITLE13,
                              //         fontFamily: "Roboto",
                              //         fontWeight: FontWeight.bold,
                              //       ),
                              //     ),
                              //     onPressed: () async {
                              //       Navigator.of(context).push(
                              //         CupertinoPageRoute(
                              //           builder: (BuildContext context) =>
                              //               PortfolioPitch(),
                              //         ),
                              //       );
                              //     },
                              //   ),
                              // ),
                              SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.30,
                            margin: EdgeInsets.only(left: 15.0, right: 5.0),
                            child: Stack(
                              children: [
                                SfCircularChart(
                                  series: <CircularSeries>[
                                    // Renders doughnut chart
                                    DoughnutSeries<ChartData, String>(
                                      dataSource: renderedChartData,
                                      pointColorMapper: (ChartData data, _) =>
                                      data.color,
                                      xValueMapper: (ChartData data, _) =>
                                      data.x,
                                      yValueMapper: (ChartData data, _) =>
                                      data.y,
                                      dataLabelSettings: DataLabelSettings(
                                        showZeroValue: true,
                                        isVisible: true,
                                        borderColor: Colors.green,
                                      ),
                                    )
                                  ],
                                ),
                                new Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.11),
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Text(
                                              '${snapshot.data["user_score"]}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AllCoustomTheme
                                                    .getTextThemeColor(),
                                                fontSize:
                                                ConstanceData.SIZE_TITLE16,
                                                fontFamily: "Roboto",
                                                package: 'Roboto-Regular',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              'coins',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AllCoustomTheme
                                                    .getTextThemeColor(),
                                                fontSize:
                                                ConstanceData.SIZE_TITLE16,
                                                fontFamily: "Roboto",
                                                package: 'Roboto-Regular',
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                                InkWell(
                                  child: new Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                        height: 30,
                                        width: 70,
                                        margin: EdgeInsets.only(
                                            top: 20.0, bottom: 20.0),
                                        decoration: new BoxDecoration(
                                          // color: Color(0xFF1E90FF),
                                          color: Color(0xFFc7ebdf),
                                          border: Border.all(
                                            // color: Color(0xFF1E90FF),
                                            color: Color(0xFFc7ebdf),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(2.0),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'EASY',
                                            style: TextStyle(
                                              color: AllCoustomTheme
                                                  .getsecoundTextThemeColor(),
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                              ConstanceData.SIZE_TITLE16,
                                              fontFamily: "Roboto",
                                              package: 'Roboto-Regular',
                                            ),
                                          ),
                                        )),
                                  ),
                                  onTap: () {
                                    // goToQuestionTemp();
                                  },
                                ),
                                new Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                      height: 30,
                                      width: 110,
                                      margin: EdgeInsets.only(
                                          top: 20.0, bottom: 20.0),
                                      decoration: new BoxDecoration(
                                        color: Color(0xFF008080),
                                        border: Border.all(
                                          color: Color(0xFF008080),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(2.0),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'INTERMEDIATE',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                            ConstanceData.SIZE_TITLE15,
                                            fontFamily: "Roboto",
                                            package: 'Roboto-Regular',
                                          ),
                                        ),
                                      )),
                                ),
                                new Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    height: 30,
                                    width: 70,
                                    margin: EdgeInsets.only(
                                        top: 60.0, bottom: 40.0),
                                    decoration: new BoxDecoration(
                                      color: Color(0xFFFF8C00),
                                      border: Border.all(
                                        color: Color(0xFFFF8C00),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(2.0),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'HARD',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: ConstanceData.SIZE_TITLE16,
                                          fontFamily: "Roboto",
                                          package: 'Roboto-Regular',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ));
                      }
                    } else {
                      return Container(
                        child: Text("Fetching your Auro Score..."),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            height: 30,
                            decoration: new BoxDecoration(
                              color: AllCoustomTheme.getsecoundTextThemeColor(),
                              border: Border.all(
                                color:
                                AllCoustomTheme.getsecoundTextThemeColor(),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(2.0),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 4.0),
                              child: Text(
                                "Today's progress: 1 concept",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AllCoustomTheme
                                      .getSubHeadingThemeColors(),
                                  fontSize: ConstanceData.SIZE_TITLE16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Roboto",
                                  package: 'Roboto-Regular',
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            // showDialog(
                            //   context: context,
                            //   builder: (context) {
                            //     return AlertDialog(
                            //       content: Container(
                            //         height:
                            //         MediaQuery
                            //             .of(context)
                            //             .size
                            //             .height / 2,
                            //         width:
                            //         MediaQuery
                            //             .of(context)
                            //             .size
                            //             .width - 60,
                            //         child: Container(
                            //           child: ListView.builder(itemBuilder:),
                            //         ),
                            //       ),
                            //     );
                            //   },
                            // );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: increaseYourScore,
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              color: AllCoustomTheme.getSeeMoreThemeColor(),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 5.0),
                              child: Text(
                                'INCREASE YOUR SCORE',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AllCoustomTheme.getTextThemeColor(),
                                  fontSize: ConstanceData.SIZE_TITLE15,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(left:8.0),
                    //   child: Container(
                    //     height: 50,
                    //     width: (MediaQuery.of(context).size.width / 2) - 10,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(5),
                    //       color: AllCoustomTheme.getSeeMoreThemeColor(),
                    //     ),
                    //     child: Center(
                    //       child: Text(
                    //         'SUBSCRIBE',
                    //         textAlign: TextAlign.center,
                    //         style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: ConstanceData.SIZE_TITLE15,
                    //           fontFamily: "Roboto",
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: (MediaQuery.of(context).size.width/2)-40,
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                              border: new Border.all(
                                  color: AllCoustomTheme
                                      .getOtherTabButtonBoxColor(),
                                  width: 1.5),
                            ),
                            child: MaterialButton(
                              splashColor: Colors.grey,
                              child: Text("SUBSCRIBE",
                                  style: AllCoustomTheme
                                      .getOtherTabButtonNonSelectedTextStyleTheme()),
                              onPressed: () async {
                                // Navigator.of(context).push(new MaterialPageRoute(
                                //     builder: (BuildContext context) =>
                                //         new WishList()));
                                Navigator.of(context).push(
                                  // MaterialPageRoute(
                                  //   builder: (BuildContext context) =>
                                  //       InvestorType(),
                                  // ),
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PaymentTypes(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: (MediaQuery.of(context).size.width/2)-40,
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                              border: new Border.all(
                                  color: AllCoustomTheme
                                      .getOtherTabButtonBoxColor(),
                                  width: 1.5),
                            ),
                            child: MaterialButton(
                              splashColor: Colors.grey,
                              child: Text("INVESTMENT MASTERCLASS",
                                  style: AllCoustomTheme
                                      .getOtherTabButtonNonSelectedTextStyleTheme()),
                              onPressed: () async {
                                // Navigator.of(context).push(new MaterialPageRoute(
                                //     builder: (BuildContext context) =>
                                //         new WishList()));
                                Navigator.of(context).push(
                                  // MaterialPageRoute(
                                  //   builder: (BuildContext context) =>
                                  //       InvestorType(),
                                  // ),
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        InvestmentMasterclass(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),

                // Padding(
                //   padding: const EdgeInsets.only(left: 16, right: 5.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: <Widget>[
                //       Expanded(
                //         child: InkWell(
                //           onTap: () => Navigator.of(context).push(
                //             MaterialPageRoute(
                //               builder: (context) => InvestmentMasterclass(),
                //             ),
                //           ),
                //           child: Container(
                //             height: 30,
                //             decoration: BoxDecoration(
                //               color: AllCoustomTheme.getSeeMoreThemeColor(),
                //             ),
                //             child: Padding(
                //               padding: EdgeInsets.only(top: 5.0),
                //               child: Text(
                //                 'INVESTMENT MASTERCLASS',
                //                 textAlign: TextAlign.center,
                //                 style: TextStyle(
                //                   color: Colors.white,
                //                   fontSize: ConstanceData.SIZE_TITLE15,
                //                   fontFamily: "Roboto",
                //                   fontWeight: FontWeight.bold,
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),

          // score board section end

          // investment track record
/*          Padding(
              padding: EdgeInsets.only(top: 0.0),
              child: Center(
                child: Text(
                  'Ankur’s Investment Track Record',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFD8AF4F),
                    fontSize: ConstanceData.SIZE_TITLE18,
                    fontFamily: "Roboto",
                    package: 'Roboto-Regular',
                  ),
                ),
              )),
          Container(
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.10,
                right: MediaQuery.of(context).size.width * 0.10),
            padding: EdgeInsets.only(
              bottom: 3, // space between underline and text
            ),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: AllCoustomTheme.getHeadingThemeColors(),
              width: 1.0, // Underline width
            ))),
          ),
          SizedBox(
            height: 10,
          ),
          //pie chart with tabs
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.65,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (BuildContext context) =>
                                    AuroStrikeBadges(),
                              ),
                            );
                          },
                          child: Container(
                            child: Image(
                              image: AssetImage('assets/buttonBadge.png'),
                              fit: BoxFit.fill,
                              height: 30,
                              width: 40,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Container(
                          child: Image(
                            image: AssetImage('assets/badgeStar.jpg'),
                            fit: BoxFit.fill,
                            height: 30,
                            width: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    margin: EdgeInsets.only(left: 180.0, right: 3.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TabBar(
                          controller: _tabController,
                          isScrollable: true,
                          onTap: (index) {
                            selectedTabIndex = index;
                          },
                          labelColor: AllCoustomTheme.getTextThemeColor(),
                          labelStyle:
                              TextStyle(fontSize: 16.0, letterSpacing: 0.2),
                          indicatorColor: AllCoustomTheme.getTextThemeColor(),
                          indicatorWeight: 4.0,
                          // unselectedLabelColor: StyleTheme.Colors.AppBarTabTextColor,
                          tabs: <Widget>[
                            new Tab(
                              text: "Overall",
                            ),
                            new Tab(text: "Weekly"),
                            new Tab(text: ""),
                            new Tab(text: ""),
                            // new Tab(text: ""),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(top: 10.0),
                      child: new TabBarView(
                        controller: _tabController,
                        children: tabList.map((Tab tab) {
                          return Container(
                            child: Stack(
                              children: [
                                SfCircularChart(
                                    legend: Legend(
                                        isVisible: true,
                                        textStyle: TextStyle(
                                            color: AllCoustomTheme
                                                .getTextThemeColor()),
                                        alignment: ChartAlignment.center,
                                        position: LegendPosition.bottom,
                                        overflowMode:
                                            LegendItemOverflowMode.wrap,
                                        itemPadding: 10.0),
                                    series: <CircularSeries>[
                                      // Render pie chart
                                      DoughnutSeries<ChartData, String>(
                                        dataSource: trackChartData,
                                        pointColorMapper: (ChartData data, _) =>
                                            data.color,
                                        xValueMapper: (ChartData data, _) =>
                                            data.x,
                                        yValueMapper: (ChartData data, _) =>
                                            data.y,
                                        dataLabelSettings: DataLabelSettings(
                                          isVisible: true,
                                        ),
                                      )
                                    ]),
                                new Align(
                                    alignment: Alignment.topCenter,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          CupertinoPageRoute(
                                            builder: (BuildContext context) =>
                                                InvestedAssetModule(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        // margin: EdgeInsets.only(top:115),
                                        margin: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.18),
                                        child: Column(
                                          children: [
                                            Center(
                                              child: Text(
                                                '800',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: AllCoustomTheme
                                                      .getTextThemeColor(),
                                                  fontSize: ConstanceData
                                                      .SIZE_TITLE16,
                                                  fontFamily: "Roboto",
                                                  package: 'Roboto-Regular',
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Text(
                                                'coins',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: AllCoustomTheme
                                                      .getTextThemeColor(),
                                                  fontSize: ConstanceData
                                                      .SIZE_TITLE16,
                                                  fontFamily: "Roboto",
                                                  package: 'Roboto-Regular',
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          );
                        }).toList(),
                        physics: ScrollPhysics(),
                      ),
                    ),
                  ),
                ],
              )),
          // inception to data league
          SizedBox(
            height: 20,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 16, right: 5.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                child: ListView(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Inception-To-Date League',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFD8AF4F),
                              fontSize: ConstanceData.SIZE_TITLE18,
                              fontFamily: "Roboto",
                              package: 'Roboto-Regular',
                            ),
                          ),
                        )),
                    Container(
                      // margin: EdgeInsets.only(right: 130.0),
                      margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.28),

                      padding: EdgeInsets.only(
                        bottom: 3, // space between underline and text
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: AllCoustomTheme.getHeadingThemeColors(),
                        width: 1.0, // Underline width
                      ))),
                    ),
                  ],
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 13, right: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 160,
                ),
                Expanded(child: new FormField(
                  builder: (FormFieldState state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueGrey, width: 1.0),
                        ),
                        labelStyle:
                            AllCoustomTheme.getDropDownFieldLabelStyleTheme(),
                        errorText: state.hasError ? state.errorText : null,
                      ),
                      isEmpty: selectedInceptionLeague == '',
                      child: new DropdownButtonHideUnderline(
                          child: ButtonTheme(
                        alignedDropdown: true,
                        child: Container(
                          height: 16.0,
                          child: new DropdownButton(
                            value: selectedInceptionLeague,
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            onChanged: (String newValue) {
                              setState(() {
                                selectedInceptionLeague = newValue;
                              });
                            },
                            items: <String>[
                              'Total Coins',
                              'Invest Edu coins',
                              'Track Record coins',
                              'Stock Pitch coins',
                              'Invest Q&A coins',
                              'Social Invest coins'
                            ].map((String value) {
                              return new DropdownMenuItem(
                                value: value,
                                child: new Text(value,
                                    style: AllCoustomTheme
                                        .getDropDownMenuItemStyleTheme()),
                              );
                            }).toList(),
                          ),
                        ),
                      )),
                    );
                  },
                )),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13, right: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: Scrollbar(
                        child: getInceptionMemberView(inceptionMemberList),
                      )),
                ),
              ],
            ),
          ),*/
          //Auro Streak section start
          Visibility(
              visible: !globals.isGoldBlack == false ? true : false,
              child: Column(
                children: [
                  // weekly auro strike
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 16, right: 5.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: ListView(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(top: 5.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Weekly Auro Streak',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFFD8AF4F),
                                      fontSize: ConstanceData.SIZE_TITLE18,
                                      fontFamily: "Roboto",
                                      package: 'Roboto-Regular',
                                    ),
                                  ),
                                )),
                            Container(
                              margin: EdgeInsets.only(
                                  right:
                                  MediaQuery.of(context).size.width * 0.42),
                              padding: EdgeInsets.only(
                                bottom: 3, // space between underline and text
                              ),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                        color: AllCoustomTheme.getHeadingThemeColors(),
                                        width: 1.0, // Underline width
                                      ))),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13, right: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.10,
                            child: Scrollbar(
                              child: ListView.builder(
                                itemCount: names.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {

                                      Navigator.of(context).push(
                                        CupertinoPageRoute(
                                          builder: (BuildContext context) =>
                                              ClubDetail(
                                                  allField: alldetailsForClubs[
                                                  names[index]]),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Stack(
                                            alignment: Alignment.topLeft,
                                            children: <Widget>[
                                              CircleAvatar(
                                                radius: 25.0,
                                                backgroundImage: index == 0
                                                    ? new AssetImage(
                                                    'assets/filledweeklyAuroBadge.png')
                                                    : new AssetImage(
                                                    'assets/weeklyAuroBadge.png'),
                                                backgroundColor:
                                                Colors.transparent,
                                              ),
                                              Positioned(
                                                bottom: 25,
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.blue,
                                                  radius: 12.0,
                                                  child: Text(
                                                    "${index + 1}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Color(0xFFD8AF4F),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE18,
                                                      fontFamily: "Roboto",
                                                      package: 'Roboto-Regular',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              /*                                          FractionalTranslation(
                                              translation: Offset(0.0, -0.99),
                                              child: CircleAvatar(
                                                backgroundColor: Colors.blue,
                                                radius: 12.0,
                                                child: Text(
                                                  "${index + 1}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xFFD8AF4F),
                                                    fontSize: ConstanceData.SIZE_TITLE18,
                                                    fontFamily: "Roboto",
                                                    package: 'Roboto-Regular',
                                                  ),
                                                ),
                                              ),
                                            )*/
                                            ],
                                          ),
                                          SizedBox(
                                            width: 10,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //weekly league
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 16, right: 5.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: ListView(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 5.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Weekly League',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFFD8AF4F),
                                    fontSize: ConstanceData.SIZE_TITLE18,
                                    fontFamily: "Roboto",
                                    package: 'Roboto-Regular',
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              // margin: EdgeInsets.only(right: 210.0),
                              margin: EdgeInsets.only(
                                  right:
                                  MediaQuery.of(context).size.width * 0.55),
                              padding: EdgeInsets.only(
                                bottom: 3, // space between underline and text
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color:
                                    AllCoustomTheme.getHeadingThemeColors(),
                                    width: 1.0, // Underline width
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 13, right: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 110,
                        ),
                        Expanded(
                          child: new FormField(
                            builder: (FormFieldState state) {
                              return InputDecorator(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blueGrey, width: 1.0),
                                  ),
                                  labelStyle: AllCoustomTheme
                                      .getDropDownFieldLabelStyleTheme(),
                                  errorText:
                                  state.hasError ? state.errorText : null,
                                ),
                                isEmpty: selectedWeeklyLeague == '',
                                child: new DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: Container(
                                      height: 16.0,
                                      child: new DropdownButton(
                                        value: selectedWeeklyLeague,
                                        dropdownColor: Colors.white,
                                        isExpanded: true,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            selectedWeeklyLeague = newValue;
                                          });
                                        },
                                        items: <String>[
                                          'Adaptive Investment Learning',
                                          'Investment Track Record',
                                          'Investment Stock Pitch',
                                          'Investment QnA',
                                          'Social Investment Score'
                                        ].map((String value) {
                                          return new DropdownMenuItem(
                                            value: value,
                                            child: new Text(value,
                                                style: AllCoustomTheme
                                                    .getDropDownMenuItemStyleTheme()),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13, right: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.35,
                            child: Scrollbar(
                              child: getWeeklyLeagueMemberView(
                                  inceptionMemberList),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          //Auro Streak section end

          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Widget getWeeklyLeagueMemberView(data) {
    return new ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Card(
          // color: AllCoustomTheme.getsecoundTextThemeColor(),
          child: ListTile(
              leading: CircleAvatar(
                radius: 15.0,
                backgroundImage: new AssetImage('assets/download.jpeg'),
                backgroundColor: Colors.transparent,
              ),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
/*                  Text(
                    "${index+1}",
                    style: new TextStyle(
                      color: AllCoustomTheme.getTextThemeColors(),
                      fontSize: ConstanceData.SIZE_TITLE16,
                    ),
                  ),
                  CircleAvatar(
                    radius: 15.0,
                    backgroundImage: new AssetImage('assets/download.jpeg'),
                    backgroundColor: Colors.transparent,
                  ),*/
                  Text(
                    titleCase(data[index]['name']),
                    style: new TextStyle(
                      color: AllCoustomTheme.getTextThemeColor(),
                      fontSize: ConstanceData.SIZE_TITLE16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Image(
                      image: AssetImage('assets/buttonBadge.png'),
                      fit: BoxFit.fill,
                      height: 30,
                      width: 30,
                    ),
                  ),
                ],
              ),
              onTap: () {}),
        );
      },
    );
  }

  increaseYourScore() async {
    HelperClass.showLoading(context, null,false);
    Question questions = await getQuestions();
    if (questions == null) {
      Navigator.pop(context);
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (_) => ErrorPage(
                message: "There are not enough questions yet.",
              )));
      return;
    }
    Navigator.pop(context);
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (BuildContext context) =>
            QuestionTemplate(questions: questions),
      ),
    );
  }

  /// Inefficient way of capitalizing each word in a string.
  String titleCase(String text) {
    if (text.length <= 1) return text.toUpperCase();
    var words = text.split(' ');
    var capitalized = words.map((word) {
      var first = word.substring(0, 1).toUpperCase();
      var rest = word.substring(1);
      return '$first$rest';
    });
    return capitalized.join(' ');
  }
}
