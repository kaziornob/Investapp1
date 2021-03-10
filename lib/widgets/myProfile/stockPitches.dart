import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:flutter/material.dart';

class StockPitches extends StatefulWidget {
  @override
  _StockPitchesState createState() => _StockPitchesState();
}

class _StockPitchesState extends State<StockPitches> {

  List stockPitchList = [
    {
      "id": 1,
      "title": "Apple"
    },
    {
      "id": 2,
      "title": "Reliance"
    },
    {
      "id": 3,
      "title": "Netflix"
    }
  ];

  Widget getStockPitchList(data) {
    if (data != null && data.length != 0) {
      return new ListView.builder(
        itemCount: data.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // question section
              GestureDetector(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Icon(
                        Icons.circle,
                        color: AllCoustomTheme.getsecoundTextThemeColor(),
                        size: 8,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Expanded(
                      child: Text(
                        "${data[index]['title']}",
                        style: TextStyle(
                            color: AllCoustomTheme.getTextThemeColor(),
                            fontSize: ConstanceData.SIZE_TITLE16,
                            fontFamily: "Roboto",
                            package: 'Roboto-Regular',
                            letterSpacing: 0.2
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          );
        },
      );
    } else {
      return Center(
          child: Text(
            "No data available yet",
            textAlign: TextAlign.center,
            style: new TextStyle(
              color: AllCoustomTheme.getTextThemeColor(),
              fontSize: ConstanceData.SIZE_TITLE18,
              fontFamily: "Rasa",
            ),
          ));
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 16, right: 5.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.09,
              child: ListView(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Ankur’s Stock Pitches',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFD8AF4F),
                            fontSize: ConstanceData.SIZE_TITLE18,
                            fontFamily: "Roboto",
                            package: 'Roboto-Regular',
                          ),
                        ),
                      )
                  ),
                  Container(
                    margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.40),
                    padding: EdgeInsets.only(
                      bottom: 3, // space between underline and text
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                              color: AllCoustomTheme.getHeadingThemeColors(),
                              width: 1.0, // Underline width
                            ))
                    ),
                  ),
                ],
              ),
            )
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.18,
                    child: getStockPitchList(stockPitchList)
                ),
              ),
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 40.0,
            ),
            Expanded(
              child: Text(
                "Show More",
                style: TextStyle(
                    color: AllCoustomTheme.getSeeMoreThemeColor(),
                    decoration: TextDecoration.underline,
                    fontSize: ConstanceData.SIZE_TITLE16,
                    fontFamily: "Roboto",
                    package: 'Roboto-Regular',
                    letterSpacing: 0.2
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
