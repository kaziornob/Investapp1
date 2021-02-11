import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/investRelatedPages/riskOnboardingPages/onBoardingThird.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:modal_progress_hud/modal_progress_hud.dart';


class OnBoardingSecond extends StatefulWidget {
  final String callingFrom;
  final String logo;

  const OnBoardingSecond({Key key, @required this.callingFrom,this.logo}) : super(key: key);

  @override
  _OnBoardingSecondState createState() => _OnBoardingSecondState();
}

class _OnBoardingSecondState extends State<OnBoardingSecond> {
  bool _isInProgress = false;

  final List sliderData = [{"text":"Equities","value": 10},{"text":"Bonds","value": 10},{"text":"Real Estate","value": 10},
    {"text":"Commodities","value": 10},{"text":"Private Deals","value": 10},{"text":"PE/VC fund","value": 10},{"text":"Impact Investing","value": 10},
    {"text":"Impact Crypto","value": 10}];

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

  Widget getSliderListView(data) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: data.length,
      // physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 8.0),
              width: MediaQuery.of(context).size.width*0.30,
              height: MediaQuery.of(context).size.height*0.062,
              child:  Text(
                "${data[index]["text"]}",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: ConstanceData.SIZE_TITLE15,
                    fontFamily: "RobotoLight",
                    letterSpacing: 0.1
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.58,
              height: MediaQuery.of(context).size.height*0.062,
              child:  Slider(
                // value: _value.toDouble(),
                  value: data[index]["value"].toDouble(),
                  min: 1.0,
                  max: 20.0,
                  activeColor: Color(0xfffec20f),
                  inactiveColor: Color(0xFF060513),
                  // activeColor: widget.callingFrom=="Accredited Investor" ?  Color(0xfffec20f) : Color(0xFF00BFFF),
                  // inactiveColor: widget.callingFrom=="Accredited Investor" ?  Color(0xFF060513) : Color(0xff696969),
                  label: 'Set volume value',
                  onChanged: (double newValue) {
                    setState(() {
                      data[index]["value"] = newValue.round();
                    });
                  },
                  semanticFormatterCallback: (double newValue) {
                    return '${newValue.round()} dollars';
                  }
              ),
            )
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
              // backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
              backgroundColor: AllCoustomTheme.getBodyContainerThemeColor(),
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
                      // width: MediaQuery.of(context).size.width,
                      // height: MediaQuery.of(context).size.height*1.3,
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
                                      AllCoustomTheme.getTextThemeColor(),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height * 0.099,
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: Column(
                                  children: [
                                    Container(
                                        child: Center(
                                          child: new Image(
                                              width: 150.0,
                                              fit: BoxFit.fill,
                                              image: new AssetImage('assets/logo.png')
                                          ),
                                        )
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 70.0,right: 70.0),
                                      padding: EdgeInsets.only(
                                        bottom: 1, // space between underline and text
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                color: Color(0xFFD8AF4F),
                                                width: 1.5, // Underline width
                                              )
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height*1.1,
                            /*decoration: new BoxDecoration(
                              color: widget.callingFrom=="Accredited Investor"
                                  ?  StyleTheme.Colors.accScreenBackgroundColor : StyleTheme.Colors.retailScreenBackgroundColor,
                            ),*/
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 20.0,bottom: 10.0,left: 15.0,right: 3.0),
                                  child: Text(
                                    "A well-diversified portfolio should have all of below!!",
                                    style: new TextStyle(
                                        color: Colors.black,
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        fontFamily: "Rosarivo",
                                        letterSpacing: 0.1
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5.0,bottom: 10.0,left: 15.0,right: 3.0),
                                  child: Text(
                                    "However, let us know if you want Auro to exclude or definitely include any one",
                                    style: new TextStyle(
                                        color: Colors.black,
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        fontFamily: "RobotoLight",
                                        letterSpacing: 0.1
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 80,
                                        ),
                                        Container(
                                          decoration: new BoxDecoration(
                                            color: Color(0xFFFFFFFF),
                                            border: Border.all(
                                              color: Color(0xFFFFFFFF),
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(2.0),
                                            ),
                                          ),
                                          child: Text(
                                            "EXCLUDE",
                                            style: new TextStyle(
                                                color: Colors.black,
                                                fontSize: ConstanceData.SIZE_TITLE16,
                                                fontFamily: "Rosarivo",
                                                letterSpacing: 0.1
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: new BoxDecoration(
                                            color: Color(0xFFFFFFFF),
                                            border: Border.all(
                                              color: Color(0xFFFFFFFF),
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(2.0),
                                            ),
                                          ),
                                          child: Text(
                                            "INCLUDE",
                                            style: new TextStyle(
                                                color: Colors.black,
                                                fontSize: ConstanceData.SIZE_TITLE16,
                                                fontFamily: "Rosarivo",
                                                letterSpacing: 0.1
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    )
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 20.0,right: 10.0),
                                      child: Scrollbar(
                                        child: getSliderListView(sliderData),
                                      )
                                    )
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height*0.25,
                                    child: Container(
                                        margin: EdgeInsets.only(left: 20.0,right: 10.0,top: 20,bottom: 20),
                                        child: ListView(
                                          physics: NeverScrollableScrollPhysics(),
                                          children: <Widget>[
                                            Container(
                                              child: Text(
                                                "Don't worry if this question sounds like greek or latin to you. You can skip this question and change it later in settings whenever you want!!",
                                                style: new TextStyle(
                                                    // color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFFCD853F),
                                                    color: Colors.black,
                                                    fontSize: ConstanceData.SIZE_TITLE16,
                                                    fontFamily: "RobotoLight",
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizedBox(
                                      width: 20,
                                    ),
                                    SizedBox(
                                      height: 35,
                                      child: Container(
                                        height: 35,
                                        width: 120,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                            border: new Border.all(color: Color(0xFFD8AF4F), width: 1.5),
                                            color: Color(0xFFD8AF4F)
                                        ),
                                        child: MaterialButton(
                                          splashColor: Colors.grey,
                                          child: Text(
                                            "SKIP",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: ConstanceData.SIZE_TITLE16,
                                            ),
                                          ),
                                          onPressed: () async
                                          {
                                            submit();
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    SizedBox(
                                      height: 35,
                                      child: Container(
                                        height: 35,
                                        width: 120,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                            border: new Border.all(color: Color(0xFFD8AF4F), width: 1.5),
                                            color: Color(0xFFD8AF4F)
                                        ),
                                        child: MaterialButton(
                                          splashColor: Colors.grey,
                                          child: Text(
                                            "NEXT",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: ConstanceData.SIZE_TITLE16,
                                            ),
                                          ),
                                          onPressed: () async
                                          {
                                            submit();
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
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
        new OnBoardingThird(logo: widget.logo,callingFrom: widget.callingFrom,)));

  }
}