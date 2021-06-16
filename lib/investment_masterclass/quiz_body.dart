import 'package:auroim/investment_masterclass/quiz.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class QuizPageBody extends StatefulWidget {
  final PageController pageController;
  const QuizPageBody({Key key,this.pageController}) : super(key: key);

  @override
  _QuizPageBodyState createState() => _QuizPageBodyState();
}

class _QuizPageBodyState extends State<QuizPageBody> {
  YoutubePlayerController _controller;
  List<QuizDemo> quizList = [];
  bool selected = false;
  bool answer = false;
  int radioValue;

  @override
  void initState() {
    super.initState();
    quizListAdd();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId('https://www.youtube.com/watch?v=J_87M2qmie4'),
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        forceHD: true,
      ),
    );
  }

  quizListAdd() {
    quizList.add(
        QuizDemo(title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", answerValue: 0));
    quizList.add(
        QuizDemo(title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", answerValue: 0));
    quizList.add(
        QuizDemo(title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", answerValue: 1));
    quizList.add(
        QuizDemo(title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", answerValue: 0));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            "What is 12-B Fee?",
            style: TextStyle(fontSize: 20),
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
              selected
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
                  : Container()
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
                    },
                    title: Text(
                      quizList[i].title,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}