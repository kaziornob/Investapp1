import 'package:auroim/investment_masterclass/chapter_quiz.dart';
import 'package:auroim/investment_masterclass/invesment_masterclass_models/module_details_response_model.dart';
import 'package:flutter/material.dart';

import 'masterclass_popup_dialog.dart';

class ContentScreen extends StatefulWidget {
  final ModuleDetailsResponseModel moduleDetailsResponseModel;
  final Function playFunction;
  final VoidCallback pause;

  const ContentScreen(
      {Key key, this.moduleDetailsResponseModel, this.playFunction, this.pause})
      : super(key: key);

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
                const SizedBox(
                  height: 10,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.moduleDetailsResponseModel.message.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                widget.pause();
                                var response = await showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    child: MasterClassPopupDialogScreen(
                                      classDetails: widget
                                          .moduleDetailsResponseModel
                                          .message[index],
                                    ),
                                    // content
                                    // content: MasterClassPopupDialogScreen(),
                                  ),
                                );
                                if (response != null) {
                                  if (response) {
                                    widget.moduleDetailsResponseModel.message
                                        .forEach((element) {
                                      if (widget.moduleDetailsResponseModel
                                              .message[index].classId ==
                                          element.classId) {
                                        element.isPlaying = true;
                                      } else {
                                        element.isPlaying = false;
                                      }
                                    });

                                    setState(() {});
                                    widget.playFunction(widget
                                        .moduleDetailsResponseModel
                                        .message[index]);
                                  }
                                }
                              },
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0,
                                              right: 15.0,
                                              bottom: 0.0,
                                              top: 30),
                                          child: widget
                                                  .moduleDetailsResponseModel
                                                  .message[index]
                                                  .isPlaying
                                              ? Image.asset(
                                                  'assets/stop.png',
                                                  width: 50,
                                                  height: 50,
                                                )
                                              : Image.asset(
                                                  'assets/play.png',
                                                  width: 50,
                                                  height: 50,
                                                ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0,
                                                right: 15.0,
                                                bottom: 0.0,
                                                top: 30),
                                            child: Text(
                                              widget.moduleDetailsResponseModel
                                                  .message[index].classTopic,
                                              style: TextStyle(fontSize: 17),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    /*SizedBox(
                                      height: 3,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15.0),
                                        child: Text('5:12m'),
                                      ),
                                    ),*/
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 8, bottom: 8),
                              /*child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => QuizScreen(),
                                        ),
                                      );
                                    },
                                    child: Row(
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
                                  ),
                                  Image.asset(
                                    'assets/like.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                ],
                              ),*/
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ChapterQuizScreen(
                                            classId: widget
                                                .moduleDetailsResponseModel
                                                .message[index]
                                                .classId,
                                          )));
                                },
                                child: Text(
                                  'Chapter Quiz',
                                  style: TextStyle(
                                      color: Color(0xffFABE2C),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w300),
                                ),
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
                      padding: const EdgeInsets.only(
                          left: 30.0, top: 15, right: 8, bottom: 15),
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
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, top: 15, right: 8, bottom: 15),
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
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
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
