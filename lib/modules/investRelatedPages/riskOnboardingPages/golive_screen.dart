import 'package:animator/animator.dart';
import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/api/future_return.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/widgets/future_return_chart.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class GoLiveScreen extends StatefulWidget {
  final String callingFrom;
  final String logo;

  const GoLiveScreen({Key key, @required this.callingFrom, this.logo})
      : super(key: key);

  @override
  _GoLiveScreenState createState() => _GoLiveScreenState();
}

class _GoLiveScreenState extends State<GoLiveScreen> {
  bool _isInProgress = false;
  TextEditingController _oneOffDepositController =
      TextEditingController(text: "100000");
  TextEditingController _monthlyDepositController =
      TextEditingController(text: "1000");
  FutureReturn _futureReturn = FutureReturn();
  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();

  // var calculatedValue;
  var userReturnData;
  var listOfChartDataWithoutMonthlyDeposit;
  var listOfChartDataWithBoth;

  @override
  void initState() {
    super.initState();
    loadDetails();
  }

  loadDetails() async {
    setState(() {
      _isInProgress = true;
    });
    // await Future.delayed(const Duration(milliseconds: 700));

    userReturnData =
        await _featuredCompaniesProvider.getGoproRiskMetricsForUser();
    // print("data is got here");
    listOfChartDataWithBoth = calculate(false);
    listOfChartDataWithoutMonthlyDeposit = calculate(true);
    // print(listOfChartDataWithoutMonthlyDeposit[4].sales);
    // print(listOfChartDataWithBoth[4].sales);
    // print(userReturnData);
    // print("data is completed here");
    setState(() {
      _isInProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // AppBar appBar = AppBar();
    // double appBarheight = appBar.preferredSize.height;
    return Stack(
      children: <Widget>[
        SafeArea(
          bottom: true,
          child: Scaffold(
            backgroundColor: AllCoustomTheme.getBodyContainerThemeColor(),
            body: ModalProgressHUD(
              inAsyncCall: _isInProgress,
              opacity: 0,
              progressIndicator: CupertinoActivityIndicator(
                radius: 12,
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: !_isInProgress
                    ? GestureDetector(
                        onTap: () => FocusScope.of(context).unfocus(),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 5,
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
                                        begin: Offset(0, 0),
                                        end: Offset(0.2, 0),
                                      ),
                                      duration: Duration(milliseconds: 500),
                                      cycles: 0,
                                      builder: (anim) => FractionalTranslation(
                                        translation: anim.value,
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          color: AllCoustomTheme
                                              .getTextThemeColor(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // decoration:
                                    //     BoxDecoration(border: Border.all()),
                                    height: 60,
                                    width: MediaQuery.of(context).size.width *
                                        0.90,
                                    child: Column(
                                      children: [
                                        Container(
                                          child: Center(
                                            child: Image(
                                              width: 150.0,
                                              fit: BoxFit.fill,
                                              image:
                                                  AssetImage('assets/logo.png'),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 70.0, right: 70.0),
                                          padding: EdgeInsets.only(
                                            bottom:
                                                1, // space between underline and text
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Color(0xFFD8AF4F),
                                                width: 1.5, // Underline width
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                // decoration: BoxDecoration(
                                //   border: Border.all(),
                                // ),
                                height: 50,
                                width: MediaQuery.of(context).size.width - 20,
                                margin: EdgeInsets.only(
                                    top: 20.0,
                                    bottom: 20.0,
                                    left: 15.0,
                                    right: 10.0),
                                child: Center(
                                  child: Text(
                                    "What will be your first deposit in to your Auro account?",
                                    style: new TextStyle(
                                        // color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFF000000),
                                        color: Colors.black,
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        fontFamily: "Rosarivo",
                                        letterSpacing: 0.1),
                                  ),
                                ),
                              ),
                              Container(
                                // decoration: BoxDecoration(border: Border.all()),
                                height: 165,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Container(
                                            // decoration: BoxDecoration(
                                            //     border: Border.all()),
                                            height: 60,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.40,
                                            child: Center(
                                              child: Text(
                                                "One Off Deposit",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: ConstanceData
                                                      .SIZE_TITLE16,
                                                  fontFamily: "RobotoLight",
                                                  letterSpacing: 0.1,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            // margin: EdgeInsets.only(left: 20.0),
                                            height: 60,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.44,
                                            decoration: BoxDecoration(
                                              color: AllCoustomTheme
                                                  .getTextThemeColors(),
                                              // border: Border.all(),
                                            ),
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                prefixIcon: Container(
                                                  padding: EdgeInsets.only(
                                                    bottom: 8,
                                                  ),
                                                  decoration: BoxDecoration(
                                                      // border: Border.all(),
                                                      ),
                                                  child: Icon(
                                                    FontAwesomeIcons.dollarSign,
                                                    size: 15,
                                                  ),
                                                ),
                                              ),
                                              controller:
                                                  _oneOffDepositController,
                                              style: TextStyle(
                                                color: AllCoustomTheme
                                                    .getTextThemeColor(),
                                                fontSize:
                                                    ConstanceData.SIZE_TITLE14,
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width /
                                                5.5,
                                      ),
                                      child: Container(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.15,
                                        decoration: new BoxDecoration(
                                          color: AllCoustomTheme
                                              .getSeeMoreThemeColor(),
                                          border: Border.all(
                                            color: AllCoustomTheme
                                                .getSeeMoreThemeColor(),
                                            width: 1.2,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(50.0),
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          size: 30.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Container(
                                            // decoration: BoxDecoration(
                                            //     border: Border.all()),
                                            height: 60,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.40,
                                            child: Center(
                                              child: Text(
                                                "Monthly Deposit",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: ConstanceData
                                                      .SIZE_TITLE16,
                                                  fontFamily: "RobotoLight",
                                                  letterSpacing: 0.1,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 60,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.44,
                                            decoration: new BoxDecoration(
                                              color: AllCoustomTheme
                                                  .getTextThemeColors(),
                                              // border: Border.all(),
                                            ),
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                prefixIcon: Container(
                                                  padding: EdgeInsets.only(
                                                    bottom: 8,
                                                  ),
                                                  decoration: BoxDecoration(
                                                      // border: Border.all(),
                                                      ),
                                                  child: Icon(
                                                    FontAwesomeIcons.dollarSign,
                                                    size: 15,
                                                  ),
                                                ),
                                              ),
                                              controller:
                                                  _monthlyDepositController,
                                              style: TextStyle(
                                                color: AllCoustomTheme
                                                    .getTextThemeColor(),
                                                fontSize:
                                                    ConstanceData.SIZE_TITLE14,
                                              ),
                                              // initialValue: "",
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 70,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(
                                    top: 5.0,
                                    // bottom: 14.0,
                                    left: 10.0,
                                    right: 10.0),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 10.0, left: 10.0, right: 10.0),
                                  child: Text(
                                    "If you make a monthly deposit of X in addition to your initial deposit, you retums will increase by Y%!",
                                    style: new TextStyle(
                                      color: Colors.black,
                                      fontSize: ConstanceData.SIZE_TITLE16,
                                      fontFamily: "RobotoLight",
                                      letterSpacing: 0.1,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              FutureReturnChart(
                                colors: [
                                  Colors.blue[50],
                                  Colors.blue[200],
                                  Colors.blue,
                                ],
                                stops: [0.0, 0.5, 1.0],
                                pricesData: listOfChartDataWithBoth,
                                pricesDataOnlyInitial:
                                    listOfChartDataWithoutMonthlyDeposit,
                              ),
                              // UserPortfolioPerformance(),
                              Container(
                                height: 90,
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 10.0, right: 10.0),
                                  child: Text(
                                    "Solid line : Return with regular monthly investments \nDotted Line : Return with only initial investment Y-axis: Years of investment",
                                    style: new TextStyle(
                                      color: Colors.black,
                                      fontSize: ConstanceData.SIZE_TITLE16,
                                      fontFamily: "RobotoLight",
                                      letterSpacing: 0.1,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 8.0,
                                ),
                                child: Container(
                                  // decoration: BoxDecoration(border: Border.all()),
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                        // decoration: BoxDecoration(border: Border.all()),
                                        height: 35,
                                        child: Container(
                                          height: 35,
                                          width: 140,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                            border: new Border.all(
                                                color: Color(0xFFD8AF4F),
                                                width: 1.5),
                                            color: Color(0xFFD8AF4F),
                                          ),
                                          child: MaterialButton(
                                            splashColor: Colors.grey,
                                            child: Text(
                                              "CALCULATE",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    ConstanceData.SIZE_TITLE16,
                                              ),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                listOfChartDataWithBoth =
                                                    calculate(false);
                                                listOfChartDataWithoutMonthlyDeposit =
                                                    calculate(true);
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      // Container(
                                      //   // decoration: BoxDecoration(border: Border.all()),
                                      //   height: 35,
                                      //   child: Container(
                                      //     height: 35,
                                      //     width: 120,
                                      //     decoration: BoxDecoration(
                                      //       borderRadius: BorderRadius.all(
                                      //         Radius.circular(20),
                                      //       ),
                                      //       border: new Border.all(
                                      //           color: Color(0xFFD8AF4F),
                                      //           width: 1.5),
                                      //       color: Color(0xFFD8AF4F),
                                      //     ),
                                      //     child: MaterialButton(
                                      //       splashColor: Colors.grey,
                                      //       child: Text(
                                      //         _oneOffDepositController
                                      //                     .text.length ==
                                      //                 0
                                      //             ? "SKIP"
                                      //             : "NEXT",
                                      //         style: TextStyle(
                                      //           color: Colors.white,
                                      //           fontSize:
                                      //               ConstanceData.SIZE_TITLE16,
                                      //         ),
                                      //       ),
                                      //       onPressed: () async {
                                      //         submit();
                                      //       },
                                      //     ),
                                      //   ),
                                      // ),

                                    ],
                                  ),
                                ),
                              ),
                              // AuroPaperPortfolioPerformace(
                              //   portfolioReturnDollar: "0.00",
                              //   percAnnualReturn: "0.00",
                              // ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  calculate(withoutMontlyDeposit) {
    print("calculateeeeee");

    List<NewSalesData> listOfChartData = [];
    if (_monthlyDepositController.text != "" &&
        _monthlyDepositController.text != null &&
        _oneOffDepositController.text != "" &&
        _oneOffDepositController.text != null) {
      if (withoutMontlyDeposit) {
        print("without");
        print(_oneOffDepositController.text);
        print(_monthlyDepositController.text);
        for (int i = 1; i < 5 * 4; i++) {
          listOfChartData.add(
            NewSalesData(
              i / 4,
              _futureReturn.calculate(
                userReturnData != null
                    ? userReturnData["expected_return"]
                    : 0.0,
                i / 4,
                0.0,
                double.parse(_oneOffDepositController.text),
              ),
            ),
          );
        }
      } else {
        print("both");
        print(_monthlyDepositController.text);
        print(_oneOffDepositController.text);
        for (int i = 1; i < 5 * 4; i++) {
          listOfChartData.add(
            NewSalesData(
              i / 4,
              _futureReturn.calculate(
                userReturnData != null
                    ? userReturnData["expected_return"]
                    : 0.0,
                i / 4,
                double.parse(_monthlyDepositController.text),
                double.parse(_oneOffDepositController.text),
              ),
            ),
          );
        }
      }
      print(listOfChartData);
      return listOfChartData;
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(
            "Invalid Deposit!",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            )
          ],
        ),
      );
      return listOfChartData;
    }
  }

  getChartFutureReturnData() {
    List<NewSalesData> listOfChartData = [];
    if (_monthlyDepositController.text != "" &&
        _monthlyDepositController.text != null &&
        _oneOffDepositController.text != "" &&
        _oneOffDepositController.text != null) {
      for (int i = 1; i < 5 * 4; i++) {
        listOfChartData.add(
          NewSalesData(
            i / 4,
            _futureReturn.calculate(
              0.24,
              i / 4,
              1000,
              1000000,
            ),
          ),
        );
      }
    } else {
      for (int i = 1; i < 5 * 4; i++) {
        listOfChartData.add(
          NewSalesData(
            i / 4,
            _futureReturn.calculate(
              0.24,
              i / 4,
              1000,
              1000000,
            ),
          ),
        );
      }
    }

    return listOfChartData;
  }

  getChartFutureReturnDataOnlyInitial() {
    List<NewSalesData> listOfChartData = [];
    if (_monthlyDepositController.text != "" &&
        _monthlyDepositController.text != null &&
        _oneOffDepositController.text != "" &&
        _oneOffDepositController.text != null) {
      for (int i = 1; i < 5 * 4; i++) {
        listOfChartData.add(
          NewSalesData(
            i / 4,
            _futureReturn.calculate(
              0.12,
              i / 4,
              0,
              1000000,
            ),
          ),
        );
      }
    } else {
      for (int i = 1; i < 5 * 4; i++) {
        listOfChartData.add(
          NewSalesData(
            i / 4,
            _futureReturn.calculate(
              0.12,
              i / 4,
              0,
              1000000,
            ),
          ),
        );
      }
    }

    return listOfChartData;
  }

  // Future submit() async {
  //   var dataToSave = {};
  //
  //   dataToSave["One Off Deposit"] =
  //       double.parse(_oneOffDepositController.text.trim());
  //   dataToSave["Monthly Deposit"] =
  //       double.parse(_monthlyDepositController.text.trim());
  //   Provider.of<GoProDataProvider>(context, listen: false)
  //       .setSixthPagePreferences(dataToSave);
  //   Provider.of<GoProDataProvider>(context, listen: false)
  //       .saveDataToSql(context);
  //
  //   // Navigator.of(context).push(
  //   //   new MaterialPageRoute(
  //   //     builder: (BuildContext context) => new OnBoardingSevenMarginApproved(
  //   //       logo: widget.logo,
  //   //       callingFrom: widget.callingFrom,
  //   //     ),
  //   //   ),
  //   // );
  // }
}
