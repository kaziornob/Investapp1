// import 'package:admob_flutter/admob_flutter.dart';
import 'package:animator/animator.dart';
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/api/reusable_functions.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/global.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/modules/chagePIN/changepin.dart';
import 'package:auroim/modules/qaInvForumPages/addEditQus.dart';
import 'package:auroim/modules/qaInvForumPages/qusDetail.dart';
import 'package:auroim/modules/settings/user_profile_page.dart';
import 'package:auroim/modules/underGroundSlider/notificationSlider.dart';
import 'package:auroim/modules/userProfile/userProfile.dart';
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
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
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
                      ),
                    );
                  },
                )
/*                GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                  child: Icon(
                    Icons.sort,
                    color: AllCoustomTheme.getsecoundTextThemeColor(),
                  ),
                ),*/
/*                Container(
                  margin: EdgeInsets.only(left: 150),
                  height: 30,
                  width: 150,
                  decoration: BoxDecoration(
                    color: AllCoustomTheme.getThemeData().textSelectionColor,
                    border: new Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: MaterialButton(
                    splashColor: Colors.grey,
                    child: Text(
                      "Ask question",
                      style: TextStyle(
                        color: AllCoustomTheme.getTextThemeColors(),
                        fontSize: ConstanceData.SIZE_TITLE16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (BuildContext context) => AddEditQus(),
                        ),
                      );
                    },
                  ),
                ),*/
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
/*          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: CircleAvatar(
                    radius: 15.0,
                    backgroundImage: new AssetImage('assets/download.jpeg'),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: AllCoustomTheme.boxColor(),
                    ),
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: ConstanceData.SIZE_TITLE16,
                        color: AllCoustomTheme.getTextThemeColors(),
                      ),
                      cursorColor: AllCoustomTheme.getTextThemeColors(),
                      onChanged: (value) {
                        filterSearchResults(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(
                          Icons.search,
                          size: 20,
                          color: AllCoustomTheme.getsecoundTextThemeColor(),
                        ),
                        hintStyle: TextStyle(
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getsecoundTextThemeColor(),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Container(
                  child: CircleAvatar(
                    radius: 15.0,
                    backgroundImage: new AssetImage('assets/appIcon.jpg'),
                    backgroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),*/
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
                    selectedTabIndex = index;
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
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height * 0.50,
              child: Scrollbar(
                child: getQuestionsList(questionsList),
              ),
            ),
          ),
        ],
      ),
    );
    // Container(
    //   child: Padding(
    //     padding: EdgeInsets.only(left: 20.0),
    //     child: Text(
    //       'Coming Soon... ',
    //       textAlign: TextAlign.center,
    //       style: TextStyle(
    //         color: AllCoustomTheme.getTextThemeColor(),
    //         fontSize: ConstanceData.SIZE_TITLE18,
    //       ),
    //     ),
    //   ));
  }

  Widget week() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height * 0.50,
              child: Scrollbar(
                child: getQuestionsList(questionsList),
              ),
            ),
          ),
        ],
      ),
    );
    // return Container(
    //     child: Padding(
    //   padding: EdgeInsets.only(left: 20.0),
    //   child: Text(
    //     'Coming Soon... ',
    //     textAlign: TextAlign.center,
    //     style: TextStyle(
    //       color: AllCoustomTheme.getTextThemeColor(),
    //       fontSize: ConstanceData.SIZE_TITLE18,
    //     ),
    //   ),
    // ));
  }

  Widget month() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height * 0.50,
              child: Scrollbar(
                child: getQuestionsList(questionsList),
              ),
            ),
          ),
        ],
      ),
    );
    // return Container(
    //     child: Padding(
    //   padding: EdgeInsets.only(left: 20.0),
    //   child: Text(
    //     'Coming Soon... ',
    //     textAlign: TextAlign.center,
    //     style: TextStyle(
    //       color: AllCoustomTheme.getTextThemeColor(),
    //       fontSize: ConstanceData.SIZE_TITLE18,
    //     ),
    //   ),
    // ));
  }

  Widget weekly() {
    return Container(
        child: Padding(
      padding: EdgeInsets.only(left: 20.0),
      child: Text(
        'Coming Soon... ',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AllCoustomTheme.getTextThemeColors(),
          fontSize: ConstanceData.SIZE_TITLE18,
        ),
      ),
    ));
  }

  Widget recommended() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 8.0,
          ),
          // random images
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: new Image(
                    height: 115,
                    width: 150.0,
                    fit: BoxFit.fill,
                    image: new AssetImage('assets/arqade.jpeg')),
              ),
              Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      new Image(
                          height: 70,
                          width: 85.0,
                          fit: BoxFit.fill,
                          image: new AssetImage('assets/language.png')),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      new Image(
                          height: 40,
                          width: 40.0,
                          fit: BoxFit.fill,
                          image: new AssetImage('assets/android.png')),
                      SizedBox(
                        width: 5,
                      ),
                      new Image(
                          height: 40,
                          width: 40.0,
                          fit: BoxFit.fill,
                          image: new AssetImage('assets/askUbuntu.png')),
                    ],
                  )
                ],
              )),
              Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      new Image(
                          height: 40,
                          width: 40.0,
                          fit: BoxFit.fill,
                          image: new AssetImage('assets/askUbuntu.png')),
                      SizedBox(
                        width: 5,
                      ),
                      new Image(
                          height: 40,
                          width: 40.0,
                          fit: BoxFit.fill,
                          image: new AssetImage('assets/android.png')),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      new Image(
                          height: 70,
                          width: 85.0,
                          fit: BoxFit.fill,
                          image: new AssetImage('assets/arqade.jpeg')),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                ],
              )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.50,
                    child: Scrollbar(
                      child: getQuestionsList(questionsList),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getQuestionsList(data) {
    if (data != null && data.length != 0) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (context, index) {
          var tagFinalData = [];

          final tagData = data[index]['tags'] as Map;
          for (final name in tagData.keys) {
            final value = tagData[name];
            tagFinalData.add({"id": name, "tag": value});
          }
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
                child: Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        "${data[index]['question']}",
                        style: TextStyle(
                            color: AllCoustomTheme.getNewSecondTextThemeColor(),
                            fontSize: ConstanceData.SIZE_TITLE16,
                            fontFamily: "Rosarivo",
                            fontStyle: FontStyle.normal,
                            letterSpacing: 0.2),
                      ),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              // question attributes section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 10.0,
                  ),
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
                    child: Container(
                      child: CircleAvatar(
                        radius: 13.5,
                        backgroundImage: new AssetImage('assets/download.jpeg'),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 3.0),
                    child: Text(
                      "${data[index]['user_score']}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ConstanceData.SIZE_TITLE14,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    child: Icon(
                      Icons.comment_bank_sharp,
                      color: AllCoustomTheme.getTextThemeColor(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2.0),
                    child: Text(
                      "${data[index]['no. of answer']}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ConstanceData.SIZE_TITLE14,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    child: Icon(
                      Icons.remove_red_eye_outlined,
                      color: AllCoustomTheme.getTextThemeColor(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 3.0),
                    child: Text(
                      data[index]['view'] != null
                          ? "${data[index]['view']}"
                          : '0',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ConstanceData.SIZE_TITLE14,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    child: Icon(
                      Icons.add,
                      color: AllCoustomTheme.getTextThemeColor(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 3.0),
                    child: Text(
                      "${data[index]["bounty"] == null ? 0 : data[index]["bounty"]}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ConstanceData.SIZE_TITLE14,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
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
                  crossAxisCount: 4,
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
        "No data available yet",
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
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          child: Icon(
            Icons.arrow_upward,
            color: AllCoustomTheme.getThemeData().textSelectionColor,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 3.0),
          child: new Text(
            "$votes",
            style: TextStyle(
              color: Colors.black,
              fontSize: ConstanceData.SIZE_TITLE14,
            ),
          ),
        ),
        Container(
          child: Icon(
            Icons.arrow_downward,
            color: AllCoustomTheme.getTextThemeColor(),
          ),
        ),
      ],
    );
  }
}
