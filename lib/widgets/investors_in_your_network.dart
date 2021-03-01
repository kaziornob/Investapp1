import 'package:flutter/material.dart';

class InvestorsInYourNetwork extends StatelessWidget {
  final String text;

  InvestorsInYourNetwork({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5.0, left: 10.0),
            child: Text(
              "$text",
              style: new TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.black,
                  fontSize: 14.0,
                  letterSpacing: 0.2),
            ),
          ),
          // investor slider
          Padding(
            padding: const EdgeInsets.only(left: 13, right: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.10,
                    child: Scrollbar(
                      child: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                              child: Container(
                                  child: Row(
                            children: [
                              CircleAvatar(
                                radius: 25.0,
                                backgroundImage: index == 0
                                    ? new AssetImage(
                                        'assets/filledweeklyAuroBadge.png')
                                    : new AssetImage(
                                        'assets/weeklyAuroBadge.png'),
                                backgroundColor: Colors.transparent,
                              ),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          )));
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
