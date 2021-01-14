import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class QusView extends StatefulWidget {

  final allParams;

  const QusView({Key key, @required this.allParams}) : super(key: key);

  @override
  _QusViewState createState() => _QusViewState();
}

class _QusViewState extends State<QusView> {
  bool _isInProgress = false;

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
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();
    double appBarheight = appBar.preferredSize.height;
    return Stack(
      children: <Widget>[
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
                          child: Animator(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.decelerate,
                            cycles: 1,
                            builder: (anim) => Transform.scale(
                              scale: anim.value,
                              child: Text(
                                  widget.allParams['title'].length==28 ? "${(widget.allParams['title'].substring(0, 28) + '...')}" : "${widget.allParams['title']}",
                                style: TextStyle(
                                  color: AllCoustomTheme.getTextThemeColors(),
                                  fontSize: ConstanceData.SIZE_TITLE16,
                                ),
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
                            child: MaterialButton(
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
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    // title section
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "${widget.allParams['title']}",
                            style: TextStyle(
                              color: AllCoustomTheme.getTextThemeColors(),
                              fontSize: ConstanceData.SIZE_TITLE16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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
                        Divider(
                          color: Colors.grey,
                        ),
                      ],
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
