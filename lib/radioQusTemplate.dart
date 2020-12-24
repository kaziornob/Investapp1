import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/routes.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/radioQusModel.dart';
import 'package:auroim/resources/radioQusTemplateData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RadioQusTemplate extends StatefulWidget {

  final List<RadioQusModel> optionData;

  const RadioQusTemplate({Key key, @required this.optionData}) : super(key: key);

  @override
  _RadioQusTemplateState createState() => _RadioQusTemplateState();
}

class _RadioQusTemplateState extends State<RadioQusTemplate> {
  bool _isRadioQusInProgress = false;
  bool _visibleRadioQus = false;
  String selectedValue = '';


  animation() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _visibleRadioQus = true;
    });
  }

  @override
  void initState() {
    super.initState();
    animation();
  }


  Widget getOptionList(options) {
    return Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: Colors.white,
        ),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ...options.map((option) => RadioListTile(
              title: Text(
                "${option['title']}",
                style: TextStyle(
                    fontSize: 16.5,
                    color: Color(0xFFFFFFFF),
                    fontFamily: "Poppins"),
              ),
              subtitle: Visibility(
                visible: option['subTitle']!='' ? true :false,
                child: Text(
                  "${option['subTitle']}",
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Color(0xFFFFFFFF),
                      fontFamily: "Poppins"),
                ),
              ),
              value: option["option_value"],
              groupValue: selectedValue,
              activeColor: Color(0xFFffffff),
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
        Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                HexColor(globals.primaryColorString).withOpacity(0.6),
                HexColor(globals.primaryColorString).withOpacity(0.6),
                HexColor(globals.primaryColorString).withOpacity(0.6),
                HexColor(globals.primaryColorString).withOpacity(0.6),
              ],
            ),
          ),
        ),
        Scaffold(
          backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
          body: ModalProgressHUD(
            inAsyncCall: _isRadioQusInProgress,
            opacity: 0,
            progressIndicator: SizedBox(),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height *1.03,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.12,
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: Center(
                            child: new Image(
                                width: 270.0,
                                fit: BoxFit.fill,
                                image: new AssetImage('assets/logo.png')
                            ),
                          )
                      ),
                      _visibleRadioQus
                          ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5)),
                            color: AllCoustomTheme.qusBoxColor(),
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 0.5,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 14, bottom: 10,top: 15.0),
                                      child: Text(
                                        '${widget.optionData[0].qusHeadline}',
                                        style: new TextStyle(
                                            fontFamily: "WorkSansSemiBold",
                                            color: Color(0xFFFFFFFF), fontSize: 18.0,
                                            letterSpacing: 0.1
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
                                      height: 50,
                                      child: Animator(
                                        tween: Tween<double>(begin: 0.8, end: 1.1),
                                        curve: Curves.easeInToLinear,
                                        cycles: 0,
                                        builder: (anim) => Transform.scale(
                                          scale: anim.value,
                                          child: Container(
                                            height: 50,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              border: new Border.all(color: Colors.white, width: 1.5),
                                              gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  globals.buttoncolor1,
                                                  globals.buttoncolor2,
                                                ],
                                              ),
                                            ),
                                            child: MaterialButton(
                                              splashColor: Colors.grey,
                                              child: Text(
                                                "NEXT",
                                                style: TextStyle(
                                                  color: AllCoustomTheme.getTextThemeColors(),
                                                  fontSize: ConstanceData.SIZE_TITLE18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              onPressed: () async {
                                                _submit();
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

  _submit() async {

    setState(() {
      _isRadioQusInProgress = true;
    });

    await Future.delayed(const Duration(milliseconds: 700));

    if(widget.optionData[0].childFrom=='piVersion')
      {
        Navigator.pushNamedAndRemoveUntil(context, Routes.Home, (Route<dynamic> route) => false);

      }
    else
      {
        var childFrom = widget.optionData[0].childFrom=='empStatus' ? 'piVersion' : '';

        List<RadioQusModel> questions = await getRadioQusTempData(widget.optionData[0].parentFrom,childFrom);


        Navigator.of(context, rootNavigator: true).push(
          CupertinoPageRoute<void>(
            builder: (BuildContext context) =>
                RadioQusTemplate(optionData: questions),
          ),
        ).then((onValue) {
          setState(() {
            _isRadioQusInProgress = false;
          });
        });
      }
  }
}
