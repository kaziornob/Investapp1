import 'dart:convert';

import 'package:animator/animator.dart';
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/global.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/qaInvForumPages/addEditAnswer.dart';
import 'package:auroim/modules/qaInvForumPages/ansDetail.dart';
import 'package:auroim/modules/settings/user_profile_page.dart';
import 'package:auroim/provider_abhinav/user_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class QusDetail extends StatefulWidget {
  final allParams;
  static var qusInfo;

  const QusDetail({Key key, @required this.allParams}) : super(key: key);

  @override
  _QusDetailState createState() => _QusDetailState();
}

class _QusDetailState extends State<QusDetail> {
  bool _isQusDetailInProgress = false;
  ApiProvider request = new ApiProvider();

  List<dynamic> answerList = [];

  @override
  void initState() {
    super.initState();
    getData();
    loadDetails();
  }

  approveAnswerWithMaxVotes() async {
    // if questions doesn't have an approved answer and has been 2 weeks
    // since posted then approve the highest voted answer
    if (widget.allParams["is_approved"] == 0 &&
        DateTime.now().difference(DateTime.parse(widget.allParams["date"])) >
            Duration(days: 14)) {
      await request.postSubmit(
        'forum/assign_bounty',
        json.encode({"question_id": widget.allParams["id"]}),
      );
    }
  }

  approveAnswer(answerId) async {
    // aaprove answer by question poster
    await request.postSubmit(
      'forum/assign_bounty_approve',
      json.encode({"a_id": answerId}),
    );
    await request.postSubmit(
      'forum/approve_answer',
      json.encode({"a_id": answerId}),
    );
  }

  loadDetails() async {
    setState(() {
      _isQusDetailInProgress = true;
    });
    // await Future.delayed(const Duration(milliseconds: 700));
    await approveAnswerWithMaxVotes();
    setState(() {
      _isQusDetailInProgress = false;
    });
  }

  Future<void> getData() async {
    var response = await request
        .getRequest('forum/get_answer?qid=${widget.allParams["id"]}');
    print("qus detail: $response");
    if (response != null && response != false) {
      setState(() {
        answerList = response['message']['answer'];
        QusDetail.qusInfo = response['message'];
      });
    }
  }

  Widget getAnswerList(data) {
    if (data != null && data.length != 0) {
      return new ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (context, index) {
          print(data[index]["is_approved"] == 1);
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  var tempField = {
                    "id": "${data[index]['id']}",
                    "body": "${data[index]['ans']}",
                    "vote": "${data[index]['votes']}",
                    "date": "${data[index]['date_time']}",
                    "email": data[index]["email"],
                    "username": data[index]["username"],
                    "is_approved": data[index]["is_approved"],
                    "user_score": data[index]["user_score"],
                  };
                  // data[index]
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (BuildContext context) =>
                          AnsDetail(allParams: tempField),
                    ),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "${data[index]['ans']}",
                        style: new TextStyle(
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: ConstanceData.SIZE_TITLE16,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: Text(
                      "${timeago.format(DateTime.parse(data[index]["date_time"]))}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: ConstanceData.SIZE_TITLE14,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: data[index]["is_approved"] == 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        child: Icon(
                          FontAwesomeIcons.checkDouble,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: (widget.allParams["is_approved"] == 0 &&
                        data[index]["email"] ==
                            Provider.of<UserDetails>(context)
                                .userDetails["email"]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: GestureDetector(
                        onTap: () async {
                          await approveAnswer(data[index]["id"]);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          child: Text(
                            "Approve",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: ConstanceData.SIZE_TITLE14,
                            ),
                          ),
                        ),
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
    } else {
      return Center(
          child: Text(
        "No data available yet",
        textAlign: TextAlign.center,
        style: new TextStyle(
          color: AllCoustomTheme.getTextThemeColors(),
          fontSize: ConstanceData.SIZE_TITLE18,
          fontFamily: "Rasa",
        ),
      ));
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
              backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
              body: ModalProgressHUD(
                inAsyncCall: _isQusDetailInProgress,
                opacity: 0,
                progressIndicator: CupertinoActivityIndicator(
                  radius: 12,
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 16),
                    child: !_isQusDetailInProgress
                        ? Column(
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
                                      duration: Duration(milliseconds: 500),
                                      cycles: 0,
                                      builder: (_, anim, __) =>
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
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          QusDetail.qusInfo == null
                                              ? ""
                                              : "${QusDetail.qusInfo['question']}",
                                          style: new TextStyle(
                                            color: AllCoustomTheme
                                                .getTextThemeColors(),
                                            fontSize:
                                                ConstanceData.SIZE_TITLE16,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  // question attributes section
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UserProfilePage(
                                                email:
                                                    widget.allParams["email"],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          child: CircleAvatar(
                                            radius: 12.0,
                                            backgroundImage: new AssetImage(
                                                'assets/download.jpeg'),
                                            backgroundColor: Colors.transparent,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: new Text(
                                          "${widget.allParams["user_score"]}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                ConstanceData.SIZE_TITLE14,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 20.0),
                                        child: Icon(
                                          Icons.comment_bank_sharp,
                                          color: AllCoustomTheme
                                              .getTextThemeColors(),
                                        ),
                                      ),
                                      Container(
                                        child: new Text(
                                          QusDetail.qusInfo == null
                                              ? ""
                                              : "${QusDetail.qusInfo['no. of answer']}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                ConstanceData.SIZE_TITLE14,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 20.0),
                                        child: Icon(
                                          Icons.remove_red_eye_outlined,
                                          color: AllCoustomTheme
                                              .getTextThemeColors(),
                                        ),
                                      ),
                                      Container(
                                        child: new Text(
                                          // QusDetail.qusInfo['view']!=null ?  "${QusDetail.qusInfo['view']}" : '0',
                                          widget.allParams["view"] != null
                                              ? widget.allParams["view"]
                                              : '0',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                ConstanceData.SIZE_TITLE14,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 20.0),
                                        child: Icon(
                                          Icons.add,
                                          color: AllCoustomTheme
                                              .getTextThemeColors(),
                                        ),
                                      ),
                                      Container(
                                        child: new Text(
                                          "${widget.allParams["bounty"] == null ? 0 : widget.allParams["bounty"]}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                ConstanceData.SIZE_TITLE14,
                                          ),
                                        ),
                                      ),
                                      upvoteDownvoteWidget(),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.45,
                                ),
                                child: Text(
                                  (widget.allParams["date"] != null &&
                                          widget.allParams != null)
                                      ? "${timeago.format(
                                          DateTime.parse(
                                              widget.allParams["date"]),
                                        )}"
                                      : "",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: ConstanceData.SIZE_TITLE14,
                                  ),
                                ),
                              ),
                              //tags section
                              Container(
                                child: StaggeredGridView.countBuilder(
                                  itemCount: widget.allParams['tags'] != null
                                      ? widget.allParams['tags'].length
                                      : 0,
                                  physics: NeverScrollableScrollPhysics(),
                                  crossAxisCount: 5,
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 5.0,
                                  shrinkWrap: true,
                                  staggeredTileBuilder: (int index) =>
                                      StaggeredTile.fit(1),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: AllCoustomTheme.getThemeData()
                                            .textSelectionColor,
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        border: Border.all(
                                          color: AllCoustomTheme.getThemeData()
                                              .textSelectionColor,
                                          width: 1.0,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5.0, vertical: 3.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              '${widget.allParams['tags'][index]['tag']}',
                                              style: TextStyle(
                                                  color: AllCoustomTheme
                                                      .getTextThemeColors(),
                                                  fontSize: ConstanceData
                                                      .SIZE_TITLE14,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.normal,
                                                  height: 1.3),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.045,
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          border: new Border.all(
                                              color: AllCoustomTheme
                                                  .getSeeMoreThemeColor(),
                                              width: 1.5),
                                          color: AllCoustomTheme
                                              .getSeeMoreThemeColor()),
                                      child: MaterialButton(
                                        onPressed: () {
                                          var tempField = {
                                            "id": QusDetail.qusInfo['id'],
                                          };
                                          Navigator.of(context).pushReplacement(
                                            CupertinoPageRoute(
                                              builder: (BuildContext context) =>
                                                  AddEditAnswer(
                                                allParams: widget.allParams,
                                              ),
                                            ),
                                          );
                                        },
                                        splashColor: Colors.grey,
                                        child: Text(
                                          "Add Answer",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                ConstanceData.SIZE_TITLE13,
                                            fontFamily: "Roboto",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 5.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Answers',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color(0xFFD8AF4F),
                                        fontSize: ConstanceData.SIZE_TITLE20,
                                        fontFamily: "Roboto",
                                        package: 'Roboto-Regular',
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.45,
                                          child: Scrollbar(
                                            child: getAnswerList(answerList),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
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

  upvoteDownvoteWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            _updateQusVote('upward', context);
          },
          child: Container(
            margin: EdgeInsets.only(left: 20.0),
            child: Icon(
              Icons.arrow_upward,
              color: AllCoustomTheme.getThemeData().textSelectionColor,
            ),
          ),
        ),
        Container(
          child: Text(
            QusDetail.qusInfo != null ? "${QusDetail.qusInfo['vote']}" : "0",
            style: TextStyle(
              color: Colors.white,
              fontSize: ConstanceData.SIZE_TITLE14,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            _updateQusVote('downward', context);
          },
          child: Container(
            child: Icon(
              Icons.arrow_downward,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  _updateQusVote(from, context) async {
    HelperClass.showLoading(context, null, false);
    var tempIdData = ["question", QusDetail.qusInfo['id']];
    var tempJsonReq = {"id": tempIdData, "vote": from == 'upward' ? 1 : -1};

    print("update vote tempJsonReq: $tempJsonReq");
    String jsonReq = json.encode(tempJsonReq);

    var jsonReqResp =
        await request.postSubmitResponse('forum/update_votes', jsonReq);
    var result = json.decode(jsonReqResp.body);

    print("votes update response: $result");

    if (jsonReqResp.statusCode == 200 || jsonReqResp.statusCode == 201) {
      if (result != null &&
          result.containsKey('auth') &&
          result['auth'] == true &&
          (result["message"]["message"] == "Answerer score updated" ||
              result["message"]["message"] == "New user Created")) {
        var tempVote;
        if (QusDetail.qusInfo['vote'] != null &&
            QusDetail.qusInfo['vote'] != "" &&
            QusDetail.qusInfo['vote'] is String) {
          tempVote = int.parse('${QusDetail.qusInfo['vote']}');
        } else if (QusDetail.qusInfo['vote'] != null &&
            QusDetail.qusInfo['vote'] is int) {
          tempVote = QusDetail.qusInfo['vote'];
        }

        if (from == 'upward') {
          setState(() {
            var intVote = tempVote + 1;
            QusDetail.qusInfo['vote'] = intVote.toString();
          });
        } else {
          setState(() {
            var intVote = tempVote - 1;
            QusDetail.qusInfo['vote'] = intVote.toString();
          });
        }
        Navigator.pop(context);
        Toast.show("Vote updated successfully", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        // instantUpdate(from,result['message']);
      } else {
        Navigator.pop(context);
        Toast.show(result["message"]["message"], context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    } else if (result != null &&
        result.containsKey('auth') &&
        result['auth'] != true) {
      Navigator.pop(context);
      Toast.show("oops! vote not updated", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      Navigator.pop(context);
      Toast.show("Something went wrong!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }
}
