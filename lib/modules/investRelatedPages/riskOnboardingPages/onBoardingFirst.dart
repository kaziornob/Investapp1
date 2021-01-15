import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/investRelatedPages/riskOnboardingPages/onBoardingSecond.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:modal_progress_hud/modal_progress_hud.dart';


class OnBoardingFirst extends StatefulWidget {
  final String callingFrom;
  final String logo;

  const OnBoardingFirst({Key key, @required this.callingFrom,this.logo}) : super(key: key);

  @override
  _OnBoardingFirstState createState() => _OnBoardingFirstState();
}

class _OnBoardingFirstState extends State<OnBoardingFirst> {
  bool _isInProgress = false;
  String selectedValue;

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

  Widget getOptionList() {
    return Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: Colors.white,
        ),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                "Exchange Traded Fund's",
                style: TextStyle(
                    fontSize: 16.5,
                    color: Color(0xFFFFFFFF),
                    fontFamily: "Poppins"),
              ),
              value: true,
              activeColor: Color(0xFFffffff),
              onChanged: (value) {
                print("Radio Tile pressed $value");
              },
            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                "Mutual Fund's",
                style: TextStyle(
                    fontSize: 16.5,
                    color: Color(0xFFFFFFFF),
                    fontFamily: "Poppins"),
              ),
              value: true,
              activeColor: Color(0xFFffffff),
              onChanged: (value) {
                print("Radio Tile pressed $value");
              },
            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                "Individual Securities",
                style: TextStyle(
                    fontSize: 16.5,
                    color: Color(0xFFFFFFFF),
                    fontFamily: "Poppins"),
              ),
              value: true,
              activeColor: Color(0xFFffffff),
              onChanged: (value) {
                print("Radio Tile pressed $value");
              },
            )
          ],
        )
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
                      height: MediaQuery.of(context).size.height*1.3,
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
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height*1.1,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 20.0,bottom: 14.0,left: 15.0,right: 3.0),
                                  child: Text(
                                    "In order to further personalize your Auro Light portfolio to a Pro version, we need a bit more information about your "
                                        "specific preferences and risk behaviour",
                                    style: new TextStyle(
                                        fontFamily: "WorkSansSemiBold",
                                        color: Color(0xFFFFFFFF), fontSize: 16.0,
                                        letterSpacing: 0.1
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                        margin: EdgeInsets.only(left: 20.0,right: 20.0),
                                        child: ListView(
                                          physics: NeverScrollableScrollPhysics(),
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(top:15.0,left: 15.0,right: 3.0),
                                              child: Text(
                                                "Auro has the ability of investing in ETF's, MF's and individual securities!",
                                                style: new TextStyle(
                                                    fontFamily: "WorkSansSemiBold",
                                                    color: Color(0xFFFFFFFF), fontSize: 16.0,
                                                    letterSpacing: 0.1
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 15.0,bottom: 10.0,left: 15.0,right: 3.0),
                                              child: Text(
                                                "While we suggest you include all of these in your portfolio, if you specifically want to exclude any of these please uncheck the respective box?",
                                                style: new TextStyle(
                                                    fontFamily: "WorkSansSemiBold",
                                                    color: Color(0xFFFFFFFF), fontSize: 16.0,
                                                    letterSpacing: 0.1
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                                child: getOptionList(),
                                              ),
                                            ),
                                          ],
                                        )
                                    )
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height*0.25,
                                    child: Container(
                                        margin: EdgeInsets.only(left: 10.0,right: 10.0),
                                        /*decoration: new BoxDecoration(
                                          color: widget.callingFrom=="Accredited Investor" ?  Color(0xFF000000) : Color(0xFFCD853F),
                                          border: Border.all(
                                            color: Color(0xFFfec20f),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(2.0),
                                          ),
                                        ),*/
                                        child: ListView(
                                          physics: NeverScrollableScrollPhysics(),
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(left: 10.0,right: 3.0),
                                              child: Text(
                                                "Don't worry if this question sounds like greek or latin to you. You can skip this question and change it later in settings whenever you want!!",
                                                style: new TextStyle(
                                                    fontFamily: "WorkSansSemiBold",
                                                    color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFFCD853F),
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.1
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                    )
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
                            ),
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
        new OnBoardingSecond(logo: widget.logo,callingFrom: widget.callingFrom,)));

  }
}