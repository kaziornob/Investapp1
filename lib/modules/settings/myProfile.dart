import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/modules/settings/show_list_of_following.dart';
import 'package:auroim/provider_abhinav/user_details.dart';

import 'package:auroim/widgets/myProfile/Qus_ans.dart';
import 'package:auroim/widgets/myProfile/live_paper_portfolio.dart';
import 'package:auroim/widgets/myProfile/profile_background.dart';
import 'package:auroim/widgets/myProfile/stockPitches.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile>
    with SingleTickerProviderStateMixin {
  int selectedTabIndex;
  String selectedInceptionLeague;
  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();

  final List<Tab> tabList = <Tab>[
    new Tab(text: 'Overall'),
    new Tab(text: 'Weekly'),
  ];
  String badgeImagePath = "";
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabList.length);
  }

  Widget getInceptionMemberView(data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/user_outline.png'),
              radius: 20,
              backgroundColor: Colors.white,
              onBackgroundImageError: (err, stack) {
                print(err.toString());
              },
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  titleCase(data[index]['name']),
                  style: TextStyle(
                    color: AllCoustomTheme.getTextThemeColor(),
                    fontSize: ConstanceData.SIZE_TITLE16,
                    fontFamily: "Roboto",
                    package: 'Roboto-Regular',
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
            onTap: () {},
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

    AppBar appBar = AppBar();
    double appBarheight = appBar.preferredSize.height;
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: AllCoustomTheme.getBodyContainerThemeColor(),
          body: ModalProgressHUD(
            inAsyncCall: false,
            opacity: 0,
            progressIndicator: CupertinoActivityIndicator(
              radius: 12,
            ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: appBarheight,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: AllCoustomTheme.getTextThemeColor(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 0.0),
                    child: Center(
                      child: Text(
                        "Your Investment Track Record",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: ConstanceData.SIZE_TITLE18,
                          fontFamily: "Roboto",
                          package: 'Roboto-Regular',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //pie chart with tabs
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
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
                                labelStyle: TextStyle(
                                    fontSize: 16.0, letterSpacing: 0.2),
                                indicatorColor:
                                    AllCoustomTheme.getTextThemeColor(),
                                indicatorWeight: 4.0,
                                // unselectedLabelColor: StyleTheme.Colors.AppBarTabTextColor,
                                tabs: <Widget>[
                                  Tab(
                                    text: "Overall",
                                  ),
                                  Tab(text: "Weekly"),
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
                                                .getTextThemeColor(),
                                          ),
                                          legendItemBuilder:
                                              (name, series, point, index) {
                                            DoughnutSeriesRenderer ss = series;
                                            ChartPoint<dynamic> dd = point;
                                            return Container(
                                              padding: EdgeInsets.all(1.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  CircleAvatar(
                                                    radius: 8,
                                                    backgroundColor: dd.color,
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 8.0,
                                                      right: 8.0,
                                                    ),
                                                    child: Text(
                                                      name,
                                                      style: TextStyle(
                                                        color: Colors.grey[800],
                                                        fontFamily: "Ubuntu",
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          alignment: ChartAlignment.center,
                                          position: LegendPosition.bottom,
                                          overflowMode:
                                              LegendItemOverflowMode.wrap,
                                        ),
                                        annotations: <CircularChartAnnotation>[
                                          CircularChartAnnotation(
                                            widget: Container(
                                              child: PhysicalModel(
                                                child: Container(
                                                  height: 100,
                                                  width: 100,
                                                ),
                                                shape: BoxShape.circle,
                                                elevation: 10,
                                                shadowColor: Colors.black,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          CircularChartAnnotation(
                                            widget: Image.asset(
                                              "assets/full_globe.png",
                                              width: 70,
                                              height: 70,
                                            ),
                                          )
                                        ],
                                        series: <CircularSeries>[
                                          // Render pie chart
                                          DoughnutSeries<ChartData, String>(
                                            strokeWidth: 5,
                                            cornerStyle: CornerStyle.bothCurve,
                                            radius: "100%",
                                            innerRadius: "80%",
                                            dataSource: trackChartData,
                                            pointColorMapper:
                                                (ChartData data, _) =>
                                                    data.color,
                                            xValueMapper: (ChartData data, _) =>
                                                data.x,
                                            yValueMapper: (ChartData data, _) =>
                                                data.y,
                                            dataLabelSettings:
                                                DataLabelSettings(
                                              isVisible: true,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              physics: ScrollPhysics(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // inception to data league
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                    child: Container(
                      child: Text(
                        'Inception-To-Date League',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: ConstanceData.SIZE_TITLE18,
                          fontFamily: "Roboto",
                          package: 'Roboto-Regular',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 20,
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: Scrollbar(
                          child: getInceptionMemberView(inceptionMemberList),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  LivePaperPortfolio(
                    email:
                        Provider.of<UserDetails>(context).userDetails["email"],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  StockPitches(
                    email:
                        Provider.of<UserDetails>(context).userDetails["email"],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  QusAns(),
                  SizedBox(
                    height: 5,
                  ),
                  ShowListOfFollowing(
                    text: "Listed Companies You Follow",
                    type: "listed",
                  ),
                  ShowListOfFollowing(
                    text: "Private Companies You Follow",
                    type: "private",
                  ),
                  ShowListOfFollowing(
                    text: "Crypto You Follow",
                    type: "crypto",
                  ),
                  ShowListOfFollowing(
                    text: "Investors You Follow",
                    type: "user",
                    getOtherUserData: false,
                  ),
                  ProfileBackground(),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
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
