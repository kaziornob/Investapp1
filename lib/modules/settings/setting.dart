import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/global.dart';
import 'package:auroim/constance/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:flutter/painting.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> with SingleTickerProviderStateMixin {
  bool _isSettingInProgress = false;
  int selectedTabIndex;
  var globalContext;
  TextEditingController _newEmailTextFieldController = TextEditingController();
  TextEditingController _confirmEmailTextFieldController = TextEditingController();



  final List<Tab> tabList = <Tab>[
    new Tab(text: 'Account'),
    new Tab(text: 'Privacy'),
  ];

  TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabList.length);
    loadUserDetails();
  }

  loadUserDetails() async {
    setState(() {
      _isSettingInProgress = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      _isSettingInProgress = false;
    });
  }

  Widget account()
  {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Divider(
            color: Colors.grey,
          ),
          InkWell(
            onTap: ()
            {
              _addEmailDialogBox(globalContext);
            },
            child:  Container(
              margin: EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Email addresses",
                    style: TextStyle(
                        color: AllCoustomTheme.getTextThemeColor(),
                        fontSize: ConstanceData.SIZE_TITLE16,
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0.2
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Add or remove email addresses on your account",
                    style: TextStyle(
                      color: AllCoustomTheme.getNewSecondTextThemeColor(),
                      fontSize: ConstanceData.SIZE_TITLE14,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Phone numbers",
                  style: TextStyle(
                      color: AllCoustomTheme.getTextThemeColor(),
                      fontSize: ConstanceData.SIZE_TITLE16,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0.2
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Add a phone number to help keep your account secure",
                  style: TextStyle(
                      color: AllCoustomTheme.getNewSecondTextThemeColor(),
                      fontSize: ConstanceData.SIZE_TITLE14,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Change password",
                  style: TextStyle(
                      color: AllCoustomTheme.getTextThemeColor(),
                      fontSize: ConstanceData.SIZE_TITLE16,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0.2
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Choose a unique password to protect your account",
                  style: TextStyle(
                    color: AllCoustomTheme.getNewSecondTextThemeColor(),
                    fontSize: ConstanceData.SIZE_TITLE14,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Showing profile photos",
                  style: TextStyle(
                      color: AllCoustomTheme.getTextThemeColor(),
                      fontSize: ConstanceData.SIZE_TITLE16,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0.2
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Choose whether to show or hide profile photos of other members",
                  style: TextStyle(
                    color: AllCoustomTheme.getNewSecondTextThemeColor(),
                    fontSize: ConstanceData.SIZE_TITLE14,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
          ),

        ],
      ),
    );
  }

  Widget privacy()
  {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Divider(
            color: Colors.grey,
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Edit your public profile",
                  style: TextStyle(
                      color: AllCoustomTheme.getTextThemeColor(),
                      fontSize: ConstanceData.SIZE_TITLE16,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0.2
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Choose how your profile appear to non-logged in members via search engines or permitted services",
                  style: TextStyle(
                    color: AllCoustomTheme.getNewSecondTextThemeColor(),
                    fontSize: ConstanceData.SIZE_TITLE14,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Profile viewing options",
                  style: TextStyle(
                      color: AllCoustomTheme.getTextThemeColor(),
                      fontSize: ConstanceData.SIZE_TITLE16,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0.2
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Choose whether you're visible or viewing in private mode",
                  style: TextStyle(
                    color: AllCoustomTheme.getNewSecondTextThemeColor(),
                    fontSize: ConstanceData.SIZE_TITLE14,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
          ),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();
    double appBarheight = appBar.preferredSize.height;
    globalContext = context;
    return Stack(
      children: <Widget>[
        SafeArea(
          child: Scaffold(
            backgroundColor: AllCoustomTheme.getBodyContainerThemeColor(),
            appBar: new AppBar(
              backgroundColor: Color(0xFF5CA2F4),
              title: Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.20),
                child: new Text(
                  'Settings',
                  style: TextStyle(
                    color: AllCoustomTheme.getTextThemeColors(),
                    fontSize: ConstanceData.SIZE_TITLE18,
                  ),
                ),
              ),
              iconTheme: new IconThemeData(color: Colors.white),
            ),
            body: ModalProgressHUD(
              inAsyncCall: _isSettingInProgress,
              opacity: 0,
              progressIndicator: CupertinoActivityIndicator(
                radius: 12,
              ),
              child: Container(
                child: !_isSettingInProgress
                    ? Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 10.0,right: 3.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TabBar(
                            controller: _tabController,
                            isScrollable: true,
                            onTap: (index)
                            {
                              selectedTabIndex = index;
                            },
                            labelColor: Color(0xFF7499C6),
                            labelStyle: TextStyle(fontSize: 18.0,letterSpacing: 0.2),
                            indicatorColor: Color(0xFF7499C6),
                            indicatorWeight: 4.0,
                            // unselectedLabelColor: StyleTheme.Colors.AppBarTabTextColor,
                            tabs: <Widget>[
                              new Tab(text: 'Account'),
                              new Tab(text: 'Privacy'),
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
                )
                    : SizedBox(),
              )
            ),
          )
        )
      ],
    );
  }

  // ignore: missing_return
  Widget _getPage(Tab tab){
    switch(tab.text){
      case 'Account': return account();
      case 'Privacy': return privacy();
    }
  }

  Future<void> _addEmailDialogBox (BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Change your email address',
              style: new TextStyle(
                color: AllCoustomTheme.getTextThemeColor(),
                fontSize: ConstanceData.SIZE_TITLE18,
                fontFamily: "Roboto",
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(
                  controller: _newEmailTextFieldController,
                  style: TextStyle(
                    fontSize: ConstanceData.SIZE_TITLE14,
                    color: AllCoustomTheme.getTextThemeColor(),
                  ),
                  decoration: InputDecoration(
                    hintText: "New Email Address",
                    hintStyle: TextStyle(
                        fontSize: ConstanceData.SIZE_TITLE16,
                        color: AllCoustomTheme.getTextThemeColor()),
                    labelStyle: TextStyle(
                        fontSize: ConstanceData.SIZE_TITLE14,
                        color: AllCoustomTheme.getTextThemeColor()),
                  ),
                ),
                TextField(
                  controller: _confirmEmailTextFieldController,
                  style: TextStyle(
                    fontSize: ConstanceData.SIZE_TITLE14,
                    color: AllCoustomTheme.getTextThemeColor(),
                  ),
                  decoration: InputDecoration(
                    hintText: "Confirm Email Address",
                    hintStyle: TextStyle(
                        fontSize: ConstanceData.SIZE_TITLE16,
                        color: AllCoustomTheme.getTextThemeColor()),
                    labelStyle: TextStyle(
                        fontSize: ConstanceData.SIZE_TITLE14,
                        color: AllCoustomTheme.getTextThemeColor()),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: ConstanceData.SIZE_TITLE12,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Color(0xFF7499C6),
                textColor: Colors.white,
                child: Text(
                  'Change',
                  style: TextStyle(
                    fontSize: ConstanceData.SIZE_TITLE12,
                  ),
                ),
                onPressed: () {
                  // _submitEmail();
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }
}
