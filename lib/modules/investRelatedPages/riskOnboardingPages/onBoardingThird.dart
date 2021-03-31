import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/investRelatedPages/riskOnboardingPages/onBoardingSix.dart';
import 'package:auroim/provider_abhinav/go_pro_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class OnBoardingThird extends StatefulWidget {
  final String callingFrom;
  final String logo;

  const OnBoardingThird({Key key, @required this.callingFrom, this.logo})
      : super(key: key);

  @override
  _OnBoardingThirdState createState() => _OnBoardingThirdState();
}

class _OnBoardingThirdState extends State<OnBoardingThird> {
  bool _isInProgress = false;
  List teamMemberList = List();
  List<String> teamMemberIds = List();
  List<String> selectionList = List();

  List<String> countryList = <String>[
    "Emerging Markets Excl Asia",
    "Western Europe",
    "Asean",
    "Australia",
    "Canada",
    "China",
    "India",
    "Japan",
    "United States",
  ];

  // List<String> combinedList = [];
  List<String> countrySectorList = [
    "",
    "China-Health Care",
    "China-Communication Services",
    "China-Consumer Discretionary",
    "China-Consumer Staples",
    "China-Energy",
    "China-Financials",
    "China-Industrials",
    "China-Information Technology",
    "China-Materials",
    "China-Real Estate",
    "China-Utilities",
    "India-Communication Services",
    "India-Consumer Discretionary",
    "India-Consumer Staples",
    "India-Energy",
    "India-Financials",
    "India-Health Care",
    "India-Industrials",
    "India-Information Technology",
    "India-Materials",
    "India-Real Estate",
    "Japan-Consumer Discretionary",
    "Japan-Consumer Staples",
    "Japan-Financials",
    "Japan-Health Care",
    "Japan-Industrials",
    "Japan-Information Technology",
    "United States-Communication Services",
    "United States-Consumer Staples",
    "United States-Energy",
    "United States-Health Care",
    "United States-Industrials",
    "United States-Information Technology",
    "United States-Materials",
    "United States-Real Estate",
    "United States-Utilities",
    "Japan-Real Estate",
    "Australia-Consumer Discretionary",
    "Australia-Consumer Staples",
    "Australia-Financials",
    "Australia-Health Care",
    "Australia-Information Technology",
    "Australia-Materials",
    "Western Europe-Consumer Staples",
    "Western Europe-Communication Services",
    "Western Europe-Consumer Discretionary",
    "Western Europe-Energy",
    "Western Europe-Financials",
    "Western Europe-Health Care",
    "Western Europe-Industrials",
    "Western Europe-Information Technology",
    "Western Europe-Real Estate",
    "Western Europe-Utilities",
    "Canada-Consumer Discretionary",
    "Canada-Consumer Staples",
    "Canada-Information Technology",
    "Western Europe-Materials",
    "India-Utilities",
    "Asean-Communication Services",
    "Asean-Consumer Discretionary",
    "Asean-Consumer Staples",
    "Asean-Financials",
    "Emerging Markets Excl Asia-Information Technology",
    "Japan-Communication Services",
    "Japan-Materials",
    "Asean-Energy",
    "Asean-Industrials",
    "Asean-Information Technology",
    "Emerging Markets Excl Asia-Communication Services",
    "Emerging Markets Excl Asia-Financials",
    "Emerging Markets Excl Asia-Materials",
    "Asean-Real Estate",
    "Asean-Materials",
    "Asean-Utilities",
    "United States-Consumer Discretionary",
    "United States-Financials",
    "Australia-Real Estate",
  ];

  List<String> sectorList = [
    "Communication Services",
    "Consumer Discretionary",
    "Consumer Staples",
    "Energy",
    "Financials",
    "Health Care",
    "Industrials",
    "Information Technology",
    "Materials",
    "Real Estate",
    "Utilities",
    "All",
  ];

  List listOfCountriesSelected = [];
  List listOfSectorsSelected = [];
  List listOfCountrySectorSelected = [];

  String selectedCountry = "";
  String selectedSector = "";
  String selectedCountrySector = "";

  @override
  void initState() {
    countrySectorList.sort((a, b) => a.toString().compareTo(b.toString()));
    sectorList.sort((a, b) => a.toString().compareTo(b.toString()));
    // countryList.sort((a, b) => a.toString().compareTo(b.toString()));

    countryList.add("");
    sectorList.add("");
    // countrySectorList.add("");
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

  addCountryPreference() {
    if (selectedCountry != null && selectedCountry != "") {
      print("add counrty");
      listOfCountriesSelected.add("equity-" + selectedCountry.toLowerCase());
      setState(() {
        selectionList.add(selectedCountry);
      });
    } else {
      print("nope counrty");
    }
  }

  addSectorPreference() {
    if (selectedSector != null && selectedSector != "") {
      listOfSectorsSelected.add(selectedSector);
      setState(() {
        selectionList.add(selectedSector);
      });
    }
    // var ss = "[\"China\",\"dd\"]";
  }

  addCountrySectorPreference() {
    if (selectedCountrySector != null && selectedCountrySector != "") {
      listOfCountrySectorSelected
          .add("equity-" + selectedCountrySector.toLowerCase());
      setState(() {
        selectionList.add(selectedCountrySector);
      });
    }
  }

  // void setSelectionArea() {
  //   var val;
  //   var exist = false;
  //
  //   if (selectedCountry != null &&
  //       selectedCountry != "" &&
  //       selectedSector != null &&
  //       selectedSector != "" &&
  //       selectedCountrySector != null &&
  //       selectedCountrySector != "") {
  //     val = "$selectedCountry" +
  //         " - " +
  //         "$selectedSector" +
  //         " - " +
  //         "$selectedCountrySector";
  //   } else if ((selectedCountry != null && selectedCountry != "") &&
  //       (selectedSector == null || selectedSector == "")) {
  //     val = "$selectedCountry";
  //   } else if ((selectedSector != null && selectedSector != "") &&
  //       (selectedCountry == null || selectedCountry == "")) {
  //     val = "$selectedSector";
  //   }
  //
  //   if (selectionList != null && selectionList.length != 0) {
  //     for (var i = 0; i < selectionList.length; i++) {
  //       print("val: $val");
  //       print("selectionList: ${selectionList[i]}");
  //       if (selectionList[i].toLowerCase().contains(val.toLowerCase().trim())) {
  //         setState(() {
  //           exist = true;
  //         });
  //         break;
  //       }
  //     }
  //   }
  //
  //   // check value exist or not
  //   if (exist == false) {
  //     setState(() {
  //       selectionList.add(val.trim());
  //     });
  //   } else {
  //     Toast.show("Already exist", context,
  //         duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  //   }
  // }

  Widget getCountryDropDownList() {
    if (countryList != null && countryList.length != 0) {
      return DropdownButtonHideUnderline(
        child: DropdownButton(
          value: selectedCountry,
          dropdownColor: Colors.white,
          isExpanded: true,
          onChanged: (String newValue) {
            setState(() {
              selectedCountry = newValue;
            });
          },
          items: countryList.map((String value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value,
                  style: AllCoustomTheme.getDropDownMenuItemStyleTheme()),
            );
          }).toList(),
        ),
      );
    } else {
      return Container(
        height: 0.0,
        width: 0.0,
      );
    }
  }

  // dropDownList(selectedValue){
  //   return DropdownButtonHideUnderline(
  //     child: DropdownButton(
  //       value: selectedValue,
  //       dropdownColor: Colors.white,
  //       isExpanded: true,
  //       onChanged: (String newValue) {
  //         setState(() {
  //           selectedSector = newValue;
  //         });
  //       },
  //       items: sectorList.map((String value) {
  //         return new DropdownMenuItem(
  //           value: value,
  //           child: new Text(value,
  //               style: AllCoustomTheme.getDropDownMenuItemStyleTheme()),
  //         );
  //       }).toList(),
  //     ),
  //   );
  // }

  Widget getCombinedDropDownList() {
    if (sectorList != null && sectorList.length != 0) {
      return DropdownButtonHideUnderline(
        child: DropdownButton(
          value: selectedCountrySector,
          dropdownColor: Colors.white,
          isExpanded: true,
          onChanged: (String newValue) {
            setState(() {
              selectedCountrySector = newValue;
            });
          },
          items: countrySectorList.map((String value) {
            return new DropdownMenuItem(
              value: value,
              child: new Text(value,
                  style: AllCoustomTheme.getDropDownMenuItemStyleTheme()),
            );
          }).toList(),
        ),
      );
    } else {
      return Container(
        height: 0.0,
        width: 0.0,
      );
    }
  }

  Widget getSectorDropDownList() {
    if (sectorList != null && sectorList.length != 0) {
      return DropdownButtonHideUnderline(
        child: DropdownButton(
          value: selectedSector,
          dropdownColor: Colors.white,
          isExpanded: true,
          onChanged: (String newValue) {
            setState(() {
              selectedSector = newValue;
            });
          },
          items: sectorList.map((String value) {
            return new DropdownMenuItem(
              value: value,
              child: new Text(value,
                  style: AllCoustomTheme.getDropDownMenuItemStyleTheme()),
            );
          }).toList(),
        ),
      );
    } else {
      return Container(
        height: 0.0,
        width: 0.0,
      );
    }
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
            // backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
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
                    ? Container(
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
                                        begin: Offset(0, 0),
                                        end: Offset(0.2, 0)),
                                    duration: Duration(milliseconds: 500),
                                    cycles: 0,
                                    builder: (anim) => FractionalTranslation(
                                      translation: anim.value,
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color:
                                            AllCoustomTheme.getTextThemeColor(),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.099,
                                  width:
                                      MediaQuery.of(context).size.width * 0.90,
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Center(
                                          child: new Image(
                                            width: 150.0,
                                            fit: BoxFit.fill,
                                            image: new AssetImage(
                                                'assets/logo.png'),
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
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15.0, right: 3.0),
                              child: Text(
                                "Auro allows you to customize your portfolio across your preferences for not only Country (e.g. US) and Sector (e.g. Tech) but also the combination of Country-Sector (e.g. US Tech). You can make multiple selection for all 3 and Auro will take that into account:",
                                style: new TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: "Rosarivo",
                                    letterSpacing: 0.1),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 20.0,
                                      right: 20.0,
                                    ),
                                    child: Text(
                                      'Country',
                                      style: new TextStyle(
                                        color: Colors.black,
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        fontFamily: "Rosarivo",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 40,
                                    margin: EdgeInsets.only(
                                      left: 20.0,
                                      right: 20.0,
                                    ),
                                    decoration: new BoxDecoration(
                                      color: Colors.white54,
                                      // border: Border.all(),
                                    ),
                                    child: getCountryDropDownList(),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              height: 30,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                border: new Border.all(
                                    color: Color(0xFFD8AF4F), width: 1.5),
                                color: Color(0xFFD8AF4F),
                              ),
                              child: MaterialButton(
                                splashColor: Colors.grey,
                                child: Text(
                                  "ADD PREFERENCE",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                  if (selectedCountry == "") {
                                    Toast.show("No value selected", context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (listOfCountriesSelected.contains(
                                      "equity-" +
                                          selectedCountry.toLowerCase())) {
                                    Toast.show("Already Added", context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else {
                                    addCountryPreference();
                                  }
                                },
                              ),
                            ),
                            Divider(),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 20.0, right: 20.0),
                                    child: Text(
                                      'Sector',
                                      style: new TextStyle(
                                        color: Colors.black,
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        fontFamily: "Rosarivo",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 20.0,
                                      right: 20.0,
                                    ),
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white54,
                                      // border: Border.all(),
                                    ),
                                    child: getSectorDropDownList(),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              height: 30,
                              width: 200,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  border: new Border.all(
                                      color: Color(0xFFD8AF4F), width: 1.5),
                                  color: Color(0xFFD8AF4F)),
                              child: MaterialButton(
                                splashColor: Colors.grey,
                                child: Text(
                                  "ADD PREFERENCE",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () async {
                                  if (selectedSector == "") {
                                    Toast.show("No value selected", context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (listOfSectorsSelected
                                      .contains(selectedSector)) {
                                    Toast.show("Already Added", context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else {
                                    addSectorPreference();
                                  }
                                },
                              ),
                            ),
                            Divider(),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 20.0,
                                      right: 20.0,
                                    ),
                                    child: Text(
                                      'Country_Sector',
                                      style: new TextStyle(
                                        color: Colors.black,
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        fontFamily: "Rosarivo",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 20.0,
                                      right: 20.0,
                                    ),
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white54,
                                      // border: Border.all(),
                                    ),
                                    child: getCombinedDropDownList(),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              height: 30,
                              width: 200,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  border: new Border.all(
                                      color: Color(0xFFD8AF4F), width: 1.5),
                                  color: Color(0xFFD8AF4F)),
                              child: MaterialButton(
                                splashColor: Colors.grey,
                                child: Text(
                                  "ADD PREFERENCE",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () async {
                                  if (selectedCountrySector == "") {
                                    Toast.show("No value selected", context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else if (listOfCountrySectorSelected
                                      .contains("equity-" +
                                          selectedCountrySector
                                              .toLowerCase())) {
                                    Toast.show("Already Added", context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  } else {
                                    addCountrySectorPreference();
                                  }
                                },
                              ),
                            ),
                            Divider(),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      'Selections',
                                      style: new TextStyle(
                                        // color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFF000000),
                                        color: Colors.black,
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        fontFamily: "Rosarivo",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 0.0,
                                      left: 15.0,
                                      right: 15,
                                    ),
                                    child: StaggeredGridView.countBuilder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: selectionList != null
                                          ? selectionList.length
                                          : 0,
                                      physics: NeverScrollableScrollPhysics(),
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 8.0,
                                      mainAxisSpacing: 8.0,
                                      shrinkWrap: true,
                                      staggeredTileBuilder: (int index) =>
                                          StaggeredTile.fit(1),
                                      itemBuilder: (context, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            border: Border.all(
                                                color: Colors.grey, width: 1.0),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 8.0),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  '${selectionList[index]}',
                                                  style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getTextThemeColor(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE12,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      height: 1.3),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    selectionList
                                                        .removeAt(index);
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.close,
                                                  color: Colors.black,
                                                  size: 15.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 10.0,
                                right: 10,
                              ),
                              child: Container(
                                // decoration: BoxDecoration(
                                //   border: Border.all(),
                                // ),
                                width: MediaQuery.of(context).size.width - 30,
                                child: Text(
                                  "Don't worry if this question sounds like greek or latin to you. You can skip this question and change it later in settings whenever you want!!",
                                  style: new TextStyle(
                                      // color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFFCD853F),
                                      color: Colors.black,
                                      fontSize: ConstanceData.SIZE_TITLE16,
                                      fontFamily: "RobotoLight",
                                      letterSpacing: 0.1),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 20,
                                ),
                                SizedBox(
                                  height: 35,
                                  child: Container(
                                    height: 35,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      border: new Border.all(
                                          color: Color(0xFFD8AF4F), width: 1.5),
                                      color: Color(0xFFD8AF4F),
                                    ),
                                    child: MaterialButton(
                                      splashColor: Colors.grey,
                                      child: Text(
                                        selectionList.length == 0
                                            ? "SKIP"
                                            : "NEXT",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ConstanceData.SIZE_TITLE16,
                                        ),
                                      ),
                                      onPressed: () async {
                                        submit();
                                        // selectionList.length == 0
                                        //     ? Toast.show(
                                        //         "Please select atleast one",
                                        //         context,
                                        //         duration: Toast.LENGTH_LONG,
                                        //         gravity: Toast.BOTTOM)
                                        //     : submit();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : SizedBox(),
              ),
            ),
          ),
        )
      ],
    );
  }

  Future submit() async {
    Map<String, Map> dataToSave = {
      "assetclass_country_weights": {},
      "sector_weights": {},
      "assetclass_country_sector_weights": {},
    };

    dataToSave["assetclass_country_weights"] = {
      "$listOfCountriesSelected": {
        "min_weight": 0,
        "max_weight": 100,
      },
    };
    dataToSave["sector_weights"] = {
      "$listOfSectorsSelected": {
        "min_weight": 0,
        "max_weight": 100,
      },
    };
    dataToSave["assetclass_country_sector_weights"] = {
      "$listOfCountrySectorSelected": {
        "min_weight": 0,
        "max_weight": 100,
      },
    };

    ///run_algo?volatility=0.15&drawdown=0.20&client_id=aa_default

    Provider.of<GoProDataProvider>(context, listen: false)
        .setThirdPagePreferences(dataToSave);

    var oneOffDeposit = 100000;
    var monthlyDeposit = 0;
    Provider.of<GoProDataProvider>(context, listen: false)
        .setSixthPagePreferences({
      "One Off Deposit" : oneOffDeposit,
      "Monthly Deposit" : monthlyDeposit,
    });
    Provider.of<GoProDataProvider>(context, listen: false)
        .saveDataToSql(context);
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (BuildContext context) => OnBoardingSix(
    //       logo: widget.logo,
    //       callingFrom: widget.callingFrom,
    //     ),
    //   ),
    // );
  }
}
