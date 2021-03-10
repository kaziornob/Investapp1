import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AllQusList extends StatefulWidget {
  @override
  _AllQusListState createState() => _AllQusListState();
}

class _AllQusListState extends State<AllQusList> {

  bool _isAllQusInProgress = false;

  List qusList = [
    {
      "id": 1,
      "qus": "Is Apple a good buy?"
    },
    {
      "id": 2,
      "qus": "Is Mukesh key for Reliance stock?"
    },
    {
      "id": 3,
      "qus": "Netflix"
    },
    {
      "id": 3,
      "qus": "Netflix"
    },
    {
      "id": 3,
      "qus": "Netflix"
    },
    {
      "id": 3,
      "qus": "Netflix"
    },
    {
      "id": 1,
      "qus": "Is Apple a good buy?"
    },
    {
      "id": 1,
      "qus": "Is Apple a good buy?"
    },
    {
      "id": 1,
      "qus": "Is Apple a good buy?"
    },
    {
      "id": 3,
      "qus": "Netflix"
    },
    {
      "id": 3,
      "qus": "Netflix"
    },
  ];

  Widget getQuestionsList(data) {
    if (data != null && data.length != 0) {
      return new ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // question section
              GestureDetector(
                onTap: () {
/*
                  var tempField = {
                    "id": "${data[index]['id']}",
                    "title": "${data[index]['title']}",
                    "body": "${data[index]['question']}",
                    "vote": "${data[index]['vote']}",
                    "view": "${data[index]['view']}",
                    "totalAns": "${data[index]['no. of answer']}",
                    "tags": tagFinalData,
                  };

                  print("QusDetail tempField: $tempField");
                  // data[index]
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (BuildContext context) =>
                          QusDetail(allParams: tempField),
                    ),
                  );*/
                },
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Icon(
                        Icons.circle,
                        color: AllCoustomTheme.getsecoundTextThemeColor(),
                        size: 8,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Text(
                            "${data[index]['qus']}",
                            style: TextStyle(
                                color: AllCoustomTheme.getNewSecondTextThemeColor(),
                                fontSize: ConstanceData.SIZE_TITLE16,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                letterSpacing: 0.2),
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
/*              // question attributes section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    child: CircleAvatar(
                      radius: 13.5,
                      backgroundImage: new AssetImage('assets/download.jpeg'),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:3.0),
                    child: new Text(
                      "10K",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ConstanceData.SIZE_TITLE14,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    child: Icon(
                      Icons.comment_bank_sharp,
                      color: AllCoustomTheme.getTextThemeColor(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:2.0),
                    child: new Text(
                      "${data[index]['no. of answer']}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ConstanceData.SIZE_TITLE14,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    child: Icon(
                      Icons.remove_red_eye_outlined,
                      color: AllCoustomTheme.getTextThemeColor(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:3.0),
                    child: new Text(
                      data[index]['view']!=null ?  "${data[index]['view']}" : '0',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ConstanceData.SIZE_TITLE14,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    child: Icon(
                      Icons.add,
                      color: AllCoustomTheme.getTextThemeColor(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:3.0),
                    child: new Text(
                      "100",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ConstanceData.SIZE_TITLE14,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    child: Icon(
                      Icons.arrow_upward,
                      color: AllCoustomTheme.getThemeData().textSelectionColor,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:3.0),
                    child: new Text(
                      "${data[index]['vote']}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ConstanceData.SIZE_TITLE14,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    child: Icon(
                      Icons.arrow_downward,
                      color: AllCoustomTheme.getTextThemeColor(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              //tags section
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: StaggeredGridView.countBuilder(
                  itemCount: tagFinalData!=null && tagFinalData.length!=0 ? tagFinalData.length : 0,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  shrinkWrap: true,
                  staggeredTileBuilder: (int tagIndex) => StaggeredTile.fit(1),
                  itemBuilder: (context, tagIndex) {
                    return Container(
                        decoration: BoxDecoration(
                            color: AllCoustomTheme.getThemeData()
                                .textSelectionColor,
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                                color: AllCoustomTheme.getThemeData()
                                    .textSelectionColor,
                                width: 1.0)),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                tagFinalData[tagIndex]['tag'],
                                style: TextStyle(
                                    color: AllCoustomTheme.getTextThemeColor(),
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.normal,
                                    height: 1.3),
                              ),
                            ),
                          ],
                        ));
                  },
                ),
              ),*/
              Divider(
                color: Colors.grey,
              )
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
              color: AllCoustomTheme.getTextThemeColor(),
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
              backgroundColor: AllCoustomTheme.getBodyContainerThemeColor(),
              body: ModalProgressHUD(
                inAsyncCall: _isAllQusInProgress,
                opacity: 0,
                progressIndicator: CupertinoActivityIndicator(
                  radius: 12,
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 16),
                    child: !_isAllQusInProgress
                        ? Column(
                      children: <Widget>[
                        SizedBox(
                          height: 40,
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
                                tween: Tween<Offset>(begin: Offset(0, 0), end: Offset(0.2, 0)),
                                duration: Duration(milliseconds: 500),
                                cycles: 0,
                                builder: (anim) => FractionalTranslation(
                                  translation: anim.value,
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: AllCoustomTheme.getTextThemeColor(),
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
                                    'All Question',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AllCoustomTheme.getTextThemeColor(),
                                      fontWeight: FontWeight.bold,
                                      fontSize: ConstanceData.SIZE_TITLE20,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height * 0.80,
                                  child: Scrollbar(
                                    child: getQuestionsList(qusList),
                                  )),
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
}
