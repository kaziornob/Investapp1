import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/provider_abhinav/user_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LivePaperPortfolio extends StatefulWidget {
  @override
  _LivePaperPortfolioState createState() => _LivePaperPortfolioState();
}

class _LivePaperPortfolioState extends State<LivePaperPortfolio> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 16, right: 5.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.09,
              child: ListView(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          Provider.of<UserDetails>(context, listen: false)
                                          .userDetails["f_name"] !=
                                      null &&
                                  Provider.of<UserDetails>(context,
                                              listen: false)
                                          .userDetails !=
                                      null
                              ? "${Provider.of<UserDetails>(context).userDetails["f_name"]}\'s Portfolio Track Record"
                              : 'Portfolio Track Record',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFD8AF4F),
                            fontSize: ConstanceData.SIZE_TITLE18,
                            fontFamily: "Roboto",
                            package: 'Roboto-Regular',
                          ),
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.22),
                    padding: EdgeInsets.only(
                      bottom: 3, // space between underline and text
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: AllCoustomTheme.getHeadingThemeColors(),
                      width: 1.0, // Underline width
                    ))),
                  ),
                ],
              ),
            )),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // live section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Live',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AllCoustomTheme.getSeeMoreThemeColor(),
                            decoration: TextDecoration.underline,
                            fontSize: ConstanceData.SIZE_TITLE18,
                            fontFamily: "Roboto",
                            package: 'Roboto-Regular',
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: Icon(
                                      Icons.circle,
                                      color: AllCoustomTheme
                                          .getsecoundTextThemeColor(),
                                      size: 8,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Return: 25%',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color:
                                            AllCoustomTheme.getTextThemeColor(),
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        fontFamily: "Roboto",
                                        package: 'Roboto-Regular',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: Icon(
                                      Icons.circle,
                                      color: AllCoustomTheme
                                          .getsecoundTextThemeColor(),
                                      size: 8,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Risk/Volatility: 10%',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color:
                                            AllCoustomTheme.getTextThemeColor(),
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        fontFamily: "Roboto",
                                        package: 'Roboto-Regular',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: Icon(
                                      Icons.circle,
                                      color: AllCoustomTheme
                                          .getsecoundTextThemeColor(),
                                      size: 8,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Sharpe ratio: 2.1',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color:
                                            AllCoustomTheme.getTextThemeColor(),
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        fontFamily: "Roboto",
                                        package: 'Roboto-Regular',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ))),
                ],
              ),
              // paper section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Paper',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AllCoustomTheme.getSeeMoreThemeColor(),
                            decoration: TextDecoration.underline,
                            fontSize: ConstanceData.SIZE_TITLE18,
                            fontFamily: "Roboto",
                            package: 'Roboto-Regular',
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: Icon(
                                      Icons.circle,
                                      color: AllCoustomTheme
                                          .getsecoundTextThemeColor(),
                                      size: 8,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Return: 25%',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color:
                                            AllCoustomTheme.getTextThemeColor(),
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        fontFamily: "Roboto",
                                        package: 'Roboto-Regular',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: Icon(
                                      Icons.circle,
                                      color: AllCoustomTheme
                                          .getsecoundTextThemeColor(),
                                      size: 8,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Risk/Volatility: 10%',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color:
                                            AllCoustomTheme.getTextThemeColor(),
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        fontFamily: "Roboto",
                                        package: 'Roboto-Regular',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: Icon(
                                      Icons.circle,
                                      color: AllCoustomTheme
                                          .getsecoundTextThemeColor(),
                                      size: 8,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Sharpe ratio: 2.1',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color:
                                            AllCoustomTheme.getTextThemeColor(),
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        fontFamily: "Roboto",
                                        package: 'Roboto-Regular',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ))),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
