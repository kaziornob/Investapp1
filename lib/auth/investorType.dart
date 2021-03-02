import 'dart:convert';

import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/auth/empStatus.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class InvestorType extends StatefulWidget {
  @override
  _InvestorTypeState createState() => _InvestorTypeState();
}

class _InvestorTypeState extends State<InvestorType> {
  bool _isInvestorInProgress = false;
  ApiProvider request = new ApiProvider();


  animation() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  void initState() {
    super.initState();
    animation();
  }

  bool descTextShowFlag = false;


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          // backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
          backgroundColor: AllCoustomTheme.boxColor(),
          body: ModalProgressHUD(
            inAsyncCall: _isInvestorInProgress,
            opacity: 0,
            progressIndicator: SizedBox(),
            child: SingleChildScrollView(
              // physics: BouncingScrollPhysics(),
              child: Container(
                // height: MediaQuery.of(context).size.height*1.1,
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30)),
                  // color: AllCoustomTheme.boxColor(),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
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
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: descTextShowFlag ? MediaQuery.of(context).size.height * 0.36 : MediaQuery.of(context).size.height * 0.26,
                        margin: EdgeInsets.only(top: 30.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 10.0, left: 70.0, right: 50.0),
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                border: new Border.all(color: Colors.white, width: 1.5),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20.0)),
                                color: Color(0xFFD8AF4F),
                              ),
                              child: MaterialButton(
                                splashColor: Colors.grey,
                                child: Text(
                                  "Accredited Investor",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ConstanceData.SIZE_TITLE18,
                                  ),
                                ),
                                onPressed: () {
                                  _submit('Accredited Investor');
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.0, left: 35.0, right: 5.0, bottom: 15.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Networth of >\$1 million either individually or jointly with your spouse OR ?"
                                          "1. Networth of >\$1 million either individually or jointly with your spouse OR"
                                          "2. an annual income exceeding \$200,000 for the last two years OR"
                                          "3. \$300,000 for joint income for the last two years",
                                        maxLines: descTextShowFlag ? 8 : 2,textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        fontSize: ConstanceData.SIZE_TITLE14,
                                        color: Colors.white,
                                        letterSpacing: 0.2,
                                        fontFamily: "Rasa",
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){ setState(() {
                                        descTextShowFlag = !descTextShowFlag;
                                        print("descTextShowFlag: $descTextShowFlag");
                                      }); },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          descTextShowFlag ? Text("Show Less",style: TextStyle(color: AllCoustomTheme.getSeeMoreThemeColor(),
                                            fontSize: ConstanceData.SIZE_TITLE15,
                                            fontFamily: "Roboto",),)
                                              :  Text("Show More",style: TextStyle(color: AllCoustomTheme.getSeeMoreThemeColor(),
                                            fontSize: ConstanceData.SIZE_TITLE15,
                                            fontFamily: "Roboto",))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                            ),
                          ],
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height *
                          0.25,
                      child: Container(
                          margin: EdgeInsets.only(
                              top: 5.0, left: 5.0, right: 5.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 10.0,
                                    left: 70.0,
                                    right: 50.0),
                                width: MediaQuery.of(context)
                                    .size
                                    .width *
                                    0.9,
                                decoration: BoxDecoration(
                                  border: new Border.all(color: Colors.white, width: 1.5),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20.0)),
                                  color: Color(0xFFD8AF4F),
                                ),
                                child: MaterialButton(
                                  splashColor: Colors.grey,
                                  child: Text(
                                    "Retail Investor",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ConstanceData.SIZE_TITLE18,
                                    ),
                                  ),
                                  onPressed: () async {
/*                                      Navigator.of(context).push(new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              PiEmpStatus(parentFrom: 'Retail Investor')));*/
                                  },
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(
                                      top: 5.0,
                                      left: 30.0,
                                      bottom: 5.0,
                                      right: 5.0),
                                  child: Text(
                                    "Select the option if you do not meet the criterion of Accredited Investor above AND are not a student",
                                    style: TextStyle(
                                      fontSize: ConstanceData.SIZE_TITLE14,
                                      color: Colors.white,
                                      letterSpacing: 0.2,
                                      fontFamily: "Rasa",
                                      fontStyle: FontStyle.normal,
                                    ),
                                  )),
                            ],
                          )),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height *
                          0.25,
                      child: Container(
                          margin: EdgeInsets.only(
                              top: 5.0, left: 5.0, right: 5.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 10.0,
                                    left: 70.0,
                                    right: 50.0),
                                width: MediaQuery.of(context)
                                    .size
                                    .width *
                                    0.9,
                                decoration: BoxDecoration(
                                  border: new Border.all(color: Colors.white, width: 1.5),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20.0)),
                                  color: Color(0xFFD8AF4F),
                                ),
                                child: MaterialButton(
                                  splashColor: Colors.grey,
                                  child: Text(
                                    "Student",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ConstanceData.SIZE_TITLE18,
                                    ),
                                  ),
                                  onPressed: () async {
/*                                      Navigator.of(context).push(new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              PiEmpStatus(parentFrom: 'Retail Investor')));*/
                                  },
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(
                                      top: 5.0,
                                      left: 30.0,
                                      bottom: 5.0,
                                      right: 5.0),
                                  child: Text(
                                    'if you’re in college/ uni/ high-school and want to learn about investing',
                                    style: TextStyle(
                                      fontSize: ConstanceData.SIZE_TITLE14,
                                      color: Colors.white,
                                      letterSpacing: 0.2,
                                      fontFamily: "Rasa",
                                      fontStyle: FontStyle.normal,
                                    ),
                                  )),
                            ],
                          )),
                    ),
                  ],
                ),
              )
            ),
          ),
        )
      ],
    );
  }

  _submit(status) async {
    var tempJsonReq = {"status": "$status"};

    print("final inv type payload: $tempJsonReq");

    String jsonReq = json.encode(tempJsonReq);

    var jsonReqResp = await request.postSubmit('users/add_invtype', jsonReq);

    var result = json.decode(jsonReqResp.body);
    print("post submit response: $result");

    if(jsonReqResp.statusCode == 200 || jsonReqResp.statusCode == 201)
    {

      if (result!=null && result.containsKey('auth') && result['auth']==true)
      {

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('InvestorType', '$status');

        Toast.show("${result['message']}", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM);

        Navigator.of(context, rootNavigator: true).push(
          CupertinoPageRoute<void>(
            builder: (BuildContext context) =>
                EmpStatus(parentFrom: 'Accredited Investor'),
          ),
        ).then((onValue) {
          setState(() {
            _isInvestorInProgress = false;
          });
        });
      }
    }
    else if(result!=null && result.containsKey('auth') && result['auth']!=true)
    {

      Toast.show("${result['message']}", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM);

      setState(() {
        _isInvestorInProgress = false;
      });
    }
    else{
      setState(() {
        _isInvestorInProgress = false;
      });
      Toast.show("Something went wrong!", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM);
    }
  }
}
