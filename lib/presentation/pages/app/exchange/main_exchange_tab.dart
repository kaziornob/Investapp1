// import 'package:admob_flutter/admob_flutter.dart';
import 'dart:convert';

import 'package:animator/animator.dart';
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/api/reusable_functions.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/global.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/chagePIN/changepin.dart';
import 'package:auroim/modules/qaInvForumPages/addEditQus.dart';
import 'package:auroim/modules/qaInvForumPages/qusDetail.dart';
import 'package:auroim/modules/settings/user_profile_page.dart';
import 'package:auroim/modules/underGroundSlider/notificationSlider.dart';
import 'package:auroim/modules/userProfile/userProfile.dart';
import 'package:auroim/presentation/common/auro_text.dart';
import 'package:auroim/presentation/pages/app/exchange/company_profile.dart';
import 'package:auroim/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MainExchangeTab extends StatefulWidget {
  @override
  _MainExchangeTabState createState() => _MainExchangeTabState();
}

class _MainExchangeTabState extends State<MainExchangeTab>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ReusableFunctions _reusableFunctions = ReusableFunctions();
  int selectedTabIndex;
  var width = 0.0;
  var height = 0.0;
  var appBarheight = 0.0;
  var statusBarHeight = 0.0;
  var graphHeight = 0.0;

  // AdmobBannerController admobBannerController;
  List<dynamic> questionsList;
  ApiProvider request = new ApiProvider();
  List<String> topCompanies = [
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Microsoft_logo.svg/480px-Microsoft_logo.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Google_2015_logo.svg/368px-Google_2015_logo.svg.png",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1GRirgS0LMYCFM1ZoNzQVzdiKCRtyLw7sUityC-fFwIayHo45qSjdNUglcLyb-eG2Pbw&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2pqL5gGZeOUfrH-BKx8qvVArzJGsmjTheCBUCtEuO5pfFArTz5Xodg2z7-mirLCekooQ&usqp=CAU",
    "https://cdn.dribbble.com/users/1857/screenshots/729847/attachments/69548/fitch-ebay-revision.png?compress=1&resize=400x300",
    "https://iconape.com/wp-content/files/vk/369251/svg/adobe-logo-icon-png-svg.png",
    "https://d1yjjnpx0p53s8.cloudfront.net/styles/logo-thumbnail/s3/0005/6612/brand.gif?itok=8ZBniu-q",
    "https://thumbs.dreamstime.com/b/amazon-logo-editorial-vector-illustration-market-136495269.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/c/cd/Facebook_logo_%28square%29.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ad/HP_logo_2012.svg/1024px-HP_logo_2012.svg.png",
  ];
  List<String> tagItemList = <String>['native', 'fixed'];

  //fifth screen params
  String selectedInceptionLeague;
  String selectedWeeklyLeague;

  final List<Tab> tabList = <Tab>[
    new Tab(text: 'Recommended'),
    new Tab(text: 'Coined'),
    new Tab(text: "Buzzing"),
    new Tab(text: "Month"),
  ];

  @override
  void initState() {
    onInitDisplayBootomSheet();
    _tabController = new TabController(vsync: this, length: tabList.length);
    getQuestionsData();
    selectedTabIndex = 0;
    super.initState();
  }

  onInitDisplayBootomSheet() async {
    // print();
    int showPopupData = await _reusableFunctions.exchangePagePopupGetData();
    print("exchange tab popppopop $showPopupData}");
    if (showPopupData == null || showPopupData == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await showDialog(
          context: context,
          builder: (builder) {
            return AlertDialog(
              content: Text(
                "Welcome to Auro Exchange. Here you can ask investment related questions or browse questions others have asked, and earn earn Auro Coins if people like your answers",
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
                    await _reusableFunctions.exchangePagePopupPressed();
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

  // api calls section start
  Future<void> getQuestionsData() async {
    questionsList = [];
    var response = await request.getRequest('forum/get_questions');
    print("qus list: $response");
    if (response != null && response != false) {
      setState(() {
        // _AnswerList = response['answers'];
        questionsList = response['message'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();
    appBarheight = appBar.preferredSize.height;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      // height: graphHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: RaisedButton(
              child: Text(
                "Ask question",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AllCoustomTheme.getSeeMoreThemeColor(),
                  fontSize: ConstanceData.SIZE_TITLE16,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w900,
                ),
              ),
              onPressed: () {
                // print("gschascvkajsc");
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => AddEditQus(),
                    // InvestorType(),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 10.0, right: 3.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  onTap: (index) {
                    setState(() {
                      selectedTabIndex = index;
                    });
                  },
                  labelColor: AllCoustomTheme.getTextThemeColor(),
                  labelStyle: TextStyle(fontSize: 14.0, letterSpacing: 0.2),
                  indicatorColor: AllCoustomTheme.getTextThemeColor(),
                  indicatorWeight: 4.0,
                  // unselectedLabelColor: StyleTheme.Colors.AppBarTabTextColor,
                  tabs: <Widget>[
                    new Tab(text: "Recommended"),
                    new Tab(text: "Coined"),
                    new Tab(text: "Buzzing"),
                    new Tab(text: "Month"),
                    // new Tab(text: "Ask Question"),
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
                  return _getPage(tab);
                }).toList(),
                physics: ScrollPhysics(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget fourthSettingScreen() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // AdmobBanner(
          //   adUnitId: getBannerAdUnitId(),
          //   adSize: bannerSize,
          //   listener: (AdmobAdEvent event, Map<String, dynamic> args) {
          //     handleEvent(event, args, 'Banner');
          //   },
          //   onBannerCreated: (AdmobBannerController controller) {
          //     setState(() {
          //       admobBannerController = controller;
          //     });
          //   },
          // ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Animator(
                tween: Tween<double>(begin: 0, end: 1),
                duration: Duration(milliseconds: 500),
                cycles: 1,
                builder: (anim) => SizeTransition(
                  sizeFactor: anim,
                  axis: Axis.horizontal,
                  axisAlignment: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Settings',
                      style: TextStyle(
                        color: AllCoustomTheme.getTextThemeColors(),
                        fontWeight: FontWeight.bold,
                        fontSize: ConstanceData.SIZE_TITLE25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'General',
                        style: TextStyle(
                          color: AllCoustomTheme.getsecoundTextThemeColor(),
                          fontSize: ConstanceData.SIZE_TITLE16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      showCupertinoModalPopup<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  globals.buttoncolor1,
                                  globals.buttoncolor2,
                                ],
                              ),
                            ),
                            height: height / 1.8,
                            child: Scaffold(
                              backgroundColor: Colors.transparent,
                              body: NotificationSlider(),
                            ),
                          );
                        },
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Notifications',
                          style: TextStyle(
                            color: AllCoustomTheme.getTextThemeColors(),
                          ),
                        ),
                        AnimatedForwardArrow(
                          isShowingarroeForward: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  AnimatedDivider(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Currency Preference',
                        style: TextStyle(
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                      AnimatedForwardArrow(
                        isShowingarroeForward: true,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: AnimatedDivider(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Alerts',
                        style: TextStyle(
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                      AnimatedForwardArrow(
                        isShowingarroeForward: true,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: AnimatedDivider(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Account',
                        style: TextStyle(
                          color: AllCoustomTheme.getsecoundTextThemeColor(),
                          fontSize: ConstanceData.SIZE_TITLE16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (BuildContext context) => UserProfile(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'User Profile',
                          style: TextStyle(
                            color: AllCoustomTheme.getTextThemeColors(),
                          ),
                        ),
                        AnimatedForwardArrow(
                          isShowingarroeForward: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: AnimatedDivider(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (BuildContext context) => ChangePINCode(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Change PIN-code',
                          style: TextStyle(
                            color: AllCoustomTheme.getTextThemeColors(),
                          ),
                        ),
                        AnimatedForwardArrow(
                          isShowingarroeForward: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: AnimatedDivider(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Log Out',
                        style: TextStyle(
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                      AnimatedForwardArrow(
                        isShowingarroeForward: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: missing_return
  Widget _getPage(Tab tab) {
    switch (tab.text) {
      case 'Recommended':
        return recommended();
      case 'Coined':
        return trending();
      case 'Buzzing':
        return week();
      case 'Month':
        return month();
      // case 'Ask Question': return askQus();
    }
  }

  Widget trending() {
    return FutureBuilder(
      future: ApiProvider().postSubmit(
        'forum/get_question_specific',
        jsonEncode({"type": "coined"}),
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          return SingleChildScrollView(
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height * 0.50,
            child: Scrollbar(
              child: getQuestionsList(snapshot.data['message']),
            ),
          );
        }
        return Center(
          child: Text('Fetching Data...'),
        );
      },
    );
  }

  Widget week() {
    return FutureBuilder(
      future: ApiProvider().postSubmit(
        'forum/get_question_specific',
        jsonEncode({"type": "buzzing"}),
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height * 0.50,
            child: Scrollbar(
              child: getQuestionsList(snapshot.data['message']),
            ),
          );
        }
        return Center(
          child: Text('No Data Available'),
        );
      },
    );
  }

  Widget month() {
    return FutureBuilder(
      future: ApiProvider().postSubmit(
        'forum/get_question_specific',
        jsonEncode({"type": "Month"}),
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            // height: MediaQuery.of(context).size.height * 0.50,
            child: Scrollbar(
              child: getQuestionsList(snapshot.data['message']),
            ),
          );
        }
        return Center(
          child: Text('No Data Available'),
        );
      },
    );
  }

  Widget recommended() {
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 8.0,
        ),
        // random images
        StaggeredGridView.countBuilder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          itemCount: topCompanies.length,
          itemBuilder: (BuildContext context, int index) => InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CompanyProfile()));
            },
            child: new Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[800]),
                  image: DecorationImage(
                      image: NetworkImage(
                        topCompanies[index],
                      ),
                      fit: BoxFit.contain)),
            ),
          ),
          staggeredTileBuilder: (int index) {
            if (index == 0 ||
                index == 2 ||
                index == 4 ||
                index == 5 ||
                index == 6) {
              return StaggeredTile.count(1, 1);
            } else if (index == 1) {
              return StaggeredTile.count(2, 1);
            } else if (index == 3) {
              return StaggeredTile.count(1, 2);
            } else {
              return StaggeredTile.count(1, 1);
            }
          },
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
        SizedBox(
          height: 20,
        ),
        Scrollbar(
          child: getQuestionsList(questionsList),
        ),
      ],
    );
  }

  Widget getQuestionsList(data) {
    if (data != null && data.length != 0) {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (context, index) {
          var tagFinalData = [];

          final tagData = data[index]['tags'] as Map;
          for (final name in tagData.keys) {
            final value = tagData[name];
            tagFinalData.add({"id": name, "tag": value});
          }

          // return QuestionWidget(onTap: () {  var tempField = {
          //           "id": "${data[index]['id']}",
          //           "title": "${data[index]['title']}",
          //           "body": "${data[index]['question']}",
          //           "vote": "${data[index]['vote']}",
          //           "view": "${data[index]['view']}",
          //           "totalAns": "${data[index]['no. of answer']}",
          //           "tags": tagFinalData,
          //           "bounty": "${data[index]["bounty"]}",
          //           "user_score": "${data[index]["user_score"]}",
          //           "date": data[index]["date-time"],
          //           "email": data[index]["email"],
          //           "username": data[index]["username"],
          //           "is_approved": data[index]["is_approved"],
          //         };

          //         print("QusDetail tempField: $tempField");
          //         // data[index]
          //         Navigator.of(context).push(
          //           CupertinoPageRoute(
          //             builder: (BuildContext context) =>
          //                 QusDetail(allParams: tempField),
          //           ),
          //         ); }, title: "${data[index]['title']}", answers: null, comments: null, question:  "${data[index]['question']}", likes: null, onUserTap: () {  },);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // question section
              GestureDetector(
                onTap: () {
                  var tempField = {
                    "id": "${data[index]['id']}",
                    "title": "${data[index]['title']}",
                    "body": "${data[index]['question']}",
                    "vote": "${data[index]['vote']}",
                    "view": "${data[index]['view']}",
                    "totalAns": "${data[index]['no. of answer']}",
                    "tags": tagFinalData,
                    "bounty": "${data[index]["bounty"]}",
                    "user_score": "${data[index]["user_score"]}",
                    "date": data[index]["date-time"],
                    "email": data[index]["email"],
                    "username": data[index]["username"],
                    "is_approved": data[index]["is_approved"],
                  };

                  print("QusDetail tempField: $tempField");
                  // data[index]
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (BuildContext context) =>
                          QusDetail(allParams: tempField),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuroText(
                      "${data[index]['title']}",
                      padding: EdgeInsets.only(left: 30),
                      color: Colors.black,
                      textType: TextType.headLine5,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        "${data[index]['question']}",
                        style: TextStyle(
                            color: AllCoustomTheme.getNewSecondTextThemeColor(),
                            fontSize: ConstanceData.SIZE_TITLE16,
                            fontFamily: "Rosarivo",
                            fontStyle: FontStyle.normal,
                            letterSpacing: 0.2),
                      ),
                    ),
                  ],
                ),
              ),

              // question attributes section
              Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // SizedBox(
                  //   width: 10.0,
                  // ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => UserProfilePage(
                                email: data[index]["email"],
                              ),
                            ),
                          );
                        },
                        child: Image.asset(
                          Assets.usersOutline,
                          height: 40,
                        ),
                      ),
                      SizedBox(width: 5),
                      AuroText(
                        "${data[index]['user_score']}",
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        textType: TextType.headLine5,
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Image.asset(
                        Assets.comment,
                        height: 40,
                      ),
                      SizedBox(width: 5),
                      AuroText(
                        "${data[index]['no. of answer']}",
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        textType: TextType.headLine5,
                      ),
                    ],
                  ),

                  // SizedBox(
                  //   width: 15,
                  // ),
                  // Container(
                  //   child: Icon(
                  //     Icons.remove_red_eye_outlined,
                  //     color: AllCoustomTheme.getTextThemeColor(),
                  //   ),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.only(top: 3.0),
                  //   child: Text(
                  //     data[index]['view'] != null
                  //         ? "${data[index]['view']}"
                  //         : '0',
                  //     style: TextStyle(
                  //       color: Colors.black,
                  //       fontSize: ConstanceData.SIZE_TITLE14,
                  //     ),
                  //   ),
                  // ),

                  // SizedBox(
                  //   width: 15,
                  // ),
                  // Container(
                  //   child: Icon(
                  //     Icons.add,
                  //     color: AllCoustomTheme.getTextThemeColor(),
                  //   ),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.only(top: 3.0),
                  //   child: Text(
                  //     "${data[index]["bounty"] == null ? 0 : data[index]["bounty"]}",
                  //     style: TextStyle(
                  //       color: Colors.black,
                  //       fontSize: ConstanceData.SIZE_TITLE14,
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: 15,
                  // ),
                  upvotesDownvotesWidget(data[index]["vote"]),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              //tags section
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: StaggeredGridView.countBuilder(
                  itemCount: tagFinalData != null && tagFinalData.length != 0
                      ? tagFinalData.length
                      : 0,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  shrinkWrap: true,
                  staggeredTileBuilder: (int tagIndex) => StaggeredTile.fit(1),
                  itemBuilder: (context, tagIndex) {
                    return Container(
                      decoration: BoxDecoration(
                        color:
                            AllCoustomTheme.getThemeData().textSelectionColor,
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(
                            color: AllCoustomTheme.getThemeData()
                                .textSelectionColor,
                            width: 1.0),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              tagFinalData[tagIndex]['tag'],
                              style: TextStyle(
                                  color: AllCoustomTheme.getTextThemeColor(),
                                  fontSize: ConstanceData.SIZE_TITLE16,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.normal,
                                  height: 1.3),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Divider(
                color: Colors.grey,
              )
            ],
          );
        },
      );
    } else {
      return Center(
          child: Text(
        "Fetching Data",
        textAlign: TextAlign.center,
        style: new TextStyle(
          color: AllCoustomTheme.getTextThemeColor(),
          fontSize: ConstanceData.SIZE_TITLE18,
          fontFamily: "Rasa",
        ),
      ));
    }
  }

  upvotesDownvotesWidget(votes) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Assets.like,
          height: 40,
        ),
        AuroText(
          "$votes",
          padding: EdgeInsets.symmetric(horizontal: 5),
          color: Colors.black,
          fontWeight: FontWeight.w300,
          textType: TextType.headLine5,
        ),
        Image.asset(
          Assets.dislike,
          height: 40,
        ),
      ],
    );
  }
}
