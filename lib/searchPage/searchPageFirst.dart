import 'package:auro/securityPages/securityPageFirst.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auro/style/theme.dart' as StyleTheme;
import 'package:syncfusion_flutter_charts/charts.dart';


class SearchPageFirst extends StatefulWidget {

  final String callingFrom;
  final String logo;

  const SearchPageFirst({Key key, @required this.callingFrom,this.logo}) : super(key: key);

  @override
  _SearchPageFirstState createState() => _SearchPageFirstState();
}

class _SearchPageFirstState extends State<SearchPageFirst> with SingleTickerProviderStateMixin {

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
    // selectedTabIndex=0;
    // TODO: implement initState
    super.initState();
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
                  fontFamily: "Poppins",
                  color: Color(0xFFFFFFFF), fontSize: 14.0,
                  letterSpacing: 0.2
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.40,
            decoration: new BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              border: Border.all(
                color: Color(0xFFFFFFFF),
                width: 1,
              ),
            ),
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
                                                  image: new AssetImage('assets/login_logo.png')),
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
                                                  image: new AssetImage('assets/login_logo.png')),
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
                                                    image: new AssetImage('assets/login_logo.png')),
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
                                                    image: new AssetImage('assets/login_logo.png')),
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
                                    image: new AssetImage('assets/login_logo.png')),
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
                  fontFamily: "WorkSansSemiBold",
                  color: Color(0xFFFFFFFF), fontSize: 16.0,
                ),
              ),
            )
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.44,
              margin: EdgeInsets.only(top: 15.0,left: 10.0,right: 10.0),
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
                                          image: new AssetImage('assets/login_logo.png')),
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
                                          image: new AssetImage('assets/login_logo.png')),
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
                                          image: new AssetImage('assets/login_logo.png')),
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
                                          image: new AssetImage('assets/login_logo.png')),
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
                                          image: new AssetImage('assets/login_logo.png')),
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
                                          image: new AssetImage('assets/login_logo.png')),
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
                                          image: new AssetImage('assets/login_logo.png')),
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
                                          image: new AssetImage('assets/login_logo.png')),
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
    return Scaffold(
      appBar: new AppBar(
        title: Padding(
            padding: EdgeInsets.only(left:25.0),
            child: Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'SEARCH',
                  style: new TextStyle(
                    fontFamily: "WorkSansSemiBold",
                    color: Color(0xFFFFFFFF), fontSize: 28.0,
                  ),
                )
            )
        ),
        backgroundColor: widget.callingFrom=="Accredited Investor" ?  StyleTheme.Colors.accAppBarBackgroundColor : StyleTheme.Colors.retailAppBarBackgroundColor,
        leading: const BackButton(),
        iconTheme: new IconThemeData(color: StyleTheme.Colors.AppBarMenuIconColor),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*1.2,
          decoration: new BoxDecoration(
            color: widget.callingFrom=="Accredited Investor" ?  StyleTheme.Colors.accScreenBackgroundColor : StyleTheme.Colors.retailScreenBackgroundColor,
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 25.0),
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
                      labelColor: StyleTheme.Colors.AppBarTabTextColor,
                      labelStyle: TextStyle(fontSize: 17.0,letterSpacing: 0.2),
                      indicatorColor: StyleTheme.Colors.AppBarSelectedTabLineColor,
                      indicatorWeight: 4.0,
                      isScrollable: true,
                      unselectedLabelColor: StyleTheme.Colors.AppBarTabTextColor,
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
              ),
            ],
          ),
        )
      ),
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

class NewSalesData {
  NewSalesData(this.year, this.sales);
  final double year;
  final double sales;
}