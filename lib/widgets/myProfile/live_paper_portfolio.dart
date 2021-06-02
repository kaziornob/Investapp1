import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/provider_abhinav/portfolio_pitch_provider.dart';
import 'package:auroim/provider_abhinav/stock_pitch_provider.dart';
import 'package:auroim/provider_abhinav/user_details.dart';
import 'package:auroim/widgets/stock_and_portfolio_pitch/show_portfolio_pitch_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LivePaperPortfolio extends StatefulWidget {
  final userName;
  final email;

  const LivePaperPortfolio({Key key, this.userName, this.email})
      : super(key: key);

  @override
  _LivePaperPortfolioState createState() => _LivePaperPortfolioState();
}

class _LivePaperPortfolioState extends State<LivePaperPortfolio> {
  String title;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<PortfolioPitchProvider>(context)
          .getPortfolioPitches(widget.email);
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // var userProvider = Provider.of<UserDetails>(context, listen: false);
    // if (widget.userName == null) {
    //   title = userProvider.userDetails["f_name"] != null &&
    //           userProvider.userDetails != null
    //       ? "${userProvider.userDetails["f_name"]}\'s Portfolio Track Record"
    //       : 'Portfolio Track Record';
    // } else {
    //   title = "${widget.userName}\'s Portfolio Track Record";
    // }

    return Consumer<PortfolioPitchProvider>(
      builder: (context, portfolioProvider, _) {
        if (portfolioProvider.allPortfolioPitches != null &&
            portfolioProvider.allPortfolioPitches.length != 0) {
          return Column(
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Your Portfolio Track Record",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: ConstanceData.SIZE_TITLE18,
                          fontFamily: "Roboto",
                          package: 'Roboto-Regular',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Divider(thickness: 1,),
              Container(
                height: 300,
                child: ListView.builder(
                    itemCount: portfolioProvider.allPortfolioPitches.length,
                    itemBuilder: (context, index) {
                      return Padding(
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
                                        color: AllCoustomTheme
                                            .getSeeMoreThemeColor(),
                                        decoration: TextDecoration.underline,
                                        fontSize: ConstanceData.SIZE_TITLE18,
                                        fontFamily: "Roboto",
                                        package: 'Roboto-Regular',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 5.0),
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
                                                      color: AllCoustomTheme
                                                          .getTextThemeColor(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE16,
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 5.0),
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
                                                      color: AllCoustomTheme
                                                          .getTextThemeColor(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE16,
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 5.0),
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
                                                      color: AllCoustomTheme
                                                          .getTextThemeColor(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE16,
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
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ShowPortfolioPitchPage(
                                              portfolioData: portfolioProvider
                                                  .allPortfolioPitches[index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Paper${index + 1}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AllCoustomTheme
                                              .getSeeMoreThemeColor(),
                                          decoration: TextDecoration.underline,
                                          fontSize: ConstanceData.SIZE_TITLE18,
                                          fontFamily: "Roboto",
                                          package: 'Roboto-Regular',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 5.0),
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
                                                    'Return: ${portfolioProvider.allPortfolioPitches[index]["realization_annual_return_perc"].toStringAsFixed(2)}%',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getTextThemeColor(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE16,
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 5.0),
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
                                                    'Risk/Volatility: ${portfolioProvider.allPortfolioPitches[index]["volatility"].toStringAsFixed(2)}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getTextThemeColor(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE16,
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 5.0),
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
                                                    'Sharpe ratio: ${portfolioProvider.allPortfolioPitches[index]["sharpe_ratio"].toStringAsFixed(2)}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: AllCoustomTheme
                                                          .getTextThemeColor(),
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE16,
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
                      );
                    }),
              ),
            ],
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
