import 'package:auro/shared/navigation_menu.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:auro/style/theme.dart' as StyleTheme;
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';


class SecurityPageFirst extends StatefulWidget {

  final String callingFrom;
  final String logo;

  const SecurityPageFirst({Key key, @required this.callingFrom,this.logo}) : super(key: key);

  @override
  _SecurityPageFirstState createState() => _SecurityPageFirstState();
}

final List<String> investorSliderDataList = ['1','2','3','4','5'];


class _SecurityPageFirstState extends State<SecurityPageFirst> with SingleTickerProviderStateMixin{

  int selectedTabIndex;

  final List<Tab> tabList = <Tab>[
    new Tab(text: 'Overview'),
    new Tab(text: 'Learn More'),
  ];

  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: tabList.length);
    // selectedTabIndex=0;
    // TODO: implement initState
    super.initState();
  }

  final List<Widget> investorsSliders = investorSliderDataList.map((item) => Container(
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Padding(
          padding: EdgeInsets.all(7.0),
          child: CircleAvatar(
            radius: 30.0,
            backgroundImage: new AssetImage('assets/success.png'),
            backgroundColor: Colors.transparent,
          ),
        )
    ),
  )).toList();

  final List<Widget> videoSliders = investorSliderDataList.map((item) => Container(
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Column(
          children: <Widget>[
            Container(
              height: 10.0,
              width: 10.0,
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Text('Video 1'),
            )
          ],
        )
    ),
  )).toList();

  Widget overView()
  {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 5.0,left: 10.0),
            child: Text(
              'Investors in your network',
              style: new TextStyle(
                  fontFamily: "Poppins",
                  color: Color(0xFFFFFFFF), fontSize: 14.0,
                  letterSpacing: 0.2
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.10,
            margin: EdgeInsets.all(7.0),
            decoration: new BoxDecoration(
              border: Border.all(
                color: Color(0xFFfec20f),
                width: 1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(2.0),
              ),
            ),
            child: CarouselSlider(
              items: investorsSliders,
              options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 2.0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0,left: 10.0),
            child: Text(
              'Description',
              style: new TextStyle(
                  fontFamily: "Poppins",
                  color: Color(0xFFFFFFFF), fontSize: 14.0,
                  letterSpacing: 0.2
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.18,
            margin: EdgeInsets.all(7.0),
            decoration: new BoxDecoration(
              border: Border.all(
                color: Color(0xFFfec20f),
                width: 1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(2.0),
              ),
            ),

          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.13,
            margin: EdgeInsets.all(7.0),
            decoration: new BoxDecoration(
              border: Border.all(
                color: Color(0xFFfec20f),
                width: 1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(2.0),
              ),
            ),
            child: CarouselSlider(
              items: videoSliders,
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.05,
            margin: EdgeInsets.all(7.0),
            decoration: new BoxDecoration(
              border: Border.all(
                color: Color(0xFFfec20f),
                width: 1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(2.0),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.06,
            margin: EdgeInsets.all(7.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width*0.48,
                  decoration: new BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFfec20f),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.0),
                    ),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.10,
                    margin: EdgeInsets.only(left:27.0,top: 7.0,right: 27.0),
                    decoration: new BoxDecoration(
                      border: Border.all(
                        color: Color(0xFFfec20f),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(2.0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Long',
                        style: new TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          color: Color(0xFFFFFFFF), fontSize: 15.0,
                        ),
                      ),
                    ),
                  )
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.48,
                  decoration: new BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFfec20f),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.0),
                    ),
                  ),
                  child:Container(
                    width: MediaQuery.of(context).size.width*0.10,
                    margin: EdgeInsets.only(left:27.0,top: 7.0,right: 27.0),
                    decoration: new BoxDecoration(
                      border: Border.all(
                        color: Color(0xFFfec20f),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(2.0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Short',
                        style: new TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          color: Color(0xFFFFFFFF), fontSize: 15.0,
                        ),
                      ),
                    ),
                  )
                )

              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.07,
            margin: EdgeInsets.only(left:7.0,right:7.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width*0.48,
                  decoration: new BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFfec20f),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Article 1',
                      style: new TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        color: Color(0xFFFFFFFF), fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.48,
                  decoration: new BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFfec20f),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Article 2',
                      style: new TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        color: Color(0xFFFFFFFF), fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.07,
            margin: EdgeInsets.only(left:7.0,right:7.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width*0.48,
                  decoration: new BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFfec20f),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Article 3',
                      style: new TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        color: Color(0xFFFFFFFF), fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.48,
                  decoration: new BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFfec20f),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Article 4',
                      style: new TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        color: Color(0xFFFFFFFF), fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.06,
            margin: EdgeInsets.only(left:7.0,right:7.0),
            child: Container(
                width: MediaQuery.of(context).size.width*0.48,
                decoration: new BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFfec20f),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(2.0),
                  ),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width*0.10,
                  margin: EdgeInsets.only(left:47.0,top: 7.0,right: 47.0,bottom: 3.0),
                  decoration: new BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFfec20f),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Explore',
                      style: new TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        color: Color(0xFFFFFFFF), fontSize: 15.0,
                      ),
                    ),
                  ),
                )
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.18,
            margin: EdgeInsets.all(7.0),
            decoration: new BoxDecoration(
              border: Border.all(
                color: Color(0xFFfec20f),
                width: 1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(2.0),
              ),
            ),
            child: Center(
              child: Text(
                'Company Sponsered Content',
                style: new TextStyle(
                    fontFamily: "Poppins",
                    color: Color(0xFFFFFFFF), fontSize: 14.0,
                    letterSpacing: 0.2
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0,left: 10.0),
            child: Text(
              'Similar Companies',
              style: new TextStyle(
                  fontFamily: "Poppins",
                  color: Color(0xFFFFFFFF), fontSize: 14.0,
                  letterSpacing: 0.2
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.10,
            margin: EdgeInsets.all(7.0),
            decoration: new BoxDecoration(
              border: Border.all(
                color: Color(0xFFfec20f),
                width: 1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(2.0),
              ),
            ),
            child: CarouselSlider(
              items: investorsSliders,
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget learnMore()
  {
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
        title: Padding(
          padding: EdgeInsets.only(left:25.0),
          child: Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'APPLE',
              style: new TextStyle(
                fontFamily: "WorkSansSemiBold",
                color: Color(0xFFFFFFFF), fontSize: 28.0,
              ),
            )
          )
        ),
        backgroundColor: widget.callingFrom=="Accredited Investor" ?  StyleTheme.Colors.accAppBarBackgroundColor : StyleTheme.Colors.retailAppBarBackgroundColor,
        leading: const BackButton(),
        iconTheme: new IconThemeData(color: StyleTheme.Colors.AppBarMenuIconColor),
      ),
        drawer: NavigationMenu(),
        body:  SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*1.6,
            decoration: new BoxDecoration(
              color: widget.callingFrom=="Accredited Investor" ?  StyleTheme.Colors.accScreenBackgroundColor : StyleTheme.Colors.retailScreenBackgroundColor,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20.0,bottom: 10.0,left: 25.0,right: 3.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: new BoxDecoration(
                              color: Color(0xFFfec20f),
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new AssetImage('assets/login_logo.png')
                              )
                          )
                      ),
                      new Container(
                        margin: EdgeInsets.only(left: 10.0),
                        width: MediaQuery.of(context).size.width*0.38,
                        height: MediaQuery.of(context).size.height*0.13,
                        decoration: new BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFfec20f),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 5.0,top: 10.0),
                              child: Text(
                                'MKT Cap:',
                                style: new TextStyle(
                                    fontFamily: "Poppins",
                                    color: Color(0xFFFFFFFF), fontSize: 15.0,
                                    letterSpacing: 0.2
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.0,top: 15.0),
                              child: Text(
                                'HQ:',
                                style: new TextStyle(
                                    fontFamily: "Poppins",
                                    color: Color(0xFFFFFFFF), fontSize: 15.0,
                                    letterSpacing: 0.2
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Container(
                        margin: EdgeInsets.only(left: 10.0),
                        width: MediaQuery.of(context).size.width*0.28,
                        height: MediaQuery.of(context).size.height*0.13,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 3.0),

                              height: MediaQuery.of(context).size.height*0.06,
                              width: MediaQuery.of(context).size.width*0.28,
                              decoration: new BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFFfec20f),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(2.0),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 25.0,top: 10.0),
                                child: Text(
                                  'Follow',
                                  style: new TextStyle(
                                      fontFamily: "Poppins",
                                      color: Color(0xFFFFFFFF), fontSize: 15.0,
                                      letterSpacing: 0.2
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 3.0),
                              height: MediaQuery.of(context).size.height*0.06,
                              width: MediaQuery.of(context).size.width*0.28,
                              decoration: new BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFFfec20f),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(2.0),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 25.0,top: 10.0),
                                child: Text(
                                  'Invest',
                                  style: new TextStyle(
                                      fontFamily: "Poppins",
                                      color: Color(0xFFFFFFFF), fontSize: 15.0,
                                      letterSpacing: 0.2
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 10.0,right: 3.0),
                  /*decoration: new BoxDecoration(
                    border: Border.all(
                      color: Color(0xfffec20f),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.0),
                    ),
                  ),*/
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TabBar(
                        controller: _tabController,
                        onTap: (index)
                        {
                          selectedTabIndex = index;
                        },
                        labelColor: StyleTheme.Colors.AppBarTabTextColor,
                        labelStyle: TextStyle(fontSize: 17.0,letterSpacing: 0.2),
                        indicatorColor: StyleTheme.Colors.AppBarSelectedTabLineColor,
                        indicatorWeight: 4.0,
                        unselectedLabelColor: StyleTheme.Colors.AppBarTabTextColor,
                        tabs: <Widget>[
                          new Tab(text: "Overview"),
                          new Tab(text: "Learn More"),
/*                          Container(
                            width: MediaQuery.of(context).size.width*0.45,
                            decoration: new BoxDecoration(
                              color: selectedTabIndex==0 ? Color(0xfffec20f) : Color(0xFF000000),
                              border: Border.all(
                                width: 1,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(2.0),
                              ),
                            ),
                            child: new Tab(text: "Overview"),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.45,
                            decoration: new BoxDecoration(
                              color: selectedTabIndex==1 ? Color(0xfffec20f) : Color(0xFF000000),
                              border: Border.all(
                                width: 1,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(2.0),
                              ),
                            ),
                            child: new Tab(text: "Learn More"),
                          ),*/
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(top: 10.0),
                    child: new TabBarView(
                      controller: _tabController,
                      children: tabList.map((Tab tab) {
                        return _getPage(tab);
                      }).toList(),
                      physics: ScrollPhysics(),
                    ),
                  ),
                ),

              ],
            ),
        ),
      )
    );
  }


  // ignore: missing_return
  Widget _getPage(Tab tab){
    switch(tab.text){
      case 'Overview': return overView();
      case 'Learn More': return learnMore();
    }
  }
}
