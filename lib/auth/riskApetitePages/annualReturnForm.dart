import 'dart:convert';
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/auth/riskApetitePages/esg_screen.dart';
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

  const AnnualReturnForm({Key key, @required this.riskAptType, this.optionData})
      : super(key: key);

  @override
  _AnnualReturnFormState createState() => _AnnualReturnFormState();
}

class _AnnualReturnFormState extends State<AnnualReturnForm> {
  bool _isInProgress = false;
  ApiProvider request = new ApiProvider();
  String annualReturnValue;

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

  Widget getRiskApetiteView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ...widget.optionData.map((option) {
          var index = widget.optionData.indexOf(option);
          return Positioned(
            top: index == 0
                ? 0
                : (index == 1
                    ? 7
                    : (index == 2
                        ? 14
                        : (index == 3 ? 21 : (index == 4 ? 28 : 0)))),
            child: Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.033,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      color: Color(0xff1D6177)),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.033,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      color: Color(0xffFAB95B)),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget getOptionList() {
    return Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: Colors.black,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ...widget.optionData.map((option) {
              var index = widget.optionData.indexOf(option);
              return Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.10,
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
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.033,
                        width: index == 0
                            ? MediaQuery.of(context).size.width * 0.40
                            : (index == 1
                                ? MediaQuery.of(context).size.width * 0.35
                                : (index == 2
                                    ? MediaQuery.of(context).size.width * 0.30
                                    : (index == 3
                                        ? MediaQuery.of(context).size.width *
                                            0.25
                                        : (index == 4
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.20
                                            : 0)))),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                          color: Color(0xff1D6177),
                        ),
                        child: Text(
                          '${option["potentialGain"]}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height * 0.033,
                          width: index == 0
                              ? MediaQuery.of(context).size.width * 0.40
                              : (index == 1
                                  ? MediaQuery.of(context).size.width * 0.35
                                  : (index == 2
                                      ? MediaQuery.of(context).size.width * 0.30
                                      : (index == 3
                                          ? MediaQuery.of(context).size.width *
                                              0.25
                                          : (index == 4
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.20
                                              : 0)))),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                              color: Color(0xffFAB95B)),
                          child: Text(
                            '${option["potentialLoss"]}',
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  ),
                ],
              );
            }),
          ],
        ));
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
                            Text(
                              'RISK-RETURN TRADEOFF',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'RosarioSemiBold',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 12.0, right: 30),
                              child: Text(
                                'There is risk (potential loss) trade-off to achieve any return (potential gain). Please select the combination below you are most comfortable with?*',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 8),
                                      height: 16,
                                      width: 16,
                                      decoration: BoxDecoration(
                                        color: Color(0xff1D6177),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                    Text(
                                      'Potential gain',
                                      style: TextStyle(
                                          fontSize: 14, fontFamily: 'Roboto'),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 8),
                                      height: 16,
                                      width: 16,
                                      decoration: BoxDecoration(
                                        color: Color(0xffFAB95B),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                    Text(
                                      'Potential loss',
                                      style: TextStyle(
                                          fontSize: 14, fontFamily: 'Roboto'),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            getOptionList(),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Text(
                                "These are expectation's of potential gains and loses from our model. Actual gains and loose can vary significantly from thse levels.",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF5E5E5E),
                                ),
                              ),
                            ),
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
                                  size: 32,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : SizedBox(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  getDrawDownConvertedValue() {
    var tempDrawDown;
    var tempPerDrawDownValue = annualReturnValue.split('%');
    print("tempDrawDownValue: $tempPerDrawDownValue");

    if (tempPerDrawDownValue[0].contains('-')) {
      var temp = tempPerDrawDownValue[0].split('-');
      print("temp: $temp");
      tempDrawDown = int.parse(temp[1]);
    } else {
      tempDrawDown = int.parse(tempPerDrawDownValue[0]);
    }

    print("tempDrawDown: $tempDrawDown");
    var drawDown = tempDrawDown / 100;
    print("drawDown: $drawDown");
    return drawDown;
  }

  Future submit() async {
    var drawDown = getDrawDownConvertedValue();

    var tempJsonReq = {
      "riskApetite_type": "${widget.riskAptType}",
      "drawdown": drawDown
    };

    print("final risk payload: $tempJsonReq");

    String jsonReq = json.encode(tempJsonReq);

    var jsonReqResp =
        await request.postSubmitResponse('users/add_risk', jsonReq);

    var result = json.decode(jsonReqResp.body);
    print("post submit response: $result");

    if (jsonReqResp.statusCode == 200 || jsonReqResp.statusCode == 201) {
      if (result != null &&
          result.containsKey('auth') &&
          result['auth'] == true) {
        Toast.show("Please Wait...", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EsgScreen(),
          ),
        );
      }
    } else if (result != null &&
        result.containsKey('auth') &&
        result['auth'] != true) {
      Toast.show("${result['message']}", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

      setState(() {
        _isInProgress = false;
      });
    } else {
      setState(() {
        _isInProgress = false;
      });
      Toast.show("Something went wrong!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }
}
