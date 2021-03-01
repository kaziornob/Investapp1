import 'package:auroim/widgets/public_company/single_notification_tile.dart';
import 'package:flutter/material.dart';

class KeySocialInvestIndicators extends StatefulWidget {
  @override
  _KeySocialInvestIndicatorsState createState() =>
      _KeySocialInvestIndicatorsState();
}

class _KeySocialInvestIndicatorsState extends State<KeySocialInvestIndicators> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width - 15,
        height: 240,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                bottom: 4.0,
              ),
              child: Row(
                children: [
              Container(
              height: 30,
              width: 60,
              child: Center(
                child: Text(
                "121.76",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              color: Colors.grey[300],
            ),
            SizedBox(
              width: 15,
            ),
            Container(
              width: 150,
              height: 30,
              color: Colors.grey[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_drop_up_outlined,
                    color: Colors.green,
                  ),
                  Text(
                    "+0.50(+0.41%)",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width * 0.75,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 2,
                  color: Color(0xFFfec20f),
                ),
              ),
            ),
            padding: EdgeInsets.only(bottom: 4.0),
            child: Center(
              child: Text(
                "Key Social Invest Indicators",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Rosarivo",
                ),
              ),
            ),
          ),
        ],
      ),
      Expanded(
        child: Column(
          children: [
            SingleNotificationTile(
              trailingText: "had Q&A on this stock",
            ),
            SingleNotificationTile(
              trailingText: "own this stock",
            ),
            SingleNotificationTile(
              trailingText: "follow this stock",
            ),
          ],
        ),
      ),
      ],
    ),)
    ,
    );
  }
}
