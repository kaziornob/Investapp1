import 'dart:convert';

import 'package:animator/animator.dart';
import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/provider_abhinav/stock_pitch_provider.dart';
import 'package:auroim/provider_abhinav/user_details.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class StockPitch extends StatefulWidget {
  @override
  _StockPitchState createState() => _StockPitchState();
}

class _StockPitchState extends State<StockPitch> {
  bool _isInProgress = false;
  List tagList = List();
  bool tagListVisible = false;
  List<TagData> itemList = List();
  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();
  TextEditingController _searchTopicController = TextEditingController();
  TextEditingController _priceBaseController = TextEditingController();
  TextEditingController _priceBearController = TextEditingController();
  TextEditingController _revenueController = TextEditingController();
  TextEditingController _epsController = TextEditingController();
  TextEditingController _searchStockNameController = TextEditingController();
  TextEditingController _stockPitchTitleController = TextEditingController();
  TextEditingController _investmentThesisController = TextEditingController();

  List<String> pollDurationList = <String>['7 days', '14 days', '21 days'];

  // List<String> stockNameList = <String>["Listed", "Unlisted", "Crypto"];

  List<String> longShortList = <String>['Long', 'Short'];

  String selectedStockId;
  String selectedLongShort;

  String fileName;
  String path;
  Map<String, String> paths;
  List<String> extensions;
  bool isLoadingPath = false;
  bool isMultiPick = false;
  FileType fileType;

  @override
  void initState() {
    super.initState();
    loadUserDetails();
    getTagList();
    fileType = FileType.any;
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

  void _openFileExplorer() async {
    setState(() => isLoadingPath = true);
    try {
      if (isMultiPick) {
        path = null;
        paths = await FilePicker.getMultiFilePath(
            type: true ? fileType : FileType.any,
            allowedExtensions: extensions);
      } else {
        path = await FilePicker.getFilePath(
            type: true ? fileType : FileType.any,
            allowedExtensions: extensions);
        paths = null;
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
    setState(() {
      isLoadingPath = false;
      fileName = path != null
          ? path.split('/').last
          : paths != null
              ? paths.keys.toString()
              : '...';
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
/*    var response = await request.getRequest("get_tags");
    setState(() {
      tagList = response['message'];
    });
    return response['message'];*/

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

  @override
  void dispose() {
    _epsController.dispose();
    _priceBaseController.dispose();
    _priceBearController.dispose();
    _revenueController.dispose();
    _searchStockNameController.dispose();
    _searchTopicController.dispose();
    _stockPitchTitleController.dispose();
    _investmentThesisController.dispose();
    super.dispose();
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
                                              .getTextThemeColor(),
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
                                          'Stock Pitch',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: AllCoustomTheme
                                                .getTextThemeColor(),
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
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: new FormField(
                                      builder: (FormFieldState state) {
                                        return InputDecorator(
                                          decoration: InputDecoration(
                                            labelText: 'Stock Name',
                                            labelStyle: AllCoustomTheme
                                                .getDropDownFieldLabelStyleTheme(),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1.0),
                                            ),
                                            errorText: state.hasError
                                                ? state.errorText
                                                : null,
                                          ),
                                          isEmpty: selectedStockId == '',
                                          child: Container(
                                            margin: EdgeInsets.only(top: 8.0),
                                            child: TypeAheadFormField(
                                              textFieldConfiguration:
                                                  TextFieldConfiguration(
                                                controller:
                                                    _searchStockNameController,
                                                textInputAction:
                                                    TextInputAction.done,
                                                textAlign: TextAlign.start,
                                                keyboardType:
                                                    TextInputType.text,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black),
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      30)
                                                ],
                                                decoration: InputDecoration(
                                                  hintText: 'Search Stock Name',
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1.0,
                                                          color: AllCoustomTheme
                                                              .getTextThemeColor()),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  0.0))),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey,
                                                        width: 1.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black,
                                                        width: 1.0),
                                                  ),
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                              ),
                                              suggestionsCallback:
                                                  (pattern) async {
                                                print("pattern : $pattern");
                                                return await _featuredCompaniesProvider
                                                    .searchPublicCompanyList(
                                                        pattern);
                                              },
                                              itemBuilder:
                                                  (context, suggestion) {
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
                                              onSuggestionSelected:
                                                  (suggestion) {
                                                setState(() {
                                                  _searchStockNameController
                                                          .text =
                                                      suggestion[
                                                          'company_name'];
                                                  selectedStockId =
                                                      suggestion['ticker'];
                                                });
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                      validator: (val) {
                                        return ((val != null && val != '') ||
                                                (selectedStockId != null &&
                                                    selectedStockId != ''))
                                            ? null
                                            : 'choose one';
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: new FormField(
                                    builder: (FormFieldState state) {
                                      return InputDecorator(
                                        decoration: InputDecoration(
                                          labelText: 'Long/Short',
                                          labelStyle: AllCoustomTheme
                                              .getDropDownFieldLabelStyleTheme(),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1.0),
                                          ),
                                          errorText: state.hasError
                                              ? state.errorText
                                              : null,
                                        ),
                                        isEmpty: selectedLongShort == '',
                                        child: new DropdownButtonHideUnderline(
                                            child: ButtonTheme(
                                                alignedDropdown: true,
                                                child: Container(
                                                  height: 18.0,
                                                  child: new DropdownButton(
                                                    value: selectedLongShort,
                                                    dropdownColor: Colors.white,
                                                    isExpanded: true,
                                                    onChanged:
                                                        (String newValue) {
                                                      setState(() {
                                                        selectedLongShort =
                                                            newValue;
                                                      });
                                                    },
                                                    items: longShortList
                                                        .map((String value) {
                                                      return new DropdownMenuItem(
                                                        value: value,
                                                        child: new Text(
                                                          value,
                                                          style: TextStyle(
                                                            color: AllCoustomTheme
                                                                .getTextThemeColor(),
                                                            fontSize:
                                                                ConstanceData
                                                                    .SIZE_TITLE16,
                                                            fontFamily:
                                                                "Roboto",
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ))),
                                      );
                                    },
                                    validator: (val) {
                                      return ((val != null && val != '') ||
                                              (selectedLongShort != null &&
                                                  selectedLongShort != ''))
                                          ? null
                                          : 'choose one';
                                    },
                                  ))
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 60,
                                child: TextField(
                                  controller: _stockPitchTitleController,
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                    labelText: 'Stock Pitch Title',
                                    hintText: 'Stock Pitch Title: ',
                                    hintStyle: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: ConstanceData.SIZE_TITLE14),
                                    labelStyle: AllCoustomTheme
                                        .getTextFormFieldLabelStyleTheme(),
                                    focusColor:
                                        AllCoustomTheme.getTextThemeColor(),
                                    fillColor:
                                        AllCoustomTheme.getTextThemeColor(),
                                    suffixIcon: questionMark(
                                        "Can be a listed stock,private company or a crypto coin that you think will go up (Long Pitch) or go down (Short Pitch) on value?"),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.0),
                                    ),
                                  ),
                                  cursorColor:
                                      AllCoustomTheme.getTextThemeColor(),
                                  style: AllCoustomTheme
                                      .getTextFormFieldBaseStyleTheme(),
                                ),
                              ),

                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 0),
                                        child: Text(
                                          '1-year target',
                                          style: TextStyle(
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE18,
                                              color: AllCoustomTheme
                                                  .getTextThemeColor()),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Container(
/*                                  height: 60,
                                  width: 150,*/
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.11,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: TextField(
                                          controller: _priceBaseController,
                                          keyboardType: TextInputType.number,
                                          maxLines: 4,
                                          decoration: InputDecoration(
                                            labelText: 'Price-Base',
                                            hintText: 'Price-Base',
                                            hintStyle: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize:
                                                    ConstanceData.SIZE_TITLE14),
                                            labelStyle: AllCoustomTheme
                                                .getTextFormFieldLabelStyleTheme(),
                                            focusColor: AllCoustomTheme
                                                .getTextThemeColor(),
                                            fillColor: AllCoustomTheme
                                                .getTextThemeColor(),
                                            suffixIcon: questionMark(
                                                "This is you target price in 1-year's time for this security.For a \'long\' pitch should be higher than current value of security, and lower if this is \'short\' pitch"),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 1.0),
                                            ),
                                          ),
                                          cursorColor: AllCoustomTheme
                                              .getTextThemeColor(),
                                          style: AllCoustomTheme
                                              .getTextFormFieldBaseStyleTheme(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Container(
/*                                  height: 60,
                                  width: 150,*/
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.11,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: TextField(
                                          controller: _priceBearController,
                                          keyboardType: TextInputType.number,
                                          maxLines: 4,
                                          cursorColor: AllCoustomTheme
                                              .getTextThemeColor(),
                                          style: AllCoustomTheme
                                              .getTextFormFieldBaseStyleTheme(),
                                          decoration: new InputDecoration(
                                            focusColor: AllCoustomTheme
                                                .getTextThemeColor(),
                                            fillColor: AllCoustomTheme
                                                .getTextThemeColor(),
                                            labelText: 'Price-Bear',
                                            hintText: 'Price-Bear',
                                            suffixIcon: questionMark(
                                                "This is your target price in 1-years's time if your investment thesis didn't work and the security goes in the opposite direction of your prediction"),
                                            hintStyle: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize:
                                                    ConstanceData.SIZE_TITLE14),
                                            labelStyle: AllCoustomTheme
                                                .getTextFormFieldLabelStyleTheme(),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 1.0),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 0),
                                        child: Text(
                                          '1-year fwd',
                                          style: TextStyle(
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE18,
                                              color: AllCoustomTheme
                                                  .getTextThemeColor()),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.11,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: TextField(
                                          controller: _revenueController,
                                          keyboardType: TextInputType.number,
                                          maxLines: 4,
                                          cursorColor: AllCoustomTheme
                                              .getTextThemeColor(),
                                          style: AllCoustomTheme
                                              .getTextFormFieldBaseStyleTheme(),
                                          decoration: new InputDecoration(
                                            focusColor: AllCoustomTheme
                                                .getTextThemeColor(),
                                            fillColor: AllCoustomTheme
                                                .getTextThemeColor(),
                                            labelText: 'Revenue',
                                            hintText: 'Revenue',
                                            suffixIcon: questionMark(
                                                "This is your estimate of this security's Revenue in 1 years's time."),
                                            hintStyle: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize:
                                                    ConstanceData.SIZE_TITLE14),
                                            labelStyle: AllCoustomTheme
                                                .getTextFormFieldLabelStyleTheme(),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 1.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.11,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: TextField(
                                          controller: _epsController,
                                          maxLines: 4,
                                          cursorColor: AllCoustomTheme
                                              .getTextThemeColor(),
                                          style: AllCoustomTheme
                                              .getTextFormFieldBaseStyleTheme(),
                                          keyboardType: TextInputType.number,
                                          decoration: new InputDecoration(
                                            focusColor: AllCoustomTheme
                                                .getTextThemeColor(),
                                            fillColor: AllCoustomTheme
                                                .getTextThemeColor(),
                                            labelText: 'Eps',
                                            hintText: 'Eps',
                                            suffixIcon: questionMark(
                                                "This is your estimate of this security's Earnings Per Share in 1 years's time."),
                                            hintStyle: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize:
                                                    ConstanceData.SIZE_TITLE14),
                                            labelStyle: AllCoustomTheme
                                                .getTextFormFieldLabelStyleTheme(),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 1.0),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 120,
                                child: TextField(
                                  controller: _investmentThesisController,
                                  maxLines: 10,
                                  cursorColor:
                                      AllCoustomTheme.getTextThemeColor(),
                                  style: AllCoustomTheme
                                      .getTextFormFieldBaseStyleTheme(),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: new InputDecoration(
                                    focusColor:
                                        AllCoustomTheme.getTextThemeColor(),
                                    fillColor:
                                        AllCoustomTheme.getTextThemeColor(),
                                    labelText: 'Investment Thesis',
                                    hintText: 'Investment Thesis: ',
                                    hintStyle: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: ConstanceData.SIZE_TITLE14),
                                    labelStyle: AllCoustomTheme
                                        .getTextFormFieldLabelStyleTheme(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 1.0),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.0),
                                    ),
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
                                          AllCoustomTheme.getTextThemeColor(),
                                      fontSize: ConstanceData.SIZE_TITLE16,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 8.0),
                                    child: TypeAheadFormField(
                                      textFieldConfiguration:
                                          TextFieldConfiguration(
                                        controller: _searchTopicController,
                                        textInputAction: TextInputAction.done,
                                        textAlign: TextAlign.start,
                                        keyboardType: TextInputType.text,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(30)
                                        ],
                                        decoration: InputDecoration(
                                          hintText: 'Search Topic Tags',
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1.0,
                                                  color: AllCoustomTheme
                                                      .getTextThemeColor()),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(0.0))),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 1.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black,
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

                                        _searchTopicController.text = '';
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
                                                .getTextThemeColor(),
                                            fontSize:
                                                ConstanceData.SIZE_TITLE16,
                                          ),
                                        ),
                                      )),
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 8.0,
                                      bottom: tagListVisible ? 24.0 : 0.0,
                                    ),
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
                                                width: 1.0,
                                              ),
                                            ),
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
                                                            .getTextThemeColor(),
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
                                                          .getTextThemeColor(),
                                                      size: 15.0,
                                                    ))
                                              ],
                                            ));
                                      },
                                    ),
                                  ),
                                ],
                              ),

                              ////upload doc//
                              new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
/*                              new Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: new DropdownButton(
                                    hint: new Text('Select file type'),
                                    value: fileType,
                                    items: <DropdownMenuItem>[
                                      new DropdownMenuItem(
                                        child: new Text('Audio'),
                                        value: FileType.audio,
                                      ),
                                      new DropdownMenuItem(
                                        child: new Text('Image'),
                                        value: FileType.image,
                                      ),
                                      new DropdownMenuItem(
                                        child: new Text('Video'),
                                        value: FileType.video,
                                      ),
                                      new DropdownMenuItem(
                                        child: new Text('Any'),
                                        value: FileType.any,
                                      ),
                                    ],
                                    onChanged: (value) => setState(() {
                                      fileType = value;
                                    })
                                ),
                              ),
                              new ConstrainedBox(
                                constraints: BoxConstraints.tightFor(width: 200.0),
                                child: new SwitchListTile.adaptive(
                                  title: new Text('Pick multiple files', textAlign: TextAlign.right),
                                  onChanged: (bool value) => setState(() => isMultiPick = value),
                                  value: isMultiPick,
                                ),
                              ),*/
                                  new Padding(
                                    padding: const EdgeInsets.only(
                                        top: 50.0, bottom: 20.0),
                                    child: new RaisedButton(
                                      onPressed: () => _openFileExplorer(),
                                      child: new Text(
                                        "Investment Thesis doc",
                                        style: TextStyle(
                                          color: AllCoustomTheme
                                              .getTextThemeColors(),
                                          fontSize: ConstanceData.SIZE_TITLE18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  new Builder(
                                    builder: (BuildContext context) =>
                                        isLoadingPath
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10.0),
                                                child:
                                                    const CircularProgressIndicator())
                                            : path != null || paths != null
                                                ? new Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 30.0),
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.50,
                                                    child: new Scrollbar(
                                                        child: new ListView
                                                            .separated(
                                                      itemCount: paths !=
                                                                  null &&
                                                              paths.isNotEmpty
                                                          ? paths.length
                                                          : 1,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        final bool isMultiPath =
                                                            paths != null &&
                                                                paths
                                                                    .isNotEmpty;
                                                        final int fileNo =
                                                            index + 1;
                                                        final String name =
                                                            'File $fileNo : ' +
                                                                (isMultiPath
                                                                    ? paths.keys
                                                                            .toList()[
                                                                        index]
                                                                    : fileName ??
                                                                        '...');
                                                        final filePath =
                                                            isMultiPath
                                                                ? paths
                                                                    .values
                                                                    .toList()[
                                                                        index]
                                                                    .toString()
                                                                : path;
                                                        return new ListTile(
                                                          title: new Text(
                                                            name,
                                                            style: TextStyle(
                                                              color: AllCoustomTheme
                                                                  .getTextThemeColor(),
                                                              fontSize:
                                                                  ConstanceData
                                                                      .SIZE_TITLE14,
                                                            ),
                                                          ),
                                                          subtitle: new Text(
                                                            filePath,
                                                            style: TextStyle(
                                                              color: AllCoustomTheme
                                                                  .getTextThemeColor(),
                                                              fontSize:
                                                                  ConstanceData
                                                                      .SIZE_TITLE14,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      separatorBuilder:
                                                          (BuildContext context,
                                                                  int index) =>
                                                              new Divider(),
                                                    )),
                                                  )
                                                : new Container(),
                                  ),
                                ],
                              ),
/*                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MaterialButton(
                                splashColor: Colors.grey,
                                child: Text(
                                  "Upload doc",
                                  style: TextStyle(
                                    color: AllCoustomTheme.getTextThemeColors(),
                                    fontSize: ConstanceData.SIZE_TITLE18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                              ),
                              MaterialButton(
                                splashColor: Colors.grey,
                                child: Text(
                                  "Upload model",
                                  style: TextStyle(
                                    color: AllCoustomTheme.getTextThemeColors(),
                                    fontSize: ConstanceData.SIZE_TITLE18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),*/

                              SizedBox(
                                height: 24.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 20, left: 14, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      child: Animator(
                                        tween:
                                            Tween<double>(begin: 0.8, end: 1.1),
                                        curve: Curves.easeInToLinear,
                                        cycles: 0,
                                        builder: (anim) => Transform.scale(
                                          scale: anim.value,
                                          child: Container(
                                            /*height: 50,
                                      width: 100,*/
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.06,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.27,
                                            decoration: BoxDecoration(
                                              border: new Border.all(
                                                  color: Colors.black,
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
                                                  color: Colors.white,
                                                  fontSize: ConstanceData
                                                      .SIZE_TITLE18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              onPressed: () async {
                                                onPressedDone();
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

  onPressedDone() async {
    if (_priceBaseController.text.isNotEmpty &&
        _priceBearController.text.isNotEmpty) {
      List allTags = [];
      itemList.forEach((element) {
        allTags.add(element.tag);
      });

      var body = {
        "email": Provider.of<UserDetails>(context, listen: false)
            .userDetails["email"],
        "stock_name": "Listed",
        "isLong": selectedLongShort == "Short" ? 0 : 1,
        "price_base": double.parse(_priceBaseController.text),
        "price_bear": double.parse(_priceBearController.text),
        "revenue": double.parse(_revenueController.text),
        "eps": double.parse(_epsController.text),
        "investment_thesis": _investmentThesisController.text,
        "topic_tags": jsonEncode(allTags),
        "stock_id": selectedStockId,
        "title": _stockPitchTitleController.text,
      };

      print(body.toString());

      bool done = await Provider.of<StockPitchProvider>(context, listen: false)
          .uploadStockPitch(body);
      if (done) {
        getDialog("Stock Pitch Uploaded", true);
      } else {
        getDialog("Some Error Occurred", true);
      }
    } else {
      getDialog("Price-Bear/Price-Base cannot be empty", false);
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

  questionMark(text) {
    return Tooltip(
      child: Icon(
        Icons.help,
        color: Colors.black,
      ),
      message: text,
    );
  }
}
