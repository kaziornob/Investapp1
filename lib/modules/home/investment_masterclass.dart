import 'package:auroim/constance/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InvestmentMasterclass extends StatefulWidget {
  @override
  _InvestmentMasterclassState createState() => _InvestmentMasterclassState();
}

class _InvestmentMasterclassState extends State<InvestmentMasterclass> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // decoration: BoxDecoration(border: Border.all()),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AllCoustomTheme.getOtherTabHeadingThemeColors(),
                      width: 2.0, // Underline width
                    ),
                  ),
                ),
                child: Text(
                  "Course Categorization",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InteractiveViewer(
                  panEnabled: false,
                  maxScale: 3.0,
                  minScale: 0.5,
                  child: Container(
                    child: Image.asset('assets/investment_masterclass.jpeg'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xff5A56B9),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width - 30,
                  height: 320,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      bulletPoints("Test + Certification \$25"),
                      // auroBeginner(),
                      SizedBox(
                        height: 10,
                      ),
                      bulletPoints("Test + Certification + Ask Auro \$49"),
                      // auroBeginner(),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          child: Text(
                            "Group Tuition",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold,
                              color: Color(0xff1D6177),
                            ),
                          ),
                        ),
                      ),
                      bulletPoints("Regular \$49"),
                      bulletPoints("Star Teacher \$99"),
                      // auroBeginner(),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          child: Text(
                            "1 – 1 Tuition (real-time)",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold,
                              color: Color(0xff1D6177),
                            ),
                          ),
                        ),
                      ),
                      bulletPoints("Regular Teacher \$99+"),
                      bulletPoints("Star Teacher \$499+"),
                      // auroBeginner(),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // ss(){
  //   return
  // }

  // auroExpert() {
  //   return Column(
  //     children: [
  //       bulletPoints("Everything in Auro Intermediate."),
  //       bulletPoints("Networking & job opportunities."),
  //       bulletPoints("20% discount on very own investment classes conducted by" +
  //           " seasoned professionals and premier educational institutions."),
  //     ],
  //   );
  // }

  bulletPoints(text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // decoration: BoxDecoration(border: Border.all()),
            padding: EdgeInsets.only(top: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xff5A56B9),
                  radius: 3.0,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 6),
            // decoration: BoxDecoration(
            //   border: Border.all(),
            // ),
            width: MediaQuery.of(context).size.width - 60,
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  payButton(text) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width - 40,
      child: RaisedButton(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60),
          borderSide: BorderSide(color: Color(0xff7499C6)),
        ),
        color: Color(0xff7499C6),
        child: Text(text),
        onPressed: () {},
      ),
    );
  }
}
