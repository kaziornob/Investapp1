import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/modules/home/homeScreen.dart';
import 'package:auroim/modules/qaInvForumPages/qusView.dart';
import 'package:auroim/reusable_widgets/customButton.dart';
import 'package:auroim/reusable_widgets/screen_title_appbar.dart';
import 'package:auroim/reusable_widgets/text_field_with_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:auroim/constance/global.dart' as globals;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';

class AddEditQus extends StatefulWidget {
  @override
  _AddEditQusState createState() => _AddEditQusState();
}

class _AddEditQusState extends State<AddEditQus> {
  bool _isInProgress = false;
  bool _isClickOnSubmit = false;
  bool giveBounty = false;
  ApiProvider request = ApiProvider();

  final _addEditQusFormKey = new GlobalKey<FormState>();
  ScrollController _scrollController = ScrollController();

  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();

  List tagList = List();
  bool tagListVisible = false;
  List<TagData> itemList = List();
  TextEditingController _searchController = TextEditingController();
  TextEditingController _qusTitleController = TextEditingController();
  TextEditingController _qusBodyController = TextEditingController();
  TextEditingController _bountyController = TextEditingController();

  bool searchingTags = true;

  final FocusNode qusBodyFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
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

  Widget getRelatedQusView(data) {
    return new ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "${data[index]['qusText']}",
                    style: new TextStyle(
                      color: AllCoustomTheme.getTextThemeColors(),
                      fontSize: ConstanceData.SIZE_TITLE16,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: CircleAvatar(
                    radius: 12.0,
                    backgroundImage: new AssetImage('assets/download.jpeg'),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Container(
                  child: new Text(
                    "10K",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: ConstanceData.SIZE_TITLE14,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.0),
                  child: Icon(
                    Icons.comment_bank_sharp,
                    color: AllCoustomTheme.getTextThemeColors(),
                  ),
                ),
                Container(
                  child: new Text(
                    "10",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: ConstanceData.SIZE_TITLE14,
                    ),
                  ),
                ),
                Container(
                  child: new Text(
                    "modified 10 sec ago",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: ConstanceData.SIZE_TITLE14,
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.grey,
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _qusBodyController.dispose();
    _qusTitleController.dispose();
    super.dispose();
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

  topicTags() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'Search Question tags',
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
                controller: _searchController,
                textInputAction: TextInputAction.done,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.text,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                inputFormatters: [LengthLimitingTextInputFormatter(30)],
                decoration: textFieldInputDecoration("Search topic tags", ""),
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

                _searchController.text = '';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: true,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Container(
              child: Form(
                key: _addEditQusFormKey,
                child: Column(
                  children: <Widget>[
                    ScreenTitleAppbar(
                      title: "ASK A QUESTION",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFieldWithTitle(
                      title: "Title",
                      isMust: false,
                      height: 60,
                      hintText: "Enter title of your question",
                      labelText: "",
                      controller: _qusTitleController,
                      maxLines: 2,
                      validator: _validateTitle,
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Visibility(
                      visible: !giveBounty,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RaisedButton(
                              onPressed: () {
                                setState(() {
                                  giveBounty = !giveBounty;
                                  _bountyController.text = "";
                                });
                              },
                              color: globals.isGoldBlack
                                  ? Color(0xFF1A3263)
                                  : Color(0xFF7499C6),
                              child: Text(
                                "Add Bounty",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.help_outline_rounded,
                              color: globals.isGoldBlack
                                  ? Color(0xFF1A3263)
                                  : Color(0xFF7499C6),
                            )
                          ],
                        ),
                      ),
                    ),
                    // add bounty section
                    Visibility(
                      visible: giveBounty,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "Set bounty",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: ConstanceData.SIZE_TITLE14,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    height: 60,
                                    child: TextFormField(
                                      maxLines: 1,
                                      controller: _bountyController,
                                      validator: _validateBounty,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        color: Colors.black,
                                      ),
                                      cursorColor: Colors.black,
                                      decoration: textFieldInputDecoration(
                                        "Give bounty to Question(50-500 auro coins)",
                                        "",
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        giveBounty = !giveBounty;
                                        _bountyController.text = "";
                                      });
                                    },
                                    icon: Icon(
                                      Icons.delete_forever,
                                    ),
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextFieldWithTitle(
                      title: "Question",
                      isMust: false,
                      height: 120,
                      hintText: "Enter Your Question Here",
                      labelText: "",
                      controller: _qusBodyController,
                      maxLines: 10,
                      validator: _validateBody,
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    topicTags(),
                    showAllSelectedTags(),
                    CustomButton(
                      textColor: globals.isGoldBlack
                          ? Color(0xFFD8AF4F)
                          : Color(0xFF1D6177),
                      borderColor: globals.isGoldBlack
                          ? Color(0xFFD8AF4F)
                          : Color(0xFF1D6177),
                      color: Colors.white,
                      text: "Preview",
                      callback: _preview,
                    ),
                    CustomButton(
                      textColor: Colors.white,
                      borderColor: globals.isGoldBlack
                          ? Color(0xFFD8AF4F)
                          : Color(0xFF1D6177),
                      color: globals.isGoldBlack
                          ? Color(0xFFD8AF4F)
                          : Color(0xFF1D6177),
                      text: "Submit",
                      callback: _submit,
                    ),
                    // keyboard actions
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _preview() async {
    // setState(() {
    //   _isClickOnSubmit = true;
    // });
    // await Future.delayed(const Duration(milliseconds: 700));
    if (_addEditQusFormKey.currentState.validate() == false) {
      // setState(() {
      //   _isClickOnSubmit = false;
      // });
      return;
    }

    var tempField = {
      "callingFrom": "add",
      "title": _qusTitleController.text,
      "body": _qusBodyController.text,
      "tags": itemList,
      "bounty": _bountyController.text.isNotEmpty
          ? int.parse(_bountyController.text)
          : 0,
    };

    // setState(() {
    //   _isClickOnSubmit = false;
    // });

    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (BuildContext context) => QusView(allParams: tempField),
      ),
    );
  }

  _submit() async {
    if (_addEditQusFormKey.currentState.validate() == false) {
      return;
    }

    Map<String, String> tagData = {};

    for (var i = 0; i < itemList.length; i++) {
      tagData.addAll({"${itemList[i].id}": '${itemList[i].tag}'});
    }

    print("tags: $tagData");

    var tempJsonReq = {
      "question_title": _qusTitleController.text,
      "body": _qusBodyController.text,
      "tags": tagData,
      "bounty": _bountyController.text.isNotEmpty
          ? int.parse(_bountyController.text)
          : 0,
    };
    String jsonReq = json.encode(tempJsonReq);

    print("jsonReq: $jsonReq");

    var jsonReqResp =
        await request.postSubmit('forum/create_question', jsonReq);
    var result = json.decode(jsonReqResp.body);

    print("qus add/edit response: $result");

    if (jsonReqResp.statusCode == 200 || jsonReqResp.statusCode == 201) {
      if (result != null &&
          result.containsKey('auth') &&
          result['auth'] == true &&
          result["message"]["message"] == "Question created successfully") {
        // ${result['message']}
        Toast.show(result["message"]["message"], context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            ModalRoute.withName("/Home"));
      } else {
        Toast.show(result["message"]["message"], context,
            duration: 3, gravity: Toast.BOTTOM);
      }
    } else if (result != null &&
        result.containsKey('auth') &&
        result['auth'] != true) {
      Toast.show("oops! question not added", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      Toast.show("Something went wrong!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  String _validateTitle(value) {
    if (value.isEmpty) {
      return "Title cannot be empty";
    }
    return null;
  }

  String _validateBounty(value) {
    if (value.isEmpty) {
      return "Bounty should be 0 or from 50-500";
    }
    return null;
  }

  String _validateBody(value) {
    if (value.isEmpty) {
      return "Body cannot be empty";
    }
    return null;
  }
}

enum SmartTextType { BOLD, T, ITALIC, BULLET }

extension SmartTextStyle on SmartTextType {
  TextStyle get textStyle {
    switch (this) {
      case SmartTextType.ITALIC:
        return TextStyle(
          fontSize: ConstanceData.SIZE_TITLE14,
          fontStyle: FontStyle.italic,
          color: AllCoustomTheme.getTextThemeColors(),
        );
      case SmartTextType.BOLD:
        return TextStyle(
            fontSize: ConstanceData.SIZE_TITLE14,
            color: AllCoustomTheme.getTextThemeColors(),
            fontWeight: FontWeight.bold);
        break;
      default:
        return TextStyle(
            fontSize: ConstanceData.SIZE_TITLE14,
            color: AllCoustomTheme.getTextThemeColors());
    }
  }

  EdgeInsets get padding {
    switch (this) {
      case SmartTextType.BULLET:
        return EdgeInsets.fromLTRB(24, 8, 16, 8);
      default:
        return EdgeInsets.fromLTRB(16, 8, 16, 8);
    }
  }

  TextAlign get align {
    switch (this) {
/*      case SmartTextType.ITALIC:
        return TextAlign.center;
        break;*/
      default:
        return TextAlign.start;
    }
  }

  String get prefix {
    switch (this) {
      case SmartTextType.BULLET:
        return '\u2022 ';
        break;
      default:
    }
  }
}
