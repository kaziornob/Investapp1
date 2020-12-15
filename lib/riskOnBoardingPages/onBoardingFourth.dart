import 'package:auro/riskOnBoardingPages/onBoardingSix.dart';
import 'package:auro/riskOnBoardingPages/onBoardingSecond.dart';
import 'package:flutter/material.dart';
import 'package:auro/style/theme.dart' as StyleTheme;
import 'package:flutter/painting.dart';


class OnBoardingFourth extends StatefulWidget {
  final String callingFrom;
  final String logo;

  const OnBoardingFourth({Key key, @required this.callingFrom,this.logo}) : super(key: key);

  @override
  _OnBoardingFourthState createState() => _OnBoardingFourthState();
}

class _OnBoardingFourthState extends State<OnBoardingFourth> {

  List<dynamic> options = <dynamic>[
    {"checked":false,"option_value": ""},
    {"checked":false,"option_value": ""},
    {"checked":false,"option_value": ""},
    {"checked":false,"option_value": ""},
    {"checked":false,"option_value": ""}
  ];

  Widget getOptionList() {
    return Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: Colors.white,
        ),
        child:  Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ...options.map((option) =>  Container(
                height: MediaQuery.of(context).size.height*0.01,
                width: MediaQuery.of(context).size.width*0.18,
                margin: EdgeInsets.only(left: 5.0),

                child: Checkbox(
                  value: option["checked"],
                  activeColor: Color(0xff696969),
                  onChanged: (newValue) {
                    setState(() {
                      option["checked"] = newValue;
                    });
                  },
                ),
              )
            ),
          ],
        )
    );
  }

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
              height: MediaQuery.of(context).size.height*1.0,
              decoration: new BoxDecoration(
                color: widget.callingFrom=="Accredited Investor" ?  StyleTheme.Colors.accScreenBackgroundColor : StyleTheme.Colors.retailScreenBackgroundColor,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height*0.15,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 20.0,bottom: 14.0,left: 20.0,right: 20.0),
                    decoration: new BoxDecoration(
                      border: Border.all(
                        color: widget.callingFrom=="Accredited Investor" ?  Color(0xff696969) : Color(0xFFFFFFFF),
                        width: 1.2,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(2.0),
                      ),
                    ),
                    child: ListView(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top:5.0),
                          child: Center(
                            child: Text(
                              "Your Attitude To Risk",
                              style: new TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFF000000),
                                  fontSize: 18.0,
                                  letterSpacing: 0.1
                              ),
                            ),
                          )
                        ),
                        Container(
                            margin: EdgeInsets.only(top:10.0,left: 20.0,right: 10.0),
                            child: Center(
                              child: Text(
                                "Which of the following option describe your expectation for annual returns?",
                                style: new TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFF000000),
                                    fontSize: 16.0,
                                    letterSpacing: 0.1
                                ),
                              ),
                            )
                        ),
                      ],
                    )
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.16,
                    width: MediaQuery.of(context).size.width*0.45,
                    margin: EdgeInsets.only(top: 10.0,bottom: 5.0,left: 165.0,right: 10.0),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 5.0,left: 4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height*0.03,
                                width: MediaQuery.of(context).size.width*0.08,
                                decoration: new BoxDecoration(
                                  color: Color(0xFF32CD32),
                                  border: Border.all(
                                    color: Color(0xFFFFFFFF),
                                    width: 1.2,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(2.0),
                                  ),
                                ),

                              ),
                              Container(
                                height: MediaQuery.of(context).size.height*0.07,
                                width: MediaQuery.of(context).size.width*0.35,
                                child: Text(
                                  "Potential gain",
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      color: Color(0xFF000000),
                                      fontFamily: "WorkSansBold"),
                                ),

                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5.4,left: 4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height*0.03,
                                width: MediaQuery.of(context).size.width*0.08,
                                decoration: new BoxDecoration(
                                  color: Color(0xFFe70b31),
                                  border: Border.all(
                                    color: Color(0xFFFFFFFF),
                                    width: 1.2,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(2.0),
                                  ),
                                ),

                              ),
                              Container(
                                height: MediaQuery.of(context).size.height*0.07,
                                width: MediaQuery.of(context).size.width*0.35,
                                child: Text(
                                  "Potential loss",
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      color: Color(0xFF000000),
                                      fontFamily: "WorkSansBold"),
                                ),

                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height*0.30,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 10.0,bottom: 14.0,left: 20.0,right: 20.0),
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage('assets/risk_onboarding_4-_pi_version.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                  ),
                  Container(
                    child: getOptionList(),
                  ),

                  Container(
                      margin: EdgeInsets.only(top:70.0,left: 20.0,right: 20.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            decoration: new BoxDecoration(
                              color: widget.callingFrom=="Accredited Investor" ?  StyleTheme.Colors.accButtonBackgroundColor : StyleTheme.Colors.retailButtonBackgroundColor,
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: MaterialButton(
                              child: Padding(
                                padding: EdgeInsets.only(left: 30.0,right: 30.0),
                                child: Center(
                                  child: Text(
                                    "SkIP",
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
                          Container(
                            width: 33,
                          ),
                          Container(
                            decoration: new BoxDecoration(
                              color: widget.callingFrom=="Accredited Investor" ?  StyleTheme.Colors.accButtonBackgroundColor : StyleTheme.Colors.retailButtonBackgroundColor,
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            ),
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
                      )
                  )
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
        new OnBoardingSix(logo: widget.logo,callingFrom: widget.callingFrom,)));

  }
}
