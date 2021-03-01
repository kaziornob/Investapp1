import 'package:auroim/modules/socialInvestRelatedPages/clubDetail.dart';
import 'package:auroim/modules/socialInvestRelatedPages/InvestedAssetModule.dart';
import 'package:auroim/modules/questionAndAnswerModule/ui/pages/error.dart';
import 'package:auroim/modules/questionAndAnswerModule/ui/pages/questionTemplate.dart';
import 'package:auroim/modules/socialInvestRelatedPages/auroStrikeBadges.dart';
import 'package:auroim/modules/questionAndAnswerModule/models/question.dart';
import 'package:auroim/modules/questionAndAnswerModule/resources/question_api_provider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PrivateDealsGraphs extends StatefulWidget {
  @override
  _PrivateDealsGraphsState createState() => _PrivateDealsGraphsState();
}

class _PrivateDealsGraphsState extends State<PrivateDealsGraphs> with SingleTickerProviderStateMixin {
  TabController _tabController;
  String selectedInceptionLeague;
  String selectedWeeklyLeague;

  final List<Tab> tabList = <Tab>[
    new Tab(text: 'Recommended'),
    new Tab(text: 'Trending'),
    new Tab(text: "Week"),
    new Tab(text: "Month"),
    // new Tab(text: "Ask Question"),
  ];

  final List<Tab> socialFilterTabList = <Tab>[
    new Tab(text: 'Overall'),
    new Tab(text: 'Weekly'),
  ];

  int selectedTabIndex;

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: tabList.length);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return fifthScreen();
  }

  Widget fifthScreen() {
    final List<ChartData> chartData = [
      ChartData('David', 35, Color(0xFFFF8C00)),
      ChartData('Steve', 38, Color(0xFF008080)),
      ChartData('Jack', 34, Color(0xFFc7ebdf)),
    ];

    final List<ChartData> trackChartData = [
      ChartData('Total', 35, Color(0xFFFF8C00)),
      ChartData('Invest Edu', 38, Color(0xFF008080)),
      ChartData('Track Record', 34, Color(0xFFc7ebdf)),
      ChartData('Stock Pitch', 38, Color(0xFFe70b31)),
      ChartData('Invest Q&A', 38, Color(0xFFfec20f)),
      ChartData('Social Invest', 38, Color(0xFFCD853F)),
    ];

    List<dynamic> inceptionMemberList = <dynamic>[
      {"name": "green", "measure": "741 XP"},
      {"name": "alena", "measure": "716 XP"},
      {"name": "tat 1 anna", "measure": "488 XP"},
      {"name": "kristie", "measure": "413 XP"},
      {"name": "piotr", "measure": "304 XP"},
    ];

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
              height: 30,
/*                    decoration: BoxDecoration(
                      color: AllCoustomTheme.getReBlackAndWhiteThemeColors(),
                    ),*/
              child: Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  'SCOREBOARD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AllCoustomTheme.getHeadingThemeColors(),
                    fontSize: ConstanceData.SIZE_TITLE18,
                    fontFamily: "Rosarivo",
                  ),
                ),
              )),
          Container(
            // margin: EdgeInsets.only(left: 110.0,right: 110.0),
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
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.30,
              margin: EdgeInsets.only(left: 15.0, right: 5.0),
              /*decoration: new BoxDecoration(
                color: AllCoustomTheme.getTextThemeColors(),
                border: Border.all(
                  color: AllCoustomTheme.getTextThemeColors(),
                  width: 1,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(2.0),
                ),
              ),*/
              child: Stack(
                children: [
                  SfCircularChart(series: <CircularSeries>[
                    // Renders doughnut chart
                    DoughnutSeries<ChartData, String>(
                        dataSource: chartData,
                        pointColorMapper: (ChartData data, _) => data.color,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y)
                  ]),
                  new Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.11),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                '150',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AllCoustomTheme.getTextThemeColor(),
                                  fontSize: ConstanceData.SIZE_TITLE16,
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
                                  color: AllCoustomTheme.getTextThemeColor(),
                                  fontSize: ConstanceData.SIZE_TITLE16,
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
                          margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
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
                                color:
                                AllCoustomTheme.getsecoundTextThemeColor(),
                                fontSize: ConstanceData.SIZE_TITLE16,
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
                        margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
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
                              color: AllCoustomTheme.getsecoundTextThemeColor(),
                              fontSize: ConstanceData.SIZE_TITLE15,
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
                        margin: EdgeInsets.only(top: 60.0, bottom: 40.0),
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
                              color: AllCoustomTheme.getsecoundTextThemeColor(),
                              fontSize: ConstanceData.SIZE_TITLE16,
                              fontFamily: "Roboto",
                              package: 'Roboto-Regular',
                            ),
                          ),
                        )),
                  )
                ],
              )),
          SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                      height: 30,
                      decoration: new BoxDecoration(
                        // color: Color(0xFF1E90FF),
                        color: AllCoustomTheme.getsecoundTextThemeColor(),
                        border: Border.all(
                          // color: Color(0xFF1E90FF),
                          color: AllCoustomTheme.getsecoundTextThemeColor(),
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
                            color: AllCoustomTheme.getSubHeadingThemeColors(),
                            fontSize: ConstanceData.SIZE_TITLE16,
                            fontFamily: "Roboto",
                            package: 'Roboto-Regular',
                          ),
                        ),
                      )),
                ),
              ],
            ),
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
                    child: InkWell(
                      onTap: () async {
                        Question questions = await getQuestions();
                        if (questions!=null) {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (_) => ErrorPage(
                                message: "There are not enough questions yet.",
                              )));
                          return;
                        }
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (BuildContext context) =>
                                QuestionTemplate(questions: questions),
                          ),
                        );
                      },
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
                              ),
                            ),
                          )),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Padding(
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
                                                0.16),
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
          ),
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
                      // margin: EdgeInsets.only(right: 180.0),
                      margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.42),
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
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () {
                                  var tempField = {
                                    "rankingNum": "1",
                                    "name": "Warren Buffet",
                                    "philosophy":
                                    "Buy companies at a low price, improve them via management and make long term gains",
                                    "trackRecord":
                                    "He has a 30-year-plus track record making on average 20 percent a year",
                                    "image": "WarrenBuffet"
                                  };
                                  print("tempfield: $tempField");
                                  Navigator.of(context).push(
                                    CupertinoPageRoute(
                                      builder: (BuildContext context) =>
                                          ClubDetail(allField: tempField),
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
                                              backgroundColor: Colors.transparent,
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
                                                    fontSize:
                                                    ConstanceData.SIZE_TITLE18,
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
                                    )));
                          },
                        ),
                      )),
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
                        )),
                    Container(
                      // margin: EdgeInsets.only(right: 210.0),
                      margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.55),
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
                  width: 110,
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
                        child: getWeeklyLeagueMemberView(inceptionMemberList),
                      )),
                ),
              ],
            ),
          ),
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


  Widget getInceptionMemberView(data) {
    return new ListView.builder(
      itemCount: data.length,
      // physics: NeverScrollableScrollPhysics(),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    titleCase(data[index]['name']),
                    style: new TextStyle(
                      color: AllCoustomTheme.getTextThemeColor(),
                      fontSize: ConstanceData.SIZE_TITLE16,
                      fontFamily: "Roboto",
                      package: 'Roboto-Regular',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
/*                    child: Icon(
                      Icons.badge,
                      color: Colors.yellow,
                    ),*/
                    child: Image(
                      image: AssetImage('assets/buttonBadge.png'),
                      fit: BoxFit.fill,
                      height: 30,
                      width: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Image(
                      image: AssetImage('assets/badgeStar.jpg'),
                      fit: BoxFit.fill,
                      height: 30,
                      width: 40,
                    ),
                  ),
                ],
              ),
              onTap: () {}),
        );
      },
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
