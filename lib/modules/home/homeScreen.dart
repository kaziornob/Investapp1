import 'package:animator/animator.dart';
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/main.dart';
import 'package:auroim/modules/home/main_exchange_tab.dart';
import 'package:auroim/modules/home/main_learn_marketplace_tab.dart';
import 'package:auroim/modules/home/main_plus_tab.dart';
import 'package:auroim/modules/investRelatedPages/securityFirstPage.dart';
import 'package:auroim/provider_abhinav/user_details.dart';
import 'package:connectivity/connectivity.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/drawer/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_home_tab.dart';
import 'main_invest_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

const String testDevice = 'YOUR_DEVICE_ID';

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  var _homeScaffoldKey = new GlobalKey<ScaffoldState>();
  ApiProvider request = new ApiProvider();

  TextEditingController _appbarTextController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  FocusNode _focusNode = FocusNode();
  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();

  bool searching = false;
  int userAuroCoinScore;
  ScrollController _scrollController = ScrollController();

  bool _isInProgress = false;
  bool isSelect1 = false;
  bool isSelect2 = false;
  bool isSelect3 = false;
  bool isSelect4 = false;
  bool isSelect5 = false;
  bool isLoading = false;

  var width = 0.0;
  var height = 0.0;
  var appBarheight = 0.0;
  var statusBarHeight = 0.0;
  var graphHeight = 0.0;

  @override
  void initState() {
    super.initState();

    getSharedPrefData();
    _appbarTextController.addListener(() {
      print("listen textFiel");
      if (_appbarTextController.text.length > 0) {
        print("hass all focus");
        setState(() {
          searching = true;
        });
      } else {
        setState(() {
          searching = false;
        });
        // print("hass nooo focus");
        // if(!FocusScope.of(context).hasFocus){
        //
        // }else{
        //   print("focus node not");
        // }
      }
    });
    setFirstTab();
  }

  SharedPreferences prefs;

  getSharedPrefData() async {
    prefs = await SharedPreferences.getInstance();
    print("investor type : ${prefs.getString('InvestorType')}");
  }

  isLoadingList() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      isLoading = false;
    });
  }

  setFirstTab() {
    setState(() {
      isSelect1 = true;
      isSelect2 = false;
      isSelect3 = false;
      isSelect4 = false;
      isSelect5 = false;
    });
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 4.0),
          child: IconButton(
            icon: Icon(
              FontAwesomeIcons.bars,
              size: 28,
              color: isSelect2 ? Colors.white : Colors.black,
            ),
            onPressed: () => _homeScaffoldKey.currentState.openDrawer(),
          ),
          // CircleAvatar(
          //   radius: 20.0,
          //   backgroundImage: new AssetImage('assets/download.jpeg'),
          //   backgroundColor: Colors.transparent,
          // ),
        ),
        // Stack(
        //   alignment: Alignment.bottomRight,
        //   children: <Widget>[
        //
        //     InkWell(
        //       onTap: () {
        //         _homeScaffoldKey.currentState.openDrawer();
        //       },
        //       child: FractionalTranslation(
        //         translation: Offset(0.4, 0.2),
        //         child: CircleAvatar(
        //           backgroundColor: Colors.white,
        //           radius: 11.0,
        //           child: Icon(
        //             Icons.sort_outlined,
        //             size: 16,
        //             color: Colors.black,
        //           ),
        //         ),
        //       ),
        //     )
        //   ],
        // ),
        //search box area
        Container(
          margin: EdgeInsets.only(top: 10.0, left: 13.0),
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
                width: MediaQuery.of(context).size.width * 0.58,
                height: MediaQuery.of(context).size.height * 0.05,
                child: TextFormField(
                  controller: _appbarTextController,
                  focusNode: _focusNode,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: ConstanceData.SIZE_TITLE14,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      FontAwesomeIcons.search,
                      color: AllCoustomTheme.getNewSecondTextThemeColor(),
                      size: 15,
                    ),
                    hintText: "Search Listed Companies",
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
        SizedBox(
          width: 5,
        ),
        //globe icon
        Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 3.0),
              child: Image(
                  height: 40,
                  width: 40,
                  image: new AssetImage('assets/appIcon.png')),
            ),
            FractionalTranslation(
              translation: Offset(-0.5, 0.0),
              child: GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 6.0,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UserDetails>(context, listen: false)
        .setUserDetails(userAllDetail);
    AppBar appBar = AppBar();
    appBarheight = appBar.preferredSize.height;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    statusBarHeight = MediaQuery.of(context).padding.top;
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
        SafeArea(
          bottom: true,
          child: Scaffold(
            key: _homeScaffoldKey,
            appBar: isSelect1 || isSelect2 || isSelect4 || isSelect5
                ? PreferredSize(
                    preferredSize: Size.fromHeight(65.0),
                    child: AppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: globals.isGoldBlack
                          ? isSelect2 == true
                              ? AllCoustomTheme.getAppBarBackgroundThemeColors()
                              : Color(0xFF7499C6)
                          : Color(0xFF7499C6),
                      title: _buildAppBar(context),
                    ),
                  )
                : null,
            bottomNavigationBar: Container(
              decoration: new BoxDecoration(
                color: AllCoustomTheme.getBodyContainerThemeColor(),
                border: Border.all(
                  color: AllCoustomTheme.getSecondIconThemeColor(),
                  width: 1.0,
                ),
              ),
              // height: 52,
              height: MediaQuery.of(context).size.height * 0.070,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        isSelect1
                            ? Animator(
                                duration: Duration(milliseconds: 500),
                                cycles: 1,
                                builder: (anim) => Transform.scale(
                                  scale: anim.value,
                                  child: Container(
                                    height: 2.5,
                                    decoration: BoxDecoration(
                                      color: globals.isGoldBlack
                                          ? Color(0xFFD8AF4F)
                                          : Color(0xFF7499C6),
                                      // gradient: LinearGradient(
                                      //   begin: Alignment.topLeft,
                                      //   end: Alignment.bottomRight,
                                      //   colors: [
                                      //     globals.iconButtonColor1,
                                      //     globals.iconButtonColor2,
                                      //   ],
                                      // ),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 2,
                              ),
                        GestureDetector(
                          onTap: () {
                            selectFirst();
                          },
                          child: isSelect1
                              ? Animator(
                                  tween: Tween<double>(begin: 0.8, end: 1.1),
                                  curve: Curves.decelerate,
                                  cycles: 1,
                                  builder: (anim) => Transform.scale(
                                      scale: anim.value,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment: Alignment.topCenter,
                                            child: Icon(
                                              Icons.home,
                                              size: 23,
                                              color: isSelect1
                                                  ? AllCoustomTheme
                                                      .getIconThemeColors()
                                                  : AllCoustomTheme
                                                      .getSecondIconThemeColor(),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Align(
                                              alignment: Alignment.topCenter,
                                              child: Text(
                                                "Home",
                                                style: TextStyle(
                                                    fontSize: ConstanceData
                                                        .SIZE_TITLE14,
                                                    color: isSelect1
                                                        ? AllCoustomTheme
                                                            .getIconThemeColors()
                                                        : AllCoustomTheme
                                                            .getSecondIconThemeColor(),
                                                    fontFamily: "Rasa",
                                                    fontStyle: FontStyle.normal,
                                                    letterSpacing: 0.2),
                                              )),
                                        ],
                                      )),
                                )
                              : firstAnimation(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        isSelect2
                            ? Animator(
                                duration: Duration(milliseconds: 500),
                                cycles: 1,
                                builder: (anim) => Transform.scale(
                                  scale: anim.value,
                                  child: Container(
                                    height: 2.5,
                                    decoration: BoxDecoration(
                                      color: globals.isGoldBlack
                                          ? Color(0xFFD8AF4F)
                                          : Color(0xFF7499C6),
                                      // gradient: LinearGradient(
                                      //   begin: Alignment.topLeft,
                                      //   end: Alignment.bottomRight,
                                      //   colors: [
                                      //     globals.iconButtonColor1,
                                      //     globals.iconButtonColor2,
                                      //   ],
                                      // ),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 2,
                              ),
                        GestureDetector(
                          onTap: () {
                            selectSecond();
                          },
                          child: isSelect2
                              ? Animator(
                                  tween: Tween<double>(begin: 0.8, end: 1.1),
                                  curve: Curves.decelerate,
                                  cycles: 1,
                                  builder: (anim) => Transform.scale(
                                    scale: anim.value,
                                    child: secondAnimation(),
                                  ),
                                )
                              : secondAnimation(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        isSelect3
                            ? Animator(
                                duration: Duration(milliseconds: 500),
                                cycles: 1,
                                builder: (anim) => Transform.scale(
                                  scale: anim.value,
                                  child: Container(
                                    height: 2.5,
                                    decoration: BoxDecoration(
                                        color: globals.isGoldBlack
                                            ? Color(0xFFD8AF4F)
                                            : Color(0xFF7499C6)
                                        // gradient: LinearGradient(
                                        //   begin: Alignment.topLeft,
                                        //   end: Alignment.bottomRight,
                                        //   colors: [
                                        //     globals.iconButtonColor1,
                                        //     globals.iconButtonColor2,
                                        //   ],
                                        // ),
                                        ),
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 2,
                              ),
                        GestureDetector(
                          onTap: () {
                            selectThird();
                          },
                          child: isSelect3
                              ? Animator(
                                  tween: Tween<double>(begin: 0.8, end: 1.1),
                                  curve: Curves.decelerate,
                                  cycles: 1,
                                  builder: (anim) => Transform.scale(
                                    scale: anim.value,
                                    child: thirdAnimation(),
                                  ),
                                )
                              : thirdAnimation(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        isSelect5
                            ? Animator(
                                duration: Duration(milliseconds: 500),
                                cycles: 1,
                                builder: (anim) => Transform.scale(
                                  scale: anim.value,
                                  child: Container(
                                    height: 2.5,
                                    decoration: BoxDecoration(
                                        color: globals.isGoldBlack
                                            ? Color(0xFFD8AF4F)
                                            : Color(0xFF7499C6)
                                        // gradient: LinearGradient(
                                        //   begin: Alignment.topLeft,
                                        //   end: Alignment.bottomRight,
                                        //   colors: [
                                        //     globals.iconButtonColor1,
                                        //     globals.iconButtonColor2,
                                        //   ],
                                        // ),
                                        ),
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 2,
                              ),
                        GestureDetector(
                          onTap: () {
                            selectFive();
                          },
                          child: isSelect5
                              ? Animator(
                                  tween: Tween<double>(begin: 0.8, end: 1.1),
                                  curve: Curves.decelerate,
                                  cycles: 1,
                                  builder: (anim) => Transform.scale(
                                    scale: anim.value,
                                    child: fifthAnimation(),
                                  ),
                                )
                              : fifthAnimation(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        isSelect4
                            ? Animator(
                                duration: Duration(milliseconds: 500),
                                cycles: 1,
                                builder: (anim) => Transform.scale(
                                  scale: anim.value,
                                  child: Container(
                                    height: 2.5,
                                    decoration: BoxDecoration(
                                      color: globals.isGoldBlack
                                          ? Color(0xFFD8AF4F)
                                          : Color(0xFF7499C6),
                                      // gradient: LinearGradient(
                                      //   begin: Alignment.topLeft,
                                      //   end: Alignment.bottomRight,
                                      //   colors: [
                                      //     globals.iconButtonColor1,
                                      //     globals.iconButtonColor2,
                                      //   ],
                                      // ),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 2,
                              ),
                        GestureDetector(
                          onTap: () {
                            selectFourth();
                          },
                          child: isSelect4
                              ? Animator(
                                  tween: Tween<double>(begin: 0.8, end: 1.1),
                                  curve: Curves.decelerate,
                                  cycles: 1,
                                  builder: (anim) => Transform.scale(
                                    scale: anim.value,
                                    child: fourthAnimation(),
                                  ),
                                )
                              : fourthAnimation(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            drawer: SizedBox(
              width: MediaQuery.of(context).size.width * 0.75 < 400
                  ? MediaQuery.of(context).size.width * 0.75
                  : 350,
              child: Drawer(
                elevation: 0,
                child: AppDrawer(
                  changeThemeCallback: (value) {
                    // Navigator.of(context).pop();
                    setState(() {
                      globals.isGoldBlack = value;
                      selectFirst();
                    });
                  },
                  selectItemName: 'home',
                  auroStreakCallback: () {
                    print("auro streak page to go on tapped");
                    // _scrollController = ScrollController(
                    //   initialScrollOffset: 500,
                    //   keepScrollOffset: true,
                    // );
                    setState(() {
                      selectFive();
                    });
                    print("sfsfsfsf");
                    // if (_scrollController.hasClients) {
                    //   _scrollController
                    //       .animateTo(
                    //     500.0,
                    //     duration: Duration(milliseconds: 500),
                    //     curve: Curves.ease,
                    //   )
                    //       .whenComplete(() {
                    //     print("the animation to auro streak finished");
                    //   }).catchError((error) {
                    //     print("the animation to auro streak error");
                    //     print(error.toString());
                    //   });
                    // }else{
                    //   print("no scroll client");
                    // }
                  },
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: searching
                ? Container(
                    color: isSelect2 ? Colors.black : Colors.white,
                    height: MediaQuery.of(context).size.height - 65,
                    child: FutureBuilder(
                      future: _featuredCompaniesProvider
                          .searchPublicCompanyList(_appbarTextController.text),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (snapshot.data.length == 0) {
                            return ListTile(
                              onTap: () {
                                setState(() {
                                  _appbarTextController.clear();
                                });
                              },
                              title: Text(
                                "No Results",
                                style: TextStyle(
                                  color:
                                      isSelect2 ? Colors.white : Colors.black,
                                ),
                              ),
                              trailing: Icon(Icons.close_rounded,
                                  color:
                                      isSelect2 ? Colors.white : Colors.black),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    _appbarTextController.text = "";
                                    FocusScope.of(context).unfocus();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => SecurityPageFirst(
                                          companyTicker: snapshot.data[index]
                                              ["ticker"],
                                        ),
                                      ),
                                    );
                                  },
                                  title: Text(
                                    snapshot.data[index]["company_name"],
                                    style: TextStyle(
                                      color: isSelect2
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        }
                      },
                    ),
                  )
                : ModalProgressHUD(
                    inAsyncCall: _isInProgress,
                    opacity: 0,
                    progressIndicator: SizedBox(),
                    child: Container(
                      color: isSelect2
                          ? AllCoustomTheme.getPageBackgroundThemeColor()
                          : isSelect1
                              ? Color(0xFFD9E4E9)
                              : (isSelect5 || isSelect4 || isSelect3
                                  ? AllCoustomTheme.getBodyContainerThemeColor()
                                  : AllCoustomTheme.getThemeData()
                                      .primaryColor),
                      height: height,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                              height: isSelect1 ||
                                      isSelect2 ||
                                      isSelect5 ||
                                      isSelect4
                                  ? 2
                                  : MediaQuery.of(context).padding.top,
                              child: Visibility(
                                visible: isSelect1 ||
                                    isSelect2 ||
                                    isSelect5 ||
                                    isSelect4,
                                child: Container(
                                  decoration: new BoxDecoration(
                                    color: Color(0xFFFFFFFF),
                                    border: Border.all(
                                      color: Color(0xFFFFFFFF),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              )),
                          Expanded(
                            child: isSelect1
                                ? MainHomeTab()
                                : isSelect2
                                    ? MainInvestTab()
                                    : (isSelect3
                                        ? MainPlusTab()
                                        : (isSelect4
                                            ? MainExchangeTab()
                                            : MainLearnMarketTab())),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        )
      ],
    );
  }

  Widget firstAnimation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Icon(
            Icons.home,
            size: 23,
            color: isSelect1
                ? AllCoustomTheme.getIconThemeColors()
                : AllCoustomTheme.getSecondIconThemeColor(),
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Align(
            alignment: Alignment.topCenter,
            child: Text(
              "Home",
              style: TextStyle(
                  fontSize: ConstanceData.SIZE_TITLE14,
                  color: isSelect1
                      ? AllCoustomTheme.getIconThemeColors()
                      : AllCoustomTheme.getSecondIconThemeColor(),
                  fontFamily: "Rasa",
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0.2),
            )),
      ],
    );
  }

  Widget secondAnimation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Icon(
            FontAwesomeIcons.coins,
            size: 20,
            color: isSelect2
                ? AllCoustomTheme.getIconThemeColors()
                : AllCoustomTheme.getSecondIconThemeColor(),
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Align(
            alignment: Alignment.topCenter,
            child: Text(
              "Invest",
              style: TextStyle(
                  fontSize: ConstanceData.SIZE_TITLE14,
                  color: isSelect2
                      ? AllCoustomTheme.getIconThemeColors()
                      : AllCoustomTheme.getSecondIconThemeColor(),
                  fontFamily: "Rasa",
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0.2),
            )),
      ],
    );
  }

  Widget thirdAnimation() {
    return Container(
      height: 40,
      width: width / 3,
      color: Colors.transparent,
      child: Icon(
        Icons.add_circle,
        size: 30,
        color: isSelect3
            ? AllCoustomTheme.getIconThemeColors()
            : AllCoustomTheme.getSecondIconThemeColor(),
      ),
    );
  }

  Widget fourthAnimation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Icon(
            FontAwesomeIcons.handshake,
            size: 20,
            color: isSelect4
                ? AllCoustomTheme.getIconThemeColors()
                : AllCoustomTheme.getSecondIconThemeColor(),
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Align(
            alignment: Alignment.topCenter,
            child: Text(
              "Exchange",
              style: TextStyle(
                  fontSize: ConstanceData.SIZE_TITLE14,
                  color: isSelect4
                      ? AllCoustomTheme.getIconThemeColors()
                      : AllCoustomTheme.getSecondIconThemeColor(),
                  fontFamily: "Rasa",
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0.2),
            )),
      ],
    );
  }

  Widget fifthAnimation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Icon(
            FontAwesomeIcons.globe,
            size: 20,
            color: isSelect5
                ? AllCoustomTheme.getIconThemeColors()
                : AllCoustomTheme.getSecondIconThemeColor(),
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            // prefs != null &&
            //         prefs.containsKey('InvestorType') &&
            //         prefs.getString('InvestorType') != null &&
            //         prefs.getString('InvestorType') == 'Accredited Investor'
            globals.isGoldBlack ? 'Learn' : 'MarketPlace',
            style: TextStyle(
                fontSize: ConstanceData.SIZE_TITLE14,
                color: isSelect5
                    ? AllCoustomTheme.getIconThemeColors()
                    : AllCoustomTheme.getSecondIconThemeColor(),
                fontFamily: "Rasa",
                fontStyle: FontStyle.normal,
                letterSpacing: 0.2),
          ),
        ),
      ],
    );
  }

  selectFirst() async {
    if (!isSelect1) {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none) {
        setFirstTab();
      }
      setState(() {
        isSelect1 = true;
        isSelect2 = false;
        isSelect3 = false;
        isSelect4 = false;
        isSelect5 = false;
      });
    }
  }

  selectSecond() async {
    if (!isSelect2) {
      setState(() {
        isSelect1 = false;
        isSelect2 = true;
        isSelect3 = false;
        isSelect4 = false;
        isSelect5 = false;
      });
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none) {
        isLoadingList();
      }
    }
  }

  selectThird() async {
    if (!isSelect3) {
      setState(() {
        isSelect1 = false;
        isSelect2 = false;
        isSelect3 = true;
        isSelect4 = false;
        isSelect5 = false;
      });
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  selectFourth() {
    if (!isSelect4) {
      setState(() {
        isSelect1 = false;
        isSelect2 = false;
        isSelect3 = false;
        isSelect4 = true;
        isSelect5 = false;
      });
    }
  }

  selectFive() {
    if (!isSelect5) {
      setState(() {
        isSelect1 = false;
        isSelect2 = false;
        isSelect3 = false;
        isSelect4 = false;
        isSelect5 = true;
      });
    }
  }
}
