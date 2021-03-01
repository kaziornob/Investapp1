import 'dart:convert';

import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/widgets/private_deals_marketplace/all_companies_single_item.dart';
import 'package:auroim/widgets/private_deals_marketplace/sample_featured_companies_list.dart';
import 'package:auroim/widgets/tab_chip.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class AllCompanies extends StatefulWidget {
  @override
  _AllCompaniesState createState() => _AllCompaniesState();
}

class _AllCompaniesState extends State<AllCompanies> {
  //
  // List<Widget> allTabs = [
  //
  // ];

  Map<String, bool> allTabsBool = {
    "trending": true,
    "live": false,
    "all": false,
    "icon": false,
  };

  TextEditingController _filterByIndustryController = TextEditingController();
  String filter = "trending";

  final FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();

  Map<String, Map<String, bool>> allFilterValues = {
    "Valuation": {
      "<100M": false,
      "100-500M": false,
      "500-1000M": false,
      ">1000M": false,
    },
    "Funding": {
      "<50M": false,
      "50-100M": false,
      "100-200M": false,
      ">200M": false,
    },
    "Employees": {
      "0-10": false,
      "11-100": false,
      "101-250": false,
      ">250": false,
    },
    "Age(years)": {
      "<5": false,
      "5-10": false,
      "10-15": false,
      ">15": false,
    },
  };

  Map<String, String> allOptionsForApi = {
    "Valuation": "valuation",
    "Funding": "funding",
    "Employees": "employees",
    "Age(years)": "age",
    "industry": "industry_list",
  };

  Map<String, String> allTagsForApi = {
    "0-10": "a",
    "11-100": "b",
    "101-250": "c",
    ">250": "d",
    "<5": "a",
    "5-10": "b",
    "10-15": "c",
    ">15": "d",
    "<50M": "a",
    "50-100M": "b",
    "100-200M": "c",
    ">200M": "d",
    "<100M": "a",
    "100-500M": "b",
    "500-1000M": "c",
    ">1000M": "d",
  };

  bool onTapFilters = false;
  String filterCompaniesString = "";

  @override
  void initState() {
    // _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // _tabController.dispose();
    _filterByIndustryController.dispose();
    super.dispose();
  }

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
                          TabChip(
                            child: Text(
                              "All",
                              style: TextStyle(
                                color: allTabsBool["all"] == true
                                    ? Colors.white
                                    : Colors.black,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: allTabsBool["all"] == true
                                ? Color(0xff7499C6)
                                : Colors.white,
                            callback: () => selectedTab("all", setWidgetState),
                          ),
                          TabChip(
                            child: Icon(
                              Icons.filter_alt_sharp,
                              color: allTabsBool["icon"] == true
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            backgroundColor: allTabsBool["icon"] == true
                                ? Color(0xff7499C6)
                                : Colors.white,
                            callback: () => selectedTab("icon", setWidgetState),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: FutureBuilder(
                    future: onTapFilters
                        ? _featuredCompaniesProvider
                            .getCompaniesByFilters(filterCompaniesString)
                        : getData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List allWidgets = [];
                        allWidgets = [...snapshot.data];
                        // allWidgets = allWidgets.reversed.toList();
                        if (allTabsBool["icon"] == true) {
                          allWidgets.insert(0, filterBox());
                        }
                        print("length of snapshot : ${allWidgets.length}");
                        return Container(
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width - 40,
                          child: ListView.builder(
                            itemCount: allWidgets.length,
                            itemBuilder: (context, index) {
                              if (allTabsBool["icon"] == true && index == 0) {
                                return filterBox();
                              } else {
                                return AllCompaniesSingleItem(
                                  companyDetails: allWidgets[index],
                                );
                              }
                            },
                          ),
                        );
                      } else {
                        return filterBox();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  filterBox() {
    return Container(
      height: 270,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Color(0xff5A56B9),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Company Filters",
              style: TextStyle(
                  color: AllCoustomTheme.getNewSecondTextThemeColor()),
            ),
          ),
          StatefulBuilder(builder: (context, setFilterOptionsState) {
            return Container(
              width: MediaQuery.of(context).size.width - 50,
              height: 120,
              // decoration: BoxDecoration(border: Border.all()),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  fundingFilters(
                    "Valuation",
                    "<100M",
                    "100-500M",
                    "500-1000M",
                    ">1000M",
                    setFilterOptionsState,
                  ),
                  fundingFilters(
                    "Funding",
                    "<50M",
                    "50-100M",
                    "100-200M",
                    ">200M",
                    setFilterOptionsState,
                  ),
                  fundingFilters(
                    "Employees",
                    "0-10",
                    "11-100",
                    "101-250",
                    ">250",
                    setFilterOptionsState,
                  ),
                  fundingFilters(
                    "Age(years)",
                    "<5",
                    "5-10",
                    "10-15",
                    ">15",
                    setFilterOptionsState,
                  ),
                ],
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width - 50,
              child: TextField(
                controller: _filterByIndustryController,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Color(0xff5A56B9),
                  fontSize: 17,
                ),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    borderSide: BorderSide(
                      color: Color(0xff5A56B9),
                      width: 1,
                    ),
                  ),
                  hintText: "Search Industry",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Color(0xff5A56B9),
                    fontSize: 17,
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: Color(0xff5A56B9),
                  ),
                  // prefix: Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 8.0, right: 8.0, bottom: 8.0, top: 8.0),
                  //   child: ,
                  // ),
                  contentPadding: EdgeInsets.all(16.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    borderSide: BorderSide(
                      color: Color(0xff5A56B9),
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 40,
            width: 120,
            child: RaisedButton(
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Color(0xff7499C6),
                  )),
              onPressed: () {
                filterCompaniesString = "";

                allFilterValues.forEach((key, value) {
                  String option = "";
                  allFilterValues[key].forEach((key2, value2) {
                    if (allFilterValues[key][key2] == true) {
                      option = option + allTagsForApi[key2];
                    }
                  });
                  filterCompaniesString = filterCompaniesString +
                      "&" +
                      allOptionsForApi[key] +
                      "=" +
                      option;
                });
                filterCompaniesString = filterCompaniesString.substring(1);
                print(filterCompaniesString);
                setState(() {});
              },
              color: Color(0xff7499C6),
              child: Text(
                "Filter",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto",
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getData() async {
    print("in get data");
    var tempJsonReq = {};

    String jsonReq = jsonEncode(tempJsonReq);

    var jsonReqResp = await _featuredCompaniesProvider.companyDetails(
        'company_details/pvtMain?list_type=$filter', jsonReq);

    var result = jsonDecode(jsonReqResp.body);
    // print("company details response: $result");

    if (jsonReqResp.statusCode == 200 || jsonReqResp.statusCode == 201) {
      // print("ggggg");
      // print(result["message"].length);
      return result["message"];
      // return getCompaniesList(result["message"]);

      // if (result != null &&
      //     result.containsKey('auth') &&
      //     result['auth'] == true) {
      //   Toast.show("${result['message']}", context,
      //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      // }
    } else if (result != null &&
        result.containsKey('auth') &&
        result['auth'] != true) {
    } else {
      Toast.show("Something went wrong!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  selectedTab(selectedKey, setWidgetState) {
    // print(selectedKey);
    setWidgetState(() {
      allTabsBool.forEach((key, value) {
        if (selectedKey == key) {
          allTabsBool[key] = true;

          if (key == "icon") {
            // filter = "all";
            onTapFilters = true;
          } else {
            onTapFilters = false;
            filter = key;
          }
        } else {
          allTabsBool[key] = false;
        }
      });
    });
    //   allTabsBool.forEach((value) {
    //     if (i == index) {
    //       allTabsBool[index] = true;
    //       i++;
    //     } else {
    //       allTabsBool[i] = false;
    //       i++;
    //     }
    //   });
    // });
  }

  fundingFilters(
      filterType, filter1, filter2, filter3, filter4, setFilterOptionsState) {
    return Container(
      // decoration: BoxDecoration(border: Border.all()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              filterType,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 20,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: SizedBox(
                    height: 10,
                    width: 10,
                    child: Checkbox(
                      activeColor: Color(0xff5A56B9),
                      value: allFilterValues[filterType][filter1],
                      onChanged: (value) {
                        setFilterOptionsState(() {
                          allFilterValues[filterType][filter1] = value;
                        });
                      },
                    ),
                  ),
                ),
                Text(
                  filter1,
                  style: TextStyle(
                    color: AllCoustomTheme.getNewSecondTextThemeColor(),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 20,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: SizedBox(
                    height: 10,
                    width: 10,
                    child: Checkbox(
                      activeColor: Color(0xff5A56B9),
                      value: allFilterValues[filterType][filter2],
                      onChanged: (value) {
                        setFilterOptionsState(() {
                          allFilterValues[filterType][filter2] = value;
                        });
                      },
                    ),
                  ),
                ),
                Text(
                  filter2,
                  style: TextStyle(
                    color: AllCoustomTheme.getNewSecondTextThemeColor(),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 20,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: SizedBox(
                    height: 10,
                    width: 10,
                    child: Checkbox(
                      value: allFilterValues[filterType][filter3],
                      activeColor: Color(0xff5A56B9),
                      onChanged: (value) {
                        setFilterOptionsState(() {
                          allFilterValues[filterType][filter3] = value;
                        });
                      },
                    ),
                  ),
                ),
                Text(
                  filter3,
                  style: TextStyle(
                    color: AllCoustomTheme.getNewSecondTextThemeColor(),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 20,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: SizedBox(
                    child: Checkbox(
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                      value: allFilterValues[filterType][filter4],
                      activeColor: Color(0xff5A56B9),
                      onChanged: (value) {
                        // print(value);
                        setFilterOptionsState(() {
                          allFilterValues[filterType][filter4] = value;
                        });
                      },
                    ),
                    height: 10,
                    width: 10,
                  ),
                ),
                Text(
                  filter4,
                  style: TextStyle(
                    color: AllCoustomTheme.getNewSecondTextThemeColor(),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
