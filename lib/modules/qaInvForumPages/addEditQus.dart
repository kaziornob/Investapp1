import 'dart:convert';

import 'package:animator/animator.dart';
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/modules/qaInvForumPages/qusView.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:flutter/services.dart';

// import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import 'package:keyboard_actions/keyboard_actions.dart';
// import 'package:keyboard_actions/keyboard_actions_config.dart';
// import 'package:keyboard_actions/keyboard_actions_item.dart';
// import 'package:html_editor/html_editor.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

// const String _markdownData = "*pooja* **pooja** # this is H1 http:github.com";

class AddEditQus extends StatefulWidget {
  @override
  _AddEditQusState createState() => _AddEditQusState();
}

class _AddEditQusState extends State<AddEditQus> {
  bool _isInProgress = false;
  bool _isClickOnSubmit = false;

  // bool italicActive = false;
  // bool boldActive = false;

/*  final controller = ScrollController();

  @override
  Future<String> get data => Future<String>.value(_markdownData);*/

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

  bool searchingTags = true;

  final FocusNode qusBodyFocusNode = FocusNode();

  // GlobalKey<HtmlEditorState> keyEditor = GlobalKey();

  List<dynamic> relatedQusList = <dynamic>[
    {
      "qusText":
          "Is now a good time to add to one’s Apple holdings or wait for a sell-off given sharp rally recently? ",
      "measure": "741 XP"
    },
    {
      "qusText":
          "Apple stocks over Microsoft given the current market situation?",
      "measure": "716 XP"
    },
    {"qusText": "tat 1 anna", "measure": "488 XP"}
  ];

  @override
  void initState() {
    // _searchController.addListener(() {
    //   if (_searchController.text.length > 0) {
    //     print(_searchController.text);
    //     setState(() {
    //       searchingTags = true;
    //     });
    //   } else {
    //     setState(() {
    //       searchingTags = false;
    //     });
    //   }
    // });
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
    // var txt = await keyEditor.currentState.getText();  to get editor text value
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

  /// Creates the [KeyboardActionsConfig] to hook up the fields
  /// and their focus nodes to our [FormKeyboardActions].
  /* KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      actions: [
        KeyboardActionsItem(
            focusNode: qusBodyFocusNode,
            toolbarButtons: [
            (node){
              return InkWell(
                onTap: ()
                {
                    setState(() {
                      italicActive = !italicActive;
                    });
                },
                child: Container(
                  margin: EdgeInsets.only(left: 13.0),
                  child: Icon(
                    FontAwesomeIcons.italic,
                    color: italicActive ? AllCoustomTheme.boxColor() : Colors.grey,
                    size: 20,
                  ),
                ),
              );
            }, (node){
                return InkWell(
                  onTap: ()
                  {
                    setState(() {
                      boldActive = !boldActive;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 13.0),
                    child: Icon(
                      FontAwesomeIcons.bold,
                      color: boldActive ? AllCoustomTheme.boxColor() : Colors.grey,
                      size: 20,
                    ),
                  ),
                );
            },(node){
              return InkWell(
                onTap: () {

                },
                child: Container(
                  margin: EdgeInsets.only(left: 13.0),
                  child: Icon(
                    FontAwesomeIcons.link,
                    color: AllCoustomTheme.boxColor(),
                    size: 20,
                  ),
                ),
              );
            },(node){
              return Container(
                margin: EdgeInsets.only(left: 13.0),
                child: Icon(
                  FontAwesomeIcons.virus,
                  color: AllCoustomTheme.boxColor(),
                  size: 20,
                ),
              );
              }, (node){
                return Container(
                  margin: EdgeInsets.only(left: 13.0),
                  child: Icon(
                    FontAwesomeIcons.book,
                    color: AllCoustomTheme.boxColor(),
                    size: 20,
                  ),
                );
              },(node){
                return Container(
                  margin: EdgeInsets.only(left: 13.0),
                  child: Icon(
                    FontAwesomeIcons.fileVideo,
                    color: AllCoustomTheme.boxColor(),
                    size: 20,
                  ),
                );
              }, (node){
                return Container(
                  margin: EdgeInsets.only(left: 13.0),
                  child: Icon(
                    FontAwesomeIcons.image,
                    color: AllCoustomTheme.boxColor(),
                    size: 20,
                  ),
                );
              }
          ]

        ),
      ],
    );
  }*/

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _qusBodyController.dispose();
    _qusTitleController.dispose();
    super.dispose();
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
              backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
              body: ModalProgressHUD(
                inAsyncCall: _isInProgress,
                opacity: 0,
                progressIndicator: CupertinoActivityIndicator(
                  radius: 12,
                ),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16, left: 16),
                      child: !_isInProgress
                          ? Container(
                              child: Form(
                                key: _addEditQusFormKey,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: appBarheight,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                            duration:
                                                Duration(milliseconds: 500),
                                            cycles: 0,
                                            builder: (anim) =>
                                                FractionalTranslation(
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
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.decelerate,
                                            cycles: 1,
                                            builder: (anim) => Transform.scale(
                                              scale: anim.value,
                                              child: Text(
                                                'Ask a question',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: AllCoustomTheme
                                                      .getTextThemeColors(),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: ConstanceData
                                                      .SIZE_TITLE20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: _qusTitleController.text !=
                                                      '' &&
                                                  _qusBodyController.text != ""
                                              ? true
                                              : false,
                                          child: Container(
                                            height: 25,
                                            width: 95,
                                            decoration: BoxDecoration(
                                              color:
                                                  AllCoustomTheme.getThemeData()
                                                      .textSelectionColor,
                                              border: new Border.all(
                                                  color: Colors.white,
                                                  width: 1.0),
                                            ),
                                            child: _isClickOnSubmit
                                                ? Container(
                                                    color: Colors.white,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 14),
                                                      child:
                                                          CupertinoActivityIndicator(
                                                        radius: 12,
                                                      ),
                                                    ),
                                                  )
                                                : MaterialButton(
                                                    splashColor: Colors.grey,
                                                    child: Text(
                                                      "Preview",
                                                      style: TextStyle(
                                                        color: AllCoustomTheme
                                                            .getTextThemeColors(),
                                                        fontSize: ConstanceData
                                                            .SIZE_TITLE12,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      _submit();
                                                    },
                                                  ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    // ques title section
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: CircleAvatar(
                                            radius: 15.0,
                                            backgroundImage: new AssetImage(
                                                'assets/download.jpeg'),
                                            backgroundColor: Colors.transparent,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              color: AllCoustomTheme.boxColor(),
                                            ),
                                            child: TextFormField(
                                              maxLines: 2,
                                              controller: _qusTitleController,
                                              validator: _validateTitle,
                                              style: TextStyle(
                                                fontSize:
                                                    ConstanceData.SIZE_TITLE16,
                                                color: AllCoustomTheme
                                                    .getTextThemeColors(),
                                              ),
                                              cursorColor: AllCoustomTheme
                                                  .getTextThemeColors(),
                                              onChanged: (value) {},
                                              decoration: InputDecoration(
                                                hintText:
                                                    'Title of your question',
                                                hintStyle: TextStyle(
                                                  fontSize: ConstanceData
                                                      .SIZE_TITLE16,
                                                  color: AllCoustomTheme
                                                      .getsecoundTextThemeColor(),
                                                ),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    // related question section
                                    Visibility(
                                      visible:
                                          _qusTitleController.text != null &&
                                              _qusTitleController.text != "",
                                      child: ExpandablePanel(
                                        header: Text(
                                          'Related Questions:',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize:
                                                ConstanceData.SIZE_TITLE16,
                                          ),
                                        ),
                                        expanded: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    color: AllCoustomTheme
                                                        .boxColor(),
                                                  ),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.35,
                                                  child: Scrollbar(
                                                    child: getRelatedQusView(
                                                        relatedQusList),
                                                  )),
                                            ),
                                          ],
                                        ),
                                        tapHeaderToExpand: true,
                                        hasIcon: true,
                                        iconColor: Colors.white,
                                      ),
                                    ),
                                    Visibility(
                                      visible:
                                          _qusTitleController.text != null &&
                                              _qusTitleController.text != "",
                                      child: SizedBox(
                                        height: 30,
                                      ),
                                    ),
                                    // bottom fomatting section
/*                        Container(
                            height: 200,
                            child: ChangeNotifierProvider<EditorProvider>(
                                create: (context) => EditorProvider(),
                                builder: (context, child) {
                                  return SafeArea(
                                    child: Scaffold(
                                        body: Container(
                                          decoration: BoxDecoration(
                                            color: AllCoustomTheme.boxColor(),
                                          ),
                                          child: Stack(
                                            children: <Widget>[
                                              Positioned(
                                                  top: 16,
                                                  left: 0,
                                                  right: 0,
                                                  bottom: 56,
                                                  child: Consumer<EditorProvider>(
                                                      builder: (context, state, _) {
                                                        return ListView.builder(
                                                            itemCount: state.length,
                                                            itemBuilder: (context, index) {
                                                              return Focus(
                                                                  onFocusChange: (hasFocus) {
                                                                    if (hasFocus) state.setFocus(state.typeAt(index));
                                                                  },
                                                                  child: Container(
                                                                    child: SmartTextField(
                                                                      type: state.typeAt(index),
                                                                      controller: state.textAt(index),
                                                                      focusNode: state.nodeAt(index),
                                                                    ),
                                                                  )
                                                              );
                                                            }
                                                        );
                                                      }
                                                  )
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                left: 0,
                                                right: 0,
                                                child: Selector<EditorProvider, SmartTextType>(
                                                  selector: (buildContext, state) => state.selectedType,
                                                  builder: (context, selectedType, _) {
                                                    return Toolbar(
                                                      selectedType: selectedType,
                                                      onSelected: Provider.of<EditorProvider>(context,
                                                          listen: false).setType,
                                                    );
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                    ),
                                  );
                                }
                            ),
                          ),*/

/*                          Container(
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                                color: AllCoustomTheme.boxColor(),
                              ),
                              child: Markdown(
                                controller: controller,
                                selectable: true,
                                data: _markdownData,
                              ),
                            ),*/
                                    // ques body section
                                    Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: AllCoustomTheme.boxColor(),
                                      ),
                                      child: TextFormField(
                                        validator: _validateBody,
                                        maxLines: null,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        controller: _qusBodyController,
                                        focusNode: qusBodyFocusNode,
                                        style: TextStyle(
                                          fontSize: ConstanceData.SIZE_TITLE14,
                                          color: AllCoustomTheme
                                              .getTextThemeColors(),
                                        ),
                                        decoration: InputDecoration(
                                          hintText: 'Type your question here..',
                                          hintStyle: TextStyle(
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE16,
                                              color: AllCoustomTheme
                                                  .getTextThemeColors()),
                                          labelStyle: TextStyle(
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE14,
                                              color: AllCoustomTheme
                                                  .getTextThemeColors()),
                                        ),
                                      ),
                                    ),
/*                          Container(
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                                color: AllCoustomTheme.boxColor(),
                              ),
                              child: KeyboardActions(
                                config: _buildConfig(context),
                                child: TextField(
                                  maxLines: null,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _qusBodyController,
                                  focusNode: qusBodyFocusNode,
                                  style: TextStyle(
                                      fontSize: ConstanceData.SIZE_TITLE14,
                                      color: AllCoustomTheme.getTextThemeColors(),
                                      fontStyle: italicActive ? FontStyle.italic : FontStyle.normal,
                                      fontWeight: boldActive ? FontWeight.bold : FontWeight.normal,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Type your question here..',
                                    hintStyle: TextStyle(
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        color:
                                        AllCoustomTheme.getTextThemeColors()),
                                    labelStyle: TextStyle(
                                        fontSize: ConstanceData.SIZE_TITLE14,
                                        color: AllCoustomTheme.getTextThemeColors()),
                                  ),
                                ),
                              ),
                            ),*/
                                    SizedBox(
                                      height: 20,
                                    ),
                                    // question Tags
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Search Question Tags',
                                          style: TextStyle(
                                            color: AllCoustomTheme
                                                .getTextThemeColors(),
                                            fontSize:
                                                ConstanceData.SIZE_TITLE16,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 8.0),
                                          child: TypeAheadFormField(
                                            textFieldConfiguration:
                                                TextFieldConfiguration(
                                                    // onTap: () {
                                                    //   print(
                                                    //       "this got tapped hard");
                                                    //   _scrollController
                                                    //       .animateTo(
                                                    //     0.0,
                                                    //     curve: Curves.easeOut,
                                                    //     duration:
                                                    //         const Duration(
                                                    //       milliseconds: 300,
                                                    //     ),
                                                    //   );
                                                    // },
                                                    controller:
                                                        _searchController,
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    textAlign: TextAlign.start,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                    ),
                                                    inputFormatters: [
                                                      LengthLimitingTextInputFormatter(
                                                          30)
                                                    ],
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          'Search Question Tags',
                                                      border: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              width: 1.0,
                                                              color: AllCoustomTheme
                                                                  .getTextThemeColors()),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
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
                                                            color: Colors.white,
                                                            width: 1.0),
                                                      ),
                                                      hintStyle: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),
                                                    onSubmitted: (value) {
                                                      setState(() {
                                                        itemList.add(TagData(
                                                            _searchController
                                                                .text,
                                                            _searchController
                                                                .text));
                                                        tagListVisible =
                                                            itemList.length == 0
                                                                ? false
                                                                : true;
                                                      });
                                                      _searchController.text =
                                                          '';
                                                    }),
                                            suggestionsCallback:
                                                (pattern) async {
                                              print("pattern : $pattern");
                                              return await _featuredCompaniesProvider
                                                  .searchPublicCompanyList(
                                                      pattern);
                                              // if (pattern
                                              //         .toString()
                                              //         .trim()
                                              //         .length <
                                              //     2) {
                                              //   return null;
                                              // } else {
                                              //   return searchItems(pattern);
                                              // }
                                            },
                                            itemBuilder: (context, suggestion) {
                                              // if (_searchController
                                              //     .text.isNotEmpty) {
                                              // print(suggestion);
                                              return ListTile(
                                                title: Text(
                                                  suggestion["company_name"],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              );
                                              //   );
                                              // } else
                                              //   return Container();
                                            },
                                            transitionBuilder: (context,
                                                suggestionsBox, controller) {
                                              return suggestionsBox;
                                            },
                                            onSuggestionSelected: (suggestion) {
                                              _searchController.text = '';
                                              setState(() {
                                                itemList.add(
                                                  TagData(
                                                      suggestion['ticker'],
                                                      suggestion[
                                                          'company_name']),
                                                );
                                                tagListVisible =
                                                    itemList.length == 0
                                                        ? false
                                                        : true;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    /////////////question Tag list////////
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 8.0,
                                              bottom:
                                                  tagListVisible ? 24.0 : 0.0),
                                          child: StaggeredGridView.countBuilder(
                                            itemCount: itemList != null
                                                ? itemList.length
                                                : 0,
                                            physics:
                                                NeverScrollableScrollPhysics(),
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
                                                          BorderRadius.circular(
                                                              4.0),
                                                      border: Border.all(
                                                          color: Colors.grey,
                                                          width: 1.0)),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 8.0),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Text(
                                                          '${itemList[index].tag}',
                                                          style: TextStyle(
                                                              color: AllCoustomTheme
                                                                  .getTextThemeColors(),
                                                              fontSize:
                                                                  ConstanceData
                                                                      .SIZE_TITLE16,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              height: 1.3),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10.0,
                                                      ),
                                                      InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              itemList.removeAt(
                                                                  index);
                                                              tagListVisible =
                                                                  itemList.length ==
                                                                          0
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
                                    // keyboard actions
                                    /*                         Container(
                              height: 100,
                              child: KeyboardActions(
                                config: _buildConfig(context),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        TextField(
                                          keyboardType: TextInputType.emailAddress,
                                          focusNode: _nodeText3,
                                          decoration: InputDecoration(
                                            hintText: "Input Number with Custom Action",
                                            hintStyle: new TextStyle(
                                              color: AllCoustomTheme.getTextThemeColors(),
                                              fontSize: ConstanceData.SIZE_TITLE16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )*/

/*                             SizedBox(height: MediaQuery.of(context).size.height * 0.10),
                               Padding(
                                 padding: const EdgeInsets.only(bottom: 20, left: 14, right: 10),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: <Widget>[
                                     SizedBox(
                                       height: MediaQuery.of(context).size.height * 0.06,
                                       child: Animator(
                                         tween: Tween<double>(begin: 0.8, end: 1.1),
                                         curve: Curves.easeInToLinear,
                                         cycles: 0,
                                         builder: (anim) => Transform.scale(
                                           scale: anim.value,
                                           child: Container(
                                             height: MediaQuery.of(context).size.height * 0.06,
                                             width: MediaQuery.of(context).size.width * 0.32,
                                             decoration: BoxDecoration(
                                               border: new Border.all(color: Colors.white, width: 1.5),
                                               gradient: LinearGradient(
                                                 begin: Alignment.topLeft,
                                                 end: Alignment.bottomRight,
                                                 colors: [
                                                   globals.buttoncolor1,
                                                   globals.buttoncolor2,
                                                 ],
                                               ),
                                             ),
                                             child: _isClickOnSubmit ?
                                               Container(
                                                 color: Colors.white,
                                                 child: Padding(
                                                   padding: EdgeInsets.only(right: 14),
                                                   child: CupertinoActivityIndicator(
                                                     radius: 12,
                                                   ),
                                                 ),
                                               )
                                              : MaterialButton(
                                               splashColor: Colors.grey,
                                               child: Text(
                                                 "Submit",
                                                 style: TextStyle(
                                                   color: AllCoustomTheme.getTextThemeColors(),
                                                   fontSize: ConstanceData.SIZE_TITLE18,
                                                   fontWeight: FontWeight.bold,
                                                 ),
                                               ),
                                               onPressed: () async {
                                                 _submit();
                                               },
                                             ),
                                           ),
                                         ),
                                       ),
                                     ),
                                   ],
                                 ),
                               )*/
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(),
                    ),
                  ),
                ),
              ),
            ))
      ],
    );
  }

  _submit() async {
    setState(() {
      _isClickOnSubmit = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    if (_addEditQusFormKey.currentState.validate() == false) {
      setState(() {
        _isClickOnSubmit = false;
      });
      return;
    }

    var tempField = {
      "callingFrom": "add",
      "title": _qusTitleController.text,
      "body": _qusBodyController.text,
      "tags": itemList,
    };

    setState(() {
      _isClickOnSubmit = false;
    });

    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (BuildContext context) => QusView(allParams: tempField),
      ),
    );
  }

  String _validateTitle(value) {
    if (value.isEmpty) {
      return "Title cannot be empty";
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
/*      case SmartTextType.BOLD:
        return EdgeInsets.fromLTRB(16, 24, 16, 8);
        break;*/
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

class SmartTextField extends StatelessWidget {
  const SmartTextField({Key key, this.type, this.controller, this.focusNode})
      : super(key: key);

  final SmartTextType type;
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        focusNode: focusNode,
        autofocus: true,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        cursorColor: Colors.teal,
        textAlign: type.align,
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixText: type.prefix,
            prefixStyle: type.textStyle,
            isDense: true,
            contentPadding: type.padding),
        style: type.textStyle);
  }
}

class Toolbar extends StatelessWidget {
  const Toolbar({Key key, this.onSelected, this.selectedType})
      : super(key: key);

  final SmartTextType selectedType;
  final ValueChanged<SmartTextType> onSelected;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(56),
      child: Material(
          elevation: 4.0,
          color: AllCoustomTheme.boxColor(),
          child: Row(children: <Widget>[
            InkWell(
              onTap: () {
                onSelected(SmartTextType.ITALIC);
              },
              child: Container(
                child: Icon(
                  FontAwesomeIcons.italic,
                  color: selectedType == SmartTextType.ITALIC
                      ? Colors.teal
                      : Colors.grey,
                  size: MediaQuery.of(context).size.width * 0.05,
                ),
              ),
            ),
            IconButton(
                icon: Icon(
                  FontAwesomeIcons.bold,
                  color: selectedType == SmartTextType.BOLD
                      ? Colors.teal
                      : Colors.grey,
                  size: MediaQuery.of(context).size.width * 0.05,
                ),
                onPressed: () => onSelected(SmartTextType.BOLD)),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.link,
                color: Colors.grey,
                size: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.virus,
                color: Colors.grey,
                size: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.book,
                color: Colors.grey,
                size: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.fileVideo,
                color: Colors.grey,
                size: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.image,
                color: Colors.grey,
                size: MediaQuery.of(context).size.width * 0.05,
              ),
            )
          ])),
    );
  }
}

class EditorProvider extends ChangeNotifier {
  List<FocusNode> _nodes = [];
  List<TextEditingController> _text = [];
  List<SmartTextType> _types = [];
  SmartTextType selectedType;

  EditorProvider({SmartTextType defaultType = SmartTextType.T}) {
    selectedType = defaultType;
    insert(index: 0);
  }

  int get length => _text.length;

  int get focus => _nodes.indexWhere((node) => node.hasFocus);

  FocusNode nodeAt(int index) => _nodes.elementAt(index);

  TextEditingController textAt(int index) => _text.elementAt(index);

  SmartTextType typeAt(int index) => _types.elementAt(index);

  void setType(SmartTextType type) {
    if (selectedType == type) {
      selectedType = SmartTextType.T;
    } else {
      selectedType = type;
    }
    _types.removeAt(focus);
    _types.insert(focus, selectedType);
    notifyListeners();
  }

  void setFocus(SmartTextType type) {
    selectedType = type;
    notifyListeners();
  }

  void insert({int index, String text, SmartTextType type = SmartTextType.T}) {
    /*final TextEditingController controller = TextEditingController(
        text: text?? ''
    );
    controller.addListener(() {
      // TODO
    });
    _text.insert(index, controller);
    _types.insert(index, type);
    _nodes.insert(index, FocusNode());*/

    final TextEditingController controller =
        TextEditingController(text: '\u200B' + (text ?? ''));
    controller.addListener(() {
      if (!controller.text.startsWith('\u200B')) {
        final int index = _text.indexOf(controller);
        if (index > 0) {
          textAt(index - 1).text += controller.text;
          textAt(index - 1).selection = TextSelection.fromPosition(TextPosition(
              offset: textAt(index - 1).text.length - controller.text.length));
          nodeAt(index - 1).requestFocus();
          _text.removeAt(index);
          _nodes.removeAt(index);
          _types.removeAt(index);
          notifyListeners();
        }
      }
      if (controller.text.contains('\n')) {
        final int index = _text.indexOf(controller);
        List<String> _split = controller.text.split('\n');
        controller.text = _split.first;
        insert(
            index: index + 1,
            text: _split.last,
            type: typeAt(index) == SmartTextType.BULLET
                ? SmartTextType.BULLET
                : SmartTextType.T);
        textAt(index + 1).selection =
            TextSelection.fromPosition(TextPosition(offset: 1));
        nodeAt(index + 1).requestFocus();
        notifyListeners();
      }
    });

    _text.insert(index, controller);
    _types.insert(index, type);
    _nodes.insert(index, FocusNode());
  }
}
