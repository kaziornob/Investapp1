import 'package:auro/riskOnBoardingPages/onBoardingSecond.dart';
import 'package:flutter/material.dart';
import 'package:auro/style/theme.dart' as StyleTheme;
import 'package:flutter/painting.dart';


class OnBoardingFirst extends StatefulWidget {
  final String callingFrom;
  final String logo;

  const OnBoardingFirst({Key key, @required this.callingFrom,this.logo}) : super(key: key);

  @override
  _OnBoardingFirstState createState() => _OnBoardingFirstState();
}

class _OnBoardingFirstState extends State<OnBoardingFirst> {

  String selectedValue;

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
                      "In order to further personalize your Auro Light portfolio to a Pro version, we need a bit more information about your "
                          "specific preferences and risk behaviour",
                      style: new TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          color: Color(0xFFFFFFFF), fontSize: 18.0,
                          letterSpacing: 0.1
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 20.0,right: 20.0),
                      decoration: new BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFfec20f),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(2.0),
                        ),
                      ),
                      child: ListView(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top:15.0,left: 15.0,right: 3.0),
                            child: Text(
                              "Auro has the ability of investing in ETF's, MF's and individual securities!",
                              style: new TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  color: Color(0xFFFFFFFF), fontSize: 18.0,
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
                                  color: Color(0xFFFFFFFF), fontSize: 18.0,
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
                        margin: EdgeInsets.only(top: 15.0,left: 20.0,right: 20.0,bottom: 15.0),
                        decoration: new BoxDecoration(
                          color: widget.callingFrom=="Accredited Investor" ?  Color(0xFF000000) : Color(0xFFCD853F),
                          border: Border.all(
                            color: Color(0xFFfec20f),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(2.0),
                          ),
                        ),
                        child: ListView(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top:15.0,bottom: 5.0,left: 15.0,right: 3.0),
                              child: Text(
                                "Don't worry if this question sounds like greek or latin to you. You can skip this question and change it later in settings whenever you want!!",
                                style: new TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFFCD853F),
                                    fontSize: 18.0,
                                    letterSpacing: 0.1
                                ),
                              ),
                            ),
                          ],
                        )
                      )
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0),
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
