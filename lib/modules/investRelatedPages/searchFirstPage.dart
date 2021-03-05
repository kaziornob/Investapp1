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
    new Tab(text: 'Trending'),
    new Tab(text: 'Unlisted'),
    new Tab(text: 'Crypto'),
    new Tab(text: 'Listed'),
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
            // decoration: BoxDecoration(border: Border.all()),
              margin: EdgeInsets.only(top: 5.0,bottom:5.0),
/*            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.40,*/
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                    width: 0.5
                ),
                Container(
/*                  width: MediaQuery.of(context).size.width*0.45,
                  height: MediaQuery.of(context).size.height*0.41,*/
                  margin: EdgeInsets.only(top: 5.0,bottom:5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      //first row of small box
                      Container(
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            //first box of first row
                            InkWell(
                              onTap: (){
                                Navigator.of(context).push(new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                    new SecurityPageFirst(logo: widget.logo,callingFrom: widget.callingFrom,)));
                              },
                              child: Container(
/*                                margin: EdgeInsets.only(left: 5.0,top: 5.0),
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.19,*/
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
                                      // margin: EdgeInsets.only(left: 3.5),
                                      width: MediaQuery.of(context).size.width*0.22,
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
                                      // margin: EdgeInsets.only(left: 3.5),
                                      width: MediaQuery.of(context).size.width*0.22,
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
                                      width: MediaQuery.of(context).size.width*0.22,
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
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          SizedBox(
                                              width:3.0
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width*0.09,
                                            height: MediaQuery.of(context).size.height*0.036,
                                            child: Container(
                                              decoration: new BoxDecoration(
                                                border: Border.all(
                                                  color: Color(0xff696969),
                                                  width: 1,
                                                ),
                                                color: Color(0xFFFFFFFF),
                                              ),
                                              child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width*0.10,
                                                    height: MediaQuery.of(context).size.height*0.015,
                                                    child: Container(
                                                        decoration: new BoxDecoration(
                                                          color: Color(0xff696969),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(left: 0.0),
                                                          child: Text(
                                                            'SELL',
                                                            textAlign: TextAlign.center,
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
                                                          padding: EdgeInsets.only(left: 0.0,top: 0.0),
                                                          child: Text(
                                                            '80.42',
                                                            textAlign: TextAlign.right,
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
                                              width:3.0
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width*0.09,
                                            height: MediaQuery.of(context).size.height*0.036,
                                            child: Container(
                                              decoration: new BoxDecoration(
                                                border: Border.all(
                                                  color: Color(0xff696969),
                                                  width: 1,
                                                ),
                                                color: Color(0xFFFFFFFF),
                                              ),
                                              child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width*0.10,
                                                    height: MediaQuery.of(context).size.height*0.015,
                                                    child: Container(
                                                        decoration: new BoxDecoration(
                                                          color: Color(0xff696969),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(left: 0.0),
                                                          child: Text(
                                                            'BUY',
                                                            textAlign: TextAlign.center,
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
                                                          padding: EdgeInsets.only(left: 0.0,top: 0.0),
                                                          child: Text(
                                                            '80.42',
                                                            textAlign: TextAlign.right,
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
                                              width:3.0
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                                width:4.0,
                            ),
                            //second  box of first row
                            InkWell(
                              onTap: (){
                                Navigator.of(context).push(new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                    new SecurityPageFirst(logo: widget.logo,callingFrom: widget.callingFrom,)));
                              },
                              child: Container(
/*                                margin: EdgeInsets.only(left: 5.0,top: 5.0),
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.19,*/
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
                                      // margin: EdgeInsets.only(left: 3.5),
                                      width: MediaQuery.of(context).size.width*0.22,
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
                                      // margin: EdgeInsets.only(left: 3.5),
                                      width: MediaQuery.of(context).size.width*0.22,
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
                                      width: MediaQuery.of(context).size.width*0.22,
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
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          SizedBox(
                                              width:3.0
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width*0.09,
                                            height: MediaQuery.of(context).size.height*0.036,
                                            child: Container(
                                              decoration: new BoxDecoration(
                                                border: Border.all(
                                                  color: Color(0xff696969),
                                                  width: 1,
                                                ),
                                                color: Color(0xFFFFFFFF),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width*0.10,
                                                    height: MediaQuery.of(context).size.height*0.015,
                                                    child: Container(
                                                        decoration: new BoxDecoration(
                                                          color: Color(0xff696969),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(left: 0.0),
                                                          child: Text(
                                                            'SELL',
                                                            textAlign: TextAlign.center,
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
                                                          padding: EdgeInsets.only(left: 0.0,top: 0.0),
                                                          child: Text(
                                                            '80.42',
                                                            textAlign: TextAlign.right,
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
                                              width:3.0
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width*0.09,
                                            height: MediaQuery.of(context).size.height*0.036,
                                            child: Container(
                                              decoration: new BoxDecoration(
                                                border: Border.all(
                                                  color: Color(0xff696969),
                                                  width: 1,
                                                ),
                                                color: Color(0xFFFFFFFF),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width*0.10,
                                                    height: MediaQuery.of(context).size.height*0.015,
                                                    child: Container(
                                                        decoration: new BoxDecoration(
                                                          color: Color(0xff696969),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(left: 0.0),
                                                          child: Text(
                                                            'BUY',
                                                            textAlign: TextAlign.center,
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
                                                          padding: EdgeInsets.only(left: 0.0,top: 0.0),
                                                          child: Text(
                                                            '80.42',
                                                            textAlign: TextAlign.right,
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
                                              width:3.0
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(
                          height:4.0
                      ),
                      //second row of small box
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            //first box of first row
                            InkWell(
                              onTap: (){
                                Navigator.of(context).push(new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                    new SecurityPageFirst(logo: widget.logo,callingFrom: widget.callingFrom,)));
                              },
                              child: Container(
/*                                margin: EdgeInsets.only(left: 5.0,top: 5.0),
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.19,*/
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
                                      // margin: EdgeInsets.only(left: 3.5),
                                      width: MediaQuery.of(context).size.width*0.22,
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
                                      // margin: EdgeInsets.only(left: 3.5),
                                      width: MediaQuery.of(context).size.width*0.22,
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
                                    // Container(
                                    //   width: MediaQuery.of(context).si ze.width*0.22,
                                    //   height: MediaQuery.of(context).size.height*0.09,
                                    //   child: SfCartesianChart(
                                    //     primaryXAxis: NumericAxis(
                                    //       isVisible: false,
                                    //     ),
                                    //     primaryYAxis: NumericAxis(
                                    //         isVisible: false
                                    //     ),
                                    //     series: <ChartSeries>[
                                    //       StackedAreaSeries<NewSalesData, double>(
                                    //         dataSource: newSalesData,
                                    //         xValueMapper: (NewSalesData data, _) => data.year,
                                    //         yValueMapper: (NewSalesData data, _) => data.sales,
                                    //         gradient: gradientColors,
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.22,
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
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          SizedBox(
                                              width:3.0
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width*0.09,
                                            height: MediaQuery.of(context).size.height*0.036,
                                            child: Container(
                                              decoration: new BoxDecoration(
                                                border: Border.all(
                                                  color: Color(0xff696969),
                                                  width: 1,
                                                ),
                                                color: Color(0xFFFFFFFF),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width*0.10,
                                                    height: MediaQuery.of(context).size.height*0.015,
                                                    child: Container(
                                                        decoration: new BoxDecoration(
                                                          color: Color(0xff696969),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(left: 0.0),
                                                          child: Text(
                                                            'SELL',
                                                            textAlign: TextAlign.center,
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
                                                          padding: EdgeInsets.only(left: 0.0,top: 0.0),
                                                          child: Text(
                                                            '80.42',
                                                            textAlign: TextAlign.right,
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
                                              width:3.0
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width*0.09,
                                            height: MediaQuery.of(context).size.height*0.036,
                                            child: Container(
                                              decoration: new BoxDecoration(
                                                border: Border.all(
                                                  color: Color(0xff696969),
                                                  width: 1,
                                                ),
                                                color: Color(0xFFFFFFFF),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width*0.10,
                                                    height: MediaQuery.of(context).size.height*0.015,
                                                    child: Container(
                                                        decoration: new BoxDecoration(
                                                          color: Color(0xff696969),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(left: 0.0),
                                                          child: Text(
                                                            'BUY',
                                                            textAlign: TextAlign.center,
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
                                                          padding: EdgeInsets.only(left: 0.0,top: 0.0),
                                                          child: Text(
                                                            '80.42',
                                                            textAlign: TextAlign.right,
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
                                              width:3.0
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width:4.0,
                            ),
                            //second  box of first row
                            InkWell(
                              onTap: (){
                                Navigator.of(context).push(new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                    new SecurityPageFirst(logo: widget.logo,callingFrom: widget.callingFrom,)));
                              },
                              child: Container(
/*                                margin: EdgeInsets.only(left: 5.0,top: 5.0),
                                width: MediaQuery.of(context).size.width*0.21,
                                height: MediaQuery.of(context).size.height*0.19,*/
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
                                      // margin: EdgeInsets.only(left: 3.5),
                                      width: MediaQuery.of(context).size.width*0.22,
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
                                      // margin: EdgeInsets.only(left: 3.5),
                                      width: MediaQuery.of(context).size.width*0.22,
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
                                      width: MediaQuery.of(context).size.width*0.22,
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
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          SizedBox(
                                              width:3.0
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width*0.09,
                                            height: MediaQuery.of(context).size.height*0.036,
                                            child: Container(
                                              decoration: new BoxDecoration(
                                                border: Border.all(
                                                  color: Color(0xff696969),
                                                  width: 1,
                                                ),
                                                color: Color(0xFFFFFFFF),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width*0.10,
                                                    height: MediaQuery.of(context).size.height*0.015,
                                                    child: Container(
                                                        decoration: new BoxDecoration(
                                                          color: Color(0xff696969),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(left: 0.0),
                                                          child: Text(
                                                            'SELL',
                                                            textAlign: TextAlign.center,
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
                                                          padding: EdgeInsets.only(left: 0.0,top: 0.0),
                                                          child: Text(
                                                            '80.42',
                                                            textAlign: TextAlign.right,
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
                                              width:3.0
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width*0.09,
                                            height: MediaQuery.of(context).size.height*0.036,
                                            child: Container(
                                              decoration: new BoxDecoration(
                                                border: Border.all(
                                                  color: Color(0xff696969),
                                                  width: 1,
                                                ),
                                                color: Color(0xFFFFFFFF),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width*0.10,
                                                    height: MediaQuery.of(context).size.height*0.015,
                                                    child: Container(
                                                        decoration: new BoxDecoration(
                                                          color: Color(0xff696969),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(left: 0.0),
                                                          child: Text(
                                                            'BUY',
                                                            textAlign: TextAlign.center,
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
                                                          padding: EdgeInsets.only(left: 0.0,top: 0.0),
                                                          child: Text(
                                                            '80.42',
                                                            textAlign: TextAlign.right,
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
                                              width:3.0
                                          ),
                                        ],
                                      ),
                                    ),
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
                //Big Box
                Container(
                  margin: EdgeInsets.only(top: 5.0,bottom: 5.0),
/*                  width: MediaQuery.of(context).size.width*0.45,
                  height: MediaQuery.of(context).size.height*0.41,*/
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
                        width: MediaQuery.of(context).size.width*0.454,
                        height: MediaQuery.of(context).size.height*0.10,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: new Image(
                                  width: 80.0,
                                  fit: BoxFit.fill,
                                  image: new AssetImage('assets/logo.png')),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
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
                              padding: EdgeInsets.only(top: 10.0),
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
                        width: MediaQuery.of(context).size.width*0.454,
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
                          width: MediaQuery.of(context).size.width*0.454,
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
                        width: MediaQuery.of(context).size.width*0.454,
                        height: MediaQuery.of(context).size.height*0.11,
                        margin: EdgeInsets.only(top: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                                width: 3.0
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.20,
                              height: MediaQuery.of(context).size.height*0.10,
                              child: Container(
                                margin: EdgeInsets.only(top: 2.0),
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
                                      width: MediaQuery.of(context).size.width*0.34,
                                      height: MediaQuery.of(context).size.height*0.038,
                                      child: Container(
                                          decoration: new BoxDecoration(
                                            color: Color(0xff696969),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 0.0),
                                            child: Text(
                                              'SELL',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Color(0xFF000000),
                                                  fontFamily: "WorkSansBold"),
                                            ),
                                          )
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*0.34,
                                      height: MediaQuery.of(context).size.height*0.0385,
                                      child: Container(
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 5.0),
                                            child: Text(
                                              '80.42',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontSize: 17.0,
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
                                margin: EdgeInsets.only(top: 2.0),
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
                                      width: MediaQuery.of(context).size.width*0.34,
                                      height: MediaQuery.of(context).size.height*0.038,
                                      child: Container(
                                          decoration: new BoxDecoration(
                                            color: Color(0xff696969),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 0.0),
                                            child: Text(
                                              'BUY',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Color(0xFF000000),
                                                  fontFamily: "WorkSansBold"),
                                            ),
                                          )
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*0.34,
                                      height: MediaQuery.of(context).size.height*0.0385,
                                      child: Container(
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 5.0),
                                            child: Text(
                                              '80.42',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontSize: 17.0,
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
                                width: 3.0
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )

              ],
            ),

          ),
          // Container(
          //     width: MediaQuery.of(context).size.width*0.70,
          //     height: MediaQuery.of(context).size.height*0.05,
          //     margin: EdgeInsets.only(top: 20.0,left: 10.0,right: 10.0),
          //     decoration: new BoxDecoration(
          //       border: Border.all(
          //         color: Color(0xfffec20f),
          //         width: 1.5,
          //       ),
          //       borderRadius: BorderRadius.all(
          //         Radius.circular(5.0),
          //       ),
          //     ),
          //     child: Padding(
          //       padding: EdgeInsets.only(top: 3.5,left: 10.0,right: 10.0),
          //       child: Text(
          //         "TOP TRENDING NEWS",
          //         style: new TextStyle(
          //           color: AllCoustomTheme.getTextThemeColors(),
          //           fontSize: ConstanceData.SIZE_TITLE16,
          //         ),
          //       ),
          //     )
          // ),
//           Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height*0.44,
//               margin: EdgeInsets.only(top: 15.0,left: 10.0,right: 10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Container(
// /*                    margin: EdgeInsets.only(left: 5.0,right: 5.0),
//                     width: MediaQuery.of(context).size.width,
//                     height: MediaQuery.of(context).size.height*0.20,*/
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Container(
// /*                          margin: EdgeInsets.only(left: 5.0,top: 5.0),
//                           width: MediaQuery.of(context).size.width*0.21,
//                           height: MediaQuery.of(context).size.height*0.19,*/
//                           decoration: new BoxDecoration(
//                             color: Color(0xFFFFFFFF),
//                             borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                             border: Border.all(
//                               color: Color(0xff696969),
//                               width: 1,
//                             ),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Container(
//                                 // margin: EdgeInsets.only(left: 3.5),
//                                 width: MediaQuery.of(context).size.width*0.22,
//                                 height: MediaQuery.of(context).size.height*0.05,
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 10.0),
//                                       child: new Image(
//                                           width: 35.0,
//                                           fit: BoxFit.fill,
//                                           image: new AssetImage('assets/logo.png')),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 10.0),
//                                       child: Text(
//                                         'Title',
//                                         style: new TextStyle(
//                                             fontFamily: "Poppins",
//                                             color: Color(0xFF000000), fontSize: 12.0,
//                                             letterSpacing: 0.2
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 10.0),
//                                       child: new Icon(
//                                         Icons.menu,
//                                         color: Colors.black,
//                                         size: 10,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 // margin: EdgeInsets.only(left: 3.5),
//                                 width: MediaQuery.of(context).size.width*0.22,
//                                 height: MediaQuery.of(context).size.height*0.01,
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 0.0),
//                                       child: Text(
//                                         'CHANGE(1D)',
//                                         style: new TextStyle(
//                                             fontFamily: "Poppins",
//                                             color: Color(0xFF000000), fontSize: 7.0,
//                                             letterSpacing: 0.2
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 0.0),
//                                       child: Text(
//                                         '27.18',
//                                         style: new TextStyle(
//                                             fontFamily: "Poppins",
//                                             color: Color(0xFFe70b31), fontSize: 8.0,
//                                             letterSpacing: 0.2
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 width: MediaQuery.of(context).size.width*0.22,
//                                 height: MediaQuery.of(context).size.height*0.09,
//                                 child: SfCartesianChart(
//                                     primaryXAxis: NumericAxis(
//                                       isVisible: false,
//                                     ),
//                                     primaryYAxis: NumericAxis(
//                                         isVisible: false
//                                     ),
//                                     series: <ChartSeries>[
//                                       StackedAreaSeries<NewSalesData, double>(
//                                         dataSource: newSalesData,
//                                         xValueMapper: (NewSalesData data, _) => data.year,
//                                         yValueMapper: (NewSalesData data, _) => data.sales,
//                                         gradient: gradientColors,
//                                       ),
//                                     ]
//                                 ),
//                               ),
//                               Container(
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//                                     SizedBox(
//                                         width: 2.0
//                                     ),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width*0.09,
//                                       height: MediaQuery.of(context).size.height*0.036,
//                                       child: Container(
//                                         margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
//                                         decoration: new BoxDecoration(
//                                           border: Border.all(
//                                             color: Color(0xff696969),
//                                             width: 1,
//                                           ),
//                                           color: Color(0xFFFFFFFF),
//                                         ),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   decoration: new BoxDecoration(
//                                                     color: Color(0xff696969),
//                                                   ),
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0),
//                                                     child: Text(
//                                                       'SELL',
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0,top: 0.0),
//                                                     child: Text(
//                                                       '80.42',
//                                                       textAlign: TextAlign.right,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width*0.09,
//                                       height: MediaQuery.of(context).size.height*0.036,
//                                       child: Container(
//                                         margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
//                                         decoration: new BoxDecoration(
//                                           border: Border.all(
//                                             color: Color(0xff696969),
//                                             width: 1,
//                                           ),
//                                           color: Color(0xFFFFFFFF),
//                                         ),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   decoration: new BoxDecoration(
//                                                     color: Color(0xff696969),
//                                                   ),
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0),
//                                                     child: Text(
//                                                       'BUY',
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0,top: 0.0),
//                                                     child: Text(
//                                                       '80.42',
//                                                       textAlign: TextAlign.right,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                         width: 2.0
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
// /*                          margin: EdgeInsets.only(left: 5.0,top: 5.0),
//                           width: MediaQuery.of(context).size.width*0.21,
//                           height: MediaQuery.of(context).size.height*0.19,*/
//                           decoration: new BoxDecoration(
//                             color: Color(0xFFFFFFFF),
//                             borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                             border: Border.all(
//                               color: Color(0xff696969),
//                               width: 1,
//                             ),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Container(
//                                 // margin: EdgeInsets.only(left: 3.5),
//                                 width: MediaQuery.of(context).size.width*0.22,
//                                 height: MediaQuery.of(context).size.height*0.05,
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 10.0),
//                                       child: new Image(
//                                           width: 35.0,
//                                           fit: BoxFit.fill,
//                                           image: new AssetImage('assets/logo.png')),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 10.0),
//                                       child: Text(
//                                         'Title',
//                                         style: new TextStyle(
//                                             fontFamily: "Poppins",
//                                             color: Color(0xFF000000), fontSize: 12.0,
//                                             letterSpacing: 0.2
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 10.0),
//                                       child: new Icon(
//                                         Icons.menu,
//                                         color: Colors.black,
//                                         size: 10,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 // margin: EdgeInsets.only(left: 3.5),
//                                 width: MediaQuery.of(context).size.width*0.22,
//                                 height: MediaQuery.of(context).size.height*0.01,
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 0.0),
//                                       child: Text(
//                                         'CHANGE(1D)',
//                                         style: new TextStyle(
//                                             fontFamily: "Poppins",
//                                             color: Color(0xFF000000), fontSize: 7.0,
//                                             letterSpacing: 0.2
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 0.0),
//                                       child: Text(
//                                         '27.18',
//                                         style: new TextStyle(
//                                             fontFamily: "Poppins",
//                                             color: Color(0xFFe70b31), fontSize: 8.0,
//                                             letterSpacing: 0.2
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 width: MediaQuery.of(context).size.width*0.22,
//                                 height: MediaQuery.of(context).size.height*0.09,
//                                 child: SfCartesianChart(
//                                     primaryXAxis: NumericAxis(
//                                       isVisible: false,
//                                     ),
//                                     primaryYAxis: NumericAxis(
//                                         isVisible: false
//                                     ),
//                                     series: <ChartSeries>[
//                                       StackedAreaSeries<NewSalesData, double>(
//                                         dataSource: newSalesData,
//                                         xValueMapper: (NewSalesData data, _) => data.year,
//                                         yValueMapper: (NewSalesData data, _) => data.sales,
//                                         gradient: gradientColors,
//                                       ),
//                                     ]
//                                 ),
//                               ),
//                               Container(
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//                                     SizedBox(
//                                         width: 2.0
//                                     ),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width*0.09,
//                                       height: MediaQuery.of(context).size.height*0.036,
//                                       child: Container(
//                                         margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
//                                         decoration: new BoxDecoration(
//                                           border: Border.all(
//                                             color: Color(0xff696969),
//                                             width: 1,
//                                           ),
//                                           color: Color(0xFFFFFFFF),
//                                         ),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   decoration: new BoxDecoration(
//                                                     color: Color(0xff696969),
//                                                   ),
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0),
//                                                     child: Text(
//                                                       'SELL',
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0,top: 0.0),
//                                                     child: Text(
//                                                       '80.42',
//                                                       textAlign: TextAlign.right,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width*0.09,
//                                       height: MediaQuery.of(context).size.height*0.036,
//                                       child: Container(
//                                         margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
//                                         decoration: new BoxDecoration(
//                                           border: Border.all(
//                                             color: Color(0xff696969),
//                                             width: 1,
//                                           ),
//                                           color: Color(0xFFFFFFFF),
//                                         ),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   decoration: new BoxDecoration(
//                                                     color: Color(0xff696969),
//                                                   ),
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0),
//                                                     child: Text(
//                                                       'BUY',
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0,top: 0.0),
//                                                     child: Text(
//                                                       '80.42',
//                                                       textAlign: TextAlign.right,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                         width: 2.0
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
// /*                          margin: EdgeInsets.only(left: 5.0,top: 5.0),
//                           width: MediaQuery.of(context).size.width*0.21,
//                           height: MediaQuery.of(context).size.height*0.19,*/
//                           decoration: new BoxDecoration(
//                             color: Color(0xFFFFFFFF),
//                             borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                             border: Border.all(
//                               color: Color(0xff696969),
//                               width: 1,
//                             ),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Container(
//                                 // margin: EdgeInsets.only(left: 3.5),
//                                 width: MediaQuery.of(context).size.width*0.22,
//                                 height: MediaQuery.of(context).size.height*0.05,
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 10.0),
//                                       child: new Image(
//                                           width: 35.0,
//                                           fit: BoxFit.fill,
//                                           image: new AssetImage('assets/logo.png')),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 10.0),
//                                       child: Text(
//                                         'Title',
//                                         style: new TextStyle(
//                                             fontFamily: "Poppins",
//                                             color: Color(0xFF000000), fontSize: 12.0,
//                                             letterSpacing: 0.2
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 10.0),
//                                       child: new Icon(
//                                         Icons.menu,
//                                         color: Colors.black,
//                                         size: 10,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 // margin: EdgeInsets.only(left: 3.5),
//                                 width: MediaQuery.of(context).size.width*0.22,
//                                 height: MediaQuery.of(context).size.height*0.01,
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 0.0),
//                                       child: Text(
//                                         'CHANGE(1D)',
//                                         style: new TextStyle(
//                                             fontFamily: "Poppins",
//                                             color: Color(0xFF000000), fontSize: 7.0,
//                                             letterSpacing: 0.2
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 0.0),
//                                       child: Text(
//                                         '27.18',
//                                         style: new TextStyle(
//                                             fontFamily: "Poppins",
//                                             color: Color(0xFFe70b31), fontSize: 8.0,
//                                             letterSpacing: 0.2
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 width: MediaQuery.of(context).size.width*0.22,
//                                 height: MediaQuery.of(context).size.height*0.09,
//                                 child: SfCartesianChart(
//                                     primaryXAxis: NumericAxis(
//                                       isVisible: false,
//                                     ),
//                                     primaryYAxis: NumericAxis(
//                                         isVisible: false
//                                     ),
//                                     series: <ChartSeries>[
//                                       StackedAreaSeries<NewSalesData, double>(
//                                         dataSource: newSalesData,
//                                         xValueMapper: (NewSalesData data, _) => data.year,
//                                         yValueMapper: (NewSalesData data, _) => data.sales,
//                                         gradient: gradientColors,
//                                       ),
//                                     ]
//                                 ),
//                               ),
//                               Container(
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//                                     SizedBox(
//                                         width: 2.0
//                                     ),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width*0.09,
//                                       height: MediaQuery.of(context).size.height*0.036,
//                                       child: Container(
//                                         margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
//                                         decoration: new BoxDecoration(
//                                           border: Border.all(
//                                             color: Color(0xff696969),
//                                             width: 1,
//                                           ),
//                                           color: Color(0xFFFFFFFF),
//                                         ),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   decoration: new BoxDecoration(
//                                                     color: Color(0xff696969),
//                                                   ),
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0),
//                                                     child: Text(
//                                                       'SELL',
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0,top: 0.0),
//                                                     child: Text(
//                                                       '80.42',
//                                                       textAlign: TextAlign.right,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width*0.09,
//                                       height: MediaQuery.of(context).size.height*0.036,
//                                       child: Container(
//                                         margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
//                                         decoration: new BoxDecoration(
//                                           border: Border.all(
//                                             color: Color(0xff696969),
//                                             width: 1,
//                                           ),
//                                           color: Color(0xFFFFFFFF),
//                                         ),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   decoration: new BoxDecoration(
//                                                     color: Color(0xff696969),
//                                                   ),
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0),
//                                                     child: Text(
//                                                       'BUY',
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0,top: 0.0),
//                                                     child: Text(
//                                                       '80.42',
//                                                       textAlign: TextAlign.right,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                         width: 2.0
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
// /*                          margin: EdgeInsets.only(left: 5.0,top: 5.0),
//                           width: MediaQuery.of(context).size.width*0.21,
//                           height: MediaQuery.of(context).size.height*0.19,*/
//                           decoration: new BoxDecoration(
//                             color: Color(0xFFFFFFFF),
//                             borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                             border: Border.all(
//                               color: Color(0xff696969),
//                               width: 1,
//                             ),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Container(
//                                 // margin: EdgeInsets.only(left: 3.5),
//                                 width: MediaQuery.of(context).size.width*0.22,
//                                 height: MediaQuery.of(context).size.height*0.05,
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 10.0),
//                                       child: new Image(
//                                           width: 35.0,
//                                           fit: BoxFit.fill,
//                                           image: new AssetImage('assets/logo.png')),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 10.0),
//                                       child: Text(
//                                         'Title',
//                                         style: new TextStyle(
//                                             fontFamily: "Poppins",
//                                             color: Color(0xFF000000), fontSize: 12.0,
//                                             letterSpacing: 0.2
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 10.0),
//                                       child: new Icon(
//                                         Icons.menu,
//                                         color: Colors.black,
//                                         size: 10,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 // margin: EdgeInsets.only(left: 3.5),
//                                 width: MediaQuery.of(context).size.width*0.22,
//                                 height: MediaQuery.of(context).size.height*0.01,
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 0.0),
//                                       child: Text(
//                                         'CHANGE(1D)',
//                                         style: new TextStyle(
//                                             fontFamily: "Poppins",
//                                             color: Color(0xFF000000), fontSize: 7.0,
//                                             letterSpacing: 0.2
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 0.0),
//                                       child: Text(
//                                         '27.18',
//                                         style: new TextStyle(
//                                             fontFamily: "Poppins",
//                                             color: Color(0xFFe70b31), fontSize: 8.0,
//                                             letterSpacing: 0.2
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 width: MediaQuery.of(context).size.width*0.22,
//                                 height: MediaQuery.of(context).size.height*0.09,
//                                 child: SfCartesianChart(
//                                     primaryXAxis: NumericAxis(
//                                       isVisible: false,
//                                     ),
//                                     primaryYAxis: NumericAxis(
//                                         isVisible: false
//                                     ),
//                                     series: <ChartSeries>[
//                                       StackedAreaSeries<NewSalesData, double>(
//                                         dataSource: newSalesData,
//                                         xValueMapper: (NewSalesData data, _) => data.year,
//                                         yValueMapper: (NewSalesData data, _) => data.sales,
//                                         gradient: gradientColors,
//                                       ),
//                                     ]
//                                 ),
//                               ),
//                               Container(
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//                                     SizedBox(
//                                         width: 2.0
//                                     ),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width*0.09,
//                                       height: MediaQuery.of(context).size.height*0.036,
//                                       child: Container(
//                                         margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
//                                         decoration: new BoxDecoration(
//                                           border: Border.all(
//                                             color: Color(0xff696969),
//                                             width: 1,
//                                           ),
//                                           color: Color(0xFFFFFFFF),
//                                         ),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   decoration: new BoxDecoration(
//                                                     color: Color(0xff696969),
//                                                   ),
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0),
//                                                     child: Text(
//                                                       'SELL',
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0,top: 0.0),
//                                                     child: Text(
//                                                       '80.42',
//                                                       textAlign: TextAlign.right,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width*0.09,
//                                       height: MediaQuery.of(context).size.height*0.036,
//                                       child: Container(
//                                         margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
//                                         decoration: new BoxDecoration(
//                                           border: Border.all(
//                                             color: Color(0xff696969),
//                                             width: 1,
//                                           ),
//                                           color: Color(0xFFFFFFFF),
//                                         ),
//                                         child: Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   decoration: new BoxDecoration(
//                                                     color: Color(0xff696969),
//                                                   ),
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0),
//                                                     child: Text(
//                                                       'BUY',
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0,top: 0.0),
//                                                     child: Text(
//                                                       '80.42',
//                                                       textAlign: TextAlign.right,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                         width: 2.0
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//
//                     ),
//                   ),
//                   Divider(color: Color(0xff696969),thickness: 1.5,),
//                   Container(
// /*                    margin: EdgeInsets.only(left: 5.0,right: 5.0),
//                     width: MediaQuery.of(context).size.width,
//                     height: MediaQuery.of(context).size.height*0.20,*/
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Container(
// /*                          margin: EdgeInsets.only(left: 5.0,top: 5.0),
//                           width: MediaQuery.of(context).size.width*0.21,
//                           height: MediaQuery.of(context).size.height*0.19,*/
//                           decoration: new BoxDecoration(
//                             color: Color(0xFFFFFFFF),
//                             borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                             border: Border.all(
//                               color: Color(0xff696969),
//                               width: 1,
//                             ),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Container(
//                                 // margin: EdgeInsets.only(left: 3.5),
//                                 width: MediaQuery.of(context).size.width*0.22,
//                                 height: MediaQuery.of(context).size.height*0.05,
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 10.0),
//                                       child: new Image(
//                                           width: 35.0,
//                                           fit: BoxFit.fill,
//                                           image: new AssetImage('assets/logo.png')),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 10.0),
//                                       child: Text(
//                                         'Title',
//                                         style: new TextStyle(
//                                             fontFamily: "Poppins",
//                                             color: Color(0xFF000000), fontSize: 12.0,
//                                             letterSpacing: 0.2
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 10.0),
//                                       child: new Icon(
//                                         Icons.menu,
//                                         color: Colors.black,
//                                         size: 10,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 // margin: EdgeInsets.only(left: 3.5),
//                                 width: MediaQuery.of(context).size.width*0.22,
//                                 height: MediaQuery.of(context).size.height*0.01,
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 0.0),
//                                       child: Text(
//                                         'CHANGE(1D)',
//                                         style: new TextStyle(
//                                             fontFamily: "Poppins",
//                                             color: Color(0xFF000000), fontSize: 7.0,
//                                             letterSpacing: 0.2
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 0.0),
//                                       child: Text(
//                                         '27.18',
//                                         style: new TextStyle(
//                                             fontFamily: "Poppins",
//                                             color: Color(0xFFe70b31), fontSize: 8.0,
//                                             letterSpacing: 0.2
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 width: MediaQuery.of(context).size.width*0.22,
//                                 height: MediaQuery.of(context).size.height*0.09,
//                                 child: SfCartesianChart(
//                                     primaryXAxis: NumericAxis(
//                                       isVisible: false,
//                                     ),
//                                     primaryYAxis: NumericAxis(
//                                         isVisible: false
//                                     ),
//                                     series: <ChartSeries>[
//                                       StackedAreaSeries<NewSalesData, double>(
//                                         dataSource: newSalesData,
//                                         xValueMapper: (NewSalesData data, _) => data.year,
//                                         yValueMapper: (NewSalesData data, _) => data.sales,
//                                         gradient: gradientColors,
//                                       ),
//                                     ]
//                                 ),
//                               ),
//                               Container(
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//                                     SizedBox(
//                                         width: 2.0
//                                     ),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width*0.09,
//                                       height: MediaQuery.of(context).size.height*0.036,
//                                       child: Container(
//                                         margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
//                                         decoration: new BoxDecoration(
//                                           border: Border.all(
//                                             color: Color(0xff696969),
//                                             width: 1,
//                                           ),
//                                           color: Color(0xFFFFFFFF),
//                                         ),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   decoration: new BoxDecoration(
//                                                     color: Color(0xff696969),
//                                                   ),
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0),
//                                                     child: Text(
//                                                       'SELL',
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0,top: 0.0),
//                                                     child: Text(
//                                                       '80.42',
//                                                       textAlign: TextAlign.right,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width*0.09,
//                                       height: MediaQuery.of(context).size.height*0.036,
//                                       child: Container(
//                                         margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
//                                         decoration: new BoxDecoration(
//                                           border: Border.all(
//                                             color: Color(0xff696969),
//                                             width: 1,
//                                           ),
//                                           color: Color(0xFFFFFFFF),
//                                         ),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   decoration: new BoxDecoration(
//                                                     color: Color(0xff696969),
//                                                   ),
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0),
//                                                     child: Text(
//                                                       'BUY',
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0,top: 0.0),
//                                                     child: Text(
//                                                       '80.42',
//                                                       textAlign: TextAlign.right,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                         width: 2.0
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
// /*                          margin: EdgeInsets.only(left: 5.0,top: 5.0),
//                           width: MediaQuery.of(context).size.width*0.21,
//                           height: MediaQuery.of(context).size.height*0.19,*/
//                           decoration: new BoxDecoration(
//                             color: Color(0xFFFFFFFF),
//                             borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                             border: Border.all(
//                               color: Color(0xff696969),
//                               width: 1,
//                             ),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Container(
//                                 // margin: EdgeInsets.only(left: 3.5),
//                                 width: MediaQuery.of(context).size.width*0.22,
//                                 height: MediaQuery.of(context).size.height*0.05,
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 10.0),
//                                       child: new Image(
//                                           width: 35.0,
//                                           fit: BoxFit.fill,
//                                           image: new AssetImage('assets/logo.png')),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 10.0),
//                                       child: Text(
//                                         'Title',
//                                         style: new TextStyle(
//                                             fontFamily: "Poppins",
//                                             color: Color(0xFF000000), fontSize: 12.0,
//                                             letterSpacing: 0.2
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 10.0),
//                                       child: new Icon(
//                                         Icons.menu,
//                                         color: Colors.black,
//                                         size: 10,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 // margin: EdgeInsets.only(left: 3.5),
//                                 width: MediaQuery.of(context).size.width*0.22,
//                                 height: MediaQuery.of(context).size.height*0.01,
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 0.0),
//                                       child: Text(
//                                         'CHANGE(1D)',
//                                         style: new TextStyle(
//                                             fontFamily: "Poppins",
//                                             color: Color(0xFF000000), fontSize: 7.0,
//                                             letterSpacing: 0.2
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 0.0),
//                                       child: Text(
//                                         '27.18',
//                                         style: new TextStyle(
//                                             fontFamily: "Poppins",
//                                             color: Color(0xFFe70b31), fontSize: 8.0,
//                                             letterSpacing: 0.2
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 width: MediaQuery.of(context).size.width*0.22,
//                                 height: MediaQuery.of(context).size.height*0.09,
//                                 child: SfCartesianChart(
//                                     primaryXAxis: NumericAxis(
//                                       isVisible: false,
//                                     ),
//                                     primaryYAxis: NumericAxis(
//                                         isVisible: false
//                                     ),
//                                     series: <ChartSeries>[
//                                       StackedAreaSeries<NewSalesData, double>(
//                                         dataSource: newSalesData,
//                                         xValueMapper: (NewSalesData data, _) => data.year,
//                                         yValueMapper: (NewSalesData data, _) => data.sales,
//                                         gradient: gradientColors,
//                                       ),
//                                     ]
//                                 ),
//                               ),
//                               Container(
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//                                     SizedBox(
//                                         width: 2.0
//                                     ),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width*0.09,
//                                       height: MediaQuery.of(context).size.height*0.036,
//                                       child: Container(
//                                         margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
//                                         decoration: new BoxDecoration(
//                                           border: Border.all(
//                                             color: Color(0xff696969),
//                                             width: 1,
//                                           ),
//                                           color: Color(0xFFFFFFFF),
//                                         ),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   decoration: new BoxDecoration(
//                                                     color: Color(0xff696969),
//                                                   ),
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0),
//                                                     child: Text(
//                                                       'SELL',
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0,top: 0.0),
//                                                     child: Text(
//                                                       '80.42',
//                                                       textAlign: TextAlign.right,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width*0.09,
//                                       height: MediaQuery.of(context).size.height*0.036,
//                                       child: Container(
//                                         margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
//                                         decoration: new BoxDecoration(
//                                           border: Border.all(
//                                             color: Color(0xff696969),
//                                             width: 1,
//                                           ),
//                                           color: Color(0xFFFFFFFF),
//                                         ),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   decoration: new BoxDecoration(
//                                                     color: Color(0xff696969),
//                                                   ),
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0),
//                                                     child: Text(
//                                                       'BUY',
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0,top: 0.0),
//                                                     child: Text(
//                                                       '80.42',
//                                                       textAlign: TextAlign.right,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                         width: 2.0
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
// /*                          margin: EdgeInsets.only(left: 5.0,top: 5.0),
//                           width: MediaQuery.of(context).size.width*0.21,
//                           height: MediaQuery.of(context).size.height*0.19,*/
//                           decoration: new BoxDecoration(
//                             color: Color(0xFFFFFFFF),
//                             borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                             border: Border.all(
//                               color: Color(0xff696969),
//                               width: 1,
//                             ),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Container(
//                                 // margin: EdgeInsets.only(left: 3.5),
//                                 width: MediaQuery.of(context).size.width*0.22,
//                                 height: MediaQuery.of(context).size.height*0.05,
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 10.0),
//                                       child: new Image(
//                                           width: 35.0,
//                                           fit: BoxFit.fill,
//                                           image: new AssetImage('assets/logo.png')),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 10.0),
//                                       child: Text(
//                                         'Title',
//                                         style: new TextStyle(
//                                             fontFamily: "Poppins",
//                                             color: Color(0xFF000000), fontSize: 12.0,
//                                             letterSpacing: 0.2
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 10.0),
//                                       child: new Icon(
//                                         Icons.menu,
//                                         color: Colors.black,
//                                         size: 10,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 // margin: EdgeInsets.only(left: 3.5),
//                                 width: MediaQuery.of(context).size.width*0.22,
//                                 height: MediaQuery.of(context).size.height*0.01,
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 0.0),
//                                       child: Text(
//                                         'CHANGE(1D)',
//                                         style: new TextStyle(
//                                             fontFamily: "Poppins",
//                                             color: Color(0xFF000000), fontSize: 7.0,
//                                             letterSpacing: 0.2
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 0.0),
//                                       child: Text(
//                                         '27.18',
//                                         style: new TextStyle(
//                                             fontFamily: "Poppins",
//                                             color: Color(0xFFe70b31), fontSize: 8.0,
//                                             letterSpacing: 0.2
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 width: MediaQuery.of(context).size.width*0.22,
//                                 height: MediaQuery.of(context).size.height*0.09,
//                                 child: SfCartesianChart(
//                                     primaryXAxis: NumericAxis(
//                                       isVisible: false,
//                                     ),
//                                     primaryYAxis: NumericAxis(
//                                         isVisible: false
//                                     ),
//                                     series: <ChartSeries>[
//                                       StackedAreaSeries<NewSalesData, double>(
//                                         dataSource: newSalesData,
//                                         xValueMapper: (NewSalesData data, _) => data.year,
//                                         yValueMapper: (NewSalesData data, _) => data.sales,
//                                         gradient: gradientColors,
//                                       ),
//                                     ]
//                                 ),
//                               ),
//                               Container(
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//                                     SizedBox(
//                                         width: 2.0
//                                     ),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width*0.09,
//                                       height: MediaQuery.of(context).size.height*0.036,
//                                       child: Container(
//                                         margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
//                                         decoration: new BoxDecoration(
//                                           border: Border.all(
//                                             color: Color(0xff696969),
//                                             width: 1,
//                                           ),
//                                           color: Color(0xFFFFFFFF),
//                                         ),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   decoration: new BoxDecoration(
//                                                     color: Color(0xff696969),
//                                                   ),
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0),
//                                                     child: Text(
//                                                       'SELL',
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0,top: 0.0),
//                                                     child: Text(
//                                                       '80.42',
//                                                       textAlign: TextAlign.right,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width*0.09,
//                                       height: MediaQuery.of(context).size.height*0.036,
//                                       child: Container(
//                                         margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
//                                         decoration: new BoxDecoration(
//                                           border: Border.all(
//                                             color: Color(0xff696969),
//                                             width: 1,
//                                           ),
//                                           color: Color(0xFFFFFFFF),
//                                         ),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   decoration: new BoxDecoration(
//                                                     color: Color(0xff696969),
//                                                   ),
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0),
//                                                     child: Text(
//                                                       'BUY',
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0,top: 0.0),
//                                                     child: Text(
//                                                       '80.42',
//                                                       textAlign: TextAlign.right,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                         width: 2.0
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
// /*                          margin: EdgeInsets.only(left: 5.0,top: 5.0),
//                           width: MediaQuery.of(context).size.width*0.21,
//                           height: MediaQuery.of(context).size.height*0.19,*/
//                           decoration: new BoxDecoration(
//                             color: Color(0xFFFFFFFF),
//                             borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                             border: Border.all(
//                               color: Color(0xff696969),
//                               width: 1,
//                             ),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Container(
//                                 // margin: EdgeInsets.only(left: 3.5),
//                                 width: MediaQuery.of(context).size.width*0.22,
//                                 height: MediaQuery.of(context).size.height*0.05,
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 10.0),
//                                       child: new Image(
//                                           width: 35.0,
//                                           fit: BoxFit.fill,
//                                           image: new AssetImage('assets/logo.png')),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 10.0),
//                                       child: Text(
//                                         'Title',
//                                         style: new TextStyle(
//                                             fontFamily: "Poppins",
//                                             color: Color(0xFF000000), fontSize: 12.0,
//                                             letterSpacing: 0.2
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 10.0),
//                                       child: new Icon(
//                                         Icons.menu,
//                                         color: Colors.black,
//                                         size: 10,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 // margin: EdgeInsets.only(left: 3.5),
//                                 width: MediaQuery.of(context).size.width*0.22,
//                                 height: MediaQuery.of(context).size.height*0.01,
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 0.0),
//                                       child: Text(
//                                         'CHANGE(1D)',
//                                         style: new TextStyle(
//                                             fontFamily: "Poppins",
//                                             color: Color(0xFF000000), fontSize: 7.0,
//                                             letterSpacing: 0.2
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(top: 0.0),
//                                       child: Text(
//                                         '27.18',
//                                         style: new TextStyle(
//                                             fontFamily: "Poppins",
//                                             color: Color(0xFFe70b31), fontSize: 8.0,
//                                             letterSpacing: 0.2
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 width: MediaQuery.of(context).size.width*0.22,
//                                 height: MediaQuery.of(context).size.height*0.09,
//                                 child: SfCartesianChart(
//                                     primaryXAxis: NumericAxis(
//                                       isVisible: false,
//                                     ),
//                                     primaryYAxis: NumericAxis(
//                                         isVisible: false
//                                     ),
//                                     series: <ChartSeries>[
//                                       StackedAreaSeries<NewSalesData, double>(
//                                         dataSource: newSalesData,
//                                         xValueMapper: (NewSalesData data, _) => data.year,
//                                         yValueMapper: (NewSalesData data, _) => data.sales,
//                                         gradient: gradientColors,
//                                       ),
//                                     ]
//                                 ),
//                               ),
//                               Container(
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//                                     SizedBox(
//                                         width: 2.0
//                                     ),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width*0.09,
//                                       height: MediaQuery.of(context).size.height*0.036,
//                                       child: Container(
//                                         margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
//                                         decoration: new BoxDecoration(
//                                           border: Border.all(
//                                             color: Color(0xff696969),
//                                             width: 1,
//                                           ),
//                                           color: Color(0xFFFFFFFF),
//                                         ),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   decoration: new BoxDecoration(
//                                                     color: Color(0xff696969),
//                                                   ),
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0),
//                                                     child: Text(
//                                                       'SELL',
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0,top: 0.0),
//                                                     child: Text(
//                                                       '80.42',
//                                                       textAlign: TextAlign.right,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width*0.09,
//                                       height: MediaQuery.of(context).size.height*0.036,
//                                       child: Container(
//                                         margin: EdgeInsets.only(left: 5.0,bottom: 1.0),
//                                         decoration: new BoxDecoration(
//                                           border: Border.all(
//                                             color: Color(0xff696969),
//                                             width: 1,
//                                           ),
//                                           color: Color(0xFFFFFFFF),
//                                         ),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   decoration: new BoxDecoration(
//                                                     color: Color(0xff696969),
//                                                   ),
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0),
//                                                     child: Text(
//                                                       'BUY',
//                                                       textAlign: TextAlign.center,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               width: MediaQuery.of(context).size.width*0.10,
//                                               height: MediaQuery.of(context).size.height*0.015,
//                                               child: Container(
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(left: 0.0,top: 0.0),
//                                                     child: Text(
//                                                       '80.42',
//                                                       textAlign: TextAlign.right,
//                                                       style: TextStyle(
//                                                           fontSize: 7.0,
//                                                           color: Color(0xFF000000),
//                                                           fontFamily: "WorkSansBold"),
//                                                     ),
//                                                   )
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                         width: 2.0
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//
//                     ),
//                   ),
//                 ],
//               )
//           ),

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
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height*0.6,
        child: Column(
          children: <Widget>[
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
                      new Tab(text: 'Trending'),
                      new Tab(text: 'Unlisted'),
                      new Tab(text: 'Crypto'),
                      new Tab(text: 'Listed'),
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
    );
  }

  // ignore: missing_return
  Widget _getPage(Tab tab){
    switch(tab.text){
      case 'Trending': return topTrendingNews();
      case 'Unlisted': return vcPCReEsg();
      case 'Crypto': return crypto();
      case 'Listed': return equities();

    }
  }
}