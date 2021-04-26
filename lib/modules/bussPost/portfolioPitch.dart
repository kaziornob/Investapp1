import 'dart:convert';

import 'package:animator/animator.dart';
import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/provider_abhinav/portfolio_pitch_provider.dart';
import 'package:auroim/provider_abhinav/user_details.dart';
import 'package:auroim/widgets/stock_and_portfolio_pitch/search_security.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class SecurityOption {
  final String id;
  String textSecurity;
  double weight;

  SecurityOption(this.id, this.textSecurity, this.weight);
}

class PortfolioPitch extends StatefulWidget {
  @override
  _PortfolioPitchState createState() => _PortfolioPitchState();
}

class _PortfolioPitchState extends State<PortfolioPitch> {
  double stockHeight = 0.0;
  bool _isInProgress = false;
  List tagList = List();
  bool tagListVisible = false;
  List<TagData> itemList = List();
  List<TextEditingController> listOfWeightControllers = [];
  List<TextEditingController> listOfSecuritiesControllers = [];
  List<String> listOfSecuritiesTickers = [];
  TextEditingController _searchTopicTagsController = TextEditingController();
  TextEditingController _targetReturnPercController = TextEditingController();
  TextEditingController _targetMaxDrawdownController = TextEditingController();
  TextEditingController _portfolioStrategyController = TextEditingController();
  TextEditingController _initialAmountInvestedController =
      TextEditingController(text: '1,000,000');
  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();
  List<String> targetMaxList = <String>['Long', 'Short'];

  List<SecurityOption> securityList = [];
  int _optionIndex = 1;

  String selectedLongShort;

  @override
  void initState() {
    super.initState();
    loadUserDetails();
    getTagList();
  }

  loadUserDetails() async {
    setState(() {
      _isInProgress = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      _isInProgress = false;
    });
  }

  Future<List> searchItems(query) async {
    List resultList = List();
    for (var i = 0; i < tagList.length; i++) {
      if (tagList[i]['tag'].toString().toLowerCase().contains(query)) {
        resultList.add(tagList[i]);
      }
    }

    return resultList;
  }

  Future getTagList() async {
    var resp = [
      {"tage": "Math", "_id": "1"},
      {"tage": "Science", "_id": "2"},
      {"tage": "Physics", "_id": "3"}
    ];

    setState(() {
      tagList = resp;
    });

    return resp;
  }

  void takeSecurityNumber(String text, String from, String itemId) {
    try {
      if (securityList != null && securityList.length != 0) {
        for (SecurityOption optObj in securityList) {
          if (optObj.id == itemId) {
            if (from == "security")
              optObj.textSecurity = text;
            else if (from == "weight") optObj.weight = double.parse(text);
          }
        }
      }
    } on FormatException {}
  }

  @override
  void dispose() {
    _searchTopicTagsController.dispose();
    _portfolioStrategyController.dispose();
    _targetMaxDrawdownController.dispose();
    _targetReturnPercController.dispose();
    listOfWeightControllers.forEach((element) {
      element.dispose();
    });
    listOfSecuritiesControllers.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();
    double appBarheight = appBar.preferredSize.height;
    return Stack(
      children: <Widget>[
        Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                HexColor(globals.primaryColorString).withOpacity(0.6),
                HexColor(globals.primaryColorString).withOpacity(0.6),
                HexColor(globals.primaryColorString).withOpacity(0.6),
                HexColor(globals.primaryColorString).withOpacity(0.6),
              ],
            ),
          ),
        ),
        SafeArea(
            bottom: true,
            child: Scaffold(
              backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
              body: ModalProgressHUD(
                inAsyncCall: _isInProgress,
                opacity: 0,
                progressIndicator: CupertinoActivityIndicator(
                  radius: 12,
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 16),
                    child: !_isInProgress
                        ? Column(
                            children: <Widget>[
                              SizedBox(
                                height: 10,
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
                                          color: AllCoustomTheme
                                              .getTextThemeColors(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Animator(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.decelerate,
                                      cycles: 1,
                                      builder: (anim) => Transform.scale(
                                        scale: anim.value,
                                        child: Text(
                                          'Portfolio Pitch',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: AllCoustomTheme
                                                .getTextThemeColors(),
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                ConstanceData.SIZE_TITLE20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Container(
                                // decoration: BoxDecoration(
                                //   border: Border.all(
                                //     color: Colors.white,
                                //   ),
                                // ),
                                height:
                                    MediaQuery.of(context).size.height * 0.20,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            // decoration: BoxDecoration(
                                            //   border: Border.all(
                                            //     color: Colors.white,
                                            //   ),
                                            // ),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.40,
                                            child: Center(
                                              child: Text(
                                                "Target return (%)",
                                                style: new TextStyle(
                                                    fontFamily:
                                                        "WorkSansSemiBold",
                                                    color: AllCoustomTheme
                                                        .getTextThemeColors(),
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.1),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.44,
                                            decoration: new BoxDecoration(
                                              color: AllCoustomTheme.boxColor(),
                                            ),
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller:
                                                  _targetReturnPercController,
                                              style: TextStyle(
                                                color: AllCoustomTheme
                                                    .getTextThemeColors(),
                                                fontSize:
                                                    ConstanceData.SIZE_TITLE14,
                                              ),
                                              // initialValue: "",
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.40,
                                            child: Center(
                                              child: Text(
                                                "Target Max Drawdown : ",
                                                style: new TextStyle(
                                                    fontFamily:
                                                        "WorkSansSemiBold",
                                                    color: AllCoustomTheme
                                                        .getTextThemeColors(),
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.1),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.44,
                                            decoration: new BoxDecoration(
                                              color: AllCoustomTheme.boxColor(),
                                            ),
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller:
                                                  _targetMaxDrawdownController,
                                              style: TextStyle(
                                                color: AllCoustomTheme
                                                    .getTextThemeColors(),
                                                fontSize:
                                                    ConstanceData.SIZE_TITLE14,
                                              ),
                                              // initialValue: "",
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.40,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AllCoustomTheme.boxColor(),
                                            ),
                                            padding: EdgeInsets.only(left: 10),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.44,
                                            child: FormField(
                                              builder: (FormFieldState state) {
                                                return InputDecorator(
                                                  decoration: InputDecoration(
                                                    labelStyle: TextStyle(
                                                        fontSize: ConstanceData
                                                            .SIZE_TITLE14,
                                                        color: AllCoustomTheme
                                                            .getTextThemeColors()),
                                                    errorText: state.hasError
                                                        ? state.errorText
                                                        : null,
                                                  ),
                                                  isEmpty:
                                                      selectedLongShort == '',
                                                  child:
                                                      new DropdownButtonHideUnderline(
                                                    child: new DropdownButton(
                                                      value: selectedLongShort,
                                                      dropdownColor:
                                                          AllCoustomTheme
                                                                  .getThemeData()
                                                              .primaryColor,
                                                      isExpanded: true,
                                                      onChanged:
                                                          (String newValue) {
                                                        setState(
                                                          () {
                                                            selectedLongShort =
                                                                newValue;
                                                          },
                                                        );
                                                      },
                                                      items: targetMaxList
                                                          .map((String value) {
                                                        return new DropdownMenuItem(
                                                          value: value,
                                                          child: new Text(
                                                            value,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize:
                                                                  ConstanceData
                                                                      .SIZE_TITLE14,
                                                            ),
                                                          ),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                );
                                              },
                                              validator: (val) {
                                                return ((val != null &&
                                                            val != '') ||
                                                        (selectedLongShort !=
                                                                null &&
                                                            selectedLongShort !=
                                                                ''))
                                                    ? null
                                                    : 'Please select field';
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 120,
                                child: TextField(
                                  controller: _portfolioStrategyController,
                                  maxLines: 10,
                                  decoration: InputDecoration(
                                    labelText: 'Portfolio strategy',
                                    hintText:
                                        'Example: Focus mostly on US indices, tech and pharma. '
                                        'Trades will be based on technical analysis using machine learning to understand patterns and trends in the markets. '
                                        'Keep a diverse portfolio to spread risk.',
                                    hintStyle: TextStyle(
                                      fontSize: ConstanceData.SIZE_TITLE14,
                                      color:
                                          AllCoustomTheme.getTextThemeColors(),
                                    ),
                                    labelStyle: TextStyle(
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        color: AllCoustomTheme
                                            .getTextThemeColors()),
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 1.0),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 1.0),
                                    ),
                                  ),
                                  style: TextStyle(
                                    color: AllCoustomTheme.getTextThemeColors(),
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              //search Tags
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Search Topic Tags',
                                    style: TextStyle(
                                      color:
                                          AllCoustomTheme.getTextThemeColors(),
                                      fontSize: ConstanceData.SIZE_TITLE14,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 8.0),
                                    child: TypeAheadFormField(
                                      textFieldConfiguration:
                                          TextFieldConfiguration(
                                        controller: _searchTopicTagsController,
                                        textInputAction: TextInputAction.done,
                                        textAlign: TextAlign.start,
                                        keyboardType: TextInputType.text,
                                        maxLines: 1,
                                        style: TextStyle(fontSize: 16.0),
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(30)
                                        ],
                                        decoration: InputDecoration(
                                          hintText: 'Search Topic Tags',
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1.0,
                                                  color: AllCoustomTheme
                                                      .getTextThemeColors()),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(0.0))),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 1.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1.0),
                                          ),
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ),
                                      suggestionsCallback: (pattern) async {
                                        print("pattern : $pattern");
                                        return await _featuredCompaniesProvider
                                            .searchPublicCompanyList(pattern);
                                      },
                                      itemBuilder: (context, suggestion) {
                                        return ListTile(
                                          title: Text(
                                            suggestion["company_name"],
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        );
                                      },
                                      transitionBuilder: (context,
                                          suggestionsBox, controller) {
                                        return suggestionsBox;
                                      },
                                      onSuggestionSelected: (suggestion) {
                                        print(
                                            "suggestion: ${suggestion['ticker']}");
                                        print(
                                            "suggestion name: ${suggestion['company_name']}");

                                        _searchTopicTagsController.text = '';
                                        setState(
                                          () {
                                            itemList.add(
                                              TagData(suggestion['ticker'],
                                                  suggestion['company_name']),
                                            );
                                            tagListVisible =
                                                itemList.length == 0
                                                    ? false
                                                    : true;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              /////////////Topic Tag list////////
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Visibility(
                                      visible: tagListVisible,
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 20.0),
                                        child: Text(
                                          'Topic Tags',
                                          style: TextStyle(
                                            color: AllCoustomTheme
                                                .getTextThemeColors(),
                                            fontSize:
                                                ConstanceData.SIZE_TITLE16,
                                          ),
                                        ),
                                      )),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 8.0,
                                        bottom: tagListVisible ? 24.0 : 0.0),
                                    child: StaggeredGridView.countBuilder(
                                      itemCount: itemList != null
                                          ? itemList.length
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
                                                    color: Colors.grey,
                                                    width: 1.0)),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                                vertical: 8.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(
                                                    '${itemList[index].tag}',
                                                    style: TextStyle(
                                                        color: AllCoustomTheme
                                                            .getTextThemeColors(),
                                                        fontSize: ConstanceData
                                                            .SIZE_TITLE16,
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
                                                        itemList
                                                            .removeAt(index);
                                                        tagListVisible =
                                                            itemList.length == 0
                                                                ? false
                                                                : true;
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.close,
                                                      color: AllCoustomTheme
                                                          .getTextThemeColors(),
                                                      size: 15.0,
                                                    ))
                                              ],
                                            ));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: securityList.length != 0
                                    ? stockHeight
                                    : 0.0,
                                child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: securityList.length,
                                    itemBuilder: (context, index) {
                                      if (securityList.isEmpty) {
                                        return Row();
                                      } else {
                                        return Dismissible(
                                          key: Key(securityList[index]
                                              .id
                                              .toString()),
                                          direction:
                                              DismissDirection.startToEnd,
                                          child: Stack(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 5.0, bottom: 9.0),
                                                child: Container(
                                                  height: 60,
                                                  child: addSecurityRow(index),
                                                ),
                                              ),
                                              Positioned(
                                                top: 0,
                                                right: 0,
                                                child: GestureDetector(
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.delete,
                                                      size: 20.0,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    _showConfirmation(
                                                        'option', index);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    }),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 40),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.09,
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      decoration: BoxDecoration(
                                        color: AllCoustomTheme.getThemeData()
                                            .textSelectionColor,
                                        border: new Border.all(
                                            color: Colors.white, width: 1.5),
                                      ),
                                      child: MaterialButton(
                                        splashColor: Colors.grey,
                                        child: Text(
                                          "Add Security",
                                          style: TextStyle(
                                            color: AllCoustomTheme
                                                .getTextThemeColors(),
                                            fontSize:
                                                ConstanceData.SIZE_TITLE16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        onPressed: () {
                                          print("tapped add security");
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) =>
                                                SearchSecurity(
                                              callBack: searchSecurityCallback,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.11,
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: TextFormField(
                                        controller:
                                            _initialAmountInvestedController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: AllCoustomTheme
                                                      .getsecoundTextThemeColor(),
                                                  width: 12.0)),
                                          fillColor: Colors.white,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white,
                                                width: 1.0),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          prefix: Text(
                                            "\$",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1.0),
                                          ),
                                        ),
                                        style: TextStyle(
                                          color: AllCoustomTheme
                                              .getTextThemeColors(),
                                          fontSize: ConstanceData.SIZE_TITLE16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 20, left: 14, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 50,
                                      child: Animator(
                                        tween:
                                            Tween<double>(begin: 0.8, end: 1.1),
                                        curve: Curves.easeInToLinear,
                                        cycles: 0,
                                        builder: (anim) => Transform.scale(
                                          scale: anim.value,
                                          child: Container(
                                            height: 50,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              border: new Border.all(
                                                  color: Colors.white,
                                                  width: 1.5),
                                              gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  globals.buttoncolor1,
                                                  globals.buttoncolor2,
                                                ],
                                              ),
                                            ),
                                            child: MaterialButton(
                                              splashColor: Colors.grey,
                                              child: Text(
                                                "Done",
                                                style: TextStyle(
                                                  color: AllCoustomTheme
                                                      .getTextThemeColors(),
                                                  fontSize: ConstanceData
                                                      .SIZE_TITLE18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              onPressed: () async {
                                                submitPortfolio();
                                                // Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        : SizedBox(),
                  ),
                ),
              ),
            ))
      ],
    );
  }

  submitPortfolio() async {
    try {
      if (_targetMaxDrawdownController.text.isNotEmpty &&
          _targetMaxDrawdownController.text.isNotEmpty) {
        double sumOfWeights = 0;
        listOfWeightControllers.forEach((element) {
          sumOfWeights = sumOfWeights + double.parse(element.text);
        });
        print(sumOfWeights);
        if (sumOfWeights == 100.0) {
          List allTags = [];
          itemList.forEach((element) {
            allTags.add(element.tag);
          });
          int i = 0;
          print(_initialAmountInvestedController.text);
          var body = {
            "email": Provider.of<UserDetails>(context, listen: false)
                .userDetails["email"],
            "stock_name": "Listed",
            "isLong": selectedLongShort == "Short" ? 0 : 1,
            "target_return_perc":
                double.parse(_targetReturnPercController.text),
            "target_max_drawdown":
                double.parse(_targetMaxDrawdownController.text),
            "portfolio_strategy": _portfolioStrategyController.text,
            "topic_tags": jsonEncode(allTags),
            "portfolio_securities_data":
                jsonEncode(listOfSecuritiesControllers.map((singleRow) {
              var item = {
                "security_ticker": listOfSecuritiesTickers[i],
                "security_name": listOfSecuritiesControllers[i].text,
                "weight": double.parse(listOfWeightControllers[i].text) / 100,
              };
              i = i + 1;
              return item;
            }).toList()),
            "initial_investment_amount": double.parse(
                _initialAmountInvestedController.text.replaceAll(",", "")),
          };
          bool isUploaded =
              await Provider.of<PortfolioPitchProvider>(context, listen: false)
                  .uploadPortfolioPitch(body);

          print(body);

          if (isUploaded) {
            getDialog("Portfolio Pitch Uploaded !!", true);
          }
        } else {
          getDialog("Sum of Weights should be 100% !!", false);
        }
      } else {
        getDialog("Provide Return and Drawdown !!", false);
      }
    } catch (e, stackTrace) {
      print(e.toString());
      print(stackTrace);
      getDialog("Some Error Occurred!!", false);
    }
  }

  void getDialog(text, cancel) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
            title: Text(
              "",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AllCoustomTheme.getTextThemeColors(),
                fontWeight: FontWeight.bold,
                fontSize: ConstanceData.SIZE_TITLE18,
              ),
            ),
            content: Text(
              "$text",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AllCoustomTheme.getTextThemeColors(),
                fontWeight: FontWeight.bold,
                fontSize: ConstanceData.SIZE_TITLE18,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Ok',
                  style: TextStyle(
                    color: AllCoustomTheme.getTextThemeColors(),
                    fontWeight: FontWeight.bold,
                    fontSize: ConstanceData.SIZE_TITLE18,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (cancel) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        });
  }

  addSecurityRow(index) {
    return Row(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.11,
          width: MediaQuery.of(context).size.width * 0.45,
          child: TextFormField(
            controller: listOfSecuritiesControllers[index],
            onChanged: (text) {
              takeSecurityNumber(text, 'security', securityList[index].id);
            },
            // initialValue: securityList[index].textSecurity,
            decoration: InputDecoration(
              border: new OutlineInputBorder(
                borderSide: new BorderSide(
                    color: AllCoustomTheme.getsecoundTextThemeColor(),
                    width: 12.0),
              ),
              // labelText: 'Option 1',
              hintText: 'Securities',
              hintStyle: TextStyle(
                  fontSize: ConstanceData.SIZE_TITLE14,
                  color: AllCoustomTheme.getTextThemeColors()),
              labelText: 'Security ${index + 1}',
              labelStyle: TextStyle(
                  fontSize: ConstanceData.SIZE_TITLE16,
                  color: AllCoustomTheme.getTextThemeColors()),
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.0),
              ),
            ),
            style: TextStyle(
              color: AllCoustomTheme.getTextThemeColors(),
              fontSize: ConstanceData.SIZE_TITLE16,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.11,
          width: MediaQuery.of(context).size.width * 0.45,
          // margin: EdgeInsets.only(left: 5.0),
          child: TextFormField(
            controller: listOfWeightControllers[index],
            onChanged: (text) {
              takeSecurityNumber(text, 'weight', securityList[index].id);
            },
            keyboardType: TextInputType.number,
            // initialValue: securityList[index].textSecurity,
            decoration: InputDecoration(
              border: new OutlineInputBorder(
                borderSide: new BorderSide(
                    color: AllCoustomTheme.getsecoundTextThemeColor(),
                    width: 12.0),
              ),
              // labelText: 'Option 1',
              hintText: 'Weightage',
              hintStyle: TextStyle(
                fontSize: ConstanceData.SIZE_TITLE14,
                color: AllCoustomTheme.getTextThemeColors(),
              ),

              labelText: 'Weightage(%)',
              labelStyle: TextStyle(
                  fontSize: ConstanceData.SIZE_TITLE16,
                  color: AllCoustomTheme.getTextThemeColors()),
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.0),
              ),
            ),
            style: TextStyle(
              color: AllCoustomTheme.getTextThemeColors(),
              fontSize: ConstanceData.SIZE_TITLE16,
            ),
          ),
        )
      ],
    );
  }

  searchSecurityCallback(companyData) {
    setState(() {
      listOfWeightControllers.add(TextEditingController());
      listOfSecuritiesControllers.add(TextEditingController());
      securityList.add(
        SecurityOption("$_optionIndex", companyData["company_name"], 0),
      );
      print(_optionIndex);
      listOfSecuritiesControllers[_optionIndex - 1].text =
          companyData["company_name"];
      listOfSecuritiesTickers.add(companyData["ticker"]);
      _optionIndex++;
      stockHeight = stockHeight + 100.0;
    });

    Navigator.of(context).pop();
  }

  void _showConfirmation(from, index) {
    double cWidth = MediaQuery.of(context).size.width * 0.71;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
            'Are you sure to delete it?',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          )),
          actions: <Widget>[
            new Container(
                width: cWidth,
                child: new Wrap(
                  spacing: 4.0,
                  runSpacing: 4.0,
                  children: <Widget>[
                    new FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(fontSize: 18.0, color: Colors.grey),
                      ),
                    ),
                    new FlatButton(
                      // padding: EdgeInsets.fromLTRB(120, 0.0, 20, 0.0),
                      onPressed: () async {
                        if (from == 'option') {
                          dynamic option;
                          setState(() {
                            option = securityList.removeAt(index);
                            stockHeight = stockHeight - 100.0;
                          });

                          if (option != null) {
                            Toast.show("Deleted successfully", context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM);
                          } else {
                            Toast.show("Not Found", context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM);
                          }
                        }
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Yes",
                        style: TextStyle(fontSize: 18.0, color: Colors.blue),
                      ),
                    ),
                  ],
                ))
          ],
        );
      },
    );
  }
}
