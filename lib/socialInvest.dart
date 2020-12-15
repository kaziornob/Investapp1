import 'dart:io';
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

    final List<ChartData> chartData = [
      ChartData('USA', 25),
      ChartData('Japan', 38),
      ChartData('China', 34),
      ChartData('India', 52)
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
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                color: StyleTheme.Colors.backgroundColor,
              ),
              child: Column(
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