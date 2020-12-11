import 'package:auro/riskOnBoardingPages/onBoardingThird.dart';
import 'package:flutter/material.dart';
import 'package:auro/style/theme.dart' as StyleTheme;
import 'package:flutter/painting.dart';


class OnBoardingSecond extends StatefulWidget {
  final String callingFrom;
  final String logo;

  const OnBoardingSecond({Key key, @required this.callingFrom,this.logo}) : super(key: key);

  @override
  _OnBoardingSecondState createState() => _OnBoardingSecondState();
}

class _OnBoardingSecondState extends State<OnBoardingSecond> {

  final List sliderData = [{"text":"Equities","value": 10},{"text":"Bonds","value": 10},{"text":"Real Estate","value": 10},
    {"text":"Commodities","value": 10},{"text":"Private Deals","value": 10},{"text":"PE/VC fund","value": 10},{"text":"Impact Investing","value": 10},
    {"text":"Impact Crypto","value": 10}];

  Widget getSliderListView(data) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: data.length,
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
                    fontSize: 17.5,
                    color: Color(0xFFFFFFFF),
                    fontFamily: "WorkSansBold"),
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
                  activeColor: widget.callingFrom=="Accredited Investor" ?  Color(0xfffec20f) : Color(0xFF00BFFF),
                  inactiveColor: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xff696969),
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
                    margin: EdgeInsets.only(top: 20.0,bottom: 10.0,left: 25.0,right: 3.0),
                    child: Text(
                      "A well-diversified portfolio should have all of below!!",
                      style: new TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          color: Color(0xFFFFFFFF), fontSize: 18.0,
                          letterSpacing: 0.1
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.0,bottom: 10.0,left: 25.0,right: 3.0),
                    child: Text(
                      "However, let us know if you want Auro to exclude or definitely include any one",
                      style: new TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          color: Color(0xFFFFFFFF), fontSize: 18.0,
                          letterSpacing: 0.1
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.0,bottom: 10.0,left: 25.0,right: 3.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(left: 100.0),
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
                                  fontFamily: "WorkSansSemiBold",
                                  color: Color(0xFF000000), fontSize: 17.0,
                                  letterSpacing: 0.1
                              ),
                            ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 60.0),
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
                                fontFamily: "WorkSansSemiBold",
                                color: Color(0xFF000000), fontSize: 17.0,
                                letterSpacing: 0.1
                            ),
                          ),
                        )
                      ],
                    )
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 20.0,right: 10.0),
                      child: getSliderListView(sliderData),
                      )
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height*0.25,
                      child: Container(
                        margin: EdgeInsets.only(top: 20.0,left: 20.0,right: 20.0,bottom: 15.0),
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
        new OnBoardingThird(logo: widget.logo,callingFrom: widget.callingFrom,)));

  }
}
