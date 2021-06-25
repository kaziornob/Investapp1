import 'dart:convert';
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/global.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/qaInvForumPages/related_tags.dart';
import 'package:auroim/modules/settings/user_profile_page.dart';
import 'package:auroim/widgets/animated_widgets/animated_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class AnsDetail extends StatefulWidget {
  final allParams;

  const AnsDetail({Key key, @required this.allParams}) : super(key: key);

  @override
  _AnsDetailState createState() => _AnsDetailState();
}

class _AnsDetailState extends State<AnsDetail> {
  bool _isQusDetailInProgress = false;
  ApiProvider request = new ApiProvider();

  List<dynamic> commentList = [];

  // comment box data member

  TextEditingController _commentTextFieldController = TextEditingController();
  String codeDialog;
  String valueText;

  @override
  void initState() {
    super.initState();
    loadDetails();
    getCommentData();
  }

  loadDetails() async {
    setState(() {
      _isQusDetailInProgress = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      _isQusDetailInProgress = false;
    });
  }

  Future<void> getCommentData() async {
    var response = await request
        .getRequest('forum/get_comment?aid=${widget.allParams["id"]}');
    print("answer comments: $response");
    if (response != null && response != false) {
      setState(() {
        commentList = response['message']['comments'];
      });
    }
  }

  Widget getCommentList(data) {
    if (data != null && data.length != 0) {
      return new ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "${data[index]['comment']}",
                      style: new TextStyle(
                        color: AllCoustomTheme.getTextThemeColors(),
                        fontSize: ConstanceData.SIZE_TITLE16,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  dateCreated(data[index]["date_time"]),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5.0),
                    child: Text(
                      '${data[index]['up votes']}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ConstanceData.SIZE_TITLE14,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5.0),
                    child: Icon(
                      Icons.thumb_up,
                      color: AllCoustomTheme.getThemeData()
                          .textSelectionTheme
                          .selectionColor,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5.0),
                    child: Text(
                      '${data[index]['down votes']}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ConstanceData.SIZE_TITLE14,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5.0),
                    child: Icon(
                      Icons.thumb_down,
                      color: Colors.white,
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
        ),
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
                                  AnimatedBackButton(
                                    color: Colors.white,
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
                                          "${widget.allParams['body']}",
                                          style: TextStyle(
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
                                    height: 20,
                                  ),
                                  // question attributes section
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      GestureDetector(
                                        child: Container(
                                          child: CircleAvatar(
                                            radius: 12.0,
                                            backgroundImage: AssetImage(
                                              'assets/download.jpeg',
                                            ),
                                            backgroundColor: Colors.transparent,
                                          ),
                                        ),
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
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: Container(
                                          child: Text(
                                            "${widget.allParams["user_score"]}",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      noOfComments(),
                                      upvoteDownvoteWidget(),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              dateCreated(widget.allParams["date"]),
                              //tags section
                              RelatedTags(
                                tags: widget.allParams['tags'],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.045,
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                            _addCommentDialogBox(context);
                                          },
                                          splashColor: Colors.grey,
                                          child: Text(
                                            "Add Comment",
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
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Comments',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Color(0xFFD8AF4F),
                                      fontSize: ConstanceData.SIZE_TITLE20,
                                      fontFamily: "Roboto",
                                      package: 'Roboto-Regular',
                                    ),
                                  ),
                                ),
                              ),
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
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.60,
                                        child: Scrollbar(
                                          child: getCommentList(commentList),
                                        ),
                                      ),
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

  dateCreated(date) {
    return Row(
      children: [
        Container(
          child: Text(
            date == null ? "" : "${timeago.format(DateTime.parse(date))}",
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.grey,
              fontSize: ConstanceData.SIZE_TITLE14,
            ),
          ),
        ),
      ],
    );
  }

  noOfComments() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: EdgeInsets.only(left: 20.0),
          child: Icon(
            Icons.comment_bank_sharp,
            color: widget.allParams["is_approved"] == 1
                ? Colors.green
                : AllCoustomTheme.getTextThemeColors(),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 5.0),
          child: Text(
            "${commentList.length}",
            style: TextStyle(
              color: Colors.white,
              fontSize: ConstanceData.SIZE_TITLE14,
            ),
          ),
        ),
      ],
    );
  }

  upvoteDownvoteWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            _updateAnsVote('upward', context);
          },
          child: Container(
            margin: EdgeInsets.only(left: 20.0),
            child: Icon(
              Icons.arrow_upward,
              color: AllCoustomTheme.getThemeData()
                  .textSelectionTheme
                  .selectionColor,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 5.0),
          child: new Text(
            "${widget.allParams['vote']}",
            style: TextStyle(
              color: Colors.white,
              fontSize: ConstanceData.SIZE_TITLE14,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            _updateAnsVote('downward', context);
          },
          child: Container(
            margin: EdgeInsets.only(left: 5.0),
            child: Icon(
              Icons.arrow_downward,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _addCommentDialogBox(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Add Comment',
              style: new TextStyle(
                color: AllCoustomTheme.getTextThemeColor(),
                fontSize: ConstanceData.SIZE_TITLE18,
                fontFamily: "Roboto",
              ),
            ),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _commentTextFieldController,
              style: TextStyle(
                fontSize: ConstanceData.SIZE_TITLE14,
                color: AllCoustomTheme.getTextThemeColor(),
              ),
              decoration: InputDecoration(
                hintText: "Type your comment here...",
                hintStyle: TextStyle(
                    fontSize: ConstanceData.SIZE_TITLE16,
                    color: AllCoustomTheme.getTextThemeColor()),
                labelStyle: TextStyle(
                    fontSize: ConstanceData.SIZE_TITLE14,
                    color: AllCoustomTheme.getTextThemeColor()),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text(
                  'CANCEL',
                  style: TextStyle(
                    fontSize: ConstanceData.SIZE_TITLE12,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontSize: ConstanceData.SIZE_TITLE12,
                  ),
                ),
                onPressed: () {
                  _submitComment();
                  /*setState(() {
                    codeDialog = valueText;
                    Navigator.pop(context);
                  });*/
                },
              ),
            ],
          );
        });
  }

  _submitComment() async {
    var tempJsonReq = {
      "answer_id": "${widget.allParams['id']}",
      "comment": "${_commentTextFieldController.text}"
    };
    print("create comment tempJsonReq: $tempJsonReq");
    String jsonReq = json.encode(tempJsonReq);

    var jsonReqResp =
        await request.postSubmitResponse('forum/create_comment', jsonReq);
    var result = json.decode(jsonReqResp.body);

    print("comment add response: $result");

    if (jsonReqResp.statusCode == 200 || jsonReqResp.statusCode == 201) {
      if (result != null &&
          result.containsKey('auth') &&
          result['auth'] == true) {
        Navigator.pop(context);
        // ${result['message']}
        Toast.show("Comment added successfully", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

        setState(() {
          commentList.add({
            "id": "",
            "comment": "${_commentTextFieldController.text}",
            "votes": 0
          });
        });
      }
    } else if (result != null &&
        result.containsKey('auth') &&
        result['auth'] != true) {
      Toast.show("oops! comment not added", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      Toast.show("Something went wrong!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

/*  void showLoading(jsonReq,from) {
    var sLoadingContext;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext loadingContext) {
        sLoadingContext = loadingContext;
        return Container(
          height: MediaQuery.of(context).size.height* 0.10,
          margin: EdgeInsets.only(top: 50, bottom: 30),
          child: Dialog(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 15.0,bottom: 8.0),
                      child: new CircularProgressIndicator(
                      ),
                    )
                ),
                Padding(padding: EdgeInsets.only(left: 110.0,bottom: 10.0,top: 5.0),
                  child: new Text(
                    "Please wait...",
                    style: new TextStyle(
                      color: AllCoustomTheme.getTextThemeColor(),
                      fontSize: ConstanceData.SIZE_TITLE18,
                      fontFamily: "Rasa",
                    ),
                  ),)
              ],
            ),
          ),
        );
      },
    );
    new Future.delayed(new Duration(seconds: 1), () {
      _updateAnsVote(jsonReq,from);
    });
  }*/

  _updateAnsVote(from, context) async {
    HelperClass.showLoading(context, null, false);

    var tempIdData = ["answer", widget.allParams['id']];
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
        if (widget.allParams['vote'] != null &&
            widget.allParams['vote'] != "" &&
            widget.allParams['vote'] is String) {
          tempVote = int.parse('${widget.allParams['vote']}');
        } else if (widget.allParams['vote'] != null &&
            widget.allParams['vote'] is int) {
          tempVote = widget.allParams['vote'];
        }

        if (from == 'upward') {
          setState(() {
            var intVote = tempVote + 1;
            widget.allParams['vote'] = intVote.toString();
          });
        } else {
          setState(() {
            var intVote = tempVote - 1;
            widget.allParams['vote'] = intVote.toString();
          });
        }
        Navigator.pop(context);
        Toast.show("Vote updated successfully", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
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
