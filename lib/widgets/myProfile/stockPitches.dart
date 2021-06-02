import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/provider_abhinav/stock_pitch_provider.dart';
import 'package:auroim/provider_abhinav/user_details.dart';
import 'package:auroim/widgets/stock_and_portfolio_pitch/show_stock_pitch_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StockPitches extends StatefulWidget {
  final userName;
  final email;

  const StockPitches({Key key, this.userName, this.email}) : super(key: key);

  @override
  _StockPitchesState createState() => _StockPitchesState();
}

class _StockPitchesState extends State<StockPitches> {
  String title = "";
  bool _isInit = true;

  Widget getStockPitchList(data) {
    if (data != null && data.length != 0) {
      return new ListView.builder(
        itemCount: data.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // question section
              GestureDetector(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Icon(
                        Icons.circle,
                        color: AllCoustomTheme.getsecoundTextThemeColor(),
                        size: 8,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Text(
                          "${data[index]['title']}",
                          style: TextStyle(
                              color: AllCoustomTheme.getTextThemeColor(),
                              fontSize: ConstanceData.SIZE_TITLE16,
                              fontFamily: "Roboto",
                              package: 'Roboto-Regular',
                              letterSpacing: 0.2),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ShowStockPitchPage(
                                stockPitchData: data[index],
                                userEmail: widget.email,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          );
        },
      );
    } else {
      return Center(
          child: Text(
        "No data available yet",
        textAlign: TextAlign.center,
        style: new TextStyle(
          color: AllCoustomTheme.getTextThemeColor(),
          fontSize: ConstanceData.SIZE_TITLE18,
          fontFamily: "Rasa",
        ),
      ));
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<StockPitchProvider>(context).getStockPitches(widget.email);
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
    //       ? "${userProvider.userDetails["f_name"]}\'s Stock Pitches"
    //       : 'Stock Pitches';
    // } else {
    //   title = "${widget.userName}\'s Stock Pitches";
    // }
    return Consumer<StockPitchProvider>(builder: (context, pitchProvider, _) {
      if (pitchProvider.allStockPitches != null &&
          pitchProvider.allStockPitches.length != 0) {
        return Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.09,
              child: Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Your Stock Pitches",
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
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.18,
                      child: getStockPitchList(pitchProvider.allStockPitches),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 40.0,
                ),
                Expanded(
                  child: Text(
                    "Show More",
                    style: TextStyle(
                        color: AllCoustomTheme.getSeeMoreThemeColor(),
                        decoration: TextDecoration.underline,
                        fontSize: ConstanceData.SIZE_TITLE16,
                        fontFamily: "Roboto",
                        package: 'Roboto-Regular',
                        letterSpacing: 0.2),
                  ),
                )
              ],
            ),
          ],
        );
      } else {
        return SizedBox();
      }
    });
  }
}
