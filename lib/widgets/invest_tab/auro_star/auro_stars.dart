import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/home/homeScreen.dart';
import 'package:auroim/widgets/invest_tab/auro_star/portfolio_statistics.dart';
import 'package:flutter/material.dart';
import 'package:auroim/widgets/invest_tab/auro_star/quantanment.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuroStar extends StatefulWidget {
  const AuroStar({Key key}) : super(key: key);

  @override
  _AuroStarState createState() => _AuroStarState();
}

class _AuroStarState extends State<AuroStar> {
  TextEditingController _appbarTextController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  var homeScaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              PreferredSize(
                preferredSize: Size.fromHeight(65.0),
                child: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.black,
                  // globals.isGoldBlack
                  //     ? AllCoustomTheme.getAppBarBackgroundThemeColors()
                  //     // : Color(0xFF7499C6)
                  //     : Color(0xFF7499C6),
                  title: _buildAppBar(context),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          "AURO STARS",
                          style:
                              TextStyle(color: Color(0xFFD8AF4F), fontSize: 20),
                        )),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                      alignment: Alignment.center,
                      child: Text(
                        "Actively managed funds by Auro.AI and it's licensed asset -management affiliates. Please choose your risk profile to choose your desired funds.",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Quantanment(
                              title: "Pan - Asia Quantamental",
                              logoString: 'Auroville_with_text',
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width / 1.8,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: Color(0xFFD8AF4F), width: 1)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/caution.png",
                              height: 100,
                              width: 100,
                            ),
                            Text(
                              "Cautions",
                              style: TextStyle(
                                  color: Color(0xFFD8AF4F), fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Quantanment(
                                      title: "Investment Management",
                                      logoString: 'logo_with_ai',
                                    )));
                      },
                      child: Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width / 1.8,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: Color(0xFFD8AF4F), width: 1)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/balanced.png",
                              height: 100,
                              width: 100,
                            ),
                            Text(
                              "Balanced",
                              style: TextStyle(
                                  color: Color(0xFFD8AF4F), fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Quantanment(
                                      title:
                                          "Auro Rabbit Investment Management",
                                      logoString: 'logo_auro_rabbit',
                                    )));
                      },
                      child: Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width / 1.8,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: Color(0xFFD8AF4F), width: 1)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/aggresive.png",
                              height: 100,
                              width: 100,
                            ),
                            Text(
                              "Aggressive",
                              style: TextStyle(
                                  color: Color(0xFFD8AF4F), fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
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
              color: Colors.white,
            ),
            onPressed: () => homeScaffoldKey.currentState.openDrawer(),
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
}
