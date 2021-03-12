import 'dart:convert';

import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/global.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/home/homeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';


class AnnualReturnForm extends StatefulWidget {
  final String riskAptType;
  final List<dynamic> optionData;

  const AnnualReturnForm({Key key, @required this.riskAptType,this.optionData}) : super(key: key);

  @override
  _AnnualReturnFormState createState() => _AnnualReturnFormState();
}

class _AnnualReturnFormState extends State<AnnualReturnForm> {
  bool _isInProgress = false;
  ApiProvider request = new ApiProvider();
  String annualReturnValue;

  /*List<dynamic> options = <dynamic>[
    {"checked":false,"potential_gain": "","potential_loss": ""},
    {"checked":false,"potential_gain": "","potential_loss": ""},
    {"checked":false,"potential_gain": "","potential_loss": ""},
    {"checked":false,"potential_gain": "","potential_loss": ""},
    {"checked":false,"potential_gain": "","potential_loss": ""}
  ];*/

  @override
  void initState() {
    annualReturnValue = '';
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
            height: MediaQuery.of(context).size.height*0.22,
            width: MediaQuery.of(context).size.width*0.177,
            child: Stack(
              children: [
                Positioned(
                  top: index==0 ? 0 : (index==1 ? 7 : (index==2 ? 14 : (index==3 ? 21 : (index==4 ? 28 : 0)))),
                  child:  Container(
                    height: MediaQuery.of(context).size.height*0.11,
                    width: MediaQuery.of(context).size.width*0.09,
                    decoration: BoxDecoration(
                      color: Color(0xFF32CD32),
                    ),
                    child:Text(
                      '${option["potentialGain"]}',
                      style: TextStyle(
                        color: AllCoustomTheme.getTextThemeColors(),
                        fontSize: ConstanceData.SIZE_TITLE15,
                        fontFamily: "RobotoLight",
                      ),
                    ),
                  ),
                ),
                Positioned(
/*                  top: 70,
                  right: 31,*/
                  top: MediaQuery.of(context).size.height*0.11,
                  right: MediaQuery.of(context).size.width*0.086,
                  bottom: index==0 ? 0 : (index==1 ? 15 : (index==2 ? 20 : (index==3 ? 25 : (index==4 ? 30 : 0)))),
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.11,
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
                          fontSize: ConstanceData.SIZE_TITLE15,
                          fontFamily: "RobotoLight",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
         }
        ),
      ],
    );

/*    return Row(
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
                            fontSize: ConstanceData.SIZE_TITLE15,
                            fontFamily: "RobotoLight",
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
                            fontSize: ConstanceData.SIZE_TITLE15,
                            fontFamily: "RobotoLight",
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
    );*/
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
              // margin: EdgeInsets.only(left: 3.0),
              child: Radio(
                value: option["potentialLoss"],
                groupValue: annualReturnValue,
                activeColor: Color(0xFFD8AF4F),
                onChanged: (newValue) {
                  print("newValue: $newValue");
                  setState(() {
                    annualReturnValue = newValue;
                  });
                },
              ),
/*              Checkbox(
                value: option["checked"],
                activeColor: Color(0xFFD8AF4F),
                onChanged: (newValue) {
                  print("newValue: $newValue");
                  setState(() {
                    option["checked"] = newValue;
                  });
                },
              ),*/
            )
            ),
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      // width: MediaQuery.of(context).size.width,
                      // height: MediaQuery.of(context).size.height*1.7,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              height: MediaQuery.of(context).size.height * 0.09,
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
/*                          Row(
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
                              SizedBox(
                                width: 60,
                              ),
                              Container(
                                // height: MediaQuery.of(context).size.height * 0.09,
                                // width: MediaQuery.of(context).size.width * 0.90,
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
                          ),*/

                          Container(
                              height: MediaQuery.of(context).size.height*0.19,
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
                                              fontFamily: "RobotoLight",
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 4.0),
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
                                              fontFamily: "RobotoLight",
                                              letterSpacing: 0.1
                                          )
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 4.0),
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
                                              fontFamily: "RobotoLight",
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
                            height: MediaQuery.of(context).size.height*0.25,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(top: 10.0,bottom: 14.0,left: 16.0,right: 20.0),
                            child: getRiskApetiteView(),
                          ),
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
                                      height: 37,
                                      child: Container(
                                        height: 37,
                                        width: 130,
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
                                              fontSize: ConstanceData.SIZE_TITLE18,
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

  getDrawDownConvertedValue()
  {
    var tempDrawDown;
    var tempPerDrawDownValue = annualReturnValue.split('%');
    print("tempDrawDownValue: $tempPerDrawDownValue");

    if(tempPerDrawDownValue[0].contains('-')) {
      var temp = tempPerDrawDownValue[0].split('-');
      print("temp: $temp");
      tempDrawDown = int.parse(temp[1]);
    }
    else
      {
        tempDrawDown = int.parse(tempPerDrawDownValue[0]);
      }

    print("tempDrawDown: $tempDrawDown");
    var drawDown = tempDrawDown/100;
    print("drawDown: $drawDown");
    return drawDown;
  }

  Future submit() async {

/*    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen()
        ),
        ModalRoute.withName("/Home")
    );*/

    var drawDown = getDrawDownConvertedValue();

    var tempJsonReq = {"riskApetite_type": "${widget.riskAptType}","drawdown": drawDown};

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

        HelperClass.showLoading(context);

        createPortfolioData();
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

  Future<void> createPortfolioData() async {
    print("getDoughnutPortfolioData called");
    var response =
    await request.getRunAlgoExistingPortfolio('users/create_portfolio');
    print("portfolio chart list: $response");
    if (response != null && response != false && response.containsKey('auth') && response['auth'] == true) {

      Navigator.pop(context);

      Toast.show("Portfolio created successfully", context,
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
    else
      {
        Navigator.pop(context);

        Toast.show("Not able to create portfolio", context,
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
}