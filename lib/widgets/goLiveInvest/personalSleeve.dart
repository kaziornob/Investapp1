import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/modules/bussPost/portfolioPitch.dart';
import 'package:auroim/widgets/goLiveInvest/SecurityBuySell.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class PersonalSleeve extends StatefulWidget {
  final VoidCallback goToPersonalSleeveCallback;

  PersonalSleeve({this.goToPersonalSleeveCallback});
  @override
  _PersonalSleeveState createState() => _PersonalSleeveState();
}

class _PersonalSleeveState extends State<PersonalSleeve> with SingleTickerProviderStateMixin {
  ApiProvider request = new ApiProvider();

  var investorType;

  int selectedTabIndex;
  var securityBoxChartData;


  final List<Tab> tabList = <Tab>[
    new Tab(text: 'LIVE'),
    new Tab(text: 'PAPER'),
  ];


  TabController _tabController;


  @override
  void initState() {
    super.initState();
    getSharedPrefData();
    _tabController = new TabController(vsync: this, length: tabList.length);
    investInfo.initData();
  }

  SharedPreferences prefs;
  getSharedPrefData() async {
    prefs = await SharedPreferences.getInstance();
    investorType = prefs!=null && prefs.containsKey('InvestorType') &&
        prefs.getString('InvestorType') != null ? prefs.getString('InvestorType') : '';
    print("investor type : ${prefs.getString('InvestorType')}");
  }


  int donutCurrentIndex = 0;

  final List donutArray = [1,2,3];

  final List<ChartData> chartData = [
    ChartData('David', 25, globals.isGoldBlack ? Color(0xFFE8E2DB) : Color(0xFF1D6177)),
    ChartData('Steve', 25, globals.isGoldBlack ? Color(0xFF1A3263) : Color(0xFF000000)),
    ChartData('Jack', 25, globals.isGoldBlack ? Color(0xFFF5564E) : Color(0xFF7499C6)),
    ChartData('Others', 25, Color(0xFFFAB95B))
  ];


  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Security', 70),
      _getTitleItemWidget('# of shares/ \$', 70),
      _getTitleItemWidget('In-Price', 70),
      _getTitleItemWidget('Current Price', 70),
      _getTitleItemWidget('% Return', 70),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      color: AllCoustomTheme.getHorTableHeadingThemeColors(),
      child: Text(
            label,
            style: new TextStyle(
              color: AllCoustomTheme.getInvestTableTextThemeColors(),
              fontSize: ConstanceData.SIZE_TITLE15,
              fontFamily: "Roboto",
            ),
        ),
      width: width,
      height: 35,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),

    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    var tempEven = (index +1) % 2;
    return Container(
      width: 70,
      height: 70,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border.all(color: tempEven==0 ? Colors.indigo[100] : Colors.indigo[50]),
        color: tempEven==0 ? Colors.indigo[100] : Colors.indigo[50],
      ),
      child: Text(
          "${investInfo.listInfo[index].security}",
        style: new TextStyle(
          // color: AllCoustomTheme.getInvestTableColumnTextThemeColors(),
          color: Colors.black,
          fontSize: ConstanceData.SIZE_TITLE15,
          fontFamily: "Roboto",
        ),
      ),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {

    var tempEven = (index +1) % 2;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: tempEven==0 ? Colors.indigo[100] : Colors.indigo[50]),
            color: tempEven==0 ? Colors.indigo[100] : Colors.indigo[50],
          ),
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          child: Text(
              investInfo.listInfo[index].share,
            style: new TextStyle(
              // color: AllCoustomTheme.getInvestTableColumnTextThemeColors(),
              color: Colors.black,
              fontSize: ConstanceData.SIZE_TITLE15,
              fontFamily: "Roboto",
            ),
          ),
          width: 70,
          height: 70,
          alignment: Alignment.centerLeft,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          decoration: BoxDecoration(
            border: Border.all(color: tempEven==0 ? Colors.indigo[100] : Colors.indigo[50]),
            color: tempEven==0 ? Colors.indigo[100] : Colors.indigo[50],
          ),
          child: Text(
              investInfo.listInfo[index].inPrice,
            style: new TextStyle(
              // color: AllCoustomTheme.getInvestTableColumnTextThemeColors(),
              color: Colors.black,
              fontSize: ConstanceData.SIZE_TITLE15,
              fontFamily: "Roboto",
            ),
          ),
          width: 70,
          height: 70,
          alignment: Alignment.centerLeft,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          decoration: BoxDecoration(
            border: Border.all(color: tempEven==0 ? Colors.indigo[100] : Colors.indigo[50]),
            color: tempEven==0 ? Colors.indigo[100] : Colors.indigo[50],
          ),
          child: Text(
              investInfo.listInfo[index].currentPrice,
            style: new TextStyle(
              // color: AllCoustomTheme.getInvestTableColumnTextThemeColors(),
              color: Colors.black,
              fontSize: ConstanceData.SIZE_TITLE15,
              fontFamily: "Roboto",
            ),
          ),
          width: 70,
          height: 70,
          alignment: Alignment.centerLeft,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          decoration: BoxDecoration(
            border: Border.all(color: tempEven==0 ? Colors.indigo[100] : Colors.indigo[50]),
            color: tempEven==0 ? Colors.indigo[100] : Colors.indigo[50],
          ),
          child: Text(
              investInfo.listInfo[index].perReturn,
            style: new TextStyle(
              // color: AllCoustomTheme.getInvestTableColumnTextThemeColors(),
              color: Colors.black,
              fontSize: ConstanceData.SIZE_TITLE15,
              fontFamily: "Roboto",
            ),
          ),
          width: 70,
          height: 70,
          alignment: Alignment.centerLeft,
        ),
/*        Container(
          height: MediaQuery.of(context).size.height*0.06,
          width: MediaQuery.of(context).size.width*0.32,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: new Border.all(color: AllCoustomTheme.getButtonBoxColor(), width: 1.5),
              color: Colors.green,

          ),
          child: MaterialButton(
            splashColor: Colors.grey,
            child: Text(
                "BUY/Sell",
                style: AllCoustomTheme.getButtonSelectedTextStyleTheme()
            ),
            onPressed: () async
            {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (BuildContext context) => SecurityBuySell(),
                ),
              );
            },
          ),
        )*/
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height*1.5,
        margin: EdgeInsets.only(left: 5.0,right: 5.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top:0.0),
              child: Center(
                  child: Text(
                    'PERSONAL SLEEVE',
                    style: new TextStyle(
                      color: AllCoustomTheme.getHeadingThemeColors(),
                      fontSize: ConstanceData.SIZE_TITLE18,
                      fontFamily: "Rosarivo",
                    ),
                  )
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.18,right: MediaQuery.of(context).size.width*0.18),
              padding: EdgeInsets.only(
                bottom: 3, // space between underline and text
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        color: AllCoustomTheme.getHeadingThemeColors(),
                        width: 1.0, // Underline width
                      )
                  )
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 10.0,right: 3.0,top: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    onTap: (index)
                    {
                      selectedTabIndex = index;
                    },
                    labelColor: Colors.white,
                    labelStyle: TextStyle(fontSize: 14.0,letterSpacing: 0.2),
                    indicator: new BoxDecoration(
                      color: AllCoustomTheme.getButtonBoxColor(),
                      border: Border.all(
                        color: AllCoustomTheme.getButtonBoxColor(),
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(2.0),
                      ),
                    ),
                    indicatorColor: AllCoustomTheme.getButtonBoxColor(),
                    indicatorWeight: 4.0,
                    // unselectedLabelColor: StyleTheme.Colors.AppBarTabTextColor,
                    tabs: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        width: 120,
                        height: 40,
                        child: Center(
                          child:Text(
                              "LIVE",
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        width: 120,
                        height: 40,
                        child: Center(
                          child:Text(
                            "PAPER",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(top: 10.0),
                /*child: new TabBarView(
                  controller: _tabController,
                  children: tabList.map((Tab tab) {
                    return _getPage(tab);
                  }).toList(),
                  physics: ScrollPhysics(),
                ),*/
                child: new TabBarView(
                  controller: _tabController,
                  children: tabList.map((Tab tab) {
                    print("tab text: $tab");
                    return ListView(
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
                                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.28,right: MediaQuery.of(context).size.width*0.28),
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
                                    tab.text=="LIVE"  ? "Buy your first Security. Clink on the button below to search for options"
                                        : "Add a portfolio pitch to create an Auro track record",
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
                                margin: EdgeInsets.only(
                                    left: tab.text=="LIVE" ? MediaQuery.of(context).size.width*0.24 : MediaQuery.of(context).size.width*0.20,
                                    right: tab.text=="LIVE" ? MediaQuery.of(context).size.width*0.24 : MediaQuery.of(context).size.width*0.20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    border: new Border.all(color: AllCoustomTheme.getButtonBoxColor(), width: 1.5),
                                    color: AllCoustomTheme.getButtonBoxColor()
                                ),
                                child: MaterialButton(
                                  splashColor: Colors.grey,
                                  child: Text(
                                    tab.text=="LIVE"  ? "Search" : "ADD PITCH",
                                    style: TextStyle(
                                      color: AllCoustomTheme.getButtonTextThemeColors(),
                                      fontSize: ConstanceData.SIZE_TITLE13,
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () async
                                  {
                                    if(tab.text == "PAPER")
                                    {
                                      Navigator.of(context).push(
                                        CupertinoPageRoute(
                                          builder: (BuildContext context) => PortfolioPitch(),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ),
                        ),

                        // doughnut chart section start
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
                        // doughnut chart section end

                        // button buy portfolio section
                        Visibility(
                          visible: tab.text=="PAPER" ? true : false,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.053,
                            width: MediaQuery.of(context).size.width * 0.40,
                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.15,right: MediaQuery.of(context).size.width*0.15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              border: new Border.all(color: Color(0xFF7499C6), width: 1.5),
                              color: Color(0xFF7499C6),
                            ),
                            child: MaterialButton(
                              splashColor: Colors.grey,
                              child: Text(
                                "GO LIVE - Buy portfolio",
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
                        ),
                        // Colors.indigo[100]
                        // table section
/*                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              singleRow(context, "Hualan Biological Engineering","5.09","7.92965","720","5%",Colors.indigo[50]),
                            ],
                          ),
                        ),*/
                        Container(
                          height: MediaQuery.of(context).size.height,
                          margin: EdgeInsets.only(top:10.0),
                          child: HorizontalDataTable(
                            leftHandSideColumnWidth: 70,
                            rightHandSideColumnWidth: 300,
                            isFixedHeader: true,
                            headerWidgets: _getTitleWidget(),
                            leftSideItemBuilder: _generateFirstColumnRow,
                            rightSideItemBuilder: _generateRightHandSideColumnRow,
                            itemCount: investInfo.listInfo.length,
                            rowSeparatorWidget: const Divider(
                              color: Colors.blueGrey,
                              height: 1.0,
                              thickness: 0.0,
                            ),
                            leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
                            rightHandSideColBackgroundColor: AllCoustomTheme.getPageBackgroundThemeColor(),
                          ),
                        )
                      ],
                    );
                  }).toList(),
                  physics: ScrollPhysics(),
                ),
              ),
            ),

          ],
        )
    );
  }

  singleRow(context, security , share , inPrice , currentPrice, perReturn, color) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: color),
          color: color,
        ),
        height: 35,
        width: MediaQuery.of(context).size.width*0.95,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: Center(child: Text(security)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: Center(child: Text(share)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: Center(child: Text(inPrice)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: Center(child: Text(currentPrice)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: Center(child: Text(perReturn)),
            ),
          ],
        ),
      ),
    );
  }
}

InvestInfo investInfo = InvestInfo();

class InvestInfo {
  List<ListInfo> listInfo = [];

  void initData() {
    listInfo = [];

/*    if(securityBoxChartData!=null && securityBoxChartData['weights_assetclass'] != null &&
        securityBoxChartData['weights_assetclass']['weights'] != null)
      {

      }*/

    listInfo.add(
        ListInfo("Hualan Biological Engineering","5.09","7.92965","720","5")
    );
  }
}


class ListInfo {
  String security;
  String share;
  String inPrice;
  String currentPrice;
  String perReturn;



  ListInfo(this.security, this.share, this.inPrice,this.currentPrice, this.perReturn);
}