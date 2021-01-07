import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/modules/invest/clubDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AuroStrikeBadges extends StatefulWidget {
  @override
  _AuroStrikeBadgesState createState() => _AuroStrikeBadgesState();
}

class _AuroStrikeBadgesState extends State<AuroStrikeBadges> {

  bool _isInProgress = false;

  @override
  void initState() {
    user.initData();
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

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Club RankIng', 100),
      _getTitleItemWidget('Club Name', 200),
      _getTitleItemWidget('Philosophy of Investor', 200),
      _getTitleItemWidget('Investment Track Record', 200),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      width: width,
      height: 56,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      child: Text("${index+1}"),
      width: 100,
      height: 52,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: ()
                {
                  var tempField = {"rankingNum": "${index+1}" ,"name": "${user.clubInfo[index].name}","philosophy": "${user.clubInfo[index].philosophy}",
                    "trackRecord": "${user.clubInfo[index].trackRecord}" ,"image": "${user.clubInfo[index].imageName}"};
                  print("tempfield: $tempField");
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (BuildContext context) => ClubDetail(allField: tempField),
                    ),
                  );
                },
                child: Text(user.clubInfo[index].name),
              )
            ],
          ),
          width: 200,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(user.clubInfo[index].philosophy),
          width: 200,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(user.clubInfo[index].trackRecord),
          width: 200,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }


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
            inAsyncCall: _isInProgress,
            opacity: 0,
            progressIndicator: CupertinoActivityIndicator(
              radius: 12,
            ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: !_isInProgress
                    ? Column(
                  children: <Widget>[
                    SizedBox(
                      height: appBarheight,
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
                            tween: Tween<Offset>(begin: Offset(0, 0), end: Offset(0.2, 0)),
                            duration: Duration(milliseconds: 500),
                            cycles: 0,
                            builder: (anim) => FractionalTranslation(
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
                            builder: (anim) => Transform.scale(
                              scale: anim.value,
                              child: Text(
                                'Auro Streak',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AllCoustomTheme.getTextThemeColors(),
                                  fontWeight: FontWeight.bold,
                                  fontSize: ConstanceData.SIZE_TITLE20,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5,right: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    'In addition to cumulative score over time, we also reward those who are engaged continuously with the app on a weekly basis.'
                                        ' Auro has learned the hard way that there are no shortcuts to becoming a good investor- '
                                        'there is no substitute for practice and getting feedback from Mr. Market on a daily basis, be it through.',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: AllCoustomTheme.getTextThemeColors(),
                                      fontSize: ConstanceData.SIZE_TITLE18,
                                    ),
                                  ),
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: HorizontalDataTable(
                        leftHandSideColumnWidth: 100,
                        rightHandSideColumnWidth: 600,
                        isFixedHeader: true,
                        headerWidgets: _getTitleWidget(),
                        leftSideItemBuilder: _generateFirstColumnRow,
                        rightSideItemBuilder: _generateRightHandSideColumnRow,
                        itemCount: user.clubInfo.length,
                        rowSeparatorWidget: const Divider(
                          color: Colors.black54,
                          height: 1.0,
                          thickness: 0.0,
                        ),
                        leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
                        rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
                        /*enablePullToRefresh: true,
                        refreshIndicator: const WaterDropHeader(),
                        refreshIndicatorHeight: 60,
                        onRefresh: () async {
                          //Do sth
                          await Future.delayed(const Duration(milliseconds: 500));
                          _hdtRefreshController.refreshCompleted();
                        },
                        htdRefreshController: _hdtRefreshController,*/
                      ),
                      height: MediaQuery.of(context).size.height,
                    )

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


User user = User();

class User {
  List<ClubInfo> clubInfo = [];

  void initData() {
    clubInfo.add(
        ClubInfo("Warren Buffet","Buy companies at a low price, improve them via management and make long term gains",
            "He has a 30-year-plus track record making on average 20 percent a year."
            ,"WarrenBuffet"
        )
    );

    clubInfo.add(
        ClubInfo("Jim Simons","Jim Simons, one of the greatest investors of all time, built his market-beating strategy around taking the human element out of investing. He founded Renaissance Technologies, which uses quantitative models underpinned by massive amounts of data to identify and profit from patterns in the market",
        "66% before charging fees—39% after fees—racking up trading gains of more than dollar 100 billion."
        ,"JimSimons"
        )
    );
    
    clubInfo.add(ClubInfo("Benjamin Graham", "value investing using fundamental analysis, whereby investors analyze stock data to find assets that have been systematically undervalued.",
        "Graham's investment firm posted annualized returns of about 20% from 1936 to 1956, far outpacing the 12.2% average return for the broader market over that time"
        ,"BenjaminGraham"
      )
    );

    clubInfo.add(ClubInfo(
        "Bill Gross", "“King of bonds”- focus on buying individual bonds with a long-term (3-5 year) outlook", "Gross’ compounded annual return over the 27 year period was 7.52%, versus 6.44% for the Barclay’s Aggregate US Index."
        ,"BillGross"
      )
    );

    clubInfo.add(ClubInfo(
        "John Templeton", "1.Diversification 2.Look for companies globally- best value stocks are those that are most neglected",
        "Templeton’s Growth Fund, created in 1954, went on to earn about a 14% annual return over the next 38 years when he retired in 1992."
        ,"JohnTempleton"
      )
    );

    clubInfo.add(ClubInfo(
        "Steve Mandel", "He employs fundamental analysis and a bottom-up stock picking approach, meaning he focuses on individual companies instead of global macro trends and economic cycles.",
        "The Hedge Fund 'Lone Pine' has averaged 30% annualized returns since 1997."
        ,"SteveMandel"
      )
    );

    clubInfo.add(ClubInfo(
        "Peter Lynch", "1.Be 100% sure. 2.It’s impossible to predict the economy and interest rates. 3.Take your time to identify exceptional companies 4.buy good businesses5.Be aware of the risks of your purchase",
        "As the manager of the Magellan Fund at Fidelity Investments between 1977 and 1990, Lynch averaged a 29.2% annual return, consistently more than double the S&P 500 stock market index and making it the best-performing mutual fund in the world."
        ,"PeterLynch"
      )
    );

    clubInfo.add(ClubInfo(
        "George Soros", "Identify macroeconomic trends Highly leveraged bets on bonds and commodities",
        "Soros Fund Management, LLC is a private American investment management firm. It is currently structured as a family office, but formerly as a hedge fund. The firm was founded in 1969 by George Soros[1] and, in 2010, was reported to be one of the most profitable firms in the hedge fund industry,[2] averaging a 20% annual rate of return over four decades."
        ,"GeorgeSoros"
      )
    );

    clubInfo.add(ClubInfo(
        "Lei Zhang", "Lei Zhang is a big believer in value investing, but where he deviates from the traditional value investing philosophy is that he likes investing in changes. He believes that it is change that derives value and he would like to invest in people driving them.",
        "Hillhouse has achieved investment returns of up to 52% annualized from inception in 2005 until 2012, even in spite of a 37% drop in 2008, making Hillhouse among the most profitable funds of its size in the world, and the leading fund in Asia"
        ,"LeiZhang"
      )
    );

    clubInfo.add(ClubInfo(
        "Rakesh Jhunjhunwala", "buy when the share is in uptrend and sell only when the share goes in the downtrend.",
        "In 1985, Jhunjhunwala invested Rs 5,000 (dollar 70) as capital. By September 2018, that capital had inflated to Rs 11,000 crore (dollar 1.5 bn).",
        "RakeshJhunjhunwala"
      )
    );
  }

  ///
  /// Single sort, sort Name's id
  void sortName(bool isAscending) {
    clubInfo.sort((a, b) {
      int aId = int.tryParse(a.name.replaceFirst('User_', ''));
      int bId = int.tryParse(b.name.replaceFirst('User_', ''));
      return (aId - bId) * (isAscending ? 1 : -1);
    });
  }
}

class ClubInfo {
  String name;
  String philosophy;
  String trackRecord;
  String imageName;


  ClubInfo(this.name, this.philosophy, this.trackRecord,this.imageName);
}