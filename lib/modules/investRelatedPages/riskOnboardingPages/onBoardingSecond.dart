import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/investRelatedPages/riskOnboardingPages/onBoardingThird.dart';
import 'package:auroim/provider_abhinav/go_pro_data_provider.dart';
import 'package:auroim/provider_abhinav/user_details.dart';
import 'package:auroim/widgets/public_company/custom_slider_thumb_circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class OnBoardingSecond extends StatefulWidget {
  final String callingFrom;
  final String logo;

  const OnBoardingSecond({Key key, @required this.callingFrom, this.logo})
      : super(key: key);

  @override
  _OnBoardingSecondState createState() => _OnBoardingSecondState();
}

class _OnBoardingSecondState extends State<OnBoardingSecond> {
  bool _isInProgress = false;

  Map sliderData = {
    "Commodity": 10,
    "Crypto": 10,
    "Equity": 10,
    "Fixed Income": 10,
    "Hedge Fund": 10,
    "Private Deals (PE/VC)": 10,
    "Real Estate": 10,
  };

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

  // Widget getSliderListView(Map data) {
  //   return Stack(
  //     children: [
  //       Container(
  //         // decoration: BoxDecoration(border: Border.all()),
  //         child: Column(
  //           children: data.keys.toList().map<Widget>(
  //             (key) {
  //               return Row(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   Container(
  //                     // decoration: BoxDecoration(border: Border.all()),
  //                     // margin: EdgeInsets.only(top: 8.0),
  //                     width: MediaQuery.of(context).size.width * 0.30,
  //                     height: 40,
  //                     child: Row(
  //                       children: [
  //                         Expanded(
  //                           child: Text(
  //                             "$key",
  //                             style: TextStyle(
  //                               color: Colors.black,
  //                               fontSize: ConstanceData.SIZE_TITLE15,
  //                               fontFamily: "RobotoLight",
  //                               letterSpacing: 0.1,
  //                             ),
  //                             textAlign: TextAlign.start,
  //                             overflow: TextOverflow.clip,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   Container(
  //                     // decoration: BoxDecoration(border: Border.all()),
  //                     width: MediaQuery.of(context).size.width * 0.58,
  //                     height: 40,
  //                     child: SliderTheme(
  //                       data: SliderThemeData(
  //                         thumbColor: Color(0xFFD8AF4F),
  //                         // activeTrackColor: Colors.black,
  //                         inactiveTrackColor: Colors.black,
  //                         trackShape: RectangularSliderTrackShape(),
  //                       ),
  //                       child: Slider(
  //                         value: data[key].toDouble(),
  //                         min: 0.0,
  //                         max: 20.0,
  //                         divisions: 2,
  //                         label: sliderLabel(data[key].toDouble()),
  //                         onChanged: (double newValue) {
  //                           setState(() {
  //                             data[key] = newValue.round();
  //                           });
  //                         },
  //                         semanticFormatterCallback: (double newValue) {
  //                           return '${newValue.round()} dollars';
  //                         },
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               );
  //             },
  //           ).toList(),
  //         ),
  //       ),
  //       Positioned(
  //         left: MediaQuery.of(context).size.width * 0.36,
  //         child: DottedLine(
  //           direction: Axis.vertical,
  //           lineLength: 280,
  //           lineThickness: 1.0,
  //           dashLength: 4.0,
  //           dashColor: Colors.black,
  //           dashRadius: 0.0,
  //           dashGapLength: 4.0,
  //           dashGapColor: Colors.transparent,
  //           dashGapRadius: 0.0,
  //         ),
  //       ),
  //       Positioned(
  //         right: MediaQuery.of(context).size.width * 0.1,
  //         child: DottedLine(
  //           direction: Axis.vertical,
  //           lineLength: 280,
  //           lineThickness: 1.0,
  //           dashLength: 4.0,
  //           dashColor: Colors.black,
  //           dashRadius: 0.0,
  //           dashGapLength: 4.0,
  //           dashGapColor: Colors.transparent,
  //           dashGapRadius: 0.0,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget getSliderListView(Map data) {
    return Stack(
      children: [
        Container(
          // decoration: BoxDecoration(border: Border.all()),
          child: Column(
            children: data.keys.toList().map<Widget>(
              (key) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      // decoration: BoxDecoration(border: Border.all()),
                      // margin: EdgeInsets.only(top: 8.0),
                      width: MediaQuery.of(context).size.width * 0.30,
                      height: 40,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "$key",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: ConstanceData.SIZE_TITLE15,
                                fontFamily: "RobotoLight",
                                letterSpacing: 0.1,
                              ),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // decoration: BoxDecoration(border: Border.all()),
                      width: MediaQuery.of(context).size.width * 0.58,
                      height: 40,
                      child: SliderTheme(
                        data: SliderThemeData(
                          thumbColor: Colors.white,
                          activeTrackColor: Color(0xffFFB200),
                          inactiveTrackColor: Color(0xffFFB200),
                          trackShape: RectangularSliderTrackShape(),
                          thumbShape: CustomSliderThumbCircle(
                            thumbRadius: 12,
                            borderColor: Color(0xffFFB200),
                          ),
                        ),
                        child: Slider(
                          value: data[key].toDouble(),
                          min: 0.0,
                          max: 20.0,
                          divisions: 2,
                          label: sliderLabel(data[key].toDouble()),
                          onChanged: (double newValue) {
                            setState(() {
                              data[key] = newValue.round();
                            });
                          },
                          semanticFormatterCallback: (double newValue) {
                            return '${newValue.round()} dollars';
                          },
                        ),
                      ),
                    )
                  ],
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }

  sliderLabel(value) {
    switch (value) {
      case 0:
        return "EXCLUDE";
      case 10:
        return "ALGO DECIDES";
      case 20:
        return "INCLUDE";
    }
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
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Icon(
                                        Icons.arrow_back,
                                        color:
                                            AllCoustomTheme.getTextThemeColor(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 1.1,
                                /*decoration: new BoxDecoration(
                              color: widget.callingFrom=="Accredited Investor"
                                  ?  StyleTheme.Colors.accScreenBackgroundColor : StyleTheme.Colors.retailScreenBackgroundColor,
                            ),*/
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 5.0,
                                          bottom: 5.0,
                                          left: 15.0,
                                          right: 3.0),
                                      child: Text(
                                        "A well-diversified portfolio should include all of below. However, Auro can customize based on your preference.",
                                        style: new TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                ConstanceData.SIZE_TITLE16,
                                            fontFamily: "Rosarivo",
                                            letterSpacing: 0.1),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.only(
                                          top: 5.0,
                                          bottom: 5.0,
                                          left: 15.0,
                                          right: 3.0),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "Move the ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily: "Rosarivo",
                                                  letterSpacing: 0.1),
                                            ),
                                            WidgetSpan(
                                              child: CircleAvatar(
                                                radius: 7,
                                                backgroundColor:
                                                    Color(0xffFFB200),
                                                child: CircleAvatar(
                                                  radius: 6,
                                                  backgroundColor: Colors.white,
                                                ),
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  " to EXCLUDE or INCLUDE any of the asset classes:",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily: "Rosarivo",
                                                  letterSpacing: 0.1),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 20,
                                      // decoration: BoxDecoration(border: Border.all(),),
                                      margin: EdgeInsets.only(
                                        left: 20.0,
                                        right: 10.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.18,
                                          ),
                                          Text(
                                            "EXCLUDE",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "ALGO DECIDES",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "INCLUDE",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 290,
                                      // decoration: BoxDecoration(border: Border.all(),),
                                      margin: EdgeInsets.only(
                                        left: 20.0,
                                        right: 10.0,
                                      ),
                                      child: Scrollbar(
                                        child: getSliderListView(sliderData),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 100,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 20.0,
                                            right: 10.0,
                                            top: 5,
                                            bottom: 20),
                                        child: ListView(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          children: <Widget>[
                                            Container(
                                              child: Text(
                                                "If you’re not quite sure, you can skip this and change it later.",
                                                style: new TextStyle(
                                                    // color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFFCD853F),
                                                    color: Colors.black,
                                                    fontSize: ConstanceData
                                                        .SIZE_TITLE16,
                                                    fontFamily: "Rosario",
                                                    letterSpacing: 0.1),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            submit();
                                          },
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Color(0xFFD8AF4F),
                                            child: Icon(
                                              Icons.arrow_forward_sharp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                ),
              ),
            ))
      ],
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   AppBar appBar = AppBar();
  //   double appBarheight = appBar.preferredSize.height;
  //   return Stack(
  //     children: <Widget>[
  //       SafeArea(
  //           bottom: true,
  //           child: Scaffold(
  //             // backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
  //             backgroundColor: AllCoustomTheme.getBodyContainerThemeColor(),
  //             body: ModalProgressHUD(
  //               inAsyncCall: _isInProgress,
  //               opacity: 0,
  //               progressIndicator: CupertinoActivityIndicator(
  //                 radius: 12,
  //               ),
  //               child: SingleChildScrollView(
  //                 physics: BouncingScrollPhysics(),
  //                 child: !_isInProgress
  //                     ? Container(
  //                         // width: MediaQuery.of(context).size.width,
  //                         // height: MediaQuery.of(context).size.height*1.3,
  //                         child: Column(
  //                           children: <Widget>[
  //                             SizedBox(
  //                               height: 20,
  //                             ),
  //                             Row(
  //                               children: <Widget>[
  //                                 InkWell(
  //                                   highlightColor: Colors.transparent,
  //                                   splashColor: Colors.transparent,
  //                                   onTap: () {
  //                                     Navigator.pop(context);
  //                                   },
  //                                   child: Animator(
  //                                     tween: Tween<Offset>(
  //                                         begin: Offset(0, 0),
  //                                         end: Offset(0.2, 0)),
  //                                     duration: Duration(milliseconds: 500),
  //                                     cycles: 0,
  //                                     builder: (anim) => FractionalTranslation(
  //                                       translation: anim.value,
  //                                       child: Icon(
  //                                         Icons.arrow_back_ios,
  //                                         color: AllCoustomTheme
  //                                             .getTextThemeColor(),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 Container(
  //                                   height: MediaQuery.of(context).size.height *
  //                                       0.099,
  //                                   width: MediaQuery.of(context).size.width *
  //                                       0.90,
  //                                   child: Column(
  //                                     children: [
  //                                       Container(
  //                                           child: Center(
  //                                         child: new Image(
  //                                             width: 150.0,
  //                                             fit: BoxFit.fill,
  //                                             image: new AssetImage(
  //                                                 'assets/logo.png')),
  //                                       )),
  //                                       Container(
  //                                         margin: EdgeInsets.only(
  //                                             left: 70.0, right: 70.0),
  //                                         padding: EdgeInsets.only(
  //                                           bottom:
  //                                               1, // space between underline and text
  //                                         ),
  //                                         decoration: BoxDecoration(
  //                                             border: Border(
  //                                                 bottom: BorderSide(
  //                                           color: Color(0xFFD8AF4F),
  //                                           width: 1.5, // Underline width
  //                                         ))),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 )
  //                               ],
  //                             ),
  //                             Container(
  //                               width: MediaQuery.of(context).size.width,
  //                               height:
  //                                   MediaQuery.of(context).size.height * 1.1,
  //                               /*decoration: new BoxDecoration(
  //                             color: widget.callingFrom=="Accredited Investor"
  //                                 ?  StyleTheme.Colors.accScreenBackgroundColor : StyleTheme.Colors.retailScreenBackgroundColor,
  //                           ),*/
  //                               child: Column(
  //                                 children: <Widget>[
  //                                   Container(
  //                                     margin: EdgeInsets.only(
  //                                         top: 5.0,
  //                                         bottom: 5.0,
  //                                         left: 15.0,
  //                                         right: 3.0),
  //                                     child: Text(
  //                                       "A well-diversified portfolio should include all of below. However, Auro can customize based on your preferences. Move the gold circle to Exclude OR Include any of these asset classes, to make your selection below:",
  //                                       style: new TextStyle(
  //                                           color: Colors.black,
  //                                           fontSize:
  //                                               ConstanceData.SIZE_TITLE16,
  //                                           fontFamily: "Rosarivo",
  //                                           letterSpacing: 0.1),
  //                                     ),
  //                                   ),
  //                                   // Container(
  //                                   //   margin: EdgeInsets.only(
  //                                   //       top: 5.0,
  //                                   //       bottom: 10.0,
  //                                   //       left: 15.0,
  //                                   //       right: 3.0),
  //                                   //   child: Text(
  //                                   //     "However, let us know if you want Auro to exclude or definitely include any one",
  //                                   //     style: new TextStyle(
  //                                   //         color: Colors.black,
  //                                   //         fontSize:
  //                                   //             ConstanceData.SIZE_TITLE16,
  //                                   //         fontFamily: "RobotoLight",
  //                                   //         letterSpacing: 0.1),
  //                                   //   ),
  //                                   // ),
  //                                   Container(
  //                                     height: 20,
  //                                     // decoration: BoxDecoration(border: Border.all(),),
  //                                     margin: EdgeInsets.only(
  //                                       left: 20.0,
  //                                       right: 10.0,
  //                                     ),
  //                                     child: Row(
  //                                       mainAxisAlignment:
  //                                           MainAxisAlignment.spaceEvenly,
  //                                       children: [
  //                                         SizedBox(
  //                                           width: MediaQuery.of(context)
  //                                                   .size
  //                                                   .width *
  //                                               0.18,
  //                                         ),
  //                                         Text(
  //                                           "EXCLUDE",
  //                                           style: TextStyle(
  //                                             fontSize: 10,
  //                                             fontWeight: FontWeight.bold,
  //                                           ),
  //                                         ),
  //                                         Text(
  //                                           "ALGO DECIDES",
  //                                           style: TextStyle(
  //                                             fontSize: 10,
  //                                             fontWeight: FontWeight.bold,
  //                                           ),
  //                                         ),
  //                                         Text(
  //                                           "INCLUDE",
  //                                           style: TextStyle(
  //                                             fontSize: 10,
  //                                             fontWeight: FontWeight.bold,
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                   Container(
  //                                     height: 290,
  //                                     // decoration: BoxDecoration(border: Border.all(),),
  //                                     margin: EdgeInsets.only(
  //                                       left: 20.0,
  //                                       right: 10.0,
  //                                     ),
  //                                     child: Scrollbar(
  //                                       child: getSliderListView(sliderData),
  //                                     ),
  //                                   ),
  //                                   SizedBox(
  //                                     height: 100,
  //                                     child: Container(
  //                                       margin: EdgeInsets.only(
  //                                           left: 20.0,
  //                                           right: 10.0,
  //                                           top: 5,
  //                                           bottom: 20),
  //                                       child: ListView(
  //                                         physics:
  //                                             NeverScrollableScrollPhysics(),
  //                                         children: <Widget>[
  //                                           Container(
  //                                             child: Text(
  //                                               "Don't worry if this question sounds like greek or latin to you. You can skip this question and change it later in settings whenever you want!!",
  //                                               style: new TextStyle(
  //                                                   // color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFFCD853F),
  //                                                   color: Colors.black,
  //                                                   fontSize: ConstanceData
  //                                                       .SIZE_TITLE16,
  //                                                   fontFamily: "RobotoLight",
  //                                                   letterSpacing: 0.1),
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   Row(
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     mainAxisAlignment:
  //                                         MainAxisAlignment.center,
  //                                     children: <Widget>[
  //                                       SizedBox(
  //                                         height: 35,
  //                                         child: Container(
  //                                           height: 35,
  //                                           width: 120,
  //                                           decoration: BoxDecoration(
  //                                               borderRadius: BorderRadius.all(
  //                                                   Radius.circular(20)),
  //                                               border: new Border.all(
  //                                                   color: Color(0xFFD8AF4F),
  //                                                   width: 1.5),
  //                                               color: Color(0xFFD8AF4F)),
  //                                           child: MaterialButton(
  //                                             splashColor: Colors.grey,
  //                                             child: Text(
  //                                               sliderData.containsValue(0) ||
  //                                                       sliderData
  //                                                           .containsValue(20)
  //                                                   ? "NEXT"
  //                                                   : "SKIP",
  //                                               style: TextStyle(
  //                                                 color: Colors.white,
  //                                                 fontSize: ConstanceData
  //                                                     .SIZE_TITLE16,
  //                                               ),
  //                                             ),
  //                                             onPressed: () async {
  //                                               submit();
  //                                             },
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       )
  //                     : SizedBox(),
  //               ),
  //             ),
  //           ))
  //     ],
  //   );
  // }

  Future submit() async {
    var dataToSave = {};
    var userRisk = Provider.of<UserDetails>(context, listen: false).userDetails;
    sliderData.forEach((key, value) {
      var value;
      if (sliderData[key] == 0) {
        value = {
          "min_weight": 0,
          "max_weight": 0,
        };
      } else if (sliderData[key] == 10) {
        value = {
          "min_weight": 0,
          "max_weight": 100,
        };
      } else {
        value = {
          "min_weight": 10,
          "max_weight": 100,
        };
      }
      var changesKey;
      if (key == "Private Deals (PE/VC)") {
        changesKey = "Private_Equity";
        dataToSave[changesKey] = value;
      } else if (key == "Fixed Income" &&
          (userRisk["risk_appetite"] == 0.07 ||
              userRisk["risk_appetite"] == 0.15)) {
        changesKey = "Fixed Income";
        dataToSave[changesKey] = {
          "min_weight": 0,
          "max_weight": 100,
        };
      } else if (key == "Fixed Income") {
        changesKey = "Fixed Income";
        dataToSave[changesKey] = value;
      } else {
        changesKey = key.toString().replaceAll(" ", "_");
        dataToSave[changesKey] = value;
      }
    });

    Map<String, Map> data = {
      "assetclass_weights": dataToSave,
    };
    Provider.of<GoProDataProvider>(context, listen: false)
        .setSecondPagePreferences(data);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => OnBoardingThird(
          logo: widget.logo,
          callingFrom: widget.callingFrom,
        ),
      ),
    );
  }
}
