
import 'package:auroim/constance/constance.dart';
import 'package:auroim/widgets/goLiveInvest/managmentFeeOptions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/themes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SecurityBuySell extends StatefulWidget {
  @override
  _SecurityBuySellState createState() => _SecurityBuySellState();
}

class _SecurityBuySellState extends State<SecurityBuySell> {

  bool _isBuySellInProgress = false;
  var _buSellScaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
    loadDetails();
  }

  loadDetails() async {
    setState(() {
      _isBuySellInProgress = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      _isBuySellInProgress = false;
    });
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        //search box area
        Container(
          margin: EdgeInsets.only(top: 10.0),
          decoration: new BoxDecoration(
            color: Color(0xFFFFFFFF),
            border: Border.all(
              color: Color(0xff696969),
              width: 1.5,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width*0.60,
                height: MediaQuery.of(context).size.height*0.05,
                child: TextFormField(
                  style: TextStyle(
                    color: AllCoustomTheme.getTextThemeColors(),
                    fontSize: ConstanceData.SIZE_TITLE14,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      FontAwesomeIcons.search,
                      color: AllCoustomTheme.getNewSecondTextThemeColor(),
                      size: 15,
                    ),
                    hintText: "Search",
                    hintStyle: TextStyle(
                      color: AllCoustomTheme.getNewSecondTextThemeColor(),
                      fontSize: ConstanceData.SIZE_TITLE14,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    // AppBar appBar = AppBar();
    // double appBarheight = appBar.preferredSize.height;
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(65.0),
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AllCoustomTheme.getAppBarBackgroundThemeColors(),
              title: _buildAppBar(context),
            ),
          ),
          body: ModalProgressHUD(
            inAsyncCall: _isBuySellInProgress,
            opacity: 0,
            progressIndicator: CupertinoActivityIndicator(
              radius: 12,
            ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: !_isBuySellInProgress
                    ? Column(
                  children: <Widget>[
                    SizedBox(
                        height: 2,
                        child: Container(
                          decoration: new BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            border: Border.all(
                              color: Color(0xFFFFFFFF),
                              width: 1.5,
                            ),
                          ),
                        ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                              height: MediaQuery.of(context).size.height*0.60,
                              width: MediaQuery.of(context).size.width*0.32,
                              decoration: BoxDecoration(
                                  color: Color(0xFF7499C6),
                                  border: Border(
                                      bottom: BorderSide(
                                        color: Color(0xFF7499C6),
                                        width: 1.0, // Underline width
                                      )
                                  )
                              ),
                              child: Center(
                                child: Text(
                                  "Security Box",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: "Roboto",
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              )
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.060,
                          width: MediaQuery.of(context).size.width * 0.40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: new Border.all(color: Colors.red, width: 1.5),
                            color: Colors.red,
                          ),
                          child: MaterialButton(
                            splashColor: Colors.grey,
                            child: Text(
                              "SELL",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ConstanceData.SIZE_TITLE14,
                              ),
                            ),
                            onPressed: () async
                            {
/*                              Navigator.of(context, rootNavigator: true)
                                  .push(
                                CupertinoPageRoute<void>(
                                  builder: (BuildContext context) => SignInScreen(),
                                ),
                              );*/
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.060,
                          width: MediaQuery.of(context).size.width * 0.40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              border: new Border.all(color: Colors.green, width: 1.5),
                              color: Colors.green
                          ),
                          child: MaterialButton(
                            splashColor: Colors.grey,
                            child: Text(
                              "BUY",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ConstanceData.SIZE_TITLE14,
                              ),
                            ),
                            onPressed: () async
                            {
                              Navigator.of(context,
                                  rootNavigator: true)
                                  .push(
                                CupertinoPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      ManagementFeeOptions(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                  ],
                )
                    : SizedBox(),
              ),
            ),
          ),
        )
      ],
    );
  }
}