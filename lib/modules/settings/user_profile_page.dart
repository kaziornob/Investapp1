import 'package:animator/animator.dart';
import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/modules/settings/show_list_of_following.dart';
import 'package:auroim/provider_abhinav/follow_provider.dart';
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

class UserProfilePage extends StatefulWidget {
  final email;

  const UserProfilePage({
    Key key,
    this.email,
  }) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>
    with SingleTickerProviderStateMixin {
  int selectedTabIndex;
  String selectedInceptionLeague;
  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();
  var userDetails;
  bool _isInit = true;

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
                  // Consumer<UserDetails>(
                  //   builder: (context,userDetailsProvider,_){
                  //     print(userDetailsProvider.userBadge);
                  //     switch(userDetailsProvider.userBadge){
                  //       case "Challenger":
                  //         badgeImagePath = "assets/challenger_badge.png";
                  //         break;
                  //       case "Trusted User":
                  //         badgeImagePath = "assets/trusted_user_badge.png";
                  //         break;
                  //       case "Guru":
                  //         badgeImagePath = "assets/trusted_user_badge.png";
                  //         break;
                  //       case "Wolf of Wall Street":
                  //         badgeImagePath = "assets/trusted_user_badge.png";
                  //         break;
                  //       default:
                  //         badgeImagePath = 'assets/buttonBadge.png';
                  //
                  //
                  //     }
                  //     return Image(
                  //       image: AssetImage(badgeImagePath),
                  //       fit: BoxFit.fill,
                  //       height: 30,
                  //       width: 30,
                  //     );
                  //   },
                  // ),

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

  getUserDetails() async {
    userDetails =
        await _featuredCompaniesProvider.getUserDetailsByUserId(widget.email);
    return userDetails;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {}
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<UserDetails>(context, listen: false).setUserBadge();
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
    return SafeArea(
      child: FutureBuilder(
        future: getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Provider.of<FollowProvider>(context, listen: false)
                .getFollowingForSingleItem(
                    Provider.of<UserDetails>(context, listen: false)
                        .userDetails["email"],
                    "user",
                    userDetails["email"]);
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Consumer<FollowProvider>(
                                  builder: (context, followProvider, _) {
                                    var isFollowing = false;
                                    if (followProvider.mapOfFollowingInvestors[
                                            userDetails["email"]] !=
                                        null) {
                                      isFollowing = followProvider
                                              .mapOfFollowingInvestors[
                                          userDetails["email"]];
                                    }
                                    return GestureDetector(
                                      onTap: () => onPressedFollow(isFollowing),
                                      child: Container(
                                        height: 40,
                                        margin: EdgeInsets.only(
                                            top: 3.0, right: 10),
                                        width: 120,
                                        decoration: new BoxDecoration(
                                          border: Border.all(
                                            color: Color(0xff90AADC),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8.0),
                                          ),
                                          color: Color(0xff90AADC),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              isFollowing
                                                  ? "Unfollow"
                                                  : 'Follow',
                                              style: new TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 18.0,
                                                letterSpacing: 0.2,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Animator(
                                  tween: Tween<Offset>(
                                      begin: Offset(0, 0), end: Offset(0.2, 0)),
                                  duration: Duration(milliseconds: 500),
                                  cycles: 0,
                                  builder: (anim) => FractionalTranslation(
                                    translation: anim.value,
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color:
                                          AllCoustomTheme.getTextThemeColor(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 0.0),
                              child: Center(
                                child: Text(
                                  userDetails != null &&
                                          userDetails["f_name"] != null
                                      ? '${userDetails["f_name"]}\'s Investment Track Record'
                                      : "Investment Track Record",
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
                                right:
                                    MediaQuery.of(context).size.width * 0.10),
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
                          SizedBox(
                            height: 20,
                          ),
                          //pie chart with tabs
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.65,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 5.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // GestureDetector(
                                        //   onTap: () {
                                        //     Navigator.of(context).push(
                                        //       CupertinoPageRoute(
                                        //         builder: (BuildContext context) =>
                                        //             AuroStrikeBadges(),
                                        //       ),
                                        //     );
                                        //   },
                                        //   child: Container(
                                        //     child: Image(
                                        //       image:
                                        //           AssetImage('assets/buttonBadge.png'),
                                        //       fit: BoxFit.fill,
                                        //       height: 30,
                                        //       width: 40,
                                        //     ),
                                        //   ),
                                        // ),
                                        SizedBox(
                                          width: 18,
                                        ),
                                        // FutureBuilder(
                                        //   future: Provider.of<UserDetails>(context)
                                        //       .getUserBadge(),
                                        //   builder: (context, snapshot) {
                                        //     if (snapshot.hasData) {
                                        //       print("badge data got");
                                        //       print(snapshot.data);
                                        //       switch (snapshot.data) {
                                        //         case "Challenger":
                                        //           badgeImagePath =
                                        //               "assets/challenger_badge.png";
                                        //           break;
                                        //         case "Trusted User":
                                        //           badgeImagePath =
                                        //               "assets/trusted_user_badge.png";
                                        //           break;
                                        //         case "Guru":
                                        //           badgeImagePath =
                                        //               "assets/guru_badge.png";
                                        //           break;
                                        //         case "Wolf of Wall Street":
                                        //           badgeImagePath =
                                        //               "assets/wolf_of_wall_street_badge.png";
                                        //           break;
                                        //         default:
                                        //           badgeImagePath =
                                        //               'assets/buttonBadge.png';
                                        //       }
                                        //       return Image(
                                        //         image: AssetImage(badgeImagePath),
                                        //         fit: BoxFit.fill,
                                        //         height: 50,
                                        //         width: 50,
                                        //       );
                                        //     } else {
                                        //       print("No badge data");
                                        //       return SizedBox();
                                        //     }
                                        //   },
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    margin: EdgeInsets.only(
                                        left: 180.0, right: 3.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        TabBar(
                                          controller: _tabController,
                                          isScrollable: true,
                                          onTap: (index) {
                                            selectedTabIndex = index;
                                          },
                                          labelColor: AllCoustomTheme
                                              .getTextThemeColor(),
                                          labelStyle: TextStyle(
                                              fontSize: 16.0,
                                              letterSpacing: 0.2),
                                          indicatorColor: AllCoustomTheme
                                              .getTextThemeColor(),
                                          indicatorWeight: 4.0,
                                          // unselectedLabelColor: StyleTheme.Colors.AppBarTabTextColor,
                                          tabs: <Widget>[
                                            new Tab(
                                              text: "Overall",
                                            ),
                                            new Tab(text: "Weekly"),
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
                                                        alignment:
                                                            ChartAlignment
                                                                .center,
                                                        position: LegendPosition
                                                            .bottom,
                                                        overflowMode:
                                                            LegendItemOverflowMode
                                                                .wrap,
                                                        itemPadding: 10.0),
                                                    series: <CircularSeries>[
                                                      // Render pie chart
                                                      DoughnutSeries<ChartData,
                                                          String>(
                                                        dataSource:
                                                            trackChartData,
                                                        pointColorMapper:
                                                            (ChartData data,
                                                                    _) =>
                                                                data.color,
                                                        xValueMapper:
                                                            (ChartData data,
                                                                    _) =>
                                                                data.x,
                                                        yValueMapper:
                                                            (ChartData data,
                                                                    _) =>
                                                                data.y,
                                                        dataLabelSettings:
                                                            DataLabelSettings(
                                                          isVisible: true,
                                                        ),
                                                      )
                                                    ]),
                                                new Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Column(
                                                    children: [
                                                      // FutureBuilder(
                                                      //   future:
                                                      //       _featuredCompaniesProvider
                                                      //           .getUserCoinsScoreData(),
                                                      //   builder: (context, snapshot) {
                                                      //     if (snapshot.hasData) {
                                                      //       return Container(
                                                      //         // margin: EdgeInsets.only(top:115),
                                                      //         margin: EdgeInsets.only(
                                                      //           top: MediaQuery.of(
                                                      //                       context)
                                                      //                   .size
                                                      //                   .height *
                                                      //               0.18,
                                                      //         ),
                                                      //         child: Column(
                                                      //           children: [
                                                      //             Center(
                                                      //               child: Text(
                                                      //                 "${snapshot.data["user_score"]}",
                                                      //                 textAlign:
                                                      //                     TextAlign
                                                      //                         .center,
                                                      //                 style: TextStyle(
                                                      //                   color: AllCoustomTheme
                                                      //                       .getSeeMoreThemeColor(),
                                                      //                   fontSize:
                                                      //                       ConstanceData
                                                      //                           .SIZE_TITLE16,
                                                      //                   fontFamily:
                                                      //                       "Roboto",
                                                      //                   package:
                                                      //                       'Roboto-Regular',
                                                      //                 ),
                                                      //               ),
                                                      //             ),
                                                      //             Center(
                                                      //               child: Text(
                                                      //                 'coins',
                                                      //                 textAlign:
                                                      //                     TextAlign
                                                      //                         .center,
                                                      //                 style: TextStyle(
                                                      //                   color: AllCoustomTheme
                                                      //                       .getSeeMoreThemeColor(),
                                                      //                   fontSize:
                                                      //                       ConstanceData
                                                      //                           .SIZE_TITLE16,
                                                      //                   fontFamily:
                                                      //                       "Roboto",
                                                      //                   package:
                                                      //                       'Roboto-Regular',
                                                      //                 ),
                                                      //               ),
                                                      //             )
                                                      //           ],
                                                      //         ),
                                                      //       );
                                                      //     } else {
                                                      //       return Container(
                                                      //         // margin: EdgeInsets.only(top:115),
                                                      //         margin: EdgeInsets.only(
                                                      //           top: MediaQuery.of(
                                                      //                       context)
                                                      //                   .size
                                                      //                   .height *
                                                      //               0.18,
                                                      //         ),
                                                      //         child: Column(
                                                      //           children: [
                                                      //             Center(
                                                      //               child: Text(
                                                      //                 '0',
                                                      //                 textAlign:
                                                      //                     TextAlign
                                                      //                         .center,
                                                      //                 style: TextStyle(
                                                      //                   color: AllCoustomTheme
                                                      //                       .getSeeMoreThemeColor(),
                                                      //                   fontSize:
                                                      //                       ConstanceData
                                                      //                           .SIZE_TITLE16,
                                                      //                   fontFamily:
                                                      //                       "Roboto",
                                                      //                   package:
                                                      //                       'Roboto-Regular',
                                                      //                 ),
                                                      //               ),
                                                      //             ),
                                                      //             Center(
                                                      //               child: Text(
                                                      //                 'coins',
                                                      //                 textAlign:
                                                      //                     TextAlign
                                                      //                         .center,
                                                      //                 style: TextStyle(
                                                      //                   color: AllCoustomTheme
                                                      //                       .getSeeMoreThemeColor(),
                                                      //                   fontSize:
                                                      //                       ConstanceData
                                                      //                           .SIZE_TITLE16,
                                                      //                   fontFamily:
                                                      //                       "Roboto",
                                                      //                   package:
                                                      //                       'Roboto-Regular',
                                                      //                 ),
                                                      //               ),
                                                      //             )
                                                      //           ],
                                                      //         ),
                                                      //       );
                                                      //     }
                                                      //   },
                                                      // ),
                                                      // IconButton(
                                                      //   icon: Icon(
                                                      //     Icons.help,
                                                      //     color:
                                                      //         Color(0xff5A56B9),
                                                      //   ),
                                                      //   onPressed: () {
                                                      //     Navigator.of(context)
                                                      //         .push(
                                                      //       CupertinoPageRoute(
                                                      //         builder: (BuildContext
                                                      //                 context) =>
                                                      //             InvestedAssetModule(),
                                                      //       ),
                                                      //     );
                                                      //   },
                                                      // ),
                                                    ],
                                                  ),
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
                              )),
                          // inception to data league
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 5.0),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.09,
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
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE18,
                                              fontFamily: "Roboto",
                                              package: 'Roboto-Regular',
                                            ),
                                          ),
                                        )),
                                    Container(
                                      // margin: EdgeInsets.only(right: 130.0),
                                      margin: EdgeInsets.only(
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.28),

                                      padding: EdgeInsets.only(
                                        bottom:
                                            3, // space between underline and text
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                        color: AllCoustomTheme
                                            .getHeadingThemeColors(),
                                        width: 1.0, // Underline width
                                      ))),
                                    ),
                                  ],
                                ),
                              )),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 13, right: 5.0),
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
                                          borderSide: BorderSide(
                                              color: Colors.blueGrey,
                                              width: 1.0),
                                        ),
                                        labelStyle: AllCoustomTheme
                                            .getDropDownFieldLabelStyleTheme(),
                                        errorText: state.hasError
                                            ? state.errorText
                                            : null,
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
                                                selectedInceptionLeague =
                                                    newValue;
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
                            padding:
                                const EdgeInsets.only(left: 13, right: 5.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.35,
                                    child: Scrollbar(
                                      child: getInceptionMemberView(
                                          inceptionMemberList),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          LivePaperPortfolio(
                            userName: userDetails["username"],
                            email: userDetails["email"],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          StockPitches(
                            userName: userDetails["username"],
                            email: userDetails["email"],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          QusAns(
                            userName: userDetails["username"],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ShowListOfFollowing(
                            text: "Listed Companies You Follow",
                            type: "listed",
                            getOtherUserData: true,
                            otherUserEmail: userDetails["email"],
                          ),
                          ShowListOfFollowing(
                            text: "Private Companies You Follow",
                            type: "private",
                            getOtherUserData: true,
                            otherUserEmail: userDetails["email"],
                          ),
                          ShowListOfFollowing(
                            text: "Crypto You Follow",
                            type: "crypto",
                            getOtherUserData: true,
                            otherUserEmail: userDetails["email"],
                          ),
                          ShowListOfFollowing(
                            text: "Investors You Follow",
                            type: "user",
                            getOtherUserData: true,
                            otherUserEmail: userDetails["email"],
                          ),
                          ProfileBackground(
                            userName: userDetails["username"],
                          ),
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
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }

  onPressedFollow(isFollowing) async {
    print("follow button pressed");
    var userEmail =
        Provider.of<UserDetails>(context, listen: false).userDetails["email"];

    if (isFollowing) {
      Provider.of<FollowProvider>(context, listen: false).unfollowSingleItem(
        userEmail,
        "user",
        userDetails["email"],
        context,
      );
    } else {
      Provider.of<FollowProvider>(context, listen: false).setFollowing(
        userEmail,
        "user",
        userDetails["email"],
        context,
      );
    }
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
