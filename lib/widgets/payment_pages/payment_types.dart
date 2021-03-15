import 'package:flutter/material.dart';

class PaymentTypes extends StatefulWidget {
  @override
  _PaymentTypesState createState() => _PaymentTypesState();
}

class _PaymentTypesState extends State<PaymentTypes> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                top: 5,
              ),
              width: MediaQuery.of(context).size.width - 30,
              decoration: BoxDecoration(
                border: Border.all(),
              ),
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
                    // decoration: BoxDecoration(border: Border.all()),
                    height: 100,
                    width: MediaQuery.of(context).size.width - 30,
                    child: Image.asset('assets/logo.png'),
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xff5A56B9),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width - 30,
                        height: 435,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                "Auro Beginner",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff1D6177),
                                ),
                              ),
                            ),
                            auroBeginner(),
                            SizedBox(
                              height: 10,
                            ),
                            payButton("PAY (\$2.99 PER MONTH)"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xff5A56B9),
                            ),
                          ),
                          width: MediaQuery.of(context).size.width - 30,
                          height: 300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  "Auro Intermediate",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff1D6177),
                                  ),
                                ),
                              ),
                              auroIntermediate(),
                              SizedBox(
                                height: 10,
                              ),
                              payButton("PAY (\$4.99 PER MONTH)"),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                          bottom: 20,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xff5A56B9),
                            ),
                          ),
                          width: MediaQuery.of(context).size.width - 30,
                          height: 280,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  "Auro Expert",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff1D6177),
                                  ),
                                ),
                              ),
                              auroExpert(),
                              SizedBox(
                                height: 10,
                              ),
                              payButton("PAY (\$9.99 PER MONTH)"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  auroBeginner() {
    return Column(
      children: [
        bulletPoints("Access to webinars conducted by professional investors."),
        bulletPoints("Take part in investment competitions and hackathons."),
        bulletPoints("Receive institutional market research reports."),
        bulletPoints("Free stock"),
        bulletPoints("Stock Pitches on a regular basis."),
        bulletPoints(
            "10% discount on our very own investment classes conducted by seasonal professionals" +
                " and premier educational institutions."),
      ],
    );
  }

  auroIntermediate() {
    return Column(
      children: [
        bulletPoints("Everything in Auro Beginner."),
        bulletPoints("1 on 1 sessions with and Investment mentor."),
        bulletPoints(
            "15% discount on our very own investment classes conducted by seasoned" +
                " professionals and premier educational institutions."),
      ],
    );
  }

  auroExpert() {
    return Column(
      children: [
        bulletPoints("Everything in Auro Intermediate."),
        bulletPoints("Networking & job opportunities."),
        bulletPoints("20% discount on very own investment classes conducted by" +
            " seasoned professionals and premier educational institutions."),
      ],
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
}
