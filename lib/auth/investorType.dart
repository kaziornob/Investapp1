import 'dart:convert';

import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/auth/riskApetitePages/riskApetiteForm.dart';
import 'package:auroim/model/radioQusModel.dart';
import 'package:auroim/resources/radioQusTemplateData.dart';
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
          backgroundColor: Colors.white,
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
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text:
                                    "Please select which customer segment you belong to? ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: 'Rosario')),
                            WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 2.0, left: 10),
                                child: Icon(CupertinoIcons.question_circle,
                                    size: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 30.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                bottom: 10.0, left: 30.0, right: 30.0),
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                                border: new Border.all(
                                    color: Color(0xFFD8AF4F), width: 1.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFD8AF4F).withOpacity(0.3),
                                    offset: const Offset(
                                      0.0,
                                      0.0,
                                    ),
                                    blurRadius: 5.0,
                                    spreadRadius: 5.0,
                                  )
                                ]),
                            child: MaterialButton(
                              splashColor: Colors.grey,
                              child: Text(
                                "Accredited Investor",
                                style: TextStyle(
                                  color: Color(0xFFD8AF4F),
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                ),
                              ),
                              onPressed: () {
                                // goToNextScreen();
                                _submit('Accredited Investor');
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 5.0,
                              left: 45.0,
                              right: 40.0,
                              bottom: 15.0,
                            ),
                            child: Column(
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            "Networth of >\$1 million either individually or jointly with your spouse ",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          letterSpacing: 0.2,
                                          fontFamily: "Rosario",
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                      WidgetSpan(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 2.0, left: 10),
                                          child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  descTextShowFlag =
                                                      !descTextShowFlag;
                                                  print(
                                                      "descTextShowFlag: $descTextShowFlag");
                                                });
                                              },
                                              child: Icon(
                                                  CupertinoIcons
                                                      .question_circle,
                                                  size: 14)),
                                        ),
                                      ),
                                      if (descTextShowFlag)
                                        TextSpan(
                                          text:
                                              "\n1. Networth of >\$1 million either individually or jointly with your spouse OR \n"
                                              "2. an annual income exceeding \$200,000 for the last two years OR \n"
                                              "3. \$300,000 for joint income for the last two years",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            letterSpacing: 0.2,
                                            fontFamily: "Rosario",
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    singleInvestorType(
                      "Retail Investor",
                      "Select the option if you do not meet the criterion of Accredited Investor above AND are not a student",
                      "",
                    ),
                    singleInvestorType(
                      "Student",
                      'If you’re college/ university/ high-school and want to learn about investing',
                      "",
                    ),
                    singleInvestorType(
                      "Research Analyst",
                      "If you're a research analyst with current or prior buyside",
                      "",
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  singleInvestorType(investorType, investorTypeInfo, tooltipText) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Container(
        margin: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                bottom: 10.0,
                left: 30.0,
                right: 30.0,
                top: 5,
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                border: new Border.all(color: Color(0xFFD8AF4F), width: 1.5),
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFD8AF4F).withOpacity(0.3),
                    offset: const Offset(
                      0.0,
                      0.0,
                    ),
                    blurRadius: 5.0,
                    spreadRadius: 5.0,
                  )
                ],
              ),
              child: MaterialButton(
                splashColor: Colors.grey,
                child: Text(
                  "$investorType",
                  style: TextStyle(
                    color: Color(0xFFD8AF4F),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
                onPressed: () async {
                  _submit("$investorType");
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: 5.0, left: 45.0, bottom: 5.0, right: 40.0),
              child: Text(
                '$investorTypeInfo',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  letterSpacing: 0.2,
                  fontFamily: "Rosario",
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _submit(status) async {
    var tempJsonReq = {"status": "$status"};

    print("final inv type payload: $tempJsonReq");

    String jsonReq = json.encode(tempJsonReq);
    var jsonReqResp =
        await request.postSubmitResponse('users/add_invtype', jsonReq);

    var result = json.decode(jsonReqResp.body);
    print("post submit response: $result");

    if (jsonReqResp.statusCode == 200 || jsonReqResp.statusCode == 201) {
      if (result != null &&
          result.containsKey('auth') &&
          result['auth'] == true) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('InvestorType', '$status');

        Toast.show("${result['message']}", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

        goToNextScreen();
      }
    } else if (result != null &&
        result.containsKey('auth') &&
        result['auth'] != true) {
      Toast.show("${result['message']}", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

      setState(() {
        _isInvestorInProgress = false;
      });
    } else {
      setState(() {
        _isInvestorInProgress = false;
      });
      Toast.show("Something went wrong!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  goToNextScreen() async {
    List<RadioQusModel> questions =
        await getRadioQusTempData('Accredited Investor', 'piVersion');

    Navigator.of(context, rootNavigator: true)
        .push(
      CupertinoPageRoute<void>(
        builder: (BuildContext context) => RiskAptForm(optionData: questions),
      ),
    )
        .then((onValue) {
      setState(() {
        _isInvestorInProgress = false;
      });
    });
  }
}
