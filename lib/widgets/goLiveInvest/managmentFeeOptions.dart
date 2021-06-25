import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/themes.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ManagementFeeOptions extends StatefulWidget {
  @override
  _ManagementFeeOptionsState createState() => _ManagementFeeOptionsState();
}

class _ManagementFeeOptionsState extends State<ManagementFeeOptions> {
  bool _isFeeInProgress = false;

  @override
  void initState() {
    super.initState();
    loadDetails();
  }

  loadDetails() async {
    setState(() {
      _isFeeInProgress = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      _isFeeInProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // AppBar appBar = AppBar();
    // double appBarheight = appBar.preferredSize.height;
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
          body: ModalProgressHUD(
            inAsyncCall: _isFeeInProgress,
            opacity: 0,
            progressIndicator: CupertinoActivityIndicator(
              radius: 12,
            ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                // height: MediaQuery.of(context).size.height *1.02,
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 40,
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
                                builder: (_, anim, __) => FractionalTranslation(
                                  translation: anim.value,
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: AllCoustomTheme.getTextThemeColors(),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Animator(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.decelerate,
                                cycles: 1,
                                builder: (_, anim, __) => Transform.scale(
                                  scale: anim.value,
                                  child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.09,
                                      child: Center(
                                        child: new Image(
                                            width: 150.0,
                                            fit: BoxFit.fill,
                                            image: new AssetImage(
                                                'assets/logo.png')),
                                      )),
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 80.0, right: 80.0),
                          padding: EdgeInsets.only(
                            bottom: 1, // space between underline and text
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: Color(0xFFD8AF4F),
                            width: 1.5, // Underline width
                          ))),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                          child: Padding(
                                        padding: EdgeInsets.only(top: 5.0),
                                        child: Text(
                                          'Select your management fee option',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: AllCoustomTheme
                                                .getTextThemeColors(),
                                            fontSize:
                                                ConstanceData.SIZE_TITLE18,
                                            fontFamily: "Roboto",
                                          ),
                                        ),
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      border: new Border.all(
                                          color: Color(0xFFfec20f), width: 1.5),
                                      color: Color(0xFFfec20f),
                                    ),
                                    child: MaterialButton(
                                      splashColor: Colors.grey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Management Fee: 0.75 %",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE20,
                                            ),
                                          ),
                                          Text(
                                            "Performance Fee: 5 %",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      onPressed: () async {},
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      border: new Border.all(
                                          color: Color(0xFFfec20f), width: 1.5),
                                      color: Color(0xFFfec20f),
                                    ),
                                    child: MaterialButton(
                                      splashColor: Colors.grey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Management Fee: 0.50 %",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE20,
                                            ),
                                          ),
                                          Text(
                                            "Performance Fee: 10 %",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      onPressed: () async {},
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      border: new Border.all(
                                          color: Color(0xFFfec20f), width: 1.5),
                                      color: Color(0xFFfec20f),
                                    ),
                                    child: MaterialButton(
                                      splashColor: Colors.grey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Management Fee: 0 %",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE20,
                                            ),
                                          ),
                                          Text(
                                            "Performance Fee: 25 %",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      onPressed: () async {},
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
