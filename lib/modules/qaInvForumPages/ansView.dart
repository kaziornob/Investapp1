import 'dart:convert';

import 'package:animator/animator.dart';
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/qaInvForumPages/qusDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class AnsView extends StatefulWidget {

  final allParams;

  const AnsView({Key key, @required this.allParams}) : super(key: key);

  @override
  _AnsViewState createState() => _AnsViewState();
}

class _AnsViewState extends State<AnsView> {
  bool _isAnsViewInProgress = false;
  bool _isAnsViewClickOnSubmit = false;
  ApiProvider request = new ApiProvider();


  @override
  void initState() {
    super.initState();
    loadDetails();
  }

  loadDetails() async {
    setState(() {
      _isAnsViewInProgress = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      _isAnsViewInProgress = false;
    });
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
                inAsyncCall: _isAnsViewInProgress,
                opacity: 0,
                progressIndicator: CupertinoActivityIndicator(
                  radius: 12,
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 16),
                    child: !_isAnsViewInProgress
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
                            Visibility(
                              visible: widget.allParams['callingFrom']=="add" ? true : false,
                              child: Container(
                                height: 25,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: AllCoustomTheme.getThemeData()
                                      .textSelectionColor,
                                  border: new Border.all(
                                      color: Colors.white, width: 1.0),
                                ),
                                child: _isAnsViewClickOnSubmit ? Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 14),
                                    child: CupertinoActivityIndicator(
                                      radius: 12,
                                    ),
                                  ),
                                )  : MaterialButton(
                                  splashColor: Colors.grey,
                                  child: Text(
                                    "Post",
                                    style: TextStyle(
                                      color: AllCoustomTheme
                                          .getTextThemeColors(),
                                      fontSize: ConstanceData.SIZE_TITLE12,
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
                          height: 40,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    "${widget.allParams['body']}",
                                    style: new TextStyle(
                                      color: AllCoustomTheme.getTextThemeColors(),
                                      fontSize: ConstanceData.SIZE_TITLE16,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // answer attributes section
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: CircleAvatar(
                                    radius: 12.0,
                                    backgroundImage: new AssetImage('assets/download.jpeg'),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                                Container(
                                  child: new Text(
                                    "0",
                                    style: TextStyle(
                                      color: Colors.white,
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
                                      color: Colors.white,
                                      fontSize: ConstanceData.SIZE_TITLE14,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20.0),
                                  child: Icon(
                                    Icons.add,
                                    color: AllCoustomTheme.getTextThemeColors(),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20.0),
                                  child: Icon(
                                    Icons.arrow_upward,
                                    color: AllCoustomTheme.getThemeData().textSelectionColor,
                                  ),
                                ),
                                Container(
                                  child: new Text(
                                    "0",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ConstanceData.SIZE_TITLE14,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20.0),
                                  child: Icon(
                                    Icons.arrow_downward,
                                    color: AllCoustomTheme.getThemeData().textSelectionColor,
                                  ),
                                ),
                                Container(
                                  child: new Text(
                                    "0",
                                    style: TextStyle(
                                      color: Colors.white,
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
                        ),
                      ],
                    )
                        : SizedBox(),
                  ),
                ),
              ),
            )
        )
      ],
    );
  }

  _submit () async
  {
    var tempJsonReq = {"question_id":"${widget.allParams['qusID']}","answer":"${widget.allParams['body']}"};
    print("create answer tempJsonReq: $tempJsonReq");
    String jsonReq = json.encode(tempJsonReq);

    var jsonReqResp = await request.postSubmit('forum/create_answer',jsonReq);
    var result = json.decode(jsonReqResp.body);

    print("ans add/edit response: $result");

    if(jsonReqResp.statusCode == 200 || jsonReqResp.statusCode == 201)
    {

      if (result!=null && result.containsKey('auth') && result['auth']==true)
      {
        // ${result['message']}
        Toast.show("Answer added successfully", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM);

        setState(() {
          _isAnsViewClickOnSubmit = false;
        });

/*        var tempField = {
          "id":"31",
          "title": "",
          "body": "Is now a good time to add to one’s Apple holdings or wait for a sell-off given sharp rally recently?",
          "tags": [],
        };

        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (BuildContext context) =>
                QusDetail(allParams : tempField),
          ),
        );*/
      }
    }
    else if(result!=null && result.containsKey('auth') && result['auth']!=true)
    {

      Toast.show("oops! answer not added", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM);

      setState(() {
        _isAnsViewClickOnSubmit = false;
      });
    }
    else{
      setState(() {
        _isAnsViewClickOnSubmit = false;
      });
      Toast.show("Something went wrong!", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM);
    }
  }
}
