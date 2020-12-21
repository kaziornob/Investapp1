import 'dart:io';
import 'package:auro/searchPage/searchPageFirst.dart';
import 'package:auro/shared/navigation_menu.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auro/style/theme.dart' as StyleTheme;
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:pie_chart/pie_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'riskOnBoardingPages/onBoardingFirst.dart';


final List<String> areaChartDataList = ['1','2','3','4'];
final List<String> pieChartDataList = ['1','2','3'];



class Invest extends StatefulWidget {
  @override
  _InvestState createState() => _InvestState();
}

class _InvestState extends State<Invest> {

  final GlobalKey<ScaffoldState> homeScaffoldKey = new GlobalKey<ScaffoldState>();

  int _currentPage;

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

  Widget _newBuildTitleRecommended(BuildContext context)
  {
    return InkWell(
      onTap: () => homeScaffoldKey.currentState.openDrawer(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: CircleAvatar(
              radius: 15.0,
              backgroundImage: new AssetImage('assets/download.jpeg'),
              backgroundColor: Colors.transparent,
            ),
          ),
          //search box area
          Container(
            margin: EdgeInsets.only(left:14.0),
            width: MediaQuery.of(context).size.width*0.52,
            height: MediaQuery.of(context).size.height*0.06,
            decoration: new BoxDecoration(
              color: Color(0xFFFFFFFF),
              border: Border.all(
                color: Color(0xff696969),
                width: 1.5,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 4.0),
                  width: MediaQuery.of(context).size.width*0.50,
                  height: MediaQuery.of(context).size.height*0.05,
                  child: TextFormField(
                    style: TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        fontSize: 14.0,
                        color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.settings_applications,
                        color: Colors.black,
                        size: 15,
                      ),
                      prefixIcon: Icon(
                        FontAwesomeIcons.search,
                        color: Colors.black,
                        size: 15,
                      ),
                      hintText: "Search",
                      hintStyle: TextStyle(
                          fontFamily: "WorkSansSemiBold", fontSize: 14.0),
                    ),
                  ),
                )
              ],
            ),
          ),
          //setting icon
          InkWell(
            child: Padding(
              padding: EdgeInsets.only(top: 4.0,left: 8.0),
              child: CircleAvatar(
                radius: 15.0,
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.settings,
                  color: Colors.black,
                  size: 30.0,
                ),
              ),
            )
          ),

        ],
      ),

    );
  }

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
            padding: EdgeInsets.only(left:35.0),
            child: Image(
                width: 180.0,
                fit: BoxFit.fill,
                image: new AssetImage('assets/login_logo.png')),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    /*final List<ChartData> chartData = [
      ChartData('USA', 25),
      ChartData('Japan', 38),
      ChartData('China', 34),
      ChartData('India', 52)
    ];*/

    final List<ChartData> chartData = [
      ChartData('David', 25, Color.fromRGBO(9,0,136,1)),
      ChartData('Steve', 38, Color.fromRGBO(147,0,119,1)),
      ChartData('Jack', 34, Color.fromRGBO(228,0,124,1)),
      ChartData('Others', 52, Color.fromRGBO(255,189,57,1))
    ];

    final List<Color> color = <Color>[];
    color.add(Colors.blue[50]);
    color.add(Colors.blue[200]);
    color.add(Colors.blue);

    final List<double> stops = <double>[];
    stops.add(0.0);
    stops.add(0.5);
    stops.add(1.0);

    final LinearGradient gradientColors =
    LinearGradient(colors: color, stops: stops);

    final List<NewSalesData> newSalesData = [
      NewSalesData(2010, 35),
      NewSalesData(2011, 28),
      NewSalesData(2012, 34),
      NewSalesData(2013, 32),
      NewSalesData(2014, 40)
    ];

    final List<Widget> areaChartSlider = areaChartDataList.map((item) =>
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                  height: MediaQuery.of(context).size.height*0.33,
                  child: Container(
                    decoration: new BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      border: Border.all(
                        color: Color(0xff696969),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(2.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.05,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left:5.0,top: 5.0),
                                child: new Image(
                                    width: 80.0,
                                    fit: BoxFit.fill,
                                    image: new AssetImage('assets/login_logo.png')),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left:20.0,top: 5.0),
                                child: Text(
                                  'Title',
                                  style: new TextStyle(
                                      fontFamily: "Poppins",
                                      color: Color(0xFF000000), fontSize: 18.0,
                                      letterSpacing: 0.2
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left:40.0,top: 5.0),
                                child: new Icon(
                                  Icons.menu,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
/*                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.008,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left:20.0),
                                child: Text(
                                  'Title',
                                  style: new TextStyle(
                                      fontFamily: "Poppins",
                                      color: Color(0xFF000000), fontSize: 15.0,
                                      letterSpacing: 0.2
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left:120.0,top: 5.0),
                                child: new Icon(
                                  Icons.menu,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),*/
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.58,
                          height: MediaQuery.of(context).size.height*0.12,
                          child: Container(
                            child: SfCartesianChart(
                                primaryXAxis: NumericAxis(
                                  isVisible: false,
                                ),
                                primaryYAxis: NumericAxis(
                                    isVisible: false
                                ),
                                series: <ChartSeries>[
                                  StackedAreaSeries<NewSalesData, double>(
                                    dataSource: newSalesData,
                                    xValueMapper: (NewSalesData data, _) => data.year,
                                    yValueMapper: (NewSalesData data, _) => data.sales,
                                    gradient: gradientColors,
                                  ),
                                ]
                            ),
                          )
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.10,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.26,
                                height: MediaQuery.of(context).size.height*0.10,
                                child: Container(
                                  margin: EdgeInsets.only(top: 5.0,left: 10.0),
                                  decoration: new BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xff696969),
                                      width: 1,
                                    ),
                                    color: Color(0xFFFFFFFF),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width*0.33,
                                        height: MediaQuery.of(context).size.height*0.038,
                                        child: Container(
                                            decoration: new BoxDecoration(
                                              color: Color(0xff696969),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 5.0),
                                              child: Text(
                                                'SELL',
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Color(0xFF000000),
                                                    fontFamily: "WorkSansBold"),
                                              ),
                                            )
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width*0.33,
                                        height: MediaQuery.of(context).size.height*0.038,
                                        child: Container(
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 20.0,top: 5.0),
                                              child: Text(
                                                '80.42',
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Color(0xFF000000),
                                                    fontFamily: "WorkSansBold"),
                                              ),
                                            )
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.29,
                                height: MediaQuery.of(context).size.height*0.10,
                                child: Container(
                                  margin: EdgeInsets.only(top: 5.0,left: 15.0),
                                  decoration: new BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xff696969),
                                      width: 1,
                                    ),
                                    color: Color(0xFFFFFFFF),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width*0.33,
                                        height: MediaQuery.of(context).size.height*0.038,
                                        child: Container(
                                            decoration: new BoxDecoration(
                                              color: Color(0xff696969),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 5.0),
                                              child: Text(
                                                'BUY',
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Color(0xFF000000),
                                                    fontFamily: "WorkSansBold"),
                                              ),
                                            )
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width*0.33,
                                        height: MediaQuery.of(context).size.height*0.038,
                                        child: Container(
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 20.0,top: 5.0),
                                              child: Text(
                                                '80.42',
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Color(0xFF000000),
                                                    fontFamily: "WorkSansBold"),
                                              ),
                                            )
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
              ),
            ],
          ),
        )
    ,).toList();


    final List<Widget> pieChartSlider = pieChartDataList.map((item) =>
        Container(
            margin: EdgeInsets.only(left: 5.0),
            height: MediaQuery.of(context).size.height*0.42,
            child: Container(
                decoration: new BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  border: Border.all(
                    color: Color(0xff696969),
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
/*                child: SfCircularChart(
                    legend: Legend(
                        isVisible: true,
                        alignment: ChartAlignment.center,
                        position: LegendPosition.bottom,
                        overflowMode: LegendItemOverflowMode.wrap,
                        itemPadding: 0.5
                    ),
                    series: <CircularSeries>[
                      // Render pie chart
                      PieSeries<ChartData, String>(
                        dataSource: chartData,
                        pointColorMapper:(ChartData data,  _) => data.color,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        dataLabelSettings:DataLabelSettings(isVisible : true),
                      )
                    ]
                )*/
            )
        )
      ,).toList();


    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        title: _newBuildTitleRecommended(context),
        backgroundColor: StyleTheme.Colors.AppBarBackGroundColor,
        iconTheme: IconThemeData(
          color: StyleTheme.Colors.AppBarMenuIconColor,
        ),
      ),
      drawer: NavigationMenu(),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                color: StyleTheme.Colors.backgroundColor,
              ),
              child: Column(
                children: <Widget>[
/*                    Padding(
                      padding: EdgeInsets.only(top: 20.0,left: 20.0),
                      child: Text(
                        'AURO PI-YOUR PERSONAL ASSET MANAGER',
                        style: new TextStyle(
                            fontFamily: "Poppins",
                            color: Color(0xFFFFFFFF), fontSize: 16.5,
                            letterSpacing: 0.2
                        ),
                      ),
                    ),*/
                  // search box
/*                  SizedBox(
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
                          padding: EdgeInsets.only(top:5.0, left: 140.0),
                          child: Text(
                            'Search',
                            style: new TextStyle(
                              fontFamily: "Poppins",
                              color: Color(0xFF000000), fontSize: 22.0,
                            ),
                          ),
                        )
                    ),
                  ),*/
                  // handshake image box
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.25,
                    child:  Container(
                      margin: EdgeInsets.only(top: 10.0,left: 5.0,right: 5.0),
                      child: Image(
                          fit: BoxFit.fill,
                          image: new AssetImage('assets/handShake.png')
                      ),
                    ),
                  ),
                  // auro paper box
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.40,
                    child:  Container(
                        margin: EdgeInsets.only(top: 5.0,left: 20.0,right: 20.0),
                        decoration: new BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFfec20f),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(2.0),
                          ),
                        ),
                        child: ListView(
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(top:5.0, left: 120.0,bottom: 5.0,right: 5.0),
                                child: Text(
                                  'Auro Paper',
                                  style: new TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    color: Color(0xFFFFFFFF), fontSize: 18.0,
                                  ),
                                )
                            ),
                            Container(
                                margin: EdgeInsets.only(top:1.0, left: 15.0,bottom: 5.0,right: 5.0),
                                child: Text(
                                  "Voila! We've created a paper portfolio for you that can help "
                                      "you start engaging and learning about how to invest. Please note that this is NOT our recommended investment portfolio for"
                                      " which you need to complete additional risk-onboarding: Go Pro",
                                  style: new TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    color: Color(0xFFFFFFFF), fontSize: 15.0,
                                  ),
                                )
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height*0.42,
                                child: Container(
                                    margin: EdgeInsets.only(top: 5.0,left: 20.0,right: 20.0,bottom: 5.0),
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
                                    child: CarouselSlider(
                                      options: CarouselOptions(
                                          aspectRatio: 2.0,
                                          enlargeCenterPage: false,
                                          scrollDirection: Axis.horizontal,
                                          autoPlay: false,
                                      ),
                                      items: pieChartSlider,
                                    ),
/*                                    child: SfCircularChart(
                                        legend: Legend(
                                            isVisible: true,
                                            alignment: ChartAlignment.center,
                                            position: LegendPosition.bottom,
                                            overflowMode: LegendItemOverflowMode.wrap,
                                            itemPadding: 0.5
                                        ),
                                        series: <CircularSeries>[
                                          // Render pie chart
                                          PieSeries<ChartData, String>(
                                            dataSource: chartData,
                                            pointColorMapper:(ChartData data,  _) => data.color,
                                            xValueMapper: (ChartData data, _) => data.x,
                                            yValueMapper: (ChartData data, _) => data.y,
                                            dataLabelSettings:DataLabelSettings(isVisible : true),
                                          )
                                        ]
                                    )*/
                                )
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.0,bottom: 10.0,left: 65.0,right: 50.0),
                              width: MediaQuery.of(context).size.width * 0.95,
                              decoration: new BoxDecoration(
                                color: Color(0xFFfec20f),
                                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                              ),
                              child: MaterialButton(
                                splashColor: Colors.grey,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20.0,top: 3.0),
                                  child: Text(
                                    "Initiate First Name Portfolio",
                                    style: TextStyle(
                                        fontSize: 17.5,
                                        color: Color(0xFFFFFFFF),
                                        fontFamily: "WorkSansBold"),
                                  ),
                                ),
                                onPressed: () async {

                                  Navigator.of(context).push(new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                      new SearchPageFirst(logo: "login_logo.png",callingFrom: "Accredited Investor",)));

                                },
                              ),
                            ),
                          ],
                        )
                    ),
                  ),
                  // go pro button
                  Container(
                    margin: EdgeInsets.only(top:15.0,left: 15.0,right: 15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 5.0,right: 5.0),
                          decoration: new BoxDecoration(
                            color: Color(0xFFfec20f),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child: MaterialButton(
                            splashColor: Colors.grey,
                            child: Padding(
                              padding: EdgeInsets.only(left: 15.0,right: 15.0),
                              child: Center(
                                child: Text(
                                  "GO PRO",
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      color: Color(0xFFFFFFFF),
                                      fontFamily: "WorkSansBold"),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                  new OnBoardingFirst(logo: "login_logo.png",callingFrom: "Accredited Investor",)));
                            },
                          ),
                        ),
                        Container(
                          width: 33,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5.0,right: 5.0),

                          decoration: new BoxDecoration(
                            color: Color(0xFFfec20f),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child: MaterialButton(
                            splashColor: Colors.grey,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0,right: 10.0),
                              child: Center(
                                child: Text(
                                  "GO LIVE",
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      color: Color(0xFFFFFFFF),
                                      fontFamily: "WorkSansBold"),
                                ),
                              ),
                            ),
                            onPressed: () async {
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
/*                    Container(
                      margin: EdgeInsets.only(top: 15.0,left: 150.0,right: 105.0),
                      width: MediaQuery.of(context).size.width * 0.95,
                      decoration: new BoxDecoration(
                        color: Color(0xFFfec20f),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                      child: MaterialButton(
                        splashColor: Colors.grey,
                        child: Text(
                          "GO PRO",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFFFFFFFF),
                              fontFamily: "WorkSansBold"),
                        ),
                        onPressed: () async {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                              new OnBoardingFirst(logo: "login_logo.png",logoBottomLine: "YOUR PERSONAL ASSET MANAGER",callingFrom: "Accredited Investor",)));
                        },
                      ),
                    ),*/
                  // portfolio component box
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.50,
                    child:  Container(
                        margin: EdgeInsets.only(top: 15.0,left: 20.0,right: 20.0),
                        decoration: new BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFfec20f),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(2.0),
                          ),
                        ),
                        child: ListView(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top:5.0),
                              child: Center(
                                  child: Text(
                                    'PORTFOLIO COMPONENTS',
                                    style: new TextStyle(
                                      fontFamily: "WorkSansSemiBold",
                                      color: Color(0xFFFFFFFF), fontSize: 18.0,
                                    ),
                                  )
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top:10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(left:90.0,bottom: 5.0),
                                        child: Text(
                                          'Auro Portfolio',
                                          style: new TextStyle(
                                            fontFamily: "WorkSansSemiBold",
                                            color: Color(0xFFFFFFFF), fontSize: 18.0,
                                          ),
                                        )
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(left:30.0,top: 3.0),
                                        child: Text(
                                          'See More',
                                          style: new TextStyle(
                                            decoration: TextDecoration.underline,
                                            fontFamily: "WorkSansSemiBold",
                                            color: Color(0xFFFFFFFF), fontSize: 15.0,
                                          ),
                                        )
                                    )
                                  ],
                                )
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height*0.34,
                                child: Container(
                                    margin: EdgeInsets.only(top: 5.0,left: 20.0,right: 20.0,bottom: 5.0),
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
                                    child: CarouselSlider(
                                      options: CarouselOptions(
                                          aspectRatio: 2.0,
                                          enlargeCenterPage: false,
                                          scrollDirection: Axis.horizontal,
                                          autoPlay: false,
                                          onPageChanged: (index, reason) {
                                            print("_currentPage: $_currentPage");
                                            setState(() {
                                              _currentPage = index;
                                            });
                                          }
                                      ),
                                      items: areaChartSlider,
                                    )
                                )
                            ),
                            Divider(color: Color(0xFFfec20f),thickness: 1.5,),
                            Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(left:50.0,bottom: 5.0),
                                        child: Text(
                                          "First Name's Portfolio",
                                          style: new TextStyle(
                                            fontFamily: "WorkSansSemiBold",
                                            color: Color(0xFFFFFFFF), fontSize: 18.0,
                                          ),
                                        )
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(left:15.0,bottom: 5.0,top: 3.0),
                                        child: Text(
                                          'See More',
                                          style: new TextStyle(
                                            decoration: TextDecoration.underline,
                                            fontFamily: "WorkSansSemiBold",
                                            color: Color(0xFFFFFFFF), fontSize: 15.0,
                                          ),
                                        )
                                    ),
                                  ],
                                )
                            ),
                            Container(
                              margin: EdgeInsets.only(left:15.0,bottom: 5.0,top: 5.0),
                              child: Text(
                                'You can also invest in individual securities that you like and create your own portfolio!! ',
                                style: new TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  color: Color(0xFFFFFFFF), fontSize: 15.0,
                                ),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(top: 20.0,bottom: 10.0,left: 90.0,right: 75.0),
                              width: MediaQuery.of(context).size.width * 0.95,
                              decoration: new BoxDecoration(
                                color: Color(0xFFfec20f),
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: MaterialButton(
                                splashColor: Colors.grey,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8.0,top: 2.0),
                                  child: Text(
                                    "START NOW",
                                    style: TextStyle(
                                        fontSize: 17.5,
                                        color: Color(0xFFFFFFFF),
                                        fontFamily: "WorkSansBold"),
                                  ),
                                ),
                                onPressed: () async {

                                },
                              ),
                            ),
                          ],
                        )
                    ),
                  ),
                  // go live button
/*                    Container(
                      margin: EdgeInsets.only(top: 15.0,left: 145.0,right: 105.0),
                      width: MediaQuery.of(context).size.width * 0.95,
                      decoration: new BoxDecoration(
                        color: Color(0xFFfec20f),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                      child: MaterialButton(
                        splashColor: Colors.grey,
                        child: Text(
                          "GO LIVE",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFFFFFFFF),
                              fontFamily: "WorkSansBold"),
                        ),
                        onPressed: () async {

                        },
                      ),
                    ),*/

                  // investment guru component box
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.50,
                    child:  Container(
                        margin: EdgeInsets.only(top: 15.0,left: 20.0,right: 20.0),
                        decoration: new BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFfec20f),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(2.0),
                          ),
                        ),
                        child: ListView(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top:10.0),
                              child: Center(
                                  child: Text(
                                    'INVESTMENT GURUS',
                                    style: new TextStyle(
                                      fontFamily: "WorkSansSemiBold",
                                      color: Color(0xFFFFFFFF), fontSize: 18.0,
                                    ),
                                  )
                              ),
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height*0.34,
                                child: Container(
                                    margin: EdgeInsets.only(top: 5.0,left: 20.0,right: 20.0,bottom: 5.0),
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
                                    child: CarouselSlider(
                                      options: CarouselOptions(
                                          aspectRatio: 2.0,
                                          enlargeCenterPage: false,
                                          scrollDirection: Axis.horizontal,
                                          autoPlay: false,
                                          onPageChanged: (index, reason) {
                                            print("_currentPage: $_currentPage");
                                            setState(() {
                                              _currentPage = index;
                                            });
                                          }
                                      ),
                                      items: areaChartSlider,
                                    )
                                )
                            ),
                            Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(left:230.0,bottom: 5.0,top: 3.0),
                                        child: Text(
                                          'See More',
                                          style: new TextStyle(
                                            fontFamily: "WorkSansSemiBold",
                                            decoration: TextDecoration.underline,
                                            color: Color(0xFFFFFFFF), fontSize: 15.0,
                                          ),
                                        )
                                    ),
                                  ],
                                )
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20.0,bottom: 10.0,left: 90.0,right: 75.0),
                              width: MediaQuery.of(context).size.width * 0.95,
                              decoration: new BoxDecoration(
                                color: Color(0xFFfec20f),
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: MaterialButton(
                                splashColor: Colors.grey,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8.0,top: 2.0),
                                  child: Text(
                                    "START NOW",
                                    style: TextStyle(
                                        fontSize: 17.5,
                                        color: Color(0xFFFFFFFF),
                                        fontFamily: "WorkSansBold"),
                                  ),
                                ),
                                onPressed: () async {

                                },
                              ),
                            ),
                          ],
                        )
                    ),
                  ),
                  // pe/vc/re component box
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.27,
                    child:  Container(
                        margin: EdgeInsets.only(top: 15.0,left: 20.0,right: 20.0),
                        decoration: new BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFfec20f),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(2.0),
                          ),
                        ),
                        child: ListView(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top:15.0),
                              child: Center(
                                  child: Text(
                                    'PE/VC/RE/ESG',
                                    style: new TextStyle(
                                      fontFamily: "WorkSansSemiBold",
                                      color: Color(0xFFFFFFFF), fontSize: 18.0,
                                    ),
                                  )
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 40.0,bottom: 10.0,left: 90.0,right: 75.0),
                              width: MediaQuery.of(context).size.width * 0.95,
                              decoration: new BoxDecoration(
                                color: Color(0xFFfec20f),
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: MaterialButton(
                                splashColor: Colors.grey,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8.0,top: 2.0),
                                  child: Text(
                                    "START NOW",
                                    style: TextStyle(
                                        fontSize: 17.5,
                                        color: Color(0xFFFFFFFF),
                                        fontFamily: "WorkSansBold"),
                                  ),
                                ),
                                onPressed: () async {

                                },
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left:235.0),
                                child: Text(
                                  'See More',
                                  style: new TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    decoration: TextDecoration.underline,
                                    color: Color(0xFFFFFFFF), fontSize: 17.0,
                                  ),
                                )
                            ),

                          ],
                        )
                    ),
                  ),
                  // last start now component box
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.27,
                    child:  Container(
                        margin: EdgeInsets.only(top: 15.0,left: 20.0,right: 20.0),
                        decoration: new BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFfec20f),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(2.0),
                          ),
                        ),
                        child: ListView(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 90.0,bottom: 10.0,left: 90.0,right: 75.0),
                              width: MediaQuery.of(context).size.width * 0.95,
                              decoration: new BoxDecoration(
                                color: Color(0xFFfec20f),
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: MaterialButton(
                                splashColor: Colors.grey,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8.0,top: 2.0),
                                  child: Text(
                                    "START NOW",
                                    style: TextStyle(
                                        fontSize: 17.5,
                                        color: Color(0xFFFFFFFF),
                                        fontFamily: "WorkSansBold"),
                                  ),
                                ),
                                onPressed: () async {

                                },
                              ),
                            ),

                          ],
                        )
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

}


class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color color;
}


class NewSalesData {
  NewSalesData(this.year, this.sales);
  final double year;
  final double sales;
}