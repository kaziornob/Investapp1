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
    {"id": 1, "qus": "Is Apple a good buy?"},
    {"id": 2, "qus": "Is Mukesh key for Reliance stock?"},
    {"id": 3, "qus": "Netflix"},
    {"id": 3, "qus": "Netflix"},
    {"id": 3, "qus": "Netflix"},
    {"id": 3, "qus": "Netflix"},
    {"id": 1, "qus": "Is Apple a good buy?"},
    {"id": 1, "qus": "Is Apple a good buy?"},
    {"id": 1, "qus": "Is Apple a good buy?"},
    {"id": 3, "qus": "Netflix"},
    {"id": 3, "qus": "Netflix"},
  ];

  Widget getQuestionsList(data) {
    if (data != null && data.length != 0) {
      return new ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Icon(
                    Icons.circle,
                    color: Colors.black,
                    size: 15,
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 10.0,
                    ),
                    child: Text(
                      "${data[index]['qus']}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: ConstanceData.SIZE_TITLE16,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal,
                          letterSpacing: 0.2),
                    ),
                  ),
                ),
              ],
            ),
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
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color:
                                          AllCoustomTheme.getTextThemeColor(),
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
                                height: 40.0,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width -
                                          40,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.80,
                                      child: Scrollbar(
                                        child: getQuestionsList(qusList),
                                      ),
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
            ))
      ],
    );
  }
}
