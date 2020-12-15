import 'package:auro/riskOnBoardingPages/onBoardingSecond.dart';
import 'package:auro/riskOnBoardingPages/onBoardingSevenMarginApproved.dart';
import 'package:flutter/material.dart';
import 'package:auro/style/theme.dart' as StyleTheme;
import 'package:flutter/painting.dart';


class OnBoardingSix extends StatefulWidget {
  final String callingFrom;
  final String logo;

  const OnBoardingSix({Key key, @required this.callingFrom,this.logo}) : super(key: key);

  @override
  _OnBoardingSixState createState() => _OnBoardingSixState();
}

class _OnBoardingSixState extends State<OnBoardingSix> {

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
              height: MediaQuery.of(context).size.height*1.2,
              decoration: new BoxDecoration(
                color: widget.callingFrom=="Accredited Investor" ?  StyleTheme.Colors.accScreenBackgroundColor : StyleTheme.Colors.retailScreenBackgroundColor,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height*0.08,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 20.0,bottom: 20.0,left: 25.0,right: 20.0),
                    child: Center(
                      child: Text(
                        "What will be your first deposit in to your Auro account?",
                        style: new TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFF000000),
                            fontSize: 17.5,
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
                                      fontSize: 18.0,
                                      letterSpacing: 0.1
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 20.0),
                                height: MediaQuery.of(context).size.height*0.05,
                                width: MediaQuery.of(context).size.width*0.44,
                                  decoration: new BoxDecoration(
                                    color: Color(0xFFFFFFFF),
                                    border: Border.all(
                                      color: Color(0xFFFFFFFF),
                                      width: 1.2,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(2.0),
                                    ),
                                  ),
                                child: TextFormField(
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
                            color: Color(0xFFFFFFFF),
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
                                      fontSize: 18.0,
                                      letterSpacing: 0.1
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 20.0),
                                height: MediaQuery.of(context).size.height*0.05,
                                width: MediaQuery.of(context).size.width*0.44,
                                decoration: new BoxDecoration(
                                  color: Color(0xFFFFFFFF),
                                  border: Border.all(
                                    color: Color(0xFFFFFFFF),
                                    width: 1.2,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(2.0),
                                  ),
                                ),
                                child: TextFormField(
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
                      margin: EdgeInsets.only(top: 20.0,bottom: 14.0,left: 20.0,right: 20.0),
                      decoration: new BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        border: Border.all(
                          color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFF000000),
                          width: 1.2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(2.0),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
                        child: Text(
                          "If you make a monthly deposit of X in addition to your initial deposit, you retums will increase by Y%!",
                          style: new TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              color: Color(0xFF000000),
                              fontSize: 18.0,
                              letterSpacing: 0.1
                          ),
                        ),
                      )
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height*0.30,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 10.0,bottom: 14.0,left: 20.0,right: 20.0),
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
                      margin: EdgeInsets.only(top: 5.0,bottom: 14.0,left: 20.0,right: 20.0),
                      decoration: new BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        border: Border.all(
                          color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFF000000),
                          width: 1.2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(2.0),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 5.0,left: 10.0,right: 10.0),
                        child: Text(
                          "Solid line: Retum with regular monthly investments Dotted Line: Return with only initial investment Y-axis: Years of investment",
                          style: new TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              color: Color(0xFF000000),
                              fontSize: 17.5,
                              letterSpacing: 0.1
                          ),
                        ),
                      )
                  ),

                  Container(
                    decoration: new BoxDecoration(
                      color: widget.callingFrom=="Accredited Investor" ?  StyleTheme.Colors.accButtonBackgroundColor : StyleTheme.Colors.retailButtonBackgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    margin: EdgeInsets.only(left: 80.0,right: 80.0),

                    child: MaterialButton(
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.0,right: 30.0),
                        child: Center(
                          child: Text(
                            "NEXT",
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
        new OnBoardingSevenMarginApproved(logo: widget.logo,callingFrom: widget.callingFrom,)));

  }
}
