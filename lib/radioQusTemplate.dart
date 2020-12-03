import 'package:auro/models/radioQuestionModel.dart';
import 'package:auro/signUpPages/piVersion.dart';
import 'package:flutter/material.dart';
import 'package:auro/style/theme.dart' as Theme;


class RadioQusTemplate extends StatefulWidget {

  final List<RadioQusModel> optionData;

  const RadioQusTemplate({Key key, @required this.optionData}) : super(key: key);

  @override
  _RadioQusTemplateState createState() => _RadioQusTemplateState();
}

class _RadioQusTemplateState extends State<RadioQusTemplate> {

  Widget getOptionList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RadioListTile(
          value: 1,
          groupValue: 1,
          title: Text(
            "Newbie - no experience",
            style: TextStyle(
                fontSize: 18.0,
                color: Color(0xFFFFFFFF),
                fontFamily: "WorkSansBold"),
          ),
          subtitle: Text(
            "(0 years of trading experience)",
            style: TextStyle(
                fontSize: 15.0,
                color: Color(0xFFFFFFFF),
                fontFamily: "WorkSansBold"),
          ),
          onChanged: (val) {
            print("Radio Tile pressed $val");
          },
          activeColor: Color(0xFFffffff),
        ),
        Divider(),
        RadioListTile(
          value: 1,
          groupValue: 1,
          title: Text(
            "Investo-curious - know a little about investing",
            style: TextStyle(
                fontSize: 18.0,
                color: Color(0xFFFFFFFF),
                fontFamily: "WorkSansBold"),
          ),
          subtitle: Text(
            "(1-2 years of trading experience)",
            style: TextStyle(
                fontSize: 15.0,
                color: Color(0xFFFFFFFF),
                fontFamily: "WorkSansBold"),
          ),
          onChanged: (val) {
            print("Radio Tile pressed $val");
          },
          activeColor: Color(0xFFffffff),
        ),
        Divider(),
        RadioListTile(
          value: 1,
          groupValue: 1,
          title: Text(
            "Up-and-Comer-have tried investing before",
            style: TextStyle(
                fontSize: 18.0,
                color: Color(0xFFFFFFFF),
                fontFamily: "WorkSansBold"),
          ),
          subtitle: Text(
            "(3-5 years of trading experience)",
            style: TextStyle(
                fontSize: 15.0,
                color: Color(0xFFFFFFFF),
                fontFamily: "WorkSansBold"),
          ),
          onChanged: (val) {
            print("Radio Tile pressed $val");
          },
          activeColor: Color(0xFFffffff),
        ),
        Divider(),
        RadioListTile(
          value: 1,
          groupValue: 1,
          title: Text(
            "Veteran - lots of experience",
            style: TextStyle(
                fontSize: 18.0,
                color: Color(0xFFFFFFFF),
                fontFamily: "WorkSansBold"),
          ),
          subtitle: Text(
            "(>5 years of trading experience)",
            style: TextStyle(
                fontSize: 15.0,
                color: Color(0xFFFFFFFF),
                fontFamily: "WorkSansBold"),
          ),
          onChanged: (val) {
            print("Radio Tile pressed $val");
          },
          activeColor: Color(0xFFffffff),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*1.1,
              decoration: new BoxDecoration(
                color: Theme.Colors.backgroundColor,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 35.0),
                    child: new Image(
                        width: 290.0,
                        fit: BoxFit.fill,
                        // ${widget.optionData[0].logo}
                        image: new AssetImage('assets/login_logo.png')),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.0),
                    child: Text(
                      'YOUR PERSONAL ASSET MANAGER',
                      style: new TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          color: Color(0xFFFFFFFF), fontSize: 17.0,
                          letterSpacing: 0.1
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 35.0,left: 25.0),
                    child: Text(
                      'What is your level of investing experience?',
                      style: new TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          color: Color(0xFFFFFFFF), fontSize: 21.0,
                          letterSpacing: 0.1
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: getOptionList(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    decoration: new BoxDecoration(
                      color: Color(0xFFfec20f),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    child: MaterialButton(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 42.0),
                        child: Text(
                          "NEXT",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontFamily: "WorkSansBold"),
                        ),
                      ),
                      onPressed: () async {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PiVersion()));
                      },
                    ),
                  ),

                ],
              ),
            ),
          ],

        ),
      )
    );
  }
}
