import 'dart:io';
import 'package:auro/questionAndAnswerModule/models/question.dart';
import 'package:auro/questionAndAnswerModule/resources/question_api_provider.dart';
import 'package:auro/questionAndAnswerModule/ui/pages/error.dart';
import 'package:auro/questionAndAnswerModule/ui/pages/questionTemplate.dart';
import 'package:auro/shared/navigation_menu.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auro/style/theme.dart' as StyleTheme;
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

final List<String> areaChartDataList = ['1','2','3','4'];


class SocialInvest extends StatefulWidget {
  @override
  _SocialInvestState createState() => _SocialInvestState();
}

class _SocialInvestState extends State<SocialInvest> {

  final GlobalKey<ScaffoldState> homeScaffoldKey = new GlobalKey<ScaffoldState>();

  Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
  };

  List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
  ];

  Widget _buildTitleRecommended(BuildContext context) {
    var horizontalTitleAlignment =
    Platform.isIOS ? CrossAxisAlignment.start : CrossAxisAlignment.start;

    return new InkWell(
      onTap: () => homeScaffoldKey.currentState.openDrawer(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: horizontalTitleAlignment,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right:30.0),
            child: Center(
              child: Text(
                'Social',
                style: new TextStyle(
                    fontFamily: "WorkSansSemiBold",
                    color: Color(0xFFCD853F),
                    fontSize: 28.0,
                    letterSpacing: 0.1
                ),
              ),
            )
          )
        ],
      ),
    );
  }

  List<dynamic> qusList = <dynamic>[
    {"qus_title": "how safe is that dividend ? (video)"},
    {"qus_title": "super finished: apple silicon not holding up"},
    {"qus_title": "2 fast-growing blue chips set to soar"},
    {"qus_title": "draftKings: grossly overvalued and accelerating losses on possible (0.87) q3 eps weigh on long-term growth"},
    {"qus_title": "5 REITs Been part 1"},
    {"qus_title": "The Media Attempts HH Job While CEO focuses on the coming reality"},
    {"qus_title": "QQQ How Is Too High?"},
    {"qus_title": "Don't Be SHY About selling This Fund"}
  ];

  List<dynamic> memberList = <dynamic>[
    {"name": "green","measure": "741 XP"},
    {"name": "alena","measure": "716 XP"},
    {"name": "tat 1 anna","measure": "488 XP"},
    {"name": "kristie","measure": "413 XP"},
    {"name": "piotr","measure": "304 XP"},
  ];


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

  Widget getQusListView(data){

    return new ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
              leading: CircleAvatar(
                radius: 15.0,
                backgroundImage: new AssetImage('assets/success.png'),
                backgroundColor: Colors.transparent,
              ),
              title: Text(
                titleCase(data[index]['qus_title']),
                style: new TextStyle(
                    fontFamily: "Poppins",
                    color: Color(0xFF000000), fontSize: 16.0,
                    letterSpacing: 0.1
                ),
              ),
              onTap: () {

              }

          ),
        );
      },
    );
  }

  Widget getMemberView(data){

    return new ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Card(
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
                        fontFamily: "Poppins",
                        color: Color(0xFF000000), fontSize: 16.0,
                        letterSpacing: 0.1
                    ),
                  ),
                  Text(
                    "${data[index]['measure']}",
                    style: new TextStyle(
                        fontFamily: "Poppins",
                        color: Color(0xFF000000), fontSize: 16.0,
                        letterSpacing: 0.1
                    ),
                  ),
                ],
              ),
              onTap: () {

              }

          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final List<ChartData> chartData = [
      ChartData('David', 25, Color.fromRGBO(9,0,136,1)),
      ChartData('Steve', 38, Color.fromRGBO(147,0,119,1)),
      ChartData('Jack', 34, Color.fromRGBO(228,0,124,1)),
      ChartData('Others', 52, Color.fromRGBO(255,189,57,1))
    ];


    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        title: _buildTitleRecommended(context),
        backgroundColor: Color(0xFF000000),
        iconTheme: IconThemeData(
          color: StyleTheme.Colors.AppBarMenuIconColor,
        ),
      ),
      drawer: NavigationMenu(),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height*2.35,
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                color: StyleTheme.Colors.backgroundColor,
              ),
              child: Column(
                children: <Widget>[
                  // search box
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.095,
                    child:  Container(
                        margin: EdgeInsets.only(top: 25.0,left: 20.0,right: 20.0),
                        decoration: new BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          border: Border.all(
                            color: Color(0xFFFFFFFF),
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top:5.0, left: 120.0),
                          child: Text(
                            'Search',
                            style: new TextStyle(
                              fontFamily: "Poppins",
                              color: Color(0xFF000000), fontSize: 22.0,
                            ),
                          ),
                        )
                    ),
                  ),
                  // start learning box
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.095,
                    child:  Container(
                        margin: EdgeInsets.only(top: 25.0,left: 20.0,right: 20.0),
                        decoration: new BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          border: Border.all(
                            color: Color(0xFFCD853F),
                            width: 4.5,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top:5.0, left: 20.0),
                          child: MaterialButton(
                            onPressed: ()
                            {
                              goToQuestionTemp();
                            },
                            child: Text(
                              'START LEARNING',
                              style: new TextStyle(
                                fontFamily: "Poppins",
                                color: Color(0xFF000000), fontSize: 18.0,
                              ),
                            ),
                          )
                        )
                    ),
                  ),
                  // learning  progress box
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.095,
                    child:  Container(
                        margin: EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0),
                        decoration: new BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          border: Border.all(
                            color: Color(0xFFCD853F),
                            width: 4.5,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top:10.0, left: 80.0),
                          child: Text(
                            'LEARNING PROGRESS',
                            style: new TextStyle(
                              fontFamily: "Poppins",
                              color: Color(0xFF000000), fontSize: 18.0,
                            ),
                          ),
                        )
                    ),
                  ),
                  //donut chart box
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.35,
                      child: Container(
                          margin: EdgeInsets.only(left: 20.0,right: 20.0,bottom: 5.0),
                          decoration: new BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            border: Border.all(
                              color: Color(0xFFFFFFFF),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(2.0),
                            ),
                          ),
                        child: SfCircularChart(
                            series: <CircularSeries>[
                              // Renders doughnut chart
                              DoughnutSeries<ChartData, String>(
                                  dataSource: chartData,
                                  pointColorMapper:(ChartData data,  _) => data.color,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y
                              )
                            ]
                        ),
                      )
                  ),
                  // todays  progress box
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.27,
                    child:  Container(
                        margin: EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0),
                        decoration: new BoxDecoration(
                          color: Color(0xFF1E90FF),
                          border: Border.all(
                            color: Color(0xFF1E90FF),
                            width: 4.5,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top:5.0),
                              child: Center(
                                child: Text(
                                  "Today's progress: 1 concept",
                                  style: new TextStyle(
                                    fontFamily: "Poppins",
                                    color: Color(0xFFFFFFFF), fontSize: 17.0,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top:8.0, left: 20.0),
                              child: Text(
                                'MASTER 10 MORE CONCEPTS TO EARN YOUR FIRST COIN',
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                  color: Color(0xFFFFFFFF), fontSize: 17.5,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top:8.0, left: 20.0),
                              child: Text(
                                'Your friend Tom has mastered 1 S intermediate and 2 hard concepts today',
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                  color: Color(0xFFFFFFFF), fontSize: 17.0,
                                ),
                              ),
                            )
                          ],
                        )
                    ),
                  ),
                  //buffet club box
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.55,
                      child: Container(
                        margin: EdgeInsets.only(top:10.0,left: 20.0,right: 20.0,bottom: 5.0),
                        decoration: new BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          border: Border.all(
                            color: Color(0xFFFFFFFF),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(2.0),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height*0.13,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top:5.0),
                                    child: Center(
                                      child: Text(
                                        "Warren Buffet Club",
                                        style: new TextStyle(
                                          fontFamily: "Poppins",
                                          color: Color(0xFF000000),
                                          fontSize: 19.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top:5.0, left: 30.0),
                                    child: Text(
                                      'Top 10 advance to the next league',
                                      style: new TextStyle(
                                        fontFamily: "Poppins",
                                        color: Color(0xff696969),
                                        fontSize: 17.5,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top:5.0, left: 100.0),
                                    child: Text(
                                      '3d 20h 41m',
                                      style: new TextStyle(
                                        fontFamily: "Poppins",
                                        color: Color(0xfffec20f),
                                        fontSize: 19.0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              color: Color(0xff696969),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height*0.35,
                              child: getMemberView(memberList),
                            )

                          ],
                        ),
                      )
                  ),
                  // ASk a qus box
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.11,
                    child:  Container(
                        margin: EdgeInsets.only(top: 15.0,left: 20.0,right: 20.0),
                        decoration: new BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          border: Border.all(
                            color: Color(0xFFCD853F),
                            width: 4.5,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top:13.0, left: 80.0),
                          child: Text(
                            'ASK A QUESTION?',
                            style: new TextStyle(
                              fontFamily: "Poppins",
                              color: Color(0xFF000000), fontSize: 18.0,
                            ),
                          ),
                        )
                    ),
                  ),
                  //qus ans box
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.61,
                    margin: EdgeInsets.only(top:10.0,left: 20.0,right: 20.0,bottom: 5.0),
                    decoration: new BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      border: Border.all(
                        color: Color(0xFFFFFFFF),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(2.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width*0.85,
                          height: MediaQuery.of(context).size.height*0.05,
                          decoration: new BoxDecoration(
                            color: Color(0xFF000000),
                            border: Border.all(
                              color: Color(0xFF000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(2.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top:2.0,left: 8.0),
                            child: Text(
                              "Earn Coins: Answer a Question...",
                              style: TextStyle(
                                  fontSize: 19.5,
                                  color: Color(0xFFFFFFFF),
                                  fontFamily: "WorkSansBold"),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height*0.55,
                          child: getQusListView(qusList),
                        )
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 30.0,bottom: 10.0,left: 90.0,right: 75.0),
                    width: MediaQuery.of(context).size.width * 0.95,
                    decoration: new BoxDecoration(
                      color: Color(0xFFfec20f),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: MaterialButton(
                      splashColor: Colors.grey,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Subscribe",
                          style: TextStyle(
                              fontSize: 19.5,
                              color: Color(0xFFFFFFFF),
                              fontFamily: "WorkSansBold"),
                        ),
                      ),
                      onPressed: () async {

                      },
                    ),
                  ),
                ],
              ),
            ),
          ],

        ),
      ),
    );
  }

  goToQuestionTemp() async
  {
    List<Question> questions = await getQuestions();
    if (questions.length < 1) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ErrorPage(
            message:
            "There are not enough questions yet.",
          )));
      return;
    }
    Navigator.of(context).pop();
    Navigator.push(context, MaterialPageRoute(builder: (_) => QuestionTemplate(questions: questions)));
  }

}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color color;
}