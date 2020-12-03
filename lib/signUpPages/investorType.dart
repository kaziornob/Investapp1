import 'package:auro/login.dart';
import 'package:auro/signUpPages/signUp.dart';
import 'package:flutter/material.dart';
import 'package:auro/style/theme.dart' as Theme;


class InvestorType extends StatefulWidget {
  @override
  _InvestorTypeState createState() => _InvestorTypeState();
}

class _InvestorTypeState extends State<InvestorType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*1.1,
            decoration: new BoxDecoration(
              color: Theme.Colors.backgroundColor,
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 30.0,left: 5.0,right: 5.0,bottom: 5.0),
                  child: new Image(
                      width: 300.0,
                      fit: BoxFit.fill,
                      image: new AssetImage('assets/login_logo.png')),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15.0,left: 5.0,right: 5.0),
                  decoration: new BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFfec20f),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 15.0,bottom: 20.0,left: 70.0,right: 50.0),
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: new BoxDecoration(
                          color: Color(0xFFfec20f),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: MaterialButton(
                          splashColor: Colors.grey,
                          child: Text(
                            "Accredited Investor",
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Color(0xFFFFFFFF),
                                fontFamily: "WorkSansBold"),
                          ),
                          onPressed: () async {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context) => new Login()));
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 35.0,right: 5.0),
                        child: Text(
                          '(Net worth > 1 million, either individually, or jointly with your spouse',
                          style: new TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              color: Color(0xFFFFFFFF), fontSize: 20.0,
                              letterSpacing: 0.2
                          ),
                        )
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 150.0,bottom: 5.0),
                          child: Text(
                            'Or',
                            style: new TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                color: Color(0xFFFFFFFF), fontSize: 20.0,
                                letterSpacing: 0.2
                            ),
                          )
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 118.0,bottom: 10.0),
                          child: Text(
                            'See More',
                            style: new TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                color: Color(0xFFe70b31), fontSize: 20.0,
                                letterSpacing: 0.2
                            ),
                          )
                      )
                    ],
                  )
                ),
                Container(
                    margin: EdgeInsets.only(top: 15.0,left: 5.0,right: 5.0),
                    decoration: new BoxDecoration(
                      border: Border.all(
                        color: Color(0xFFfec20f),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 15.0,bottom: 20.0,left: 70.0,right: 50.0),
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: new BoxDecoration(
                            color: Color(0xFFfec20f),
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: MaterialButton(
                            splashColor: Colors.grey,
                            child: Text(
                              "Retail Investor",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Color(0xFFFFFFFF),
                                  fontFamily: "WorkSansBold"),
                            ),
                            onPressed: () async {
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (BuildContext context) => new Login()));
                            },
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 30.0,bottom: 10.0,right: 5.0),
                            child: Text(
                              '(select this option if you do not meet the criterion of Accredited Investor defined above And are not a student)',
                              style: new TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  color: Color(0xFFFFFFFF), fontSize: 20.0,
                                  letterSpacing: 0.2
                              ),
                            )
                        ),
                      ],
                    )
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.13,
                  child: Container(
                      margin: EdgeInsets.only(top: 15.0,left: 5.0,right: 5.0),
                      decoration: new BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFfec20f),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            margin: EdgeInsets.only(top: 8.0,bottom: 5.0,left: 70.0,right: 50.0),
                            decoration: new BoxDecoration(
                              color: Color(0xFFfec20f),
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            ),
                            child: MaterialButton(
                              splashColor: Colors.grey,
                              child: Text(
                                "Student",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Color(0xFFFFFFFF),
                                    fontFamily: "WorkSansBold"),
                              ),
                              onPressed: () async {
                                Navigator.of(context).push(new MaterialPageRoute(
                                    builder: (BuildContext context) => new Login()));
                              },
                            ),
                          ),
                        ],
                      )
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
