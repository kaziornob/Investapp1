import 'package:auro/riskOnBoardingPages/onBoardingGettingApproval.dart';
import 'package:auro/riskOnBoardingPages/onBoardingSecond.dart';
import 'package:flutter/material.dart';
import 'package:auro/style/theme.dart' as StyleTheme;
import 'package:flutter/painting.dart';


class OnBoardingSevenMarginNotApproved extends StatefulWidget {
  final String callingFrom;
  final String logo;

  const OnBoardingSevenMarginNotApproved({Key key, @required this.callingFrom,this.logo}) : super(key: key);

  @override
  _OnBoardingSevenMarginNotApprovedState createState() => _OnBoardingSevenMarginNotApprovedState();
}

class _OnBoardingSevenMarginNotApprovedState extends State<OnBoardingSevenMarginNotApproved> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Padding(
            padding: EdgeInsets.only(left:25.0),
            child: Image(
              width: 180.0,
              fit: BoxFit.fill,
              image: new AssetImage('assets/${widget.logo}')),
          ),
          backgroundColor: Color(0xFF000000),
          leading: const BackButton(),
          iconTheme: new IconThemeData(color: StyleTheme.Colors.AppBarMenuIconColor),
        ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*1.1,
              decoration: new BoxDecoration(
                color: widget.callingFrom=="Accredited Investor" ?  StyleTheme.Colors.accScreenBackgroundColor : StyleTheme.Colors.retailScreenBackgroundColor,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20.0,bottom: 14.0,left: 25.0,right: 3.0),
                    child: Text(
                      "We regret to inform you that your choice was an incorrect solution.we will continue sending practice questions in your envelope and"
                          "once you are ready, we will open up marginal/leveraged trading for you.",
                      style: new TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFF000000),
                          fontSize: 25.0,
                          letterSpacing: 0.1
                      ),
                    ),
                  ),
                  Container(
                    decoration: new BoxDecoration(
                      color: widget.callingFrom=="Accredited Investor" ?  StyleTheme.Colors.accButtonBackgroundColor : StyleTheme.Colors.retailButtonBackgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    margin: EdgeInsets.only(left: 20.0,right: 20.0,top: 230.0),
                    child: MaterialButton(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0,right: 10.0),
                        child: Center(
                          child: Text(
                            "GO TO PERSONAL SLEEVE",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                                fontFamily: "WorkSansBold"),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        submit();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],

        ),
      )
    );
  }

  Future submit() async {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) =>
        new OnBoardingGettingApprovalTrade(logo: widget.logo,callingFrom: widget.callingFrom,)));

  }
}
