import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/drawer/drawer.dart';
import 'package:auroim/widgets/private_deals_marketplace/appbar_widget_with_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'appbar_widget.dart';

class MyDeals extends StatefulWidget {
  @override
  _MyDealsState createState() => _MyDealsState();
}

class _MyDealsState extends State<MyDeals> {
  var _homeScaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _homeScaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: AppBar(
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(3),
            child: Container(
              height: 4,
              color: Colors.grey[400],
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff7499C6),
          title: AppbarWidgetWithDrawer(
            callback: () {
              _homeScaffoldKey.currentState.openDrawer();
            },
          ),
        ),
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75 < 400
            ? MediaQuery.of(context).size.width * 0.75
            : 350,
        child: Drawer(
          elevation: 0,
          child: AppDrawer(
            selectItemName: 'home',
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xffD9E4E8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                ),
                child: Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width - 20,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xff5A56B9),
                    ),
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          "My Private Deals",
                          style: TextStyle(
                            color: Color(0xff5A56B9),
                            fontSize: 30,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "All deals made can be seen here",
                          style: TextStyle(
                              color:
                                  AllCoustomTheme.getNewSecondTextThemeColor(),
                              fontFamily: "Roboto",
                              fontSize: 14.5,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.normal,
                              letterSpacing: 0.1),
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                ),
                child: Container(
                  height: 160,
                  width: MediaQuery.of(context).size.width - 20,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xff5A56B9),
                    ),
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      bottom: 10,
                      right: 15,
                      top: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Evernote",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Common Stock"),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 40,
                                width: (MediaQuery.of(context).size.width - 60) /2,
                                // decoration: BoxDecoration(
                                //   border: Border.all(),
                                // ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "\$500M",
                                      style: TextStyle(

                                          color: Color(0xff5A56B9),
                                          fontFamily: "Roboto",
                                          fontSize: 14.5,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.1),
                                    ),
                                    Text(
                                      "Indicated Valuation",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Roboto",
                                          fontSize: 13,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 0.1),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 40,
                                width: (MediaQuery.of(context).size.width - 60) /2,
                                // decoration: BoxDecoration(
                                //   border: Border.all(),
                                // ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Action Required",
                                      style: TextStyle(

                                          color:Color(0xff7499C6),
                                          fontFamily: "Roboto",
                                          fontSize: 14.5,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.1),
                                    ),
                                    Text(
                                      "Status",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Roboto",
                                          fontSize: 13,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 0.1),
                                      textAlign: TextAlign.end,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 40,
                                width: (MediaQuery.of(context).size.width - 60) /2,
                                // decoration: BoxDecoration(
                                //   border: Border.all(),
                                // ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "\$12500",
                                      style: TextStyle(

                                          color: Color(0xff5A56B9),
                                          fontFamily: "Roboto",
                                          fontSize: 14.5,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.1),
                                    ),
                                    Text(
                                      "Investment Size",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Roboto",
                                          fontSize: 13,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 0.1),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 40,
                                width: (MediaQuery.of(context).size.width - 60) /2,
                                // decoration: BoxDecoration(
                                //   border: Border.all(),
                                // ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "100",
                                      style: TextStyle(
                                          color: Color(0xff5A56B9),
                                          fontFamily: "Roboto",
                                          fontSize: 14.5,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.1),
                                    ),
                                    Text(
                                      "Days Posted",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Roboto",
                                          fontSize: 13,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 0.1),
                                      textAlign: TextAlign.end,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
