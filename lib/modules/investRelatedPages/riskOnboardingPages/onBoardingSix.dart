import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/investRelatedPages/riskOnboardingPages/onBoardingSevenMarginApproved.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:modal_progress_hud/modal_progress_hud.dart';


class OnBoardingSix extends StatefulWidget {
  final String callingFrom;
  final String logo;

  const OnBoardingSix({Key key, @required this.callingFrom,this.logo}) : super(key: key);

  @override
  _OnBoardingSixState createState() => _OnBoardingSixState();
}

class _OnBoardingSixState extends State<OnBoardingSix> {
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
                      height: MediaQuery.of(context).size.height*1.4,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
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
                              SizedBox(
                                width: 60,
                              ),
                              Container(
                                  height: MediaQuery.of(context).size.height * 0.12,
                                  margin: EdgeInsets.only(bottom: 10.0),
                                  child: Center(
                                    child: new Image(
                                        width: 200.0,
                                        fit: BoxFit.fill,
                                        image: new AssetImage('assets/logo.png')
                                    ),
                                  )
                              ),
                            ],
                          ),
                          Container(
                              height: MediaQuery.of(context).size.height*0.08,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(top: 20.0,bottom: 20.0,left: 15.0,right: 10.0),
                              child: Center(
                                child: Text(
                                  "What will be your first deposit in to your Auro account?",
                                  style: new TextStyle(
                                      fontFamily: "WorkSansSemiBold",
                                      color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFF000000),
                                      fontSize: 16,
                                      letterSpacing: 0.1
                                  ),
                                ),
                              )
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height*0.20,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: MediaQuery.of(context).size.height*0.05,
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(left: 15.0,right: 5.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height: MediaQuery.of(context).size.height*0.05,
                                        width: MediaQuery.of(context).size.width*0.40,
                                        child: Text(
                                          "One Off Deposit",
                                          style: new TextStyle(
                                              fontFamily: "WorkSansSemiBold",
                                              color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFF000000),
                                              fontSize: 16.0,
                                              letterSpacing: 0.1
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 20.0),
                                        height: MediaQuery.of(context).size.height*0.05,
                                        width: MediaQuery.of(context).size.width*0.44,
                                        decoration: new BoxDecoration(
                                          color: AllCoustomTheme.boxColor(),
                                        ),
                                        child: TextFormField(
                                          style: TextStyle(
                                            color: AllCoustomTheme.getTextThemeColors(),
                                            fontSize: ConstanceData.SIZE_TITLE14,
                                          ),
                                          initialValue: "",

                                        ),
                                      )

                                    ],
                                  ),

                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height*0.05,
                                  width: MediaQuery.of(context).size.width*0.15,
                                  margin: EdgeInsets.only(left: 35.0,right: 5.0,bottom: 10.0),
                                  decoration: new BoxDecoration(
                                    color: AllCoustomTheme.getTextThemeColors(),
                                    border: Border.all(
                                      color: Color(0xFFFFFFFF),
                                      width: 1.2,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50.0),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 30.0,
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height*0.05,
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(left: 15.0,right: 5.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height: MediaQuery.of(context).size.height*0.05,
                                        width: MediaQuery.of(context).size.width*0.40,
                                        child: Text(
                                          "Monthly Deposit",
                                          style: new TextStyle(
                                              fontFamily: "WorkSansSemiBold",
                                              color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFF000000),
                                              fontSize: 16.0,
                                              letterSpacing: 0.1
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 20.0),
                                        height: MediaQuery.of(context).size.height*0.05,
                                        width: MediaQuery.of(context).size.width*0.44,
                                        decoration: new BoxDecoration(
                                          color: AllCoustomTheme.boxColor(),
                                        ),
                                        child: TextFormField(
                                          style: TextStyle(
                                            color: AllCoustomTheme.getTextThemeColors(),
                                            fontSize: ConstanceData.SIZE_TITLE14,
                                          ),
                                          initialValue: "",

                                        ),
                                      )

                                    ],
                                  ),

                                ),

                              ],
                            ),
                          ),
                          Container(
                              height: MediaQuery.of(context).size.height*0.13,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(top: 20.0,bottom: 14.0,left: 10.0,right: 10.0),
                              /*decoration: new BoxDecoration(
                                color: Color(0xFFFFFFFF),
                                border: Border.all(
                                  color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFF000000),
                                  width: 1.2,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(2.0),
                                ),
                              ),*/
                              child: Padding(
                                padding: EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
                                child: Text(
                                  "If you make a monthly deposit of X in addition to your initial deposit, you retums will increase by Y%!",
                                  style: new TextStyle(
                                      fontFamily: "WorkSansSemiBold",
                                      color: AllCoustomTheme.getTextThemeColors(),
                                      fontSize: 16.0,
                                      letterSpacing: 0.1
                                  ),
                                ),
                              )
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height*0.30,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(left: 10.0,right: 10.0),
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: new AssetImage('assets/risk_onboarding_6-_pi_version.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Container(
                              height: MediaQuery.of(context).size.height*0.15,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(left: 10.0,right: 10.0),
                              /*decoration: new BoxDecoration(
                                color: Color(0xFFFFFFFF),
                                border: Border.all(
                                  color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFF000000),
                                  width: 1.2,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(2.0),
                                ),
                              ),*/
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0,right: 10.0),
                                child: Text(
                                  "Solid line: Retum with regular monthly investments Dotted Line: Return with only initial investment Y-axis: Years of investment",
                                  style: new TextStyle(
                                      fontFamily: "WorkSansSemiBold",
                                      color: AllCoustomTheme.getTextThemeColors(),
                                      fontSize: 16,
                                      letterSpacing: 0.1
                                  ),
                                ),
                              )
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 35,
                                      child: Container(
                                        height: 35,
                                        width: 120,
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
                                            "SKIP",
                                            style: TextStyle(
                                              color: AllCoustomTheme.getTextThemeColors(),
                                              fontSize: ConstanceData.SIZE_TITLE18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onPressed: () async
                                          {
                                            submit();
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 35,
                                      child: Container(
                                        height: 35,
                                        width: 120,
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
                                            "NEXT",
                                            style: TextStyle(
                                              color: AllCoustomTheme.getTextThemeColors(),
                                              fontSize: ConstanceData.SIZE_TITLE18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onPressed: () async
                                          {
                                            submit();
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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

  Future submit() async {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) =>
        new OnBoardingSevenMarginApproved(logo: widget.logo,callingFrom: widget.callingFrom,)));
  }
}