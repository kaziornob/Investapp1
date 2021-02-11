import 'dart:convert';
import 'package:animator/animator.dart';
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/auth/riskApetitePages/annualReturnForm.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/global.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/radioQusModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class RiskAptForm extends StatefulWidget {

  final List<RadioQusModel> optionData;

  const RiskAptForm({Key key, @required this.optionData}) : super(key: key);

  @override
  _RiskAptFormState createState() => _RiskAptFormState();
}

class _RiskAptFormState extends State<RiskAptForm> {
  bool _isRadioQusInProgress = false;
  bool _visibleRadioQus = false;
  String selectedValue;
  ApiProvider request = new ApiProvider();


  animation() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _visibleRadioQus = true;
    });
  }

  @override
  void initState() {
    selectedValue = "";
    super.initState();
    animation();
  }


  Widget getOptionList(options) {
    return Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: Colors.black,
        ),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ...options.map((option) => RadioListTile(
              title: Text(
                "${option['title']}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ConstanceData.SIZE_TITLE15,
                  fontFamily: "Roboto",
                ),
              ),
              subtitle: Visibility(
                visible: option['subTitle']!='' ? true :false,
                child: Text(
                  "${option['subTitle']}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: ConstanceData.SIZE_TITLE14,
                    fontFamily: "Roboto",
                  ),
                ),
              ),
              value: option["option_value"],
              groupValue: selectedValue,
              activeColor: Color(0xFFD8AF4F),
              onChanged: (value) {
                print("Radio Tile pressed $value");
                setState(() => selectedValue = value);
              },
            )),
          ],
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();

    RadioQusModel question = widget.optionData[0];
    final List<dynamic> options = question.qusOptions;

    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: AllCoustomTheme.getBodyContainerThemeColor(),
          body: ModalProgressHUD(
            inAsyncCall: _isRadioQusInProgress,
            opacity: 0,
            progressIndicator: SizedBox(),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                  color: AllCoustomTheme.getBodyContainerThemeColor(),
                  // height: MediaQuery.of(context).size.height *1.03,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
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
                        _visibleRadioQus
                            ? Container(
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5)),
                          //   color: AllCoustomTheme.qusBoxColor(),
                          // ),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 14, bottom: 10,top: 15.0),
                                        child: Text(
                                          '${widget.optionData[0].qusHeadline}',
                                          style: new TextStyle(
                                            color: Colors.black,
                                            fontSize: ConstanceData.SIZE_TITLE16,
                                            fontFamily: "Roboto",
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 14, bottom: 10),
                                        child: getOptionList(options),
                                      ),
                                    ),

                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20, left: 14, right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 37,
                                        child: Animator(
                                          tween: Tween<double>(begin: 0.8, end: 1.1),
                                          curve: Curves.easeInToLinear,
                                          cycles: 0,
                                          builder: (anim) => Transform.scale(
                                            scale: anim.value,
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
                                                  "NEXT",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: ConstanceData.SIZE_TITLE18,
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  if(selectedValue!=null && selectedValue!="")
                                                    _submit();
                                                  else{
                                                    Toast.show("Choose Any Option First", context,
                                                        duration: Toast.LENGTH_LONG,
                                                        gravity: Toast.BOTTOM);
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                        )
                            : SizedBox()
                      ],
                    ),
                  )
              ),
            ),
          ),
        )
      ],
    );
  }

  setData()
  {
    var exist = false;
    var foundIndex;

    if(GlobalInstance.riskInfoQusAns!=null && GlobalInstance.riskInfoQusAns.length!=0)
    {

      for(var i = 0; i < GlobalInstance.riskInfoQusAns.length; i++){
        print("riskInfoQusAns qus_id: ${GlobalInstance.riskInfoQusAns[i]["qus_id"]}");
        print("qus_id: ${widget.optionData[0].qusID}");

        if(GlobalInstance.riskInfoQusAns[i]["qus_id"]==widget.optionData[0].qusID) {
          setState(() {
            exist = true;
            foundIndex = i;
          });
          break;
        }
      }
      print("exist: $exist and foundIndex: $foundIndex");

      // check value exist or not
      if(exist==false)
      {
        GlobalInstance.riskInfoQusAns.add(
          {
            "qus_id":"${widget.optionData[0].qusID}",
            "qus_title":"${widget.optionData[0].qusHeadline}",
            "ans":"$selectedValue"
          },
        );
      }
      else
      {
        GlobalInstance.riskInfoQusAns[foundIndex]["ans"] = "$selectedValue";
      }
    }
    else
    {
      GlobalInstance.riskInfoQusAns = [];

      GlobalInstance.riskInfoQusAns.add(
        {
          "qus_id":"${widget.optionData[0].qusID}",
          "qus_title":"${widget.optionData[0].qusHeadline}",
          "ans":"$selectedValue"
        },
      );
    }
  }

  getRiskAptOptions()
  {
    var data = GlobalInstance.riskAptOptionsValue;
    for(var i=0; i<data.length;i++)
      {
        if(data[i]["riskAptType"]==selectedValue)
          {
            var options = data[i]["optionValue"];
            return options;
          }
      }
  }

  _submit() async {

    setState(() {
      _isRadioQusInProgress = true;
    });

    // setData(); // to set data at risk payload

    var optionData = getRiskAptOptions();

    print("risk payload: ${GlobalInstance.riskInfoQusAns}");

    await Future.delayed(const Duration(milliseconds: 700));

    Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute<void>(
        builder: (BuildContext context) =>
            AnnualReturnForm(riskAptType: selectedValue,optionData: optionData),
      ),
    ).then((onValue) {
      setState(() {
        _isRadioQusInProgress = false;
      });
    });

/*    if(widget.optionData[0].childFrom=='piVersion')
    {

      print("final risk payload: ${GlobalInstance.riskInfoQusAns}");

      String jsonReq = json.encode(GlobalInstance.riskInfoQusAns);

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
          _isRadioQusInProgress = false;
        });
      }
      else{
        setState(() {
          _isRadioQusInProgress = false;
        });
        Toast.show("Something went wrong!", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM);
      }

    }*/
  }
}
