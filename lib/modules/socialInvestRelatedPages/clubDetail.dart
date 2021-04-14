import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ClubDetail extends StatefulWidget {
  final allField;
  const ClubDetail({Key key, @required this.allField}) : super(key: key);

  @override
  _ClubDetailState createState() => _ClubDetailState();
}

class _ClubDetailState extends State<ClubDetail> {

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
          backgroundColor: AllCoustomTheme.getBodyContainerThemeColor(),
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
                                '#${widget.allField["name"]}',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color(0xfffec20f),
                                  fontFamily: "Roboto",
                                  fontSize: ConstanceData.SIZE_TITLE20,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5,right: 5.0),
                      child: Container(
                        // color: Colors.white,
                        child: Image(
                          image: AssetImage('assets/weeklyAuroBadge.png'),
                          fit: BoxFit.fill,
                          height: 180,
                          width: 230,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5,right: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    'Investment Philosophy:  ${widget.allField["text1"]}',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: AllCoustomTheme.getTextThemeColor(),
                                      fontSize: ConstanceData.SIZE_TITLE18,
                                      fontFamily: "Rasa",
                                    ),
                                  ),
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5,right: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    'Investment Track record:  ${widget.allField["text2"]}',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color:Colors.black,
                                      fontSize: ConstanceData.SIZE_TITLE18,
                                      fontFamily: "Rasa",

                                    ),
                                  ),
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
      ],
    );
  }
}
