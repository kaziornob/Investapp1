import 'package:animator/animator.dart';
import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/widgets/public_company/single_company_debate_tab.dart';
import 'package:auroim/widgets/public_company/single_company_overview_tab.dart';
import 'package:auroim/widgets/public_company/single_public_company_appbar.dart';
import 'package:auroim/widgets/public_company/single_public_company_fundamental_tab.dart';
import 'package:auroim/widgets/public_company/single_public_company_header.dart';
import 'package:auroim/widgets/public_company/single_public_company_technical_tab.dart';
import 'package:auroim/widgets/single_public_company_videos.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SecurityPageFirst extends StatefulWidget {
  final String callingFrom;
  final String logo;
  final companyTicker;

  const SecurityPageFirst({
    Key key,
    @required this.callingFrom,
    this.logo,
    this.companyTicker,
  }) : super(key: key);

  @override
  _SecurityPageFirstState createState() => _SecurityPageFirstState();
}

class _SecurityPageFirstState extends State<SecurityPageFirst>
    with SingleTickerProviderStateMixin {
  // bool _isInProgress = false;
  ScrollController _scrollController = ScrollController();

  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();

  int selectedTabIndex;

  final List<Tab> tabList = <Tab>[
    Tab(text: 'Overview'),
    Tab(text: 'Debate'),
    Tab(text: 'Fundamental'),
    Tab(text: 'Technical'),
  ];

  TabController _tabController;

  double _voteValue = 3.0;

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: tabList.length);
    super.initState();
    // loadDetails();
  }

  Widget learnMore(data) {
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();
    double appBarheight = appBar.preferredSize.height;
    return FutureBuilder(
      future: _featuredCompaniesProvider
          .getSinglePublicCompanyData(widget.companyTicker,"all"),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return dd(snapshot.data);
        } else {
          return SizedBox();
        }
      },
    );
  }

  dd(data) {
    return Stack(
      children: <Widget>[
        SafeArea(
            bottom: true,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                controller: _scrollController,
                // physics: BouncingScrollPhysics(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 2.3,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      SinglePublicCompanyAppBar(
                        companyName: data["company_name"],
                        companyImageUrl: data["logo_img_name"],
                      ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      SinglePublicCompanyHeader(
                        marketCapital: data["market_cap_usd_mn"],
                        netDebt: data["net_debt_usd_mn"],
                        roe3yr: data["roe_3yr"],
                        currency: data["currency"],
                        equityBeta: data["equity_beta"],
                        marketCapLocal: data["market_cap_local_mn"],
                        fixRate: data["fx_rate"],
                        ticker: data["ticker"],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(left: 10.0, right: 3.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TabBar(
                              controller: _tabController,
                              onTap: (index) {
                                selectedTabIndex = index;
                              },
                              labelColor: Colors.black,
                              labelStyle: TextStyle(
                                fontSize: 17.0,
                                letterSpacing: 0.2,
                                fontWeight: FontWeight.bold,
                              ),
                              indicatorColor:
                                  AllCoustomTheme.getTextThemeColors(),
                              indicatorWeight: 4.0,
                              isScrollable: true,
                              unselectedLabelColor: Colors.grey,
                              tabs: <Widget>[
                                Tab(text: 'Overview'),
                                Tab(text: 'Debate'),
                                Tab(text: 'Fundamental'),
                                Tab(text: 'Technical'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        // flex: 1,
                        child: Container(
                          // padding: EdgeInsets.only(top: 10.0),
                          child: TabBarView(
                            controller: _tabController,
                            children: tabList.map((Tab tab) {
                              return _getPage(tab, data);
                            }).toList(),
                            physics: ScrollPhysics(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ))
      ],
    );
  }

  // ignore: missing_return
  Widget _getPage(Tab tab, data) {
    switch (tab.text) {
      case 'Overview':
        return SinglePublicCompanyOverviewTab(data: data);
      case 'Debate':
        return SinglePublicCompaniesDebateTab(data: data);
      case 'Fundamental':
        return SinglePublicCompanyDetailsFundamentalTab(
          marketCapital: data["market_cap_usd_mn"],
          netDebt: data["net_debt_usd_mn"],
          roe3yr: data["roe_3yr"],
          currency: data["currency"],
          equityBeta: data["equity_beta"],
          marketCapLocal: data["market_cap_local_mn"],
          fixRate: data["fx_rate"],
        );
      case 'Technical':
        return SinglePublicCompanyDetailsTechnicalTab(
          marketCapital: data["market_cap_usd_mn"],
          netDebt: data["net_debt_usd_mn"],
          roe3yr: data["roe_3yr"],
          currency: data["currency"],
          equityBeta: data["equity_beta"],
          marketCapLocal: data["market_cap_local_mn"],
          fixRate: data["fx_rate"],
          ticker: widget.companyTicker,
        );
    }
  }
}
