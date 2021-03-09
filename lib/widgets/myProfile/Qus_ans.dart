import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:flutter/material.dart';

class QusAns extends StatefulWidget {
  @override
  _QusAnsState createState() => _QusAnsState();
}

class _QusAnsState extends State<QusAns> {

  List qusList = [
    {
      "id": 1,
      "qus": "Is Apple a good buy?"
    },
    {
      "id": 2,
      "qus": "Is Mukesh key for Reliance stock?"
    },
    {
      "id": 3,
      "qus": "Netflix"
    }
  ];
  List ansList = [
    {
      "id": 1,
      "ans": "EM contagion"
    },
    {
      "id": 2,
      "ans": "Why Buy Etherium"
    },
    {
      "id": 3,
      "ans": "Why short Netflix"
    }
  ];


  Widget getQuestionsList(data) {
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
                          "${data[index]['qus']}",
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

  Widget getAnsList(data) {
    if (data != null && data.length != 0) {
      return new ListView.builder(
        itemCount: data.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // answer section
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
                          "${data[index]['ans']}",
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
                          'Ankur’s Investment Q&A',
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
                    margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.35),
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
        SizedBox(
          height: 10.0,
        ),
        // question section
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Question',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AllCoustomTheme.getSeeMoreThemeColor(),
                        decoration: TextDecoration.underline,
                        fontSize: ConstanceData.SIZE_TITLE18,
                        fontFamily: "Roboto",
                        package: 'Roboto-Regular',
                      ),
                    ),
                  )
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.18,
                        child: getQuestionsList(qusList)
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        // answer section
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Answer',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AllCoustomTheme.getSeeMoreThemeColor(),
                        decoration: TextDecoration.underline,
                        fontSize: ConstanceData.SIZE_TITLE18,
                        fontFamily: "Roboto",
                        package: 'Roboto-Regular',
                      ),
                    ),
                  )
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.18,
                        child: getAnsList(ansList)
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
