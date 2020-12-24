import 'package:auroim/auth/empStatus.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:modal_progress_hud/modal_progress_hud.dart';

class InvestorType extends StatefulWidget {
  @override
  _InvestorTypeState createState() => _InvestorTypeState();
}

class _InvestorTypeState extends State<InvestorType> {
  bool _isInvestorInProgress = false;

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
    AppBar appBar = AppBar();
    double appBarheight = appBar.preferredSize.height;


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
            inAsyncCall: _isInvestorInProgress,
            opacity: 0,
            progressIndicator: SizedBox(),
            child: SingleChildScrollView(
              // physics: BouncingScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height*1.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30)),
                  color: AllCoustomTheme.boxColor(),
                ),
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
                    Container(
                      height: 5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(2)),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            globals.buttoncolor1,
                            globals.buttoncolor2,
                          ],
                        ),
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: descTextShowFlag ? MediaQuery.of(context).size.height * 0.34 : MediaQuery.of(context).size.height * 0.23,
                        // height: MediaQuery.of(context).size.height * 0.34,

                        margin: EdgeInsets.only(
                            top: 15.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 10.0, left: 70.0, right: 50.0),
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                border: new Border.all(color: Colors.white, width: 1.5),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20.0)),
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
                                  "Accredited Investor",
                                  style: TextStyle(
                                    color: AllCoustomTheme.getTextThemeColors(),
                                    fontSize: ConstanceData.SIZE_TITLE18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () async {
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
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.0, left: 35.0, right: 5.0, bottom: 15.0),
                                child: Column(
                                  children: [
                                    Text("Net worth > 1 million, either individually, or jointly with your spouse ' "
                                        "'Net worth > 1 million, either individually, or jointly with your spouse' "
                                        "'Net worth > 1 million, either individually, or jointly with your spouse",
                                        maxLines: descTextShowFlag ? 8 : 2,textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        letterSpacing: .4,
                                        color: Colors.white
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
                                          descTextShowFlag ? Text("Show Less",style: TextStyle(color: Colors.blue),) :  Text("Show More",style: TextStyle(color: Colors.blue))
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
                                    "Retail Investor",
                                    style: TextStyle(
                                      color: AllCoustomTheme.getTextThemeColors(),
                                      fontSize: ConstanceData.SIZE_TITLE18,
                                      fontWeight: FontWeight.bold,
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
                                    '(select this option if you do not meet the criterion of Accredited Investor defined above And are not a student)',
                                    style: TextStyle(
                                      color: AllCoustomTheme.getTextThemeColors(),
                                      fontSize: ConstanceData.SIZE_TITLE16,
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
                                    "Student",
                                    style: TextStyle(
                                      color: AllCoustomTheme.getTextThemeColors(),
                                      fontSize: ConstanceData.SIZE_TITLE18,
                                      fontWeight: FontWeight.bold,
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
                                      color: AllCoustomTheme.getTextThemeColors(),
                                      fontSize: ConstanceData.SIZE_TITLE16,
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
}
