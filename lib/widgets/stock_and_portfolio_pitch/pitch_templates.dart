import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PitchTemplates extends StatelessWidget {
  const PitchTemplates({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.arrow_back_sharp,
          color: Colors.white,
          size: 40,
        ),
        backgroundColor: Color(0xFF8A8A8A),
        onPressed: () => Navigator.of(context).pop(),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 2,
                          child: Image.asset("assets/globe_left.png"),
                          // decoration: BoxDecoration(
                          //   border: Border.all(),
                          // ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 3.5,
              right: 0.0,
              child: Container(
                height: MediaQuery.of(context).size.height / 1.5,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Image.asset("assets/globe_right.png"),
                      // decoration: BoxDecoration(
                      //   border: Border.all(),
                      // ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 4,
              right: 19,
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width - 38,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * 0.05),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 4,
              right: 20,
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * 0.05),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.03,
                      ),
                      child: Text(
                        "Auro Stock Pitch Sample",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.03,
                        left: MediaQuery.of(context).size.width * 0.04,
                      ),
                      child: GestureDetector(
                        onTap: () => launch(
                            "https://drive.google.com/file/d/18WQYI7EcjMrVNtLjsKRY-TfFTHJ0ktp5/view"),
                        child: Text(
                          "-  Auro Stock Pitch - Short Form",
                          style: TextStyle(
                            color: Color(0xFFD8AF4F),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.02,
                        left: MediaQuery.of(context).size.width * 0.04,
                      ),
                      child: GestureDetector(
                        onTap: () => launch(
                            "https://drive.google.com/file/d/1U-1ggq0MRlOd9lqCVIipVvIzgZOSsHs0/view?usp=sharing"),
                        child: Text(
                          "-  Auro Stock Pitch - Long Form",
                          style: TextStyle(
                            color: Color(0xFFD8AF4F),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.03,
                      ),
                      child: Text(
                        "Templates are available to download here:",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.03,
                        left: MediaQuery.of(context).size.width * 0.04,
                      ),
                      child: GestureDetector(
                        onTap: () => launch(
                            "https://drive.google.com/file/d/1OHEW6gqE5NTqs5HAvcrWHkVz92jyjh_M/view?usp=sharing"),
                        child: Text(
                          "-  Short Form Template",
                          style: TextStyle(
                            color: Color(0xFFD8AF4F),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.02,
                        left: MediaQuery.of(context).size.width * 0.04,
                      ),
                      child: GestureDetector(
                        onTap: () => launch(
                            "https://drive.google.com/file/d/1dJ91dYQmyXXFlqLMuJYelwoPqzbCPdKB/view?usp=sharing"),
                        child: Text(
                          "-  Long Form Template",
                          style: TextStyle(
                            color: Color(0xFFD8AF4F),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
