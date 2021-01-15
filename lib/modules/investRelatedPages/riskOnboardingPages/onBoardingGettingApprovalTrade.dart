import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/routes.dart';
import 'package:auroim/constance/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:modal_progress_hud/modal_progress_hud.dart';


class OnBoardingGettingApprovalTrade extends StatefulWidget {
  final String callingFrom;
  final String logo;

  const OnBoardingGettingApprovalTrade({Key key, @required this.callingFrom,this.logo}) : super(key: key);

  @override
  _OnBoardingGettingApprovalTradeState createState() => _OnBoardingGettingApprovalTradeState();
}

class _OnBoardingGettingApprovalTradeState extends State<OnBoardingGettingApprovalTrade> {
  bool _isInProgress = false;

  List<dynamic> options = <dynamic>[
    {"checked":false,"option_value": "100 trade with 10x leverage will allow you to trade worth 1000"},
    {"checked":false,"option_value": "Your trade will not be cancelled when you receive a margin call"},
    {"checked":false,"option_value": "If price of Apple falls, price of your CFD will rise"},
    {"checked":false,"option_value": "Your position will remain open once the stop loss is triggered"},
  ];

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
            ...options.map((option) => CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                "${option["option_value"]}",
                style: TextStyle(
                    fontSize: 16.0,
                    color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFF000000),
                    fontFamily: "Poppins"),
              ),
              value: option["checked"],
              activeColor: widget.callingFrom=="Accredited Investor" ?  Color(0xFF000000) : Color(0xFFFFFFFF),
              onChanged: (value) {
                print("checkbox Tile pressed $value");
                setState(() {
                  option["checked"] = value;
                });
              },
            ),
            ),
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
                      height: MediaQuery.of(context).size.height*1.2,
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
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: Text(
                              "choose the right option",
                              style: new TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFF000000),
                                  fontSize: 20.0,
                                  letterSpacing: 0.1
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 50.0),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: getOptionList(),
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
                                        width: 100,
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
                                            "Done",
                                            style: TextStyle(
                                              color: AllCoustomTheme.getTextThemeColors(),
                                              fontSize: ConstanceData.SIZE_TITLE18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onPressed: () async {
                                              Navigator.pushNamedAndRemoveUntil(context, Routes.Home, (Route<dynamic> route) => false);
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

  Future submit() async {
/*    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) =>
        new OnBoardingSevenMarginNotApproved(logo: widget.logo,callingFrom: widget.callingFrom,)));*/
  }
}