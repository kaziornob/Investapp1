import 'package:auro/riskOnBoardingPages/onBoardingSecond.dart';
import 'package:flutter/material.dart';
import 'package:auro/style/theme.dart' as StyleTheme;
import 'package:flutter/painting.dart';


class OnBoardingGettingApprovalTrade extends StatefulWidget {
  final String callingFrom;
  final String logo;

  const OnBoardingGettingApprovalTrade({Key key, @required this.callingFrom,this.logo}) : super(key: key);

  @override
  _OnBoardingGettingApprovalTradeState createState() => _OnBoardingGettingApprovalTradeState();
}

class _OnBoardingGettingApprovalTradeState extends State<OnBoardingGettingApprovalTrade> {

  List<dynamic> options = <dynamic>[
    {"checked":false,"option_value": "100 trade with 10x leverage will allow you to trade worth 1000"},
    {"checked":false,"option_value": "Your trade will not be cancelled when you receive a margin call"},
    {"checked":false,"option_value": "If price of Apple falls, price of your CFD will rise"},
    {"checked":false,"option_value": "Your position will remain open once the stop loss is triggered"},
  ];

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
                  fontSize: 18.0,
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
                    margin: EdgeInsets.only(top: 40.0,left: 15.0,right: 3.0),
                    child: Text(
                      "choose the right option",
                      style: new TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFF000000),
                          fontSize: 22.0,
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
                  Container(
                      margin: EdgeInsets.only(top: 150.0,left: 20.0,right: 20.0),
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
        new OnBoardingSecond(logo: widget.logo,callingFrom: widget.callingFrom,)));

  }
}
