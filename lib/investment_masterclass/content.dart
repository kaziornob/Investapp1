
import 'package:flutter/material.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({Key key}) : super(key: key);

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 20, bottom: 30),
                  child: Text(
                    'Stylistic Investing Modules',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                // showDialog(
                                //   context: context,
                                //   child: AlertDialog(
                                //     contentPadding: EdgeInsets.all(0),
                                //     content: MasterClassPopupDialogScreen(),
                                //   ),
                                // );
                              },
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 0.0, top: 30),
                                          child: Image.asset(
                                            'assets/play.png',
                                            width: 50,
                                            height: 50,
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 0.0, top: 30),
                                            child: Text(
                                              'What is value investing?',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 15.0),
                                        child: Text('5:12m'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text('Take Chapter Quiz'),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Image.asset(
                                        'assets/trophy.png',
                                        width: 30,
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                  Image.asset(
                                    'assets/like.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 15, right: 8, bottom: 15),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/testQuiz.png',
                            width: 45,
                            height: 45,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Take a test',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 15, right: 8, bottom: 15),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/certificate.png',
                            width: 45,
                            height: 45,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Get a certificate',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
