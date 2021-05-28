
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/provider_abhinav/go_pro_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    "Japan",
    "United States",
  ];

  var countrySectorList = [
    "",
    "China-Communication Services",
    "China-Energy",
    "China-Health Care",
    "China-Industrials",
    "China-Information Technology",
    "China-Materials",
    "China-Consumer Discretionary",
    "China-Real Estate",
    "China-Consumer Staples",
    "China-Utilities",
    "China-Financials",
    "United States-Health Care",
    "United States-Real Estate",
    "United States-Financials",
    "Japan-Consumer Discretionary",
    "Japan-Consumer Staples",
    "Japan-Financials",
    "Japan-Health Care",
    "Japan-Industrials",
    "Japan-Information Technology",
    "Japan-Utilities",
    "United States-Information Technology",
    "United States-Materials",
    "United States-Communication Services",
    "United States-Energy",
    "United States-Industrials",
    "United States-Consumer Staples",
    "United States-Utilities",
    "Asean-Industrials",
    "Asean-Financials",
    "Asean-Consumer Discretionary",
    "Asean-Real Estate",
    "Asean-Consumer Staples",
    "Asean-Communication Services",
    "Asean-Information Technology",
    "Asean-energy",
    "Australia-Materials",
    "Australia-Consumer Staples",
    "Australia-Consumer Discretionary",
    "Australia-Financials",
    "Australia-Information Technology",
    "Australia-Health Care",
    "Canada-Consumer Staples",
    "Canada-Consumer Discretionary",
    "Canada-Information Technology",
    "Emerging Markets Excl Asia-Information Technology",
    "Emerging Markets Excl Asia-Materials",
    "Emerging Markets Excl Asia-Financials",
    "Emerging Markets Excl Asia-Communication Services",
    "Japan-Real Estate",
    "Western Europe-Consumer Discretionary",
    "Western Europe-Financials",
    "Western Europe-Information Technology",
    "Western Europe-Consumer Staples",
    "Western Europe-Industrials",
    "Western Europe-Materials",
    "Western Europe-Health Care",
    "Western Europe-Energy",
    "Western Europe-Communication Services",
    "Western Europe-Utilities",
    "Western Europe-Real Estate",
    "United States-Consumer Discretionary",
    "Japan-Communication Services",
    "Japan-Materials",
    "Japan-Energy",
    "Australia-Utilities",
    "Australia-Industrials",
    "Australia-Real Estate",
    "Merging Markets Excl Asia-Consumer Discretionary",
    "Australia-Energy",
    "Australia-Communication Services"
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

  Widget getCountryDropDownList() {
    if (countryList != null && countryList.length != 0) {
      return DropdownButton(
        // value: selectedCountry,
        hint: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            'ADD PREFRENCE',
            style: TextStyle(color: Color(0xffD8AF4F), fontSize: 14),
          ),
        ),
        dropdownColor: Colors.white,
        isExpanded: true,
        onChanged: (String newValue) {
          setState(() {
            selectedCountry = newValue;
            if (selectedCountry == "") {
              Toast.show("No value selected", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            } else if (listOfCountriesSelected.contains("equity-" + selectedCountry.toLowerCase())) {
              Toast.show("Already Added", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            } else {
              addCountryPreference();
            }
          });
        },
        items: countryList.map((String value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value, style: AllCoustomTheme.getDropDownMenuItemStyleTheme()),
          );
        }).toList(),
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
      return DropdownButton(
        hint: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            'ADD PREFRENCE',
            style: TextStyle(color: Color(0xffD8AF4F), fontSize: 14),
          ),
        ),
        dropdownColor: Colors.white,
        isExpanded: true,
        onChanged: (String newValue) {
          setState(() {
            selectedCountrySector = newValue;
            if (selectedCountrySector == "") {
              Toast.show("No value selected", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            } else if (listOfCountrySectorSelected.contains("equity-" + selectedCountrySector.toLowerCase())) {
              Toast.show("Already Added", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            } else {
              addCountrySectorPreference();
            }
          });
        },
        items: countrySectorList.map((String value) {
          return new DropdownMenuItem(
            value: value,
            child: new Text(value, style: AllCoustomTheme.getDropDownMenuItemStyleTheme()),
          );
        }).toList(),
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
      return DropdownButton(
        // value: selectedSector,
        hint: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            'ADD PREFRENCE',
            style: TextStyle(color: Color(0xffD8AF4F), fontSize: 14),
          ),
        ),
        dropdownColor: Colors.white,
        isExpanded: true,
        onChanged: (String newValue) {
          setState(() {
            selectedSector = newValue;
            if (selectedSector == "") {
              Toast.show("No value selected", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            } else if (listOfSectorsSelected.contains(selectedSector)) {
              Toast.show("Already Added", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            } else {
              addSectorPreference();
            }
          });
        },
        items: sectorList.map((String value) {
          return new DropdownMenuItem(
            value: value,
            child: new Text(value, style: AllCoustomTheme.getDropDownMenuItemStyleTheme()),
          );
        }).toList(),
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
    // AppBar appBar = AppBar();
    // double appBarheight = appBar.preferredSize.height;
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
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(left: 10.0),
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: AllCoustomTheme
                                          .getTextThemeColor(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15.0, right: 15.0),
                              child: Text(
                                "Auro allows you to customize your portfolio across not only Country (e.g. US), Sector (e.g. Tech), but also combination of Country-Sector (e.g. China Healthcare). \n\nYou can select multiple preferences for each by clicking on Add Preference:",
                                style: new TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: "Rosarivo",
                                  letterSpacing: 0.1,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            SizedBox(
                              height: 15,
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
                                                color: Color(0xffD8AF4F),
                                                width: 1.0),
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
                                  "If you’re not quite sure, you can skip this and change it later.",
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
                              height: 20.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    submit();
                                  },
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Color(0xFFD8AF4F),
                                    child: Icon(
                                      Icons.arrow_forward_sharp,
                                      color: Colors.white,
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

    var oneOffDeposit = 1000000;
    var monthlyDeposit = 0;
    Provider.of<GoProDataProvider>(context, listen: false)
        .setSixthPagePreferences({
      "One Off Deposit": oneOffDeposit,
      "Monthly Deposit": monthlyDeposit,
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
