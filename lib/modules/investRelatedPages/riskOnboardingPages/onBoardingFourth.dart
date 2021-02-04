import 'dart:convert';

import 'package:animator/animator.dart';
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/home/homeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';


class OnBoardingFourth extends StatefulWidget {
  final String riskAptType;
  final List<dynamic> optionData;

  const OnBoardingFourth({Key key, @required this.riskAptType,this.optionData}) : super(key: key);

  @override
  _OnBoardingFourthState createState() => _OnBoardingFourthState();
}

class _OnBoardingFourthState extends State<OnBoardingFourth> {
  bool _isInProgress = false;
  ApiProvider request = new ApiProvider();

  /*List<dynamic> options = <dynamic>[
    {"checked":false,"potential_gain": "","potential_loss": ""},
    {"checked":false,"potential_gain": "","potential_loss": ""},
    {"checked":false,"potential_gain": "","potential_loss": ""},
    {"checked":false,"potential_gain": "","potential_loss": ""},
    {"checked":false,"potential_gain": "","potential_loss": ""}
  ];*/

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

  Widget getRiskApetiteView()
  {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ...widget.optionData.map((option) {
            var index = widget.optionData.indexOf(option);
            return Container(
                height: MediaQuery.of(context).size.height*0.35,
                // width: MediaQuery.of(context).size.width*0.175,
                margin: EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: index==0 ? MediaQuery.of(context).size.height*0.10
                          : (index==1 ? MediaQuery.of(context).size.height*0.09
                            : (index==2 ? MediaQuery.of(context).size.height*0.08
                              : (index==3 ? MediaQuery.of(context).size.height*0.07
                                  : (index==4 ? MediaQuery.of(context).size.height*0.06 : MediaQuery.of(context).size.height*0.10)))),
                      width: MediaQuery.of(context).size.width*0.09,
                      decoration: BoxDecoration(
                        color: Color(0xFF32CD32),
                      ),
                      child:Center(
                        child: Text(
                          '${option["potentialGain"]}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AllCoustomTheme.getTextThemeColors(),
                            fontSize: ConstanceData.SIZE_TITLE16,
                            fontFamily: "Roboto",
                            package: 'Roboto-Regular',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: index==0 ? MediaQuery.of(context).size.height*0.10
                          : (index==1 ? MediaQuery.of(context).size.height*0.09
                            : (index==2 ? MediaQuery.of(context).size.height*0.08
                              : (index==3 ? MediaQuery.of(context).size.height*0.07
                                  : (index==4 ? MediaQuery.of(context).size.height*0.06 : MediaQuery.of(context).size.height*0.10)))),
                      width: MediaQuery.of(context).size.width*0.09,
                      decoration: BoxDecoration(
                        color: Color(0xFFe70b31),
                      ),
                      child: Center(
                        child: Text(
                          '${option["potentialLoss"]}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AllCoustomTheme.getTextThemeColors(),
                            fontSize: ConstanceData.SIZE_TITLE16,
                            fontFamily: "Roboto",
                            package: 'Roboto-Regular',
                          ),
                        ),
                      ),
                    ),
                  ],
                )
            );
          }
        ),
      ],
    );
  }

  Widget getOptionList() {
    return Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: Colors.black,
        ),
        child:  Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ...widget.optionData.map((option) =>  Container(
              height: MediaQuery.of(context).size.height*0.01,
              width: MediaQuery.of(context).size.width*0.18,
              margin: EdgeInsets.only(left: 5.0),
              child: Checkbox(
                value: option["checked"],
                activeColor: Color(0xFFD8AF4F),
                onChanged: (newValue) {
                  print("newValue: $newValue");
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
    AppBar appBar = AppBar();
    double appBarheight = appBar.preferredSize.height;
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
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*1.7,
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
                                height: MediaQuery.of(context).size.height * 0.09,
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
                                      margin: EdgeInsets.only(left: 80.0,right: 80.0),
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
                              height: MediaQuery.of(context).size.height*0.17,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(top: 20.0,bottom: 14.0,left: 20.0,right: 20.0),
                              decoration: new BoxDecoration(
                                border: Border.all(
                                  // color: widget.callingFrom=="Accredited Investor" ?  Color(0xff696969) : Color(0xFFFFFFFF),
                                  color: Color(0xff696969),
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
                                              // color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFF000000),
                                              color: Colors.black,
                                              fontSize: ConstanceData.SIZE_TITLE16,
                                              fontFamily: "Rosarivo",
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
                                              // color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFF000000),
                                              color: Colors.black,
                                              fontSize: ConstanceData.SIZE_TITLE16,
                                              fontFamily: "Rosarivo",
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
                                              color: Colors.black,
                                              fontSize: ConstanceData.SIZE_TITLE16,
                                              fontFamily: "Rosarivo",
                                              letterSpacing: 0.1
                                          )
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
                                              color: Colors.black,
                                              fontSize: ConstanceData.SIZE_TITLE16,
                                              fontFamily: "Rosarivo",
                                              letterSpacing: 0.1)
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
                            child: getRiskApetiteView(),
                          ),
/*                          Container(
                            height: MediaQuery.of(context).size.height*0.30,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(top: 10.0,bottom: 14.0,left: 20.0,right: 20.0),
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: new AssetImage('assets/risk_onboarding_4-_pi_version.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),*/
                          Container(
                            child: getOptionList(),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
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
                                            "DONE",
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
                                  ],
                                ),
                              ),
                            ],
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

    print("optionData: ${widget.optionData}");

    var finalOptionData;
    for(var i=0 ; i < widget.optionData.length;i++)
    {
      if(widget.optionData[i]["checked"]==true)
      {
        finalOptionData.add(widget.optionData[i]);
      }
    }

    var tempJsonReq = {"riskApetite_type": "${widget.riskAptType}","answers": finalOptionData};

    print("final risk payload: $tempJsonReq");

    String jsonReq = json.encode(tempJsonReq);

    var jsonReqResp = await request.postSubmit('users/add_risk', jsonReq);

    var result = json.decode(jsonReqResp.body);
    print("post submit response: $result");


    if(jsonReqResp.statusCode == 200 || jsonReqResp.statusCode == 201)
    {

      if (result!=null && result.containsKey('auth') && result['auth']==true)
      {

        Toast.show("${result['message']}", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM);

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen()
            ),
            ModalRoute.withName("/Home")
        );
      }
    }
    else if(result!=null && result.containsKey('auth') && result['auth']!=true)
    {

      Toast.show("${result['message']}", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM);

      setState(() {
        _isInProgress = false;
      });
    }
    else{
      setState(() {
        _isInProgress = false;
      });
      Toast.show("Something went wrong!", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM);
    }
  }
}