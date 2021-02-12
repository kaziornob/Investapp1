import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class QusDetail extends StatefulWidget {

  final allParams;

  const QusDetail({Key key, @required this.allParams}) : super(key: key);

  @override
  _QusDetailState createState() => _QusDetailState();
}

class _QusDetailState extends State<QusDetail> {
  bool _isQusDetailInProgress = false;

  List<dynamic> answerList = <dynamic>[
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
      _isQusDetailInProgress = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      _isQusDetailInProgress = false;
    });
  }

  Widget getAnswerList(data) {
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
                            // question attributes section
                            Row(
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
                                      color: Colors.white,
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
                                    Icons.remove_red_eye_outlined,
                                    color: AllCoustomTheme.getTextThemeColors(),
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
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20.0),
                                  child: Icon(
                                    Icons.add,
                                    color: AllCoustomTheme.getTextThemeColors(),
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

                                SizedBox(
                                  width: 8,
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

                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.45),
                          child: new Text(
                            "modified 10 sec ago",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: ConstanceData.SIZE_TITLE14,
                            ),
                          ),
                        ),
                        //tags section
                        Container(
                          // margin: EdgeInsets.only(left: 15.0),
                          child: StaggeredGridView.countBuilder(
                            itemCount: widget.allParams['tags'] != null ? widget.allParams['tags'].length : 0,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 4,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                            shrinkWrap: true,
                            staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                            itemBuilder: (context, index){
                              return Container(
                                  decoration: BoxDecoration(
                                      color: AllCoustomTheme.getThemeData().textSelectionColor,
                                      borderRadius: BorderRadius.circular(4.0),
                                      border: Border.all(color: AllCoustomTheme.getThemeData().textSelectionColor, width: 1.0)),
                                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          '${widget.allParams['tags'][index].tag}',
                                          style: TextStyle(
                                              color: AllCoustomTheme.getTextThemeColors(),
                                              fontSize: ConstanceData.SIZE_TITLE16,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.normal,
                                              height: 1.3
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              child: Container(
                                height: MediaQuery.of(context).size.height*0.045,
                                width: MediaQuery.of(context).size.width*0.35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    border: new Border.all(color: AllCoustomTheme.getSeeMoreThemeColor(), width: 1.5),
                                    color: AllCoustomTheme.getSeeMoreThemeColor()
                                ),
                                child: MaterialButton(
                                  splashColor: Colors.grey,
                                  child: Text(
                                    "Add Answer",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ConstanceData.SIZE_TITLE13,
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Container(
                              child: Icon(
                                Icons.star,
                                color: AllCoustomTheme.getTextThemeColors(),
                              ),
                            ),
                            Container(
                              child: new Text(
                                "favorite",
                                style: TextStyle(
                                  color: Colors.white,
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
                                Icons.share,
                                color: AllCoustomTheme.getTextThemeColors(),
                              ),
                            ),
                            Container(
                              child: new Text(
                                "share",
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
                            )
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5,right: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height*0.35,
                                    child: Scrollbar(
                                      child: getAnswerList(
                                          answerList),
                                    )
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
            )
        )
      ],
    );
  }
}
