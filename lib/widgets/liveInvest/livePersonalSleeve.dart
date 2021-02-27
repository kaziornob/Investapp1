import 'dart:convert';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:auroim/constance/constance.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:toast/toast.dart';

class AllCompanies extends StatefulWidget {
  @override
  _AllCompaniesState createState() => _AllCompaniesState();
}

class _AllCompaniesState extends State<AllCompanies> {

  Map<String, bool> allTabsBool = {
    "LIVE": true,
    "PAPER": false,
  };

  String filter = "trending";

  @override
  void initState() {
    super.initState();
  }

  int donutCurrentIndex = 0;

  final List donutArray = [1,2,3];

  final List<ChartData> chartData = [
    ChartData('David', 25, globals.isGoldBlack ? Color(0xFFE8E2DB) : Color(0xFF1D6177)),
    ChartData('Steve', 25, globals.isGoldBlack ? Color(0xFF1A3263) : Color(0xFF000000)),
    ChartData('Jack', 25, globals.isGoldBlack ? Color(0xFFF5564E) : Color(0xFF7499C6)),
    ChartData('Others', 25, Color(0xFFFAB95B))
  ];

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setWidgetState) {
        return Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      Text(
                        "All Companies",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: ConstanceData.SIZE_TITLE20,
                            fontFamily: "Rosarivo",
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0.1),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: 30,
                    // color: Colors.green,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        children: [
                          TabChip(
                            child: Text(
                              "Trending",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: allTabsBool["trending"] == true
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: allTabsBool["trending"] == true
                                ? Color(0xff7499C6)
                                : Colors.white,
                            callback: () =>
                                selectedTab("trending", setWidgetState),
                          ),
                          TabChip(
                            child: Text(
                              "Live",
                              style: TextStyle(
                                color: allTabsBool["live"] == true
                                    ? Colors.white
                                    : Colors.black,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: allTabsBool["live"] == true
                                ? Color(0xff7499C6)
                                : Colors.white,
                            callback: () => selectedTab("live", setWidgetState),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width - 40,
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        // plus, search section
                        Container(
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.10,right: MediaQuery.of(context).size.width*0.10,
                              top:MediaQuery.of(context).size.height*0.04,bottom: MediaQuery.of(context).size.height*0.04),
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Color(0xFF7499C6),
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(2.0),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15.0,
                              ),
                              InkWell(
                                  child: Container(
                                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.25,right: MediaQuery.of(context).size.width*0.25),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.black,
                                      size: 70,
                                    ),
                                  )
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.07,right: MediaQuery.of(context).size.width*0.03),
                                  child: Text(
                                    "Buy your first Security. Clink on the button below to search for options",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: AllCoustomTheme.getNewSecondTextThemeColor(),
                                        fontSize: 14.5,
                                        fontFamily: "Roboto",
                                        fontStyle: FontStyle.normal,
                                        letterSpacing: 0.2
                                    ),
                                  )
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height * 0.053,
                                width: MediaQuery.of(context).size.width * 0.40,
                                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.24,right: MediaQuery.of(context).size.width*0.24),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  border: new Border.all(color: Color(0xFF7499C6), width: 1.5),
                                  color: Color(0xFF7499C6),
                                ),
                                child: MaterialButton(
                                  splashColor: Colors.grey,
                                  child: Text(
                                    "Search",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ConstanceData.SIZE_TITLE16,
                                    ),
                                  ),
                                  onPressed: () async
                                  {

                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: true,
                          child: Container(
                            child: CarouselSlider.builder(
                              itemCount: donutArray.length,
                              options: CarouselOptions(
                                  autoPlay: false,
                                  viewportFraction: donutCurrentIndex==1 ? 1.1 : 1,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      donutCurrentIndex = index;
                                    });
                                  }
                              ),
                              itemBuilder: (context,index){
                                return Container(
                                  child: SfCircularChart(
                                      series: <CircularSeries>[
                                        DoughnutSeries<ChartData, String>(
                                          dataSource: chartData,
                                          // pointColorMapper:(ChartData data,  _) => data.color,
                                          xValueMapper: (ChartData data, _) => data.x,
                                          yValueMapper: (ChartData data, _) => data.y,
                                          dataLabelSettings:DataLabelSettings(
                                              isVisible : true,
                                              // labelPosition: ChartDataLabelPosition.outside,
                                              useSeriesColor: true,
                                              showCumulativeValues: true,
                                              showZeroValue: true
                                          ),
                                        )
                                      ]
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Visibility(
                          visible: true,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: donutArray.map((url) {
                                int index = donutArray.indexOf(url);
                                return Container(
                                  width: 10.0,
                                  height: 8.0,
                                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: donutCurrentIndex == index
                                    // ? Color(0xFFFFFFFF)
                                        ? Color(0xFFD8AF4F)
                                        : Color(0xffCBB4B4),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  selectedTab(selectedKey, setWidgetState) {
    int i = 0;
    print(selectedKey);
    setWidgetState(() {
      allTabsBool.forEach((key, value) {
        if (selectedKey == key) {
          allTabsBool[key] = true;
          filter = key;
        } else {
          allTabsBool[key] = false;
        }
      });
    });
  }
}

class TabChip extends StatelessWidget {
  final Widget child;
  final Function callback;
  final Color backgroundColor;

  TabChip({
    this.child,
    this.backgroundColor,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: GestureDetector(
        onTap: callback,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: backgroundColor,
          ),
          width: 90,
          height: 40,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
