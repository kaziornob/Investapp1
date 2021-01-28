import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/bussPost/wishListDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:modal_progress_hud/modal_progress_hud.dart';

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  bool _isInProgress = false;

  List<dynamic> wishListData = <dynamic>[
    {"name": "green","valuePer": "38.25 (14.72 %)"},
    {"name": "alena","valuePer": "38.25 (14.72 %)"},
    {"name": "tat 1 anna","valuePer": "38.25 (14.72 %)"},
    {"name": "kristie","valuePer": "38.25 (14.72 %)"},
    {"name": "piotr","valuePer": "38.25 (14.72 %)"},
  ];

  @override
  void initState() {
    super.initState();
    loadUserDetails();
  }

  loadUserDetails() async {
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
                                    color: AllCoustomTheme.getTextThemeColors(),
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
                                    'Watch List',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AllCoustomTheme.getTextThemeColors(),
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
                          height: 40,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Container(
                                    child: Text(
                                      "MARKETS",
                                      style: new TextStyle(
                                        color: AllCoustomTheme.getTextThemeColors(),
                                        fontSize: ConstanceData.SIZE_TITLE18,
                                      ),
                                    ),
                                  )
                              ),
                              Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 71.0),
                                    child: Text(
                                      "BUY",
                                      style: new TextStyle(
                                        color: AllCoustomTheme.getTextThemeColors(),
                                        fontSize: ConstanceData.SIZE_TITLE18,
                                      ),
                                    ),
                                  )
                              ),
                              Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 60.0),
                                    child: Text(
                                      "SELL",
                                      style: new TextStyle(
                                        color: AllCoustomTheme.getTextThemeColors(),
                                        fontSize: ConstanceData.SIZE_TITLE18,
                                      ),
                                    ),
                                  )
                              ),

                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height*0.70,
                                  child: Scrollbar(
                                      child: new ListView.builder(
                                        itemCount: wishListData.length,
                                        itemBuilder: (context, index) {
                                          return Card(
                                            color: AllCoustomTheme.getsecoundTextThemeColor(),
                                            child: ListTile(
                                                leading: ClipRRect(
                                                    borderRadius: BorderRadius.circular(5.0),//or 15.0
                                                    child: Container(
                                                      height: 40.0,
                                                      width: 50.0,
                                                      color: Color(0xffFF0E58),
                                                      child:  Image(
                                                        image: AssetImage('assets/buttonBadge.png'),
                                                        fit: BoxFit.fill,
                                                        height: 40,
                                                        width: 50,
                                                      ),
                                                    ),
                                                  ),
                                                subtitle: Text(
                                                  "${wishListData[index]['valuePer']}",
                                                  style: new TextStyle(
                                                    color: AllCoustomTheme.getTextThemeColors(),
                                                    fontSize: ConstanceData.SIZE_TITLE12,
                                                  ),
                                                ),
                                                title: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    InkWell(
                                                      onTap : ()
                                                      {
                                                        Navigator.of(context).push(
                                                          CupertinoPageRoute(
                                                            builder: (BuildContext context) => WishListDetail(),
                                                          ),
                                                        );
                                                      },
                                                      child: Text(
                                                        "${wishListData[index]['name']}",
                                                        style: new TextStyle(
                                                          color: AllCoustomTheme.getTextThemeColors(),
                                                          fontSize: ConstanceData.SIZE_TITLE16,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 30,
                                                    ),
                                                    Container(
                                                      height: 40.0,
                                                      width: 50.0,
                                                      color: AllCoustomTheme.boxColor(),
                                                      child:  TextFormField(
                                                        readOnly: true,
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          color: AllCoustomTheme.getTextThemeColors(),
                                                          fontSize: ConstanceData.SIZE_TITLE14,
                                                        ),
                                                        initialValue: "50",

                                                      ),
                                                    ),
                                                    Container(
                                                      height: 40.0,
                                                      width: 50.0,
                                                      color: AllCoustomTheme.boxColor(),
                                                      child:  TextFormField(
                                                        textAlign: TextAlign.center,
                                                        readOnly: true,
                                                        style: TextStyle(
                                                          color: AllCoustomTheme.getTextThemeColors(),
                                                          fontSize: ConstanceData.SIZE_TITLE14,
                                                        ),
                                                        initialValue: "100",

                                                      ),
                                                    ),

                                                  ],
                                                ),
                                                onTap: () {

                                                }

                                            ),
                                          );
                                        },
                                      )
                                  )
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
        )
      ],
    );
  }
}
