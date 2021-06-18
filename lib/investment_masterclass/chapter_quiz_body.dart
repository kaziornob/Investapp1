import 'dart:async';

import 'package:auroim/investment_masterclass/invesment_masterclass_models/next_question_model.dart';
import 'package:auroim/investment_masterclass/provider/ivm_chapter_quiz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'invesment_masterclass_models/quiz_model.dart';

class ChapterQuizBody extends StatefulWidget {
  final NextQuestionModel questionData;
  final int classId;

  const ChapterQuizBody({
    Key key,
    this.questionData,
    this.classId,
  }) : super(key: key);

  @override
  _ChapterQuizBodyState createState() => _ChapterQuizBodyState();
}

class _ChapterQuizBodyState extends State<ChapterQuizBody> with SingleTickerProviderStateMixin {
  YoutubePlayerController _controller;
  List<QuizDemo> quizList = [];
  bool selected = false;
  bool answer = false;
  int radioValue;
  AnimationController _timerController;

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

    _timerController = AnimationController(vsync: this, duration: Duration(minutes: 5));

    _timerController.forward();

    _timerController.addListener(() {
      if (_timerController.isCompleted) {
        print("Animation completed");
        onTimerComplete();
      }
    });
  }

  void quizListAdd() {
    print(widget.questionData.message.questionType);
    if (widget.questionData.message.questionType == 3) {
      widget.questionData.message.answers.forEach((answerId, option) {
        quizList.add(
          QuizDemo(
            title: option[0],
            answerValue: option[1] == "true" ? 1 : 0,
          ),
        );
      });
    } else {
      widget.questionData.message.answers.forEach((answerId, option) {
        quizList.add(
          QuizDemo(
            title: option[0],
            answerValue: option[1] == "true" ? 0 : 1,
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _timerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
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
                            value: i,
                            groupValue: radioValue,
                            // activeColor: answer ? Colors.green : Colors.orange,
                            activeColor: Colors.black,
                            onChanged: (value) {
                              setState(() {
                                selected = true;
                                _controller.pause();
                                radioValue = value;
                                if (quizList[i].answerValue == 1) {
                                  answer = true;
                                } else {
                                  answer = false;
                                }
                                print(value);
                              });
                              Future.delayed(Duration(milliseconds: 500)).then((value) {
                                Provider.of<IVMChapterQuizProvider>(context, listen: false).postNextQuestion(
                                    classId: widget.classId,
                                    questionId: widget.questionData.message.questionId,
                                    responseString: answer.toString(),
                                    optionSelected: i);
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
                margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.35),
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
                    // Text(oneSec.toString()),
                    Countdown(
                      animation: StepTween(
                        begin: 1 * 60, // convert to seconds here
                        end: 0,
                      ).animate(_timerController),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  void onTimerComplete(){
    Provider.of<IVMChapterQuizProvider>(context, listen: false).postNextQuestion(
        classId: widget.classId,
        questionId: widget.questionData.message.questionId,
        responseString: "",
        optionSelected: -1);
  }
}

class Countdown extends AnimatedWidget {
  Countdown({Key key, this.animation}) : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${(clockTimer.inSeconds.remainder(60) % 60).toString().padLeft(2, '0')}';

    return Text(
      "$timerText",
      style: TextStyle(
        fontSize: 17,
        color: Colors.black,
      ),
    );
  }
}
