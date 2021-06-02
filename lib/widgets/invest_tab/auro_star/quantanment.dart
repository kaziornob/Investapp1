import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/home/homeScreen.dart';
import 'package:auroim/widgets/invest_tab/auro_star/portfolio_statistics.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:auroim/constance/global.dart' as globals;

class Quantanment extends StatefulWidget {
  final String title;
  final String logoString;

  Quantanment({@required this.title, @required this.logoString});

  @override
  _QuantanmentState createState() => _QuantanmentState();
}

class _QuantanmentState extends State<Quantanment> {
  YoutubePlayerController _controller;
  TextEditingController _appbarTextController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  var homeScaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
          'https://www.youtube.com/watch?v=J_87M2qmie4'),
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor:
              // globals.isGoldBlack
              //     ?
              Colors.black,
          // : Color(0xFF7499C6)
          //     : Color(0xFF7499C6),
          title: _buildAppBar(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 30),
                          alignment: Alignment.topLeft,
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(right: 50),
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/${widget.logoString}.png",
                            height: 40,
                            width: 100,
                          )),
                      Container()
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Direction",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        Text(
                          "Long Short",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
                    height: 1,
                    color: Color.fromRGBO(185, 185, 185, 0.2),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Risk Profile",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        Text(
                          "Balanced",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
                    height: 1,
                    color: Color.fromRGBO(185, 185, 185, 0.2),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Annualized Return",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        Text(
                          "15%",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
                    height: 1,
                    color: Color.fromRGBO(185, 185, 185, 0.2),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Benchmark",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        Text(
                          "10%",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
                    height: 1,
                    color: Color.fromRGBO(185, 185, 185, 0.2),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PortfolioStatistics(),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 2,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xFFD8AF4F),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "TRACK RECORD",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 5),
                    height: 1,
                    color: Colors.white,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      alignment: Alignment.center,
                      child: Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                      alignment: Alignment.center,
                      child: Text(
                        "Deep Fundamental bottom-up underwriting of target prices and drawdown levels conmbined with Quant driven mean-variance optimization techniques for portfolio construction",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      )),
                  Container(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                        size: 40,
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    height: 1,
                    color: Colors.white,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 15),
                      alignment: Alignment.center,
                      child: Text(
                        "InvestoMedia",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 150,
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (c, i) {
                          return SizedBox(
                            width: 20,
                          );
                        },
                        itemCount: 5,
                        itemBuilder: (c, i) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 150,
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: YoutubePlayer(
                                  controller: _controller,
                                  onReady: () {},
                                  onEnded: (YoutubeMetaData metaData) {
                                    _controller.pause();
                                  },
                                ),
                              ),
                              Container(
                                height: 150,
                                width: MediaQuery.of(context).size.width / 1.5,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.6)),
                              ),
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(bottom: 80),
                                child: Text(
                                  "PITCH VIDEO",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          );
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 5),
                    height: 1,
                    color: Colors.white,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 15),
                      alignment: Alignment.center,
                      child: Text(
                        "Investment Letters",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromRGBO(196, 196, 196, 0.06),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "AuroRabbit Investment Newsletter - April 2021",
                              maxLines: 2,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 70,
                          margin: EdgeInsets.only(right: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xFFD8AF4F),
                          ),
                          child: Text(
                            "VIEW",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromRGBO(196, 196, 196, 0.06),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "Aim Pan-Asia and India Newsletter -1q 2021",
                              maxLines: 2,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 70,
                          margin: EdgeInsets.only(right: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xFFD8AF4F),
                          ),
                          child: Text(
                            "VIEW",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromRGBO(196, 196, 196, 0.06),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "AuroRabbit Investment Newsletter - March 2021",
                              maxLines: 2,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 70,
                          margin: EdgeInsets.only(right: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xFFD8AF4F),
                          ),
                          child: Text(
                            "VIEW",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "www.AuroIM.com",
                    style: TextStyle(
                      fontSize: 21,
                      color: Color(0xFFD8AF4F),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
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
