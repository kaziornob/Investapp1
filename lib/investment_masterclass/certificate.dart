import 'package:flutter/material.dart';

class CertificateScreen extends StatefulWidget {
  const CertificateScreen({Key key}) : super(key: key);

  @override
  _CertificateScreenState createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              backButton(),
              Center(
                child: Image.asset(
                  'assets/auro_edu.png',
                  width: MediaQuery.of(context).size.width * 0.60,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              standtext(
                  fontSize: 18,
                  text:
                      "Build your Investment Track and Credibility by getting an Auro.Ai certificate for your investment course:"),
              SizedBox(
                height: 20,
              ),
              certi(image: 'assets/silver_certificate.png'),
              standtext(fontSize: 15, text: "10 questions you can do on your own after signing fairness pledge."),
              SizedBox(
                height: 10,
              ),
              buyButton(price: "Buy 25\$"),
              SizedBox(
                height: 20,
              ),
              certi(image: 'assets/gold_certificate.png'),
              standtext(fontSize: 15, text: "20 questions done with online video proctoring by Auro.Ai."),
              SizedBox(
                height: 10,
              ),
              buyButton(price: "Buy 49\$"),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    ));
  }

  backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: CircleAvatar(
          radius: 15,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  standtext({String text, double fontSize}) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10),
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize),
        textAlign: TextAlign.center,
      ),
    );
  }

  certi({String image}) {
    return Container(
      height: 250,
      width: MediaQuery.of(context).size.width,
      child: Image.asset(
        image,
        fit: BoxFit.contain,
      ),
    );
  }

  unlocktext() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10),
      child: Text(
        "To unlock your certificate of accomplishment and unveil the skills gained by you to people.",
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }

  buyButton({String price, Function onPressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {},
          child: Card(
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff000000).withOpacity(0.15),
                      offset: const Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 5.0,
                      spreadRadius: 2.0,
                    )
                  ],
                  borderRadius: BorderRadius.circular(7)),
              width: MediaQuery.of(context).size.width / 2.3,
              child: Text(
                price,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
