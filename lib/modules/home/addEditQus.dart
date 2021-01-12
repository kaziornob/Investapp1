import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:html_editor/html_editor.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class AddEditQus extends StatefulWidget {
  @override
  _AddEditQusState createState() => _AddEditQusState();
}

class _AddEditQusState extends State<AddEditQus> {
  bool _isInProgress = false;
  List tagList = List();
  bool tagListVisible = false;
  List<TagData> itemList = List();
  TextEditingController _searchController = TextEditingController();
  TextEditingController _qusTitleController = TextEditingController();
  // GlobalKey<HtmlEditorState> keyEditor = GlobalKey();



  List<dynamic> relatedQusList = <dynamic>[
    {"qusText": "Is now a good time to add to one’s Apple holdings or wait for a sell-off given sharp rally recently? ", "measure": "741 XP"},
    {"qusText": "Apple stocks over Microsoft given the current market situation?", "measure": "716 XP"},
    {"qusText": "tat 1 anna", "measure": "488 XP"}
  ];

  @override
  void initState() {
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
              children: [
                Container(
                  child: CircleAvatar(
                    radius: 12.0,
                    backgroundImage: new AssetImage('assets/download.jpeg'),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                SizedBox(
                  width: 4,
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
                SizedBox(
                  width: 8,
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
                SizedBox(
                  width: 50,
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
        Scaffold(
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
                            height: appBarheight,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Animator(
                                  tween: Tween<Offset>(
                                      begin: Offset(0, 0), end: Offset(0.2, 0)),
                                  duration: Duration(milliseconds: 500),
                                  cycles: 0,
                                  builder: (anim) => FractionalTranslation(
                                    translation: anim.value,
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color:
                                          AllCoustomTheme.getTextThemeColors(),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 190),
                                  height: 30,
                                  width: 160,
                                  decoration: BoxDecoration(
                                    color: AllCoustomTheme.getThemeData()
                                        .textSelectionColor,
                                    border: new Border.all(
                                        color: Colors.white, width: 1.5),
                                  ),
                                  child: MaterialButton(
                                    splashColor: Colors.grey,
                                    child: Text(
                                      "Preview",
                                      style: TextStyle(
                                        color: AllCoustomTheme
                                            .getTextThemeColors(),
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        CupertinoPageRoute(
                                          builder: (BuildContext context) =>
                                              AddEditQus(),
                                        ),
                                      );
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: CircleAvatar(
                                  radius: 15.0,
                                  backgroundImage:
                                      new AssetImage('assets/download.jpeg'),
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: AllCoustomTheme.boxColor(),
                                  ),
                                  child: TextFormField(
                                    maxLines: 2,
                                    controller: _qusTitleController,
                                    style: TextStyle(
                                      fontSize: ConstanceData.SIZE_TITLE16,
                                      color:
                                          AllCoustomTheme.getTextThemeColors(),
                                    ),
                                    cursorColor:
                                        AllCoustomTheme.getTextThemeColors(),
                                    onChanged: (value) {},
                                    decoration: InputDecoration(
                                      hintText: 'Title of your question',
                                      hintStyle: TextStyle(
                                        fontSize: ConstanceData.SIZE_TITLE16,
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
                              visible: _qusTitleController.text!=null && _qusTitleController.text!="",
                              child: Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                          color: AllCoustomTheme.boxColor(),
                                        ),
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height *
                                            0.03,
                                        child: Text(
                                          'Related Questions:',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: ConstanceData.SIZE_TITLE16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ),

                          Visibility(
                            visible: _qusTitleController.text!=null && _qusTitleController.text!="",
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                        color: AllCoustomTheme.boxColor(),
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height *
                                          0.35,
                                      child: getRelatedQusView(
                                          relatedQusList),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _qusTitleController.text!=null && _qusTitleController.text!="",
                            child: SizedBox(
                                height: 30,
                              ),
                          ),
                          // ques body section
/*                          HtmlEditor(
                            height: 300.0,
                            key: keyEditor,
                            showBottomToolbar: false,
                            hint: 'Type your question here..',
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              color: AllCoustomTheme.boxColor(),
                            ),
//                          sessionId: sessionId,
//                          apiUrl: GlobalInstance.apiBaseUrl,
                          ),*/
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: AllCoustomTheme.boxColor(),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Type your question here..',
                                hintStyle: TextStyle(
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                    color:
                                        AllCoustomTheme.getTextThemeColors()),
                                labelStyle: TextStyle(
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                    color:
                                        AllCoustomTheme.getTextThemeColors()),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // question Tags
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Search Question Tags',
                                style: TextStyle(
                                  color: AllCoustomTheme.getTextThemeColors(),
                                  fontSize: ConstanceData.SIZE_TITLE16,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 8.0),
                                child: TypeAheadFormField(
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                          controller: _searchController,
                                          textInputAction: TextInputAction.done,
                                          textAlign: TextAlign.start,
                                          keyboardType: TextInputType.text,
                                          maxLines: 1,
                                          style: TextStyle(fontSize: 16.0),
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(30)
                                          ],
                                          decoration: InputDecoration(
                                            hintText: 'Search Question Tags',
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.0,
                                                    color: AllCoustomTheme
                                                        .getTextThemeColors()),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(0.0))),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 1.0),
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
                                          onSubmitted: (value) {
                                            setState(() {
                                              itemList.add(TagData(
                                                  _searchController.text,
                                                  _searchController.text));
                                              tagListVisible =
                                                  itemList.length == 0
                                                      ? false
                                                      : true;
                                            });
                                            _searchController.text = '';
                                          }),
                                  suggestionsCallback: (pattern) {
                                    if (pattern.toString().trim().length < 2) {
                                      return null;
                                    } else {
                                      return searchItems(pattern);
                                    }
                                  },
                                  itemBuilder: (context, suggestion) {
                                    if (_searchController.text.isNotEmpty) {
                                      return ListTile(
                                        title: Text(suggestion['tag']),
                                      );
                                    } else
                                      return Container();
                                  },
                                  transitionBuilder:
                                      (context, suggestionsBox, controller) {
                                    return suggestionsBox;
                                  },
                                  onSuggestionSelected: (suggestion) {
                                    _searchController.text = '';
                                    setState(() {
                                      itemList.add(TagData(suggestion['_id'],
                                          suggestion['tag']));
                                      tagListVisible =
                                          itemList.length == 0 ? false : true;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          /////////////question Tag list////////
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                  visible: tagListVisible,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      'Question Tags',
                                      style: TextStyle(
                                        color: AllCoustomTheme
                                            .getTextThemeColors(),
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                      ),
                                    ),
                                  )),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 8.0,
                                    bottom: tagListVisible ? 24.0 : 0.0),
                                child: StaggeredGridView.countBuilder(
                                  itemCount:
                                      itemList != null ? itemList.length : 0,
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
                                            horizontal: 10.0, vertical: 8.0),
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
                                                    fontStyle: FontStyle.normal,
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
                                                    itemList.removeAt(index);
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
                        ],
                      )
                    : SizedBox(),
              ),
            ),
          ),
        )
      ],
    );
  }
}
