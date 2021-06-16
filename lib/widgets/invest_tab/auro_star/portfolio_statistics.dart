import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/home/homeScreen.dart';
import 'package:auroim/widgets/invest_tab/auro_star/static_auro_rabbit_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:auroim/constance/global.dart' as globals;

class PortfolioStatistics extends StatefulWidget {
  final String inceptionDate;
  final String returnStat;
  final String annualizedReturn;
  final String benchmark;
  final String alpha;
  final String downsideVolatility;
  final String sharpeRatio;
  final String sortiniRatio;

  const PortfolioStatistics(
      {Key key,
      this.inceptionDate,
      this.returnStat,
      this.annualizedReturn,
      this.benchmark,
      this.alpha,
      this.downsideVolatility,
      this.sharpeRatio,
      this.sortiniRatio})
      : super(key: key);

  @override
  _PortfolioStatisticsState createState() => _PortfolioStatisticsState();
}

class _PortfolioStatisticsState extends State<PortfolioStatistics> {
  TextEditingController _appbarTextController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  var homeScaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(65.0),
        //   child: AppBar(
        //     automaticallyImplyLeading: false,
        //     backgroundColor: Colors.black,
        //     // globals.isGoldBlack
        //     //     ? AllCoustomTheme.getAppBarBackgroundThemeColors()
        //     // // : Color(0xFF7499C6)
        //     //     : Color(0xFF7499C6),
        //     title: _buildAppBar(context),
        //   ),
        // ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Portfolio Statistics',
                      style: TextStyle(
                          color: Color(0xffd8af4f),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Rosario',
                          fontSize: 18),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Return',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Rosario',
                    fontWeight: FontWeight.w400),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xffc4c4c4).withOpacity(0.06),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    rowWidget(title: 'Inception Date', value: 'May 2017'),
                    rowWidget(title: 'Return', value: 'Balanced'),
                    rowWidget(title: 'Annualized Return', value: '15%'),
                    rowWidget(
                        title: 'Benchmark', value: 'MSCI Asia Pac (MXAS US)'),
                    rowWidget(title: 'Alpha', value: '10%'),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Risk Adjusted',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Rosario',
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xffc4c4c4).withOpacity(0.06),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    rowWidget(title: 'Downside Volatility', value: '9%'),
                    rowWidget(title: 'Sharpe Ratio', value: '10%'),
                    rowWidget(title: 'Sortini Ratio', value: '15%'),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Charts',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Rosario',
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 10,
              ),
              SfCartesianChart(
                plotAreaBorderWidth: 0,
                title: ChartTitle(text: ''),
                legend: Legend(
                  isVisible: true,
                  overflowMode: LegendItemOverflowMode.wrap,
                  alignment: ChartAlignment.center,
                  position: LegendPosition.top,
                  legendItemBuilder: (name, series, point, index) {
                    var changesString = name.replaceAll("_", " ").toLowerCase();
                    // print("legend");
                    LineSeries ss = series;
                    ChartPoint<dynamic> dd = point;

                    // print(series.runtimeType.toString());
                    // print(point.runtimeType.toString());
                    return Container(
                      padding: EdgeInsets.all(1.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: ss.color,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            changesString.toUpperCase(),
                            style: TextStyle(
                              color: ss.color,
                              fontFamily: "Ubuntu",
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                primaryXAxis: DateTimeAxis(
                    // edgeLabelPlacement: EdgeLabelPlacement.shift,
                    // interval: 2,

                    majorGridLines: MajorGridLines(width: 0)),
                primaryYAxis: NumericAxis(
                    labelFormat: '{value}%',
                    majorTickLines: MajorTickLines(color: Colors.transparent)),
                series: _getDefaultLineSeries(),
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                ),
                axes: [
                  NumericAxis(
                    opposedPosition: true,
                    name: 'yAxis1',
                    majorGridLines: MajorGridLines(width: 0),
                    labelFormat: '{value}K',
                    minimum: 10,
                    maximum: 100,
                    interval: 10,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 4.0),
          child: IconButton(
            icon: Icon(
              FontAwesomeIcons.bars,
              size: 28,
              color: Colors.white,
            ),
            onPressed: () => homeScaffoldKey.currentState.openDrawer(),
          ),
          // CircleAvatar(
          //   radius: 20.0,
          //   backgroundImage: new AssetImage('assets/download.jpeg'),
          //   backgroundColor: Colors.transparent,
          // ),
        ),
        // Stack(
        //   alignment: Alignment.bottomRight,
        //   children: <Widget>[
        //
        //     InkWell(
        //       onTap: () {
        //         _homeScaffoldKey.currentState.openDrawer();
        //       },
        //       child: FractionalTranslation(
        //         translation: Offset(0.4, 0.2),
        //         child: CircleAvatar(
        //           backgroundColor: Colors.white,
        //           radius: 11.0,
        //           child: Icon(
        //             Icons.sort_outlined,
        //             size: 16,
        //             color: Colors.black,
        //           ),
        //         ),
        //       ),
        //     )
        //   ],
        // ),
        //search box area
        Container(
          margin: EdgeInsets.only(top: 10.0, left: 13.0),
          decoration: new BoxDecoration(
            color: Color(0xFFFFFFFF),
            border: Border.all(
              color: Color(0xff696969),
              width: 1.5,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.58,
                height: MediaQuery.of(context).size.height * 0.05,
                child: TextFormField(
                  controller: _appbarTextController,
                  focusNode: _focusNode,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: ConstanceData.SIZE_TITLE14,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      FontAwesomeIcons.search,
                      color: AllCoustomTheme.getNewSecondTextThemeColor(),
                      size: 15,
                    ),
                    hintText: "Search Listed Companies",
                    hintStyle: TextStyle(
                      color: AllCoustomTheme.getNewSecondTextThemeColor(),
                      fontSize: ConstanceData.SIZE_TITLE14,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: 5,
        ),
        //globe icon
        Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 3.0),
              child: Image(
                  height: 40,
                  width: 40,
                  image: new AssetImage('assets/appIcon.png')),
            ),
            FractionalTranslation(
              translation: Offset(-0.5, 0.0),
              child: GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 6.0,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget rowWidget({String title, String value}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Divider(
            color: Color(0xffc4c4c4),
          ),
        )
      ],
    );
  }

  List<LineSeries<ChartData, DateTime>> _getDefaultLineSeries() {
    return <LineSeries<ChartData, DateTime>>[
      LineSeries<ChartData, DateTime>(
          animationDuration: 2500,
          dataSource: chartData,
          // yAxisName: 'yAxis1',
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          width: 2,
          color: Colors.purple,
          name: 'Auro Rabbit',
          markerSettings: MarkerSettings(isVisible: false)),
      LineSeries<ChartData, DateTime>(
          animationDuration: 2500,
          dataSource: chartData,
          // yAxisName: 'yAxis1',
          width: 2,
          name: 'BTC Return',
          color: Colors.cyan,
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y2,
          markerSettings: MarkerSettings(isVisible: false)),
      LineSeries<ChartData, DateTime>(
          animationDuration: 2500,
          dataSource: chartData,
          // yAxisName: 'yAxis1',
          width: 2,
          name: 'Alpha',
          color: Colors.yellow,
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y3,
          markerSettings: MarkerSettings(isVisible: false)),
      LineSeries<ChartData, DateTime>(
          animationDuration: 2500,
          dataSource: chartData,
          yAxisName: 'yAxis1',
          width: 2,
          name: 'BTC Dose Price',
          color: Colors.blue,
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y4,
          markerSettings: MarkerSettings(isVisible: false))
    ];
  }
}

class ChartData {
  ChartData(this.x, this.y, this.y2, this.y3, this.y4);

  final DateTime x;
  final double y;
  final double y2;
  final double y3;
  final double y4;
}
