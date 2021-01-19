import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/modules/investRelatedPages/securityFirstPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class SearchFirstPage extends StatefulWidget {
  final String callingFrom;
  final String logo;

  const SearchFirstPage({Key key, @required this.callingFrom,this.logo}) : super(key: key);

  @override
  _SearchFirstPageState createState() => _SearchFirstPageState();
}

class _SearchFirstPageState extends State<SearchFirstPage> with SingleTickerProviderStateMixin {
  bool _isInProgress = false;

  int selectedTabIndex;

  final List<Tab> tabList = <Tab>[
    new Tab(text: 'Top Trending News'),
    new Tab(text: 'VC/ PE/ RE/ ESG'),
    new Tab(text: 'Crypto'),
    new Tab(text: 'Equities')
  ];

  TabController _tabController;

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

  Widget topTrendingNews()
  {
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

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10.0,left: 12.0),
            child: Text(
              'Click on any of the following to start adding to your personal sleeve!',
              style: new TextStyle(
                  color: AllCoustomTheme.getTextThemeColors(),
                  fontSize: ConstanceData.SIZE_TITLE14,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.40,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width*0.45,
                  height: MediaQuery.of(context).size.height*0.41,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //first row of small box
                      Container(
                        child: Row(
                          children: <Widget>[
                            //first box of first row
                            InkWell(
                              onTap: (){
                                Navigator.of(context).push(new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                    new SecurityPageFirst(logo: widget.logo,callingFrom: widget.callingFrom,)));
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 5.0,top: 5.0),
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.19,
                                decoration: new BoxDecoration(
                                  color: Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  border: Border.all(
                                    color: Color(0xff696969),
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left: 3.5),
                                      width: MediaQuery.of(context).size.width*0.21,
                                      height: MediaQuery.of(context).size.height*0.05,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(top: 10.0),
                                            child: new Image(
                                                width: 35.0,
                                                fit: BoxFit.fill,
                                                image: new AssetImage('assets/logo.png')),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10.0),
                                            child: Text(
                                              'Title',
                                              style: new TextStyle(
                                                  fontFamily: "Poppins",
                                                  color: Color(0xFF000000), fontSize: 12.0,
                                                  letterSpacing: 0.2
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10.0),
                                            child: new Icon(
                                              Icons.menu,
                                              color: Colors.black,
                                              size: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 3.5),
                                      width: MediaQuery.of(context).size.width*0.21,
                                      height: MediaQuery.of(context).size.height*0.01,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(top: 0.0),
                                            child: Text(
                                              'CHANGE(1D)',
                                              style: new TextStyle(
                                                  fontFamily: "Poppins",
                                                  color: Color(0xFF000000), fontSize: 7.0,
                                                  letterSpacing: 0.2
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 0.0),
                                            child: Text(
                                              '27.18',
                                              style: new TextStyle(
                                                  fontFamily: "Poppins",
                                                  color: Color(0xFFe70b31), fontSize: 8.0,
                                                  letterSpacing: 0.2
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.21,
                                      height: MediaQuery.of(context).size.height*0.09,
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
                                    ),
                                    Container(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width*0.09,
                                            height: MediaQuery.of(context).size.height*0.036,
                                            child: Container(
                                              margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
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
                                                    width: MediaQuery.of(context).size.width*0.10,
                                                    height: MediaQuery.of(context).size.height*0.015,
                                                    child: Container(
                                                        decoration: new BoxDecoration(
                                                          color: Color(0xff696969),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(left: 3.0),
                                                          child: Text(
                                                            'SELL',
                                                            style: TextStyle(
                                                                fontSize: 7.0,
                                                                color: Color(0xFF000000),
                                                                fontFamily: "WorkSansBold"),
                                                          ),
                                                        )
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width*0.10,
                                                    height: MediaQuery.of(context).size.height*0.015,
                                                    child: Container(
                                                        child: Padding(
                                                          padding: EdgeInsets.only(left: 5.0,top: 5.0),
                                                          child: Text(
                                                            '80.42',
                                                            style: TextStyle(
                                                                fontSize: 7.0,
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
                                            width: MediaQuery.of(context).size.width*0.09,
                                            height: MediaQuery.of(context).size.height*0.036,
                                            child: Container(
                                              margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
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
                                                    width: MediaQuery.of(context).size.width*0.10,
                                                    height: MediaQuery.of(context).size.height*0.015,
                                                    child: Container(
                                                        decoration: new BoxDecoration(
                                                          color: Color(0xff696969),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(left: 3.0),
                                                          child: Text(
                                                            'BUY',
                                                            style: TextStyle(
                                                                fontSize: 7.0,
                                                                color: Color(0xFF000000),
                                                                fontFamily: "WorkSansBold"),
                                                          ),
                                                        )
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width*0.10,
                                                    height: MediaQuery.of(context).size.height*0.015,
                                                    child: Container(
                                                        child: Padding(
                                                          padding: EdgeInsets.only(left: 5.0,top: 5.0),
                                                          child: Text(
                                                            '80.42',
                                                            style: TextStyle(
                                                                fontSize: 7.0,
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
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //second  box of first row
                            InkWell(
                                onTap: (){
/*                                  Navigator.of(context).push(new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                      new SecurityPageFirst(logo: widget.logo,callingFrom: widget.callingFrom,)));*/
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 5.0,top: 5.0),
                                  width: MediaQuery.of(context).size.width*0.21,
                                  height: MediaQuery.of(context).size.height*0.19,
                                  decoration: new BoxDecoration(
                                    color: Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    border: Border.all(
                                      color: Color(0xff696969),
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left: 3.5),
                                        width: MediaQuery.of(context).size.width*0.21,
                                        height: MediaQuery.of(context).size.height*0.05,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(top: 10.0),
                                              child: new Image(
                                                  width: 35.0,
                                                  fit: BoxFit.fill,
                                                  image: new AssetImage('assets/logo.png')),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 10.0),
                                              child: Text(
                                                'Title',
                                                style: new TextStyle(
                                                    fontFamily: "Poppins",
                                                    color: Color(0xFF000000), fontSize: 12.0,
                                                    letterSpacing: 0.2
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 10.0),
                                              child: new Icon(
                                                Icons.menu,
                                                color: Colors.black,
                                                size: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 3.5),
                                        width: MediaQuery.of(context).size.width*0.21,
                                        height: MediaQuery.of(context).size.height*0.01,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(top: 0.0),
                                              child: Text(
                                                'CHANGE(1D)',
                                                style: new TextStyle(
                                                    fontFamily: "Poppins",
                                                    color: Color(0xFF000000), fontSize: 7.0,
                                                    letterSpacing: 0.2
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 0.0),
                                              child: Text(
                                                '27.18',
                                                style: new TextStyle(
                                                    fontFamily: "Poppins",
                                                    color: Color(0xFFe70b31), fontSize: 8.0,
                                                    letterSpacing: 0.2
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.21,
                                        height: MediaQuery.of(context).size.height*0.09,
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
                                      ),
                                      Container(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width*0.09,
                                              height: MediaQuery.of(context).size.height*0.036,
                                              child: Container(
                                                margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
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
                                                      width: MediaQuery.of(context).size.width*0.10,
                                                      height: MediaQuery.of(context).size.height*0.015,
                                                      child: Container(
                                                          decoration: new BoxDecoration(
                                                            color: Color(0xff696969),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.only(left: 3.0),
                                                            child: Text(
                                                              'SELL',
                                                              style: TextStyle(
                                                                  fontSize: 7.0,
                                                                  color: Color(0xFF000000),
                                                                  fontFamily: "WorkSansBold"),
                                                            ),
                                                          )
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: MediaQuery.of(context).size.width*0.10,
                                                      height: MediaQuery.of(context).size.height*0.015,
                                                      child: Container(
                                                          child: Padding(
                                                            padding: EdgeInsets.only(left: 5.0,top: 5.0),
                                                            child: Text(
                                                              '80.42',
                                                              style: TextStyle(
                                                                  fontSize: 7.0,
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
                                              width: MediaQuery.of(context).size.width*0.09,
                                              height: MediaQuery.of(context).size.height*0.036,
                                              child: Container(
                                                margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
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
                                                      width: MediaQuery.of(context).size.width*0.10,
                                                      height: MediaQuery.of(context).size.height*0.015,
                                                      child: Container(
                                                          decoration: new BoxDecoration(
                                                            color: Color(0xff696969),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.only(left: 3.0),
                                                            child: Text(
                                                              'BUY',
                                                              style: TextStyle(
                                                                  fontSize: 7.0,
                                                                  color: Color(0xFF000000),
                                                                  fontFamily: "WorkSansBold"),
                                                            ),
                                                          )
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: MediaQuery.of(context).size.width*0.10,
                                                      height: MediaQuery.of(context).size.height*0.015,
                                                      child: Container(
                                                          child: Padding(
                                                            padding: EdgeInsets.only(left: 5.0,top: 5.0),
                                                            child: Text(
                                                              '80.42',
                                                              style: TextStyle(
                                                                  fontSize: 7.0,
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
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ),

                          ],
                        ),
                      ),
                      //second row of small box
                      Container(
                        child: Row(
                          children: <Widget>[
                            //first box of first row
                            InkWell(
                              onTap: (){
/*                                Navigator.of(context).push(new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                    new SecurityPageFirst(logo: widget.logo,callingFrom: widget.callingFrom,)));*/
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 5.0,top: 5.0),
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.19,
                                decoration: new BoxDecoration(
                                  color: Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  border: Border.all(
                                    color: Color(0xff696969),
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left: 3.5),
                                      width: MediaQuery.of(context).size.width*0.21,
                                      height: MediaQuery.of(context).size.height*0.05,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(top: 10.0),
                                            child: new Image(
                                                width: 35.0,
                                                fit: BoxFit.fill,
                                                image: new AssetImage('assets/logo.png')),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10.0),
                                            child: Text(
                                              'Title',
                                              style: new TextStyle(
                                                  fontFamily: "Poppins",
                                                  color: Color(0xFF000000), fontSize: 12.0,
                                                  letterSpacing: 0.2
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10.0),
                                            child: new Icon(
                                              Icons.menu,
                                              color: Colors.black,
                                              size: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 3.5),
                                      width: MediaQuery.of(context).size.width*0.21,
                                      height: MediaQuery.of(context).size.height*0.01,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(top: 0.0),
                                            child: Text(
                                              'CHANGE(1D)',
                                              style: new TextStyle(
                                                  fontFamily: "Poppins",
                                                  color: Color(0xFF000000), fontSize: 7.0,
                                                  letterSpacing: 0.2
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 0.0),
                                            child: Text(
                                              '27.18',
                                              style: new TextStyle(
                                                  fontFamily: "Poppins",
                                                  color: Color(0xFFe70b31), fontSize: 8.0,
                                                  letterSpacing: 0.2
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.21,
                                      height: MediaQuery.of(context).size.height*0.09,
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
                                    ),
                                    Container(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width*0.09,
                                            height: MediaQuery.of(context).size.height*0.036,
                                            child: Container(
                                              margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
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
                                                    width: MediaQuery.of(context).size.width*0.10,
                                                    height: MediaQuery.of(context).size.height*0.015,
                                                    child: Container(
                                                        decoration: new BoxDecoration(
                                                          color: Color(0xff696969),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(left: 3.0),
                                                          child: Text(
                                                            'SELL',
                                                            style: TextStyle(
                                                                fontSize: 7.0,
                                                                color: Color(0xFF000000),
                                                                fontFamily: "WorkSansBold"),
                                                          ),
                                                        )
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width*0.10,
                                                    height: MediaQuery.of(context).size.height*0.015,
                                                    child: Container(
                                                        child: Padding(
                                                          padding: EdgeInsets.only(left: 5.0,top: 5.0),
                                                          child: Text(
                                                            '80.42',
                                                            style: TextStyle(
                                                                fontSize: 7.0,
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
                                            width: MediaQuery.of(context).size.width*0.09,
                                            height: MediaQuery.of(context).size.height*0.036,
                                            child: Container(
                                              margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
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
                                                    width: MediaQuery.of(context).size.width*0.10,
                                                    height: MediaQuery.of(context).size.height*0.015,
                                                    child: Container(
                                                        decoration: new BoxDecoration(
                                                          color: Color(0xff696969),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(left: 3.0),
                                                          child: Text(
                                                            'BUY',
                                                            style: TextStyle(
                                                                fontSize: 7.0,
                                                                color: Color(0xFF000000),
                                                                fontFamily: "WorkSansBold"),
                                                          ),
                                                        )
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width*0.10,
                                                    height: MediaQuery.of(context).size.height*0.015,
                                                    child: Container(
                                                        child: Padding(
                                                          padding: EdgeInsets.only(left: 5.0,top: 5.0),
                                                          child: Text(
                                                            '80.42',
                                                            style: TextStyle(
                                                                fontSize: 7.0,
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
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //second box of first row
                            InkWell(
                                onTap: (){
/*                                  Navigator.of(context).push(new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                      new SecurityPageFirst(logo: widget.logo,callingFrom: widget.callingFrom,)));*/
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 5.0,top: 5.0),
                                  width: MediaQuery.of(context).size.width*0.21,
                                  height: MediaQuery.of(context).size.height*0.19,
                                  decoration: new BoxDecoration(
                                    color: Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    border: Border.all(
                                      color: Color(0xff696969),
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left: 3.5),
                                        width: MediaQuery.of(context).size.width*0.21,
                                        height: MediaQuery.of(context).size.height*0.05,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(top: 10.0),
                                              child: new Image(
                                                  width: 35.0,
                                                  fit: BoxFit.fill,
                                                  image: new AssetImage('assets/logo.png')),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 10.0),
                                              child: Text(
                                                'Title',
                                                style: new TextStyle(
                                                    fontFamily: "Poppins",
                                                    color: Color(0xFF000000), fontSize: 12.0,
                                                    letterSpacing: 0.2
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 10.0),
                                              child: new Icon(
                                                Icons.menu,
                                                color: Colors.black,
                                                size: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 3.5),
                                        width: MediaQuery.of(context).size.width*0.21,
                                        height: MediaQuery.of(context).size.height*0.01,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(top: 0.0),
                                              child: Text(
                                                'CHANGE(1D)',
                                                style: new TextStyle(
                                                    fontFamily: "Poppins",
                                                    color: Color(0xFF000000), fontSize: 7.0,
                                                    letterSpacing: 0.2
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 0.0),
                                              child: Text(
                                                '27.18',
                                                style: new TextStyle(
                                                    fontFamily: "Poppins",
                                                    color: Color(0xFFe70b31), fontSize: 8.0,
                                                    letterSpacing: 0.2
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.21,
                                        height: MediaQuery.of(context).size.height*0.09,
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
                                      ),
                                      Container(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width*0.09,
                                              height: MediaQuery.of(context).size.height*0.036,
                                              child: Container(
                                                margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
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
                                                      width: MediaQuery.of(context).size.width*0.10,
                                                      height: MediaQuery.of(context).size.height*0.015,
                                                      child: Container(
                                                          decoration: new BoxDecoration(
                                                            color: Color(0xff696969),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.only(left: 3.0),
                                                            child: Text(
                                                              'SELL',
                                                              style: TextStyle(
                                                                  fontSize: 7.0,
                                                                  color: Color(0xFF000000),
                                                                  fontFamily: "WorkSansBold"),
                                                            ),
                                                          )
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: MediaQuery.of(context).size.width*0.10,
                                                      height: MediaQuery.of(context).size.height*0.015,
                                                      child: Container(
                                                          child: Padding(
                                                            padding: EdgeInsets.only(left: 5.0,top: 5.0),
                                                            child: Text(
                                                              '80.42',
                                                              style: TextStyle(
                                                                  fontSize: 7.0,
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
                                              width: MediaQuery.of(context).size.width*0.09,
                                              height: MediaQuery.of(context).size.height*0.036,
                                              child: Container(
                                                margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
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
                                                      width: MediaQuery.of(context).size.width*0.10,
                                                      height: MediaQuery.of(context).size.height*0.015,
                                                      child: Container(
                                                          decoration: new BoxDecoration(
                                                            color: Color(0xff696969),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.only(left: 3.0),
                                                            child: Text(
                                                              'BUY',
                                                              style: TextStyle(
                                                                  fontSize: 7.0,
                                                                  color: Color(0xFF000000),
                                                                  fontFamily: "WorkSansBold"),
                                                            ),
                                                          )
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: MediaQuery.of(context).size.width*0.10,
                                                      height: MediaQuery.of(context).size.height*0.015,
                                                      child: Container(
                                                          child: Padding(
                                                            padding: EdgeInsets.only(left: 5.0,top: 5.0),
                                                            child: Text(
                                                              '80.42',
                                                              style: TextStyle(
                                                                  fontSize: 7.0,
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
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            )
                          ],
                        ),
                      ),

                    ],
                  ),

                ),
                //Big Box
                Container(
                  margin: EdgeInsets.only(top: 5.0,left: 5.0,right: 5.0,bottom: 5.0),
                  width: MediaQuery.of(context).size.width*0.45,
                  height: MediaQuery.of(context).size.height*0.41,
                  decoration: new BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    border: Border.all(
                      color: Color(0xff696969),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width*0.44,
                        height: MediaQuery.of(context).size.height*0.10,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 10.0,left: 5.0),
                              child: new Image(
                                  width: 80.0,
                                  fit: BoxFit.fill,
                                  image: new AssetImage('assets/logo.png')),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0,left: 5.0),
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
                              padding: EdgeInsets.only(top: 10.0,left: 5.0),
                              child: new Icon(
                                Icons.menu,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.44,
                        height: MediaQuery.of(context).size.height*0.03,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 0.0,left: 8.0),
                              child: Text(
                                'CHANGE(1D)',
                                style: new TextStyle(
                                    fontFamily: "Poppins",
                                    color: Color(0xFF000000), fontSize: 14.0,
                                    letterSpacing: 0.2
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 0.0,left: 15.0),
                              child: Text(
                                '27.18',
                                style: new TextStyle(
                                    fontFamily: "Poppins",
                                    color: Color(0xFFe70b31), fontSize: 14.0,
                                    letterSpacing: 0.2
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width*0.44,
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
                      Container(
                        width: MediaQuery.of(context).size.width*0.44,
                        height: MediaQuery.of(context).size.height*0.10,
                        margin: EdgeInsets.only(top: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.20,
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
                              width: MediaQuery.of(context).size.width*0.20,
                              height: MediaQuery.of(context).size.height*0.10,
                              child: Container(
                                margin: EdgeInsets.only(top: 8.0,left: 15.0),
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

              ],
            ),

          ),
          Container(
              width: MediaQuery.of(context).size.width*0.70,
              height: MediaQuery.of(context).size.height*0.05,
              margin: EdgeInsets.only(top: 20.0,left: 10.0,right: 10.0),
              decoration: new BoxDecoration(
                border: Border.all(
                  color: Color(0xfffec20f),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 3.5,left: 10.0,right: 10.0),
                child: Text(
                  "TOP TRENDING NEWS",
                  style: new TextStyle(
                    color: AllCoustomTheme.getTextThemeColors(),
                    fontSize: ConstanceData.SIZE_TITLE16,
                  ),
                ),
              )
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.44,
              margin: EdgeInsets.only(top: 15.0,left: 10.0,right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 5.0,right: 5.0),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.20,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 5.0,top: 5.0),
                          width: MediaQuery.of(context).size.width*0.21,
                          height: MediaQuery.of(context).size.height*0.19,
                          decoration: new BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(
                              color: Color(0xff696969),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 3.5),
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.05,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: new Image(
                                          width: 35.0,
                                          fit: BoxFit.fill,
                                          image: new AssetImage('assets/logo.png')),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        'Title',
                                        style: new TextStyle(
                                            color: AllCoustomTheme.getTextThemeColors(),
                                            fontSize: ConstanceData.SIZE_TITLE12,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: new Icon(
                                        Icons.menu,
                                        color: Colors.black,
                                        size: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 3.5),
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.01,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 0.0),
                                      child: Text(
                                        'CHANGE(1D)',
                                        style: new TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color(0xFF000000), fontSize: 7.0,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 0.0),
                                      child: Text(
                                        '27.18',
                                        style: new TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color(0xFFe70b31), fontSize: 8.0,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.09,
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
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*0.09,
                                      height: MediaQuery.of(context).size.height*0.036,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
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
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  decoration: new BoxDecoration(
                                                    color: Color(0xff696969),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 3.0),
                                                    child: Text(
                                                      'SELL',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
                                                          color: Color(0xFF000000),
                                                          fontFamily: "WorkSansBold"),
                                                    ),
                                                  )
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 5.0,top: 5.0),
                                                    child: Text(
                                                      '80.42',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
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
                                      width: MediaQuery.of(context).size.width*0.09,
                                      height: MediaQuery.of(context).size.height*0.036,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
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
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  decoration: new BoxDecoration(
                                                    color: Color(0xff696969),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 3.0),
                                                    child: Text(
                                                      'BUY',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
                                                          color: Color(0xFF000000),
                                                          fontFamily: "WorkSansBold"),
                                                    ),
                                                  )
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 5.0,top: 5.0),
                                                    child: Text(
                                                      '80.42',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5.0,top: 5.0),
                          width: MediaQuery.of(context).size.width*0.21,
                          height: MediaQuery.of(context).size.height*0.19,
                          decoration: new BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(
                              color: Color(0xff696969),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 3.5),
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.05,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: new Image(
                                          width: 35.0,
                                          fit: BoxFit.fill,
                                          image: new AssetImage('assets/logo.png')),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        'Title',
                                        style: new TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color(0xFF000000), fontSize: 12.0,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: new Icon(
                                        Icons.menu,
                                        color: Colors.black,
                                        size: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 3.5),
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.01,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 0.0),
                                      child: Text(
                                        'CHANGE(1D)',
                                        style: new TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color(0xFF000000), fontSize: 7.0,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 0.0),
                                      child: Text(
                                        '27.18',
                                        style: new TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color(0xFFe70b31), fontSize: 8.0,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.09,
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
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*0.09,
                                      height: MediaQuery.of(context).size.height*0.036,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
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
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  decoration: new BoxDecoration(
                                                    color: Color(0xff696969),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 3.0),
                                                    child: Text(
                                                      'SELL',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
                                                          color: Color(0xFF000000),
                                                          fontFamily: "WorkSansBold"),
                                                    ),
                                                  )
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 5.0,top: 5.0),
                                                    child: Text(
                                                      '80.42',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
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
                                      width: MediaQuery.of(context).size.width*0.09,
                                      height: MediaQuery.of(context).size.height*0.036,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
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
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  decoration: new BoxDecoration(
                                                    color: Color(0xff696969),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 3.0),
                                                    child: Text(
                                                      'BUY',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
                                                          color: Color(0xFF000000),
                                                          fontFamily: "WorkSansBold"),
                                                    ),
                                                  )
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 5.0,top: 5.0),
                                                    child: Text(
                                                      '80.42',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5.0,top: 5.0),
                          width: MediaQuery.of(context).size.width*0.21,
                          height: MediaQuery.of(context).size.height*0.19,
                          decoration: new BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(
                              color: Color(0xff696969),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 3.5),
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.05,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: new Image(
                                          width: 35.0,
                                          fit: BoxFit.fill,
                                          image: new AssetImage('assets/logo.png')),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        'Title',
                                        style: new TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color(0xFF000000), fontSize: 12.0,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: new Icon(
                                        Icons.menu,
                                        color: Colors.black,
                                        size: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 3.5),
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.01,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 0.0),
                                      child: Text(
                                        'CHANGE(1D)',
                                        style: new TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color(0xFF000000), fontSize: 7.0,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 0.0),
                                      child: Text(
                                        '27.18',
                                        style: new TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color(0xFFe70b31), fontSize: 8.0,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.09,
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
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*0.09,
                                      height: MediaQuery.of(context).size.height*0.036,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
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
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  decoration: new BoxDecoration(
                                                    color: Color(0xff696969),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 3.0),
                                                    child: Text(
                                                      'SELL',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
                                                          color: Color(0xFF000000),
                                                          fontFamily: "WorkSansBold"),
                                                    ),
                                                  )
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 5.0,top: 5.0),
                                                    child: Text(
                                                      '80.42',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
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
                                      width: MediaQuery.of(context).size.width*0.09,
                                      height: MediaQuery.of(context).size.height*0.036,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
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
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  decoration: new BoxDecoration(
                                                    color: Color(0xff696969),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 3.0),
                                                    child: Text(
                                                      'BUY',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
                                                          color: Color(0xFF000000),
                                                          fontFamily: "WorkSansBold"),
                                                    ),
                                                  )
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 5.0,top: 5.0),
                                                    child: Text(
                                                      '80.42',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5.0,top: 5.0),
                          width: MediaQuery.of(context).size.width*0.21,
                          height: MediaQuery.of(context).size.height*0.19,
                          decoration: new BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(
                              color: Color(0xff696969),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 3.5),
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.05,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: new Image(
                                          width: 35.0,
                                          fit: BoxFit.fill,
                                          image: new AssetImage('assets/logo.png')),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        'Title',
                                        style: new TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color(0xFF000000), fontSize: 12.0,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: new Icon(
                                        Icons.menu,
                                        color: Colors.black,
                                        size: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 3.5),
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.01,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 0.0),
                                      child: Text(
                                        'CHANGE(1D)',
                                        style: new TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color(0xFF000000), fontSize: 7.0,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 0.0),
                                      child: Text(
                                        '27.18',
                                        style: new TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color(0xFFe70b31), fontSize: 8.0,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.09,
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
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*0.09,
                                      height: MediaQuery.of(context).size.height*0.036,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
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
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  decoration: new BoxDecoration(
                                                    color: Color(0xff696969),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 3.0),
                                                    child: Text(
                                                      'SELL',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
                                                          color: Color(0xFF000000),
                                                          fontFamily: "WorkSansBold"),
                                                    ),
                                                  )
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 5.0,top: 5.0),
                                                    child: Text(
                                                      '80.42',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
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
                                      width: MediaQuery.of(context).size.width*0.09,
                                      height: MediaQuery.of(context).size.height*0.036,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
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
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  decoration: new BoxDecoration(
                                                    color: Color(0xff696969),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 3.0),
                                                    child: Text(
                                                      'BUY',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
                                                          color: Color(0xFF000000),
                                                          fontFamily: "WorkSansBold"),
                                                    ),
                                                  )
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 5.0,top: 5.0),
                                                    child: Text(
                                                      '80.42',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                    ),
                  ),
                  Divider(color: Color(0xff696969),thickness: 1.5,),
                  Container(
                    margin: EdgeInsets.only(left: 5.0,right: 5.0),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.20,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 5.0,top: 5.0),
                          width: MediaQuery.of(context).size.width*0.21,
                          height: MediaQuery.of(context).size.height*0.19,
                          decoration: new BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(
                              color: Color(0xff696969),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 3.5),
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.05,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: new Image(
                                          width: 35.0,
                                          fit: BoxFit.fill,
                                          image: new AssetImage('assets/logo.png')),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        'Title',
                                        style: new TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color(0xFF000000), fontSize: 12.0,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: new Icon(
                                        Icons.menu,
                                        color: Colors.black,
                                        size: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 3.5),
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.01,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 0.0),
                                      child: Text(
                                        'CHANGE(1D)',
                                        style: new TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color(0xFF000000), fontSize: 7.0,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 0.0),
                                      child: Text(
                                        '27.18',
                                        style: new TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color(0xFFe70b31), fontSize: 8.0,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.09,
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
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*0.09,
                                      height: MediaQuery.of(context).size.height*0.036,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
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
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  decoration: new BoxDecoration(
                                                    color: Color(0xff696969),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 3.0),
                                                    child: Text(
                                                      'SELL',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
                                                          color: Color(0xFF000000),
                                                          fontFamily: "WorkSansBold"),
                                                    ),
                                                  )
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 5.0,top: 5.0),
                                                    child: Text(
                                                      '80.42',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
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
                                      width: MediaQuery.of(context).size.width*0.09,
                                      height: MediaQuery.of(context).size.height*0.036,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
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
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  decoration: new BoxDecoration(
                                                    color: Color(0xff696969),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 3.0),
                                                    child: Text(
                                                      'BUY',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
                                                          color: Color(0xFF000000),
                                                          fontFamily: "WorkSansBold"),
                                                    ),
                                                  )
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 5.0,top: 5.0),
                                                    child: Text(
                                                      '80.42',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5.0,top: 5.0),
                          width: MediaQuery.of(context).size.width*0.21,
                          height: MediaQuery.of(context).size.height*0.19,
                          decoration: new BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(
                              color: Color(0xff696969),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 3.5),
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.05,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: new Image(
                                          width: 35.0,
                                          fit: BoxFit.fill,
                                          image: new AssetImage('assets/logo.png')),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        'Title',
                                        style: new TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color(0xFF000000), fontSize: 12.0,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: new Icon(
                                        Icons.menu,
                                        color: Colors.black,
                                        size: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 3.5),
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.01,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 0.0),
                                      child: Text(
                                        'CHANGE(1D)',
                                        style: new TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color(0xFF000000), fontSize: 7.0,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 0.0),
                                      child: Text(
                                        '27.18',
                                        style: new TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color(0xFFe70b31), fontSize: 8.0,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.09,
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
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*0.09,
                                      height: MediaQuery.of(context).size.height*0.036,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
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
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  decoration: new BoxDecoration(
                                                    color: Color(0xff696969),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 3.0),
                                                    child: Text(
                                                      'SELL',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
                                                          color: Color(0xFF000000),
                                                          fontFamily: "WorkSansBold"),
                                                    ),
                                                  )
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 5.0,top: 5.0),
                                                    child: Text(
                                                      '80.42',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
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
                                      width: MediaQuery.of(context).size.width*0.09,
                                      height: MediaQuery.of(context).size.height*0.036,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
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
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  decoration: new BoxDecoration(
                                                    color: Color(0xff696969),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 3.0),
                                                    child: Text(
                                                      'BUY',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
                                                          color: Color(0xFF000000),
                                                          fontFamily: "WorkSansBold"),
                                                    ),
                                                  )
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 5.0,top: 5.0),
                                                    child: Text(
                                                      '80.42',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5.0,top: 5.0),
                          width: MediaQuery.of(context).size.width*0.21,
                          height: MediaQuery.of(context).size.height*0.19,
                          decoration: new BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(
                              color: Color(0xff696969),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 3.5),
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.05,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: new Image(
                                          width: 35.0,
                                          fit: BoxFit.fill,
                                          image: new AssetImage('assets/logo.png')),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        'Title',
                                        style: new TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color(0xFF000000), fontSize: 12.0,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: new Icon(
                                        Icons.menu,
                                        color: Colors.black,
                                        size: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 3.5),
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.01,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 0.0),
                                      child: Text(
                                        'CHANGE(1D)',
                                        style: new TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color(0xFF000000), fontSize: 7.0,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 0.0),
                                      child: Text(
                                        '27.18',
                                        style: new TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color(0xFFe70b31), fontSize: 8.0,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.09,
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
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*0.09,
                                      height: MediaQuery.of(context).size.height*0.036,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
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
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  decoration: new BoxDecoration(
                                                    color: Color(0xff696969),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 3.0),
                                                    child: Text(
                                                      'SELL',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
                                                          color: Color(0xFF000000),
                                                          fontFamily: "WorkSansBold"),
                                                    ),
                                                  )
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 5.0,top: 5.0),
                                                    child: Text(
                                                      '80.42',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
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
                                      width: MediaQuery.of(context).size.width*0.09,
                                      height: MediaQuery.of(context).size.height*0.036,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
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
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  decoration: new BoxDecoration(
                                                    color: Color(0xff696969),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 3.0),
                                                    child: Text(
                                                      'BUY',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
                                                          color: Color(0xFF000000),
                                                          fontFamily: "WorkSansBold"),
                                                    ),
                                                  )
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 5.0,top: 5.0),
                                                    child: Text(
                                                      '80.42',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5.0,top: 5.0),
                          width: MediaQuery.of(context).size.width*0.21,
                          height: MediaQuery.of(context).size.height*0.19,
                          decoration: new BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(
                              color: Color(0xff696969),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 3.5),
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.05,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: new Image(
                                          width: 35.0,
                                          fit: BoxFit.fill,
                                          image: new AssetImage('assets/logo.png')),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        'Title',
                                        style: new TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color(0xFF000000), fontSize: 12.0,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: new Icon(
                                        Icons.menu,
                                        color: Colors.black,
                                        size: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 3.5),
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.01,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 0.0),
                                      child: Text(
                                        'CHANGE(1D)',
                                        style: new TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color(0xFF000000), fontSize: 7.0,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 0.0),
                                      child: Text(
                                        '27.18',
                                        style: new TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color(0xFFe70b31), fontSize: 8.0,
                                            letterSpacing: 0.2
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.09,
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
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*0.09,
                                      height: MediaQuery.of(context).size.height*0.036,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
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
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  decoration: new BoxDecoration(
                                                    color: Color(0xff696969),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 3.0),
                                                    child: Text(
                                                      'SELL',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
                                                          color: Color(0xFF000000),
                                                          fontFamily: "WorkSansBold"),
                                                    ),
                                                  )
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 5.0,top: 5.0),
                                                    child: Text(
                                                      '80.42',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
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
                                      width: MediaQuery.of(context).size.width*0.09,
                                      height: MediaQuery.of(context).size.height*0.036,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
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
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  decoration: new BoxDecoration(
                                                    color: Color(0xff696969),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 3.0),
                                                    child: Text(
                                                      'BUY',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
                                                          color: Color(0xFF000000),
                                                          fontFamily: "WorkSansBold"),
                                                    ),
                                                  )
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width*0.10,
                                              height: MediaQuery.of(context).size.height*0.015,
                                              child: Container(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 5.0,top: 5.0),
                                                    child: Text(
                                                      '80.42',
                                                      style: TextStyle(
                                                          fontSize: 7.0,
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                    ),
                  ),
                ],
              )
          ),

        ],
      ),
    );
  }

  Widget vcPCReEsg()
  {
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget crypto()
  {
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget equities()
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
                      height: MediaQuery.of(context).size.height*1.5,
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
                                      'Search',
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
                            margin: EdgeInsets.only(top: 25.0),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
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
                                    new Tab(text: "Top Trending News"),
                                    new Tab(text: "VC/ PE/ RE/ ESG"),
                                    new Tab(text: "Crypto"),
                                    new Tab(text: "Equities"),
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
                          )
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
      case 'Top Trending News': return topTrendingNews();
      case 'VC/ PE/ RE/ ESG': return vcPCReEsg();
      case 'Crypto': return crypto();
      case 'Equities': return equities();

    }
  }
}