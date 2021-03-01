import 'package:auroim/constance/themes.dart';
import 'package:auroim/widgets/private_deals_marketplace/my_deals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'appbar_widget.dart';

class ThankYou extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: AppbarWidget(),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Color(0xffD9E4E8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
              ),
              child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xff5A56B9),
                  ),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Thank you for your interest",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
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
                        "We will be in touch shortly with next steps",
                        style: TextStyle(
                            color: AllCoustomTheme.getNewSecondTextThemeColor(),
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
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 60,
                width: 140,
                child: RaisedButton(
                  color: Color(0xff7499C6),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => MyDeals(),
                      ),
                    );
                  },
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Color(0xff7499C6),
                    ),
                  ),
                  child: Text(
                    "My Deals",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Roboto",
                        fontSize: 20,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
