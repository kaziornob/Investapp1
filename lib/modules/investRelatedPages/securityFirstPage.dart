import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class SecurityPageFirst extends StatefulWidget {
  final String callingFrom;
  final String logo;

  const SecurityPageFirst({Key key, @required this.callingFrom,this.logo}) : super(key: key);

  @override
  _SecurityPageFirstState createState() => _SecurityPageFirstState();
}

class _SecurityPageFirstState extends State<SecurityPageFirst> with SingleTickerProviderStateMixin {
  bool _isInProgress = false;


  int selectedTabIndex;

  final List<Tab> tabList = <Tab>[
    new Tab(text: 'Overview'),
    new Tab(text: 'Learn More'),
  ];

  TabController _tabController;

/*  double option1 = 2.0;

  String user = "king@mail.com";
  Map usersWhoVoted = {'sam@mail.com': 3, 'mike@mail.com' : 4, 'john@mail.com' : 1, 'kenny@mail.com' : 5};
  String creator = "eddy@mail.com";*/

  double _voteValue = 3.0;

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: tabList.length);
    super.initState();
    loadDetails();
  }

  loadDetails() async {
    setState(() {
      _isInProgress = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      _isInProgress = false;
    });
  }

  Widget overView()
  {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 5.0,left: 10.0),
            child: Text(
              'Investors in your network',
              style: new TextStyle(
                  fontFamily: "Poppins",
                  color: Color(0xFFFFFFFF), fontSize: 14.0,
                  letterSpacing: 0.2
              ),
            ),
          ),
          // investor slider
          Padding(
            padding: const EdgeInsets.only(left: 13,right: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.10,
                      child: Scrollbar(
                        child: ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                                child: Container(
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 25.0,
                                          backgroundImage: index==0 ? new AssetImage('assets/filledweeklyAuroBadge.png') : new AssetImage('assets/weeklyAuroBadge.png'),
                                          backgroundColor: Colors.transparent,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        )
                                      ],
                                    )
                                )
                            );
                          },
                        ),
                      )
                  ),
                ),
              ],
            ),
          ),
          // description section
          Padding(
            padding: EdgeInsets.only(top: 5.0,left: 10.0),
            child: Text(
              'Description',
              style: new TextStyle(
                  fontFamily: "Poppins",
                  color: Color(0xFFFFFFFF), fontSize: 14.0,
                  letterSpacing: 0.2
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.18,
            margin: EdgeInsets.all(7.0),
            decoration: new BoxDecoration(
              border: Border.all(
                color: Color(0xFFfec20f),
                width: 1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(2.0),
              ),
            ),

          ),
          //video sliders
          Container(
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height*0.15,
            margin: EdgeInsets.all(7.0),
            decoration: new BoxDecoration(
              border: Border.all(
                color: Color(0xFFfec20f),
                width: 1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(2.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 5,right: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.14,
                        margin: EdgeInsets.only(top: 8.0),
                        child: Scrollbar(
                          child: ListView.builder(
                            itemCount: 6,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 77.0,
                                width: 85.0,
                                margin: EdgeInsets.only(top: 2.0,left: 5.0,right: 5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 55.0,
                                      width: 85.0,
                                      decoration: new BoxDecoration(
                                        border: Border.all(
                                          color: Color(0xFFfec20f),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(2.0),
                                        ),
                                      ),

                                    ),
                                    Container(
                                      height: 15.0,
                                      width: 85.0,
                                      decoration: new BoxDecoration(
                                        border: Border.all(
                                          color: Color(0xFFfec20f),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(2.0),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Video ${index+1}",
                                          style: TextStyle(
                                              fontSize: 11.0,
                                              color: Color(0xFFFFFFFF),
                                              fontFamily: "WorkSansBold"),
                                        ),
                                      )
                                    )

                                  ],
                                ),
                              );
                            },
                          ),
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
          // voting bar box
          Padding(
            padding: EdgeInsets.only(top: 5.0,left: 10.0),
            child: Text(
              'Voting bar',
              style: new TextStyle(
                  fontFamily: "Poppins",
                  color: Color(0xFFFFFFFF), fontSize: 14.0,
                  letterSpacing: 0.2
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.05,
            margin: EdgeInsets.all(7.0),
            decoration: new BoxDecoration(
              border: Border.all(
                color: Color(0xFFfec20f),
                width: 1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(2.0),
              ),
            ),
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.green,
                inactiveTrackColor: Colors.red[100],
                trackShape: RoundedRectSliderTrackShape(),
                trackHeight: 4.0,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                thumbColor: Colors.green,
                overlayColor: Colors.red.withAlpha(32),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                tickMarkShape: RoundSliderTickMarkShape(),
                activeTickMarkColor: Colors.green,
                inactiveTickMarkColor: Colors.red[100],
                valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                valueIndicatorColor: Colors.green,
                valueIndicatorTextStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
              child: Slider(
                value: _voteValue,
                min: 0,
                max: 100,
                divisions: 10,
                label: '$_voteValue',
                onChanged: (value) {
                  setState(
                        () {
                      _voteValue = value;
                    },
                  );
                },
              ),
            ),
          ),
          Container(
/*            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.06,*/
            margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width*0.48,
                    decoration: new BoxDecoration(
                      border: Border.all(
                        color: Color(0xFFfec20f),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(2.0),
                      ),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.10,
                      margin: EdgeInsets.only(left:27.0,top: 7.0,right: 27.0),
                      decoration: new BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFfec20f),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(2.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Long',
                          style: new TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            color: Color(0xFFFFFFFF), fontSize: 15.0,
                          ),
                        ),
                      ),
                    )
                ),
                Container(
                    width: MediaQuery.of(context).size.width*0.48,
                    decoration: new BoxDecoration(
                      border: Border.all(
                        color: Color(0xFFfec20f),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(2.0),
                      ),
                    ),
                    child:Container(
                      width: MediaQuery.of(context).size.width*0.10,
                      margin: EdgeInsets.only(left:27.0,top: 7.0,right: 27.0),
                      decoration: new BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFfec20f),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(2.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Short',
                          style: new TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            color: Color(0xFFFFFFFF), fontSize: 15.0,
                          ),
                        ),
                      ),
                    )
                )

              ],
            ),
          ),
          Container(
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height*0.07,
            margin: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.02),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height*0.07,
                  width: MediaQuery.of(context).size.width*0.48,
                  decoration: new BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFfec20f),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Article 1',
                      style: new TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        color: Color(0xFFFFFFFF), fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.07,
                  width: MediaQuery.of(context).size.width*0.48,
                  decoration: new BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFfec20f),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Article 2',
                      style: new TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        color: Color(0xFFFFFFFF), fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
/*            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.07,
            margin: EdgeInsets.only(left:7.0,right:7.0),*/
            margin: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.02),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height*0.07,
                  width: MediaQuery.of(context).size.width*0.48,
                  decoration: new BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFfec20f),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Article 3',
                      style: new TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        color: Color(0xFFFFFFFF), fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.07,
                  width: MediaQuery.of(context).size.width*0.48,
                  decoration: new BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFfec20f),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Article 4',
                      style: new TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        color: Color(0xFFFFFFFF), fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.06,
            margin: EdgeInsets.only(left:7.0,right:7.0),
            child: Container(
                width: MediaQuery.of(context).size.width*0.48,
                decoration: new BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFfec20f),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(2.0),
                  ),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width*0.10,
                  margin: EdgeInsets.only(left:47.0,top: 7.0,right: 47.0,bottom: 3.0),
                  decoration: new BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFfec20f),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Explore',
                      style: new TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        color: Color(0xFFFFFFFF), fontSize: 15.0,
                      ),
                    ),
                  ),
                )
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.18,
            margin: EdgeInsets.all(7.0),
            decoration: new BoxDecoration(
              border: Border.all(
                color: Color(0xFFfec20f),
                width: 1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(2.0),
              ),
            ),
            child: Center(
              child: Text(
                'Company Sponsered Content',
                style: new TextStyle(
                    fontFamily: "Poppins",
                    color: Color(0xFFFFFFFF), fontSize: 14.0,
                    letterSpacing: 0.2
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0,left: 10.0),
            child: Text(
              'Similar Companies',
              style: new TextStyle(
                  fontFamily: "Poppins",
                  color: Color(0xFFFFFFFF), fontSize: 14.0,
                  letterSpacing: 0.2
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13,right: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.10,
                      child: Scrollbar(
                        child: ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                                child: Container(
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 25.0,
                                          backgroundImage: index==0 ? new AssetImage('assets/filledweeklyAuroBadge.png') : new AssetImage('assets/weeklyAuroBadge.png'),
                                          backgroundColor: Colors.transparent,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        )
                                      ],
                                    )
                                )
                            );
                          },
                        ),
                      )
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget learnMore()
  {
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();
    double appBarheight = appBar.preferredSize.height;
    return Stack(
      children: <Widget>[
        SafeArea(
            bottom: true,
            child: Scaffold(
              backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
              body: ModalProgressHUD(
                inAsyncCall: _isInProgress,
                opacity: 0,
                progressIndicator: CupertinoActivityIndicator(
                  radius: 12,
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: !_isInProgress
                      ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*1.9,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
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
                                      AllCoustomTheme.getTextThemeColors(),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Animator(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.decelerate,
                                  cycles: 1,
                                  builder: (anim) => Transform.scale(
                                    scale: anim.value,
                                    child: Text(
                                      'Apple',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AllCoustomTheme.getTextThemeColors(),
                                        fontWeight: FontWeight.bold,
                                        fontSize: ConstanceData.SIZE_TITLE20,
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
                          Container(
                            margin: EdgeInsets.only(top: 20.0,bottom: 10.0,left: 5.0,right: 3.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                new Container(
/*                                    width: 60.0,
                                    height: 60.0,*/
                                    width: MediaQuery.of(context).size.width*0.16,
                                    height: MediaQuery.of(context).size.height*0.13,
                                    decoration: new BoxDecoration(
                                        color: Color(0xFFfec20f),
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image: new AssetImage('assets/logo.png')
                                        )
                                    )
                                ),
                                new Container(
                                  margin: EdgeInsets.only(left: 5.0),
                                  width: MediaQuery.of(context).size.width*0.50,
                                  height: MediaQuery.of(context).size.height*0.13,
                                  decoration: new BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xFFfec20f),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: 5.0,top: 10.0),
                                        child: Text(
                                          'MKT Cap:',
                                          style: new TextStyle(
                                              fontFamily: "Poppins",
                                              color: Color(0xFFFFFFFF), fontSize: 15.0,
                                              letterSpacing: 0.2
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5.0,top: 15.0),
                                        child: Text(
                                          'HQ:',
                                          style: new TextStyle(
                                              fontFamily: "Poppins",
                                              color: Color(0xFFFFFFFF), fontSize: 15.0,
                                              letterSpacing: 0.2
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                new Container(
                                  margin: EdgeInsets.only(left: 5.0),
/*                                  width: MediaQuery.of(context).size.width*0.28,
                                  height: MediaQuery.of(context).size.height*0.13,*/
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(top: 3.0),
                                        height: MediaQuery.of(context).size.height*0.06,
                                        width: MediaQuery.of(context).size.width*0.28,
                                        decoration: new BoxDecoration(
                                          border: Border.all(
                                            color: Color(0xFFfec20f),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(2.0),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 25.0,top: 10.0),
                                          child: Text(
                                            'Follow',
                                            style: new TextStyle(
                                                fontFamily: "Poppins",
                                                color: Color(0xFFFFFFFF), fontSize: 15.0,
                                                letterSpacing: 0.2
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 3.0),
                                        height: MediaQuery.of(context).size.height*0.06,
                                        width: MediaQuery.of(context).size.width*0.28,
                                        decoration: new BoxDecoration(
                                          border: Border.all(
                                            color: Color(0xFFfec20f),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(2.0),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 25.0,top: 10.0),
                                          child: Text(
                                            'Invest',
                                            style: new TextStyle(
                                                fontFamily: "Poppins",
                                                color: Color(0xFFFFFFFF), fontSize: 15.0,
                                                letterSpacing: 0.2
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height*0.06,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.48,
                                  margin: EdgeInsets.only(top: 7.0),
                                  decoration: new BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xFFfec20f),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(2.0),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Buy',
                                      style: new TextStyle(
                                        fontFamily: "WorkSansSemiBold",
                                        color: Color(0xFFFFFFFF), fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.47,
                                  margin: EdgeInsets.only(top: 7.0),
                                  decoration: new BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xFFfec20f),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(2.0),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Sell',
                                      style: new TextStyle(
                                        fontFamily: "WorkSansSemiBold",
                                        color: Color(0xFFFFFFFF), fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(left: 10.0,right: 3.0),
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TabBar(
                                  controller: _tabController,
                                  onTap: (index)
                                  {
                                    selectedTabIndex = index;
                                  },
                                  labelColor: AllCoustomTheme.getTextThemeColors(),
                                  labelStyle: TextStyle(fontSize: 17.0,letterSpacing: 0.2),
                                  indicatorColor: AllCoustomTheme.getTextThemeColors(),
                                  indicatorWeight: 4.0,
                                  isScrollable: true,
                                  unselectedLabelColor: Colors.grey,
                                  tabs: <Widget>[
                                    new Tab(text: "Overview"),
                                    new Tab(text: "Learn More"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
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
                      )
                  )
                      : SizedBox(),
                ),
              ),
            )
        )
      ],
    );
  }

  // ignore: missing_return
  Widget _getPage(Tab tab){
    switch(tab.text){
      case 'Overview': return overView();
      case 'Learn More': return learnMore();
    }
  }
}