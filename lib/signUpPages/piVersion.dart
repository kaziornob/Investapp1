import 'package:flutter/material.dart';
import 'package:auro/style/theme.dart' as Theme;


class PiVersion extends StatefulWidget {
  @override
  _PiVersionState createState() => _PiVersionState();
}

class _PiVersionState extends State<PiVersion> {


  Widget getOptionList() {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RadioListTile(
          value: 1,
          groupValue: 1,
          title: Text(
            "Cautious (Low risk appetite, expected returns higher than saving accounts, ideal for individuals at a late stage in their carrer)",
            style: TextStyle(
                fontSize: 18.0,
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
            "Modest (Medium risk appetite,looking for average returns, with slight ability to sustain losses)",
            style: TextStyle(
                fontSize: 18.0,
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
            "Aggressive (High-risk appetite seeking significant returns with the ability to sustain losses, investing with long-term goals)",
            style: TextStyle(
                fontSize: 18.0,
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
            "Extremely Aggressive (Extremely high-risk appetite, seeking great returns willing to take on the risk)",
            style: TextStyle(
                fontSize: 18.0,
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
                    margin: EdgeInsets.only(top: 25.0),
                    child: new Image(
                        width: 290.0,
                        fit: BoxFit.fill,
                        image: new AssetImage('assets/login_logo.png')),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
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
                    margin: EdgeInsets.only(top: 25.0,left: 40.0,bottom: 25.0),
                    child: Text(
                      'Help us understand your attitude towards risk, by choosing the options that suits you the most',
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
                  Expanded(
                    child: Container(
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
                  )

                ],
              ),
            ),
          ],

        ),
      )
    );
  }
}
