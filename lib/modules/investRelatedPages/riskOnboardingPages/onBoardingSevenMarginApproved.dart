import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/investRelatedPages/riskOnboardingPages/onBoardingGettingApprovalTrade.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class OnBoardingSevenMarginApproved extends StatefulWidget {
  final String callingFrom;
  final String logo;

  const OnBoardingSevenMarginApproved(
      {Key key, @required this.callingFrom, this.logo})
      : super(key: key);

  @override
  _OnBoardingSevenMarginApprovedState createState() =>
      _OnBoardingSevenMarginApprovedState();
}

class _OnBoardingSevenMarginApprovedState
    extends State<OnBoardingSevenMarginApproved> {
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
    // AppBar appBar = AppBar();
    // double appBarheight = appBar.preferredSize.height;
    return Stack(
      children: <Widget>[
        SafeArea(
            bottom: true,
            child: Scaffold(
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
/*                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.7,*/
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
                                        begin: Offset(0, 0),
                                        end: Offset(0.2, 0)),
                                    duration: Duration(milliseconds: 500),
                                    cycles: 0,
                                    builder: (_, anim, __) =>
                                        FractionalTranslation(
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
                                  height: MediaQuery.of(context).size.height *
                                      0.094,
                                  width:
                                      MediaQuery.of(context).size.width * 0.90,
                                  child: Column(
                                    children: [
                                      Container(
                                          child: Center(
                                        child: new Image(
                                            width: 150.0,
                                            fit: BoxFit.fill,
                                            image: new AssetImage(
                                                'assets/logo.png')),
                                      )),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 70.0, right: 70.0),
                                        padding: EdgeInsets.only(
                                          bottom:
                                              1, // space between underline and text
                                        ),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                          color: Color(0xFFD8AF4F),
                                          width: 1.5, // Underline width
                                        ))),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20.0, right: 20.0),
                              child: Text(
                                "Congratulations! you are eligible to trade option and futures using margin/leverage in your personal sleeve",
/*                              "We regret to inform you that your choice was an incorrect solution.we will continue sending practice questions in your envelope and"
                                  "once you are ready, we will open up marginal/leveraged trading for you.",*/
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                    // color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFF000000),
                                    color: Colors.black,
                                    fontSize: ConstanceData.SIZE_TITLE18,
                                    fontFamily: "Rosarivo",
                                    letterSpacing: 0.1),
                              ),
                            ),
                            SizedBox(
                              height: 100,
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
                                    width: 250,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        border: new Border.all(
                                            color: Color(0xFFD8AF4F),
                                            width: 1.5),
                                        color: Color(0xFFD8AF4F)),
                                    child: MaterialButton(
                                      splashColor: Colors.grey,
                                      child: Text(
                                        "GO TO PERSONAL SLEEVE",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ConstanceData.SIZE_TITLE16,
                                        ),
                                      ),
                                      onPressed: () async {
                                        submit();
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                          ],
                        ))
                      : SizedBox(),
                ),
              ),
            ))
      ],
    );
  }

  Future submit() async {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new OnBoardingGettingApprovalTrade(
              logo: widget.logo,
              callingFrom: widget.callingFrom,
            )));
  }
}
