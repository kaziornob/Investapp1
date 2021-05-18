import 'dart:convert';
import 'package:auroim/constance/global.dart' as globals;
import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/dialog_widgets/dialog1.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/provider_abhinav/portfolio_pitch_provider.dart';
import 'package:auroim/provider_abhinav/user_details.dart';
import 'package:auroim/reusable_widgets/screen_title_appbar.dart';
import 'package:auroim/widgets/stock_and_portfolio_pitch/search_security.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import '../../reusable_widgets/customButton.dart';

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

  Future<List> searchItems(query) async {
    List resultList = List();
    for (var i = 0; i < tagList.length; i++) {
      if (tagList[i]['tag'].toString().toLowerCase().contains(query)) {
        resultList.add(tagList[i]);
      }
    }

    return resultList;
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                ScreenTitleAppbar(
                  title: 'PORTFOLIO PITCH',
                ),
                SizedBox(
                  height: 40,
                ),
                longShortDropdown(),
                SizedBox(
                  height: 20,
                ),
                enterValueWidget(
                  "Target return (%)",
                  _targetReturnPercController,
                  "",
                  "",
                ),
                SizedBox(
                  height: 20,
                ),
                enterValueWidget(
                  "Target max drawdown",
                  _targetMaxDrawdownController,
                  "",
                  "",
                ),
                SizedBox(
                  height: 20,
                ),
                portfolioStrategy(),
                SizedBox(
                  height: 20,
                ),
                topicTags(),
                showAllSelectedTags(),
                SizedBox(
                  height: 20,
                ),
                showListOfSelectedSecurities(),
                addSecurity(),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  color: globals.isGoldBlack
                      ? Color(0xFFD8AF4F)
                      : Color(0xFF1D6177),
                  text: "Done",
                  callback: () async {
                    submitPortfolio();
                  },
                  borderColor: globals.isGoldBlack
                      ? Color(0xFFD8AF4F)
                      : Color(0xFF1D6177),
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  textFieldInputDecoration(hintText, labelText) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      hintStyle: TextStyle(
        fontSize: ConstanceData.SIZE_TITLE14,
        color: Colors.black,
      ),
      labelStyle: TextStyle(
        fontSize: ConstanceData.SIZE_TITLE16,
        color: Colors.black,
      ),
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
    );
  }

  enterValueWidget(title, controller, hintText, labelText) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 60,
            width: (MediaQuery.of(context).size.width / 2) - 10,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    Text(
                      title,
                      style: new TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        color: Colors.black,
                        fontSize: 18.0,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Container(
              height: 60,
              width: (MediaQuery.of(context).size.width / 2) - 10,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: controller,
                decoration: textFieldInputDecoration(hintText, labelText),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ConstanceData.SIZE_TITLE14,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  longShortDropdown() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 60,
            width: (MediaQuery.of(context).size.width / 2) - 10,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Text(
                      "Strategy",
                      style: TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        color: Colors.black,
                        fontSize: 16.0,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              width: (MediaQuery.of(context).size.width / 2) - 10,
              child: FormField(
                builder: (FormFieldState state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        fontSize: ConstanceData.SIZE_TITLE14,
                        color: Colors.black,
                      ),
                      errorText: state.hasError ? state.errorText : null,
                    ),
                    isEmpty: selectedLongShort == '',
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                          value: selectedLongShort,
                          // isExpanded: true,
                          onChanged: (String newValue) {
                            setState(() {
                              selectedLongShort = newValue;
                            });
                          },
                          items: targetMaxList.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ConstanceData.SIZE_TITLE14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  );
                },
                validator: (val) {
                  return ((val != null && val != '') ||
                          (selectedLongShort != null &&
                              selectedLongShort != ''))
                      ? null
                      : 'Please select field';
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  portfolioStrategy() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text("Portfolio strategy"),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12.0,
          ),
          child: Container(
            height: 120,
            child: TextField(
              controller: _portfolioStrategyController,
              maxLines: 10,
              decoration: textFieldInputDecoration(
                'Example: Focus mostly on US indices, tech and pharma. '
                    'Trades will be based on technical analysis using machine learning to understand patterns and trends in the markets. '
                    'Keep a diverse portfolio to spread risk.',
                '',
              ),
              style: TextStyle(
                color: Colors.black,
                fontSize: ConstanceData.SIZE_TITLE16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  topicTags() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'Search topic tags',
            style: TextStyle(
              color: Colors.black,
              fontSize: ConstanceData.SIZE_TITLE14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12.0,
          ),
          child: Container(
            child: TypeAheadFormField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: _searchTopicTagsController,
                textInputAction: TextInputAction.done,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.text,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                inputFormatters: [LengthLimitingTextInputFormatter(30)],
                decoration: textFieldInputDecoration(
                  "Search topic tags",
                  "",
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
              transitionBuilder: (context, suggestionsBox, controller) {
                return suggestionsBox;
              },
              onSuggestionSelected: (suggestion) {
                print("suggestion: ${suggestion['ticker']}");
                print("suggestion name: ${suggestion['company_name']}");

                _searchTopicTagsController.text = '';
                setState(
                  () {
                    itemList.add(
                      TagData(suggestion['ticker'], suggestion['company_name']),
                    );
                    tagListVisible = itemList.length == 0 ? false : true;
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  showAllSelectedTags() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: tagListVisible,
            child: Padding(
              padding: EdgeInsets.only(
                top: 20.0,
                bottom: 8.0,
              ),
              child: Text(
                'Topic Tags',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ConstanceData.SIZE_TITLE16,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 8.0,
              bottom: tagListVisible ? 24.0 : 0.0,
            ),
            child: StaggeredGridView.countBuilder(
              itemCount: itemList != null ? itemList.length : 0,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              shrinkWrap: true,
              staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                      color: globals.isGoldBlack
                          ? Color(0xFFD8AF4F)
                          : Color(0xFF1D6177),
                      width: 1.0,
                    ),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '${itemList[index].tag}',
                          style: TextStyle(
                            color: globals.isGoldBlack
                                ? Color(0xFFD8AF4F)
                                : Color(0xFF1D6177),
                            fontSize: ConstanceData.SIZE_TITLE16,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.normal,
                            height: 1.3,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            itemList.removeAt(index);
                            tagListVisible =
                                itemList.length == 0 ? false : true;
                          });
                        },
                        child: Icon(
                          Icons.close,
                          color: globals.isGoldBlack
                              ? Color(0xFFD8AF4F)
                              : Color(0xFF1D6177),
                          size: 15.0,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  showListOfSelectedSecurities() {
    return Container(
      height: securityList.length != 0 ? stockHeight : 0.0,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: securityList.length,
        itemBuilder: (context, index) {
          if (securityList.isEmpty) {
            return Row();
          } else {
            return Dismissible(
              key: Key(securityList[index].id.toString()),
              direction: DismissDirection.startToEnd,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, bottom: 9.0),
                    child: Container(
                      height: 60,
                      child: addSecurityRow(index),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 12,
                    child: GestureDetector(
                      child: IconButton(
                        icon: Icon(
                          Icons.delete,
                          size: 20.0,
                          color: Colors.red,
                        ),
                      ),
                      onTap: () {
                        _showConfirmation('option', index);
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  addSecurity() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 40,
        left: 12,
        right: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width * 0.45,
            decoration: BoxDecoration(
              color: Color(0xFF1A3263),
              borderRadius: BorderRadius.circular(5),
            ),
            child: MaterialButton(
              splashColor: Colors.grey,
              shape: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF1A3263),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "Add Security",
                style: TextStyle(
                  color: AllCoustomTheme.getTextThemeColors(),
                  fontSize: ConstanceData.SIZE_TITLE16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => SearchSecurity(
                    callBack: searchSecurityCallback,
                  ),
                );
              },
            ),
          ),
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width * 0.45,
            child: TextFormField(
              controller: _initialAmountInvestedController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 12.0,
                  ),
                ),
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: globals.isGoldBlack
                        ? Color(0xFF1A3263)
                        : Color(0xFF7499C6),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                prefix: Text(
                  "\$",
                  style: TextStyle(
                    color: globals.isGoldBlack
                        ? Color(0xFF1A3263)
                        : Color(0xFF7499C6),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: globals.isGoldBlack
                        ? Color(0xFF1A3263)
                        : Color(0xFF7499C6),
                    width: 1.0,
                  ),
                ),
              ),
              style: TextStyle(
                color:
                    globals.isGoldBlack ? Color(0xFF1A3263) : Color(0xFF7499C6),
                fontSize: ConstanceData.SIZE_TITLE16,
              ),
            ),
          ),
        ],
      ),
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
          return Dialog1(
            text: text,
            doublePop: cancel,
          );
        });
  }

  addSecurityRow(index) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 12.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width * 0.45,
            child: TextFormField(
              controller: listOfSecuritiesControllers[index],
              onChanged: (text) {
                takeSecurityNumber(text, 'security', securityList[index].id);
              },
              decoration: textFieldInputDecoration(
                'Securities',
                'Security ${index + 1}',
              ),
              style: TextStyle(
                color: Colors.black,
                fontSize: ConstanceData.SIZE_TITLE16,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width * 0.45,
            child: TextFormField(
              controller: listOfWeightControllers[index],
              onChanged: (text) {
                takeSecurityNumber(
                  text,
                  'weight',
                  securityList[index].id,
                );
              },
              keyboardType: TextInputType.number,
              decoration: textFieldInputDecoration(
                'Weightage',
                'Weightage(%)',
              ),
              style: TextStyle(
                color: Colors.black,
                fontSize: ConstanceData.SIZE_TITLE16,
              ),
            ),
          )
        ],
      ),
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
