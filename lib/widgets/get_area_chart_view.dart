import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/modules/investRelatedPages/riskOnboardingPages/onBoardingFirst.dart';
import 'package:auroim/modules/investRelatedPages/securityFirstPage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GetAreaChartView extends StatefulWidget {
  final List<Color> color;
  final List<double> stops;
  final List<NewSalesData> newSalesData;
  final companyData;

  GetAreaChartView({
    this.color,
    this.newSalesData,
    this.stops,
    this.companyData,
  });

  @override
  _GetAreaChartViewState createState() => _GetAreaChartViewState();
}

class _GetAreaChartViewState extends State<GetAreaChartView> {
  LinearGradient gradientColors;

  @override
  void initState() {
    gradientColors = LinearGradient(
      colors: widget.color,
      stops: widget.stops,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.companyData);
    return Container(
      height: 300,
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return wid();
        },
      ),
    );
  }

  wid() {
    return Container(
      // decoration: BoxDecoration(border: Border.all(color: Colors.white,),),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
              height: 290,
              width: MediaQuery.of(context).size.width * 0.96,
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: new Border.all(
                      color: AllCoustomTheme.getChartBoxThemeColor(),
                      width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 5.0),
                      child: Container(
                        // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                        height: MediaQuery.of(context).size.height * 0.10,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.companyData == null
                                      ? ""
                                      : widget.companyData["company_name"],
                                  style: TextStyle(
                                    color: AllCoustomTheme
                                        .getChartBoxTextThemeColor(),
                                    fontSize: ConstanceData.SIZE_TITLE18,
                                    fontFamily: "Roboto",
                                  ),
                                ),
                                Text(
                                  "2.20 (1.61%)",
                                  style: TextStyle(
                                    color: AllCoustomTheme
                                        .getNewSecondTextThemeColor(),
                                    fontSize: ConstanceData.SIZE_TITLE8,
                                    fontFamily: "Roboto",
                                  ),
                                ),
                                Text(
                                  '\$' + " 390.00",
                                  style: TextStyle(
                                    color: AllCoustomTheme
                                        .getChartBoxTextThemeColor(),
                                    fontSize: ConstanceData.SIZE_TITLE18,
                                    fontFamily: "Roboto",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "HIGH",
                                      style: TextStyle(
                                        color: AllCoustomTheme
                                            .getNewTextThemeColors(),
                                        fontSize: ConstanceData.SIZE_TITLE10,
                                        fontFamily: "Roboto",
                                      ),
                                    ),
                                    Icon(
                                      FontAwesomeIcons.arrowUp,
                                      color: Colors.green,
                                      size: 10,
                                    ),
                                    Text(
                                      "139.00",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: ConstanceData.SIZE_TITLE10,
                                        fontFamily: "Roboto",
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "LOW",
                                      style: TextStyle(
                                        color: AllCoustomTheme
                                            .getNewTextThemeColors(),
                                        fontSize: ConstanceData.SIZE_TITLE10,
                                        fontFamily: "Roboto",
                                      ),
                                    ),
                                    Icon(
                                      FontAwesomeIcons.arrowDown,
                                      color: Colors.red,
                                      size: 10,
                                    ),
                                    Text(
                                      "139.00",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: ConstanceData.SIZE_TITLE10,
                                        fontFamily: "Roboto",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.88,
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: SfCartesianChart(
                              primaryXAxis: NumericAxis(
                                isVisible: false,
                              ),
                              primaryYAxis: NumericAxis(isVisible: false),
                              series: <ChartSeries>[
                                StackedAreaSeries<NewSalesData, double>(
                                  dataSource: widget.newSalesData,
                                  xValueMapper: (NewSalesData data, _) =>
                                      data.year,
                                  yValueMapper: (NewSalesData data, _) =>
                                      data.sales,
                                  gradient: gradientColors,
                                ),
                              ]),
                        )),
                    SizedBox(
                      // height: MediaQuery.of(context).size.height*0.10,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: MediaQuery.of(context).size.height * 0.038,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: new Border.all(
                                    color:
                                        AllCoustomTheme.getChartBoxThemeColor(),
                                    width: 1.5),
                                color: AllCoustomTheme.getChartBoxThemeColor(),
                              ),
                              child: MaterialButton(
                                // splashColor: Colors.grey,
                                child: Text(
                                  "BUY",
                                  style: TextStyle(
                                    color: AllCoustomTheme
                                        .getButtonTextThemeColors(),
                                    fontSize: ConstanceData.SIZE_TITLE13,
                                    fontFamily: "Roboto",
                                  ),
                                ),
                                onPressed: () async {
/*                                      Navigator.of(context).push(new MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                            new OnBoardingFirst(logo: "logo.png",callingFrom: "Accredited Investor",)));*/
                                  Navigator.of(context).push(
                                    new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new SecurityPageFirst(
                                        logo: "logo.png",
                                        callingFrom: "Accredited Investor",
                                        companyTicker:
                                            widget.companyData["ticker"],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.26,
                            height: MediaQuery.of(context).size.height * 0.038,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: new Border.all(
                                    color:
                                        AllCoustomTheme.getChartBoxThemeColor(),
                                    width: 1.5),
                                // color: AllCoustomTheme.getChartBoxThemeColor(),
                              ),
                              child: MaterialButton(
                                splashColor: Colors.grey,
                                child: Text(
                                  "SELL",
                                  style: TextStyle(
                                    color: AllCoustomTheme
                                        .getChartBoxTextThemeColor(),
                                    fontSize: ConstanceData.SIZE_TITLE13,
                                    fontFamily: "Roboto",
                                  ),
                                ),
                                onPressed: () async {
/*                                      Navigator.of(context).push(new MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                            new OnBoardingFirst(logo: "logo.png",callingFrom: "Accredited Investor",)));*/
                                  Navigator.of(context).push(
                                    new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new SecurityPageFirst(
                                              logo: "logo.png",
                                              callingFrom:
                                                  "Accredited Investor"),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.32,
                            height: MediaQuery.of(context).size.height * 0.038,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: new Border.all(
                                    color:
                                        AllCoustomTheme.getChartBoxThemeColor(),
                                    width: 1.5),
                                // color: AllCoustomTheme.getChartBoxThemeColor(),
                              ),
                              child: MaterialButton(
                                splashColor: Colors.grey,
                                child: Text(
                                  "WATCH",
                                  style: TextStyle(
                                    color: AllCoustomTheme
                                        .getChartBoxTextThemeColor(),
                                    fontSize: ConstanceData.SIZE_TITLE13,
                                    fontFamily: "Roboto",
                                  ),
                                ),
                                onPressed: () async {
                                  Navigator.of(context).push(
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              new OnBoardingFirst(
                                                logo: "logo.png",
                                                callingFrom:
                                                    "Accredited Investor",
                                              )));
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
