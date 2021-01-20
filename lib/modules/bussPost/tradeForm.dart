import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class TradeForm extends StatefulWidget {

  @override
  _TradeFormState createState() => _TradeFormState();
}

class _TradeFormState extends State<TradeForm> {
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
                  child: !_isInProgress
                      ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*1.2,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Row(
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
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),//or 15.0
                                    child: Container(
                                      height: 50.0,
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
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "GREEN",
                                                  style: new TextStyle(
                                                    color: AllCoustomTheme.getTextThemeColors(),
                                                    fontSize: ConstanceData.SIZE_TITLE16,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "|",
                                                  style: new TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: ConstanceData.SIZE_TITLE14,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Green Motors, Inc",
                                                  style: new TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: ConstanceData.SIZE_TITLE14,
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "854.41",
                                                  style: new TextStyle(
                                                    color: AllCoustomTheme.getTextThemeColors(),
                                                    fontSize: ConstanceData.SIZE_TITLE16,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "4.97 (0.57%)",
                                                  style: new TextStyle(
                                                    color: Colors.lightGreen,
                                                    fontSize: ConstanceData.SIZE_TITLE14,
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "PRICES BY NASDAQ, IN USD",
                                                  style: new TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: ConstanceData.SIZE_TITLE12,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(
                                                  FontAwesomeIcons.timesCircle,
                                                  size: 10,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "MARKET CLOSED",
                                                  style: new TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: ConstanceData.SIZE_TITLE10,
                                                  ),
                                                ),
                                              ],
                                            )
                                        )
                                      ],
                                    )
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "SET RATE",
                                  style: new TextStyle(
                                    color: AllCoustomTheme.getTextThemeColors(),
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                  ),
                                ),
                                SizedBox(
                                  width: 185,
                                ),
                                Icon(
                                  FontAwesomeIcons.arrowsAlt,
                                  size: 15,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "RATE",
                                  style: new TextStyle(
                                    color: Colors.blue,
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                  ),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 40.0,
                                  width: 330.0,
                                  color: AllCoustomTheme.boxColor(),
                                  child:  TextFormField(
                                    readOnly: true,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: ConstanceData.SIZE_TITLE14,
                                    ),
                                    initialValue: "At Market",

                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "AMOUNT",
                                  style: new TextStyle(
                                    color: AllCoustomTheme.getTextThemeColors(),
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                  ),
                                ),
                                SizedBox(
                                  width: 185,
                                ),
                                Icon(
                                  FontAwesomeIcons.arrowsAlt,
                                  size: 15,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "UNITS",
                                  style: new TextStyle(
                                    color: Colors.blue,
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                  ),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 32,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: AllCoustomTheme.getThemeData().textSelectionColor,
                                    border: new Border.all(color: Colors.white, width: 1.0),
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.only(left: 5.0),
                                    icon: Icon(
                                      FontAwesomeIcons.minus,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                    onPressed: (){

                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 35.0,
                                  width: 225.0,
                                  color: AllCoustomTheme.boxColor(),
                                  child:  TextFormField(
                                    readOnly: true,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: ConstanceData.SIZE_TITLE14,
                                    ),
                                    initialValue: "0",
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 32,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: AllCoustomTheme.getThemeData().textSelectionColor,
                                    border: new Border.all(color: Colors.white, width: 1.0),
                                  ),
                                  child: IconButton(
                                    // splashColor: Colors.grey,
                                    padding: EdgeInsets.only(left: 5.0),
                                    icon: Icon(
                                      FontAwesomeIcons.plus,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                    onPressed: (){

                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  "5.85 UNITS | " + "EXPOSURE " + '\$' + '5,000.00',
                                  style: new TextStyle(
                                    color: Colors.grey,
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 90,
                                ),
                                Text(
                                  "5.00% OF EQUITY",
                                  style: new TextStyle(
                                    color: Colors.grey,
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0,right: 5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AllCoustomTheme.getsecoundTextThemeColor(),
                                border: new Border.all(color: AllCoustomTheme.getsecoundTextThemeColor(), width: 1.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 5.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                "NO Sl",
                                                style: new TextStyle(
                                                  color: Colors.red,
                                                  fontSize: ConstanceData.SIZE_TITLE16,
                                                ),
                                              ),
                                              Text(
                                                "STOP LOSS",
                                                style: new TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: ConstanceData.SIZE_TITLE16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        Container(
                                          child: Column(
                                            children: [
                                              Text(
                                                "X1",
                                                style: new TextStyle(
                                                  color: Colors.red,
                                                  fontSize: ConstanceData.SIZE_TITLE16,
                                                ),
                                              ),
                                              Text(
                                                "LEVERAGE",
                                                style: new TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: ConstanceData.SIZE_TITLE16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        Container(
                                          child: Column(
                                            children: [
                                              Text(
                                                '\$' + "49,999.85",
                                                style: new TextStyle(
                                                  color: Colors.lightGreen,
                                                  fontSize: ConstanceData.SIZE_TITLE16,
                                                ),
                                              ),
                                              Text(
                                                "TAKE PROFIT",
                                                style: new TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: ConstanceData.SIZE_TITLE16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                    child: Divider(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 15.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          "YOU ARE BUYING THE UNDERLYING ASSET",
                                          style: new TextStyle(
                                            color: AllCoustomTheme.getTextThemeColors(),
                                            fontSize: ConstanceData.SIZE_TITLE16,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          "COMMISSION FREE",
                                          style: new TextStyle(
                                            color: Colors.blue,
                                            fontSize: ConstanceData.SIZE_TITLE16,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "NOTE: YOUR TRADE WILL BE EXECUTED ONCE THE MARKET OPENS",
                                    style: new TextStyle(
                                      color: AllCoustomTheme.getTextThemeColors(),
                                      fontSize: ConstanceData.SIZE_TITLE14,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 70,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20, left: 14, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 50,
                                  child: Animator(
                                    tween: Tween<double>(begin: 0.8, end: 1.1),
                                    curve: Curves.easeInToLinear,
                                    cycles: 0,
                                    builder: (anim) => Transform.scale(
                                      scale: anim.value,
                                      child: Container(
                                        height: 50,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          border: new Border.all(color: Colors.white, width: 1.5),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              globals.buttoncolor1,
                                              globals.buttoncolor2,
                                            ],
                                          ),
                                        ),
                                        child: MaterialButton(
                                          splashColor: Colors.grey,
                                          child: Text(
                                            "SET ORDER",
                                            style: TextStyle(
                                              color: AllCoustomTheme.getTextThemeColors(),
                                              fontSize: ConstanceData.SIZE_TITLE18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onPressed: () async {

                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                  )
                      : SizedBox(),
                ),
              ),
            )
        )
      ],
    );
  }
}