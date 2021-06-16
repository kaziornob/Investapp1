import 'dart:async';

import 'package:auroim/investment_masterclass/invesment_masterclass_models/next_question_model.dart';
import 'package:auroim/investment_masterclass/quiz.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ChapterQuizBody extends StatefulWidget {
  // final PageController pageController;
  final NextQuestionModel questionData;

  const ChapterQuizBody({
    Key key,
    // this.pageController,
    this.questionData,
  }) : super(key: key);

  @override
  _ChapterQuizBodyState createState() => _ChapterQuizBodyState();
}

class _ChapterQuizBodyState extends State<ChapterQuizBody> {
  YoutubePlayerController _controller;
  List<QuizDemo> quizList = [];
  bool selected = false;
  bool answer = false;
  int radioValue;
  Timer _timer;
  int _start = 10;

  @override
  void initState() {
    super.initState();
    quizListAdd();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
        widget.questionData.message.assetVideo,
      ),
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        forceHD: true,
      ),
    );
  }

  quizListAdd() {
    widget.questionData.message.answers.forEach((answerId, option) {
      quizList.add(
        QuizDemo(
          title: option[0],
          answerValue: option[1] == "true" ? 1 : 0,
        ),
      );
    });

    // quizList.add(QuizDemo(
    //     title:
    //     ,
    //     answerValue: 0),);
    // quizList.add(QuizDemo(
    //     title:
    //     "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    //     answerValue: 0));
    // quizList.add(QuizDemo(
    //     title:
    //     "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    //     answerValue: 1));
    // quizList.add(QuizDemo(
    //     title:
    //     "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    //     answerValue: 0));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(border: Border.all()),
          child: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 10, top: 10),
                    child: Icon(Icons.arrow_back_ios),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.questionData.message.question,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      height: 200,
                      child: YoutubePlayer(
                        controller: _controller,
                        onReady: () {},
                        onEnded: (YoutubeMetaData metaData) {
                          _controller.pause();
                        },
                      ),
                    ),
                    /* selected
                        ? Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                            alignment: Alignment.center,
                            child: Text(
                              answer
                                  ? "Congrats That is Correct. You have earned 3 Auro Coins."
                                  : "Oops that is incorrect. Please take a moment to review the correct answer.",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              widget.pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.linear);
                            },
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                height: 50,
                                width: 50,
                                margin: EdgeInsets.only(right: 10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: answer ? Colors.green : Colors.orange,
                                ),
                                child: Text(
                                  "Next",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                        : Container()*/
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                AbsorbPointer(
                  absorbing: selected,
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: quizList.length,
                      separatorBuilder: (c, i) {
                        return SizedBox(
                          height: 10,
                        );
                      },
                      itemBuilder: (c, i) {
                        return RadioListTile(
                          value: quizList[i].answerValue,
                          groupValue: radioValue,
                          activeColor: answer ? Colors.green : Colors.orange,
                          onChanged: (value) {
                            setState(() {
                              selected = true;
                              _controller.pause();
                              radioValue = value;
                              if (radioValue == 1) {
                                answer = true;
                              }
                              print(value);
                            });
                            Future.delayed(Duration(milliseconds: 500))
                                .then((value) {
                              // widget.pageController.nextPage(
                              //   duration: Duration(milliseconds: 500),
                              //   curve: Curves.linear,
                              // );
                            });
                          },
                          title: Text(
                            quizList[i].title,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.35),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color(0xffD1D0D0),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/hourglass_bw.png',
                    height: 30,
                    width: 30,
                  ),
                  Text('4:99m')
                ],
              ),
            ))
      ],
    );
  }
}
