import 'package:auroim/investment_masterclass/invesment_masterclass_models/next_question_model.dart';
import 'package:flutter/material.dart';

import 'invesment_masterclass_models/quiz_model.dart';

class CongratulationsRadioTiles extends StatefulWidget {
  final NextQuestionModel questionData;
  final int optionSelected;

  const CongratulationsRadioTiles({Key key, this.questionData, this.optionSelected}) : super(key: key);

  @override
  _CongratulationsRadioTilesState createState() => _CongratulationsRadioTilesState();
}

class _CongratulationsRadioTilesState extends State<CongratulationsRadioTiles> {
  List<QuizDemo> quizList = [];
  bool selected = false;
  bool answer = false;
  int radioValue;

  quizListAdd() {
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
  void initState() {
    quizListAdd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: quizList.length,
            separatorBuilder: (c, i) {
              return SizedBox(
                height: 10,
              );
            },
            itemBuilder: (c, i) {
              return RadioListTile(
                value: quizList[i].answerValue == 1 || widget.optionSelected == i ? 1 : 0,
                groupValue: 1,
                activeColor: quizList[i].answerValue == 1 ? Colors.green : Colors.orange,
                selected: true,

                // activeColor: Colors.black,
                onChanged: (value) {
                  setState(() {
                    // selected = true;

                    radioValue = value;
                    if (quizList[i].answerValue == 1) {
                      answer = true;
                    } else {
                      answer = false;
                    }
                    print(value);
                  });
                  Future.delayed(Duration(milliseconds: 500)).then((value) {});
                },
                title: Text(
                  quizList[i].title,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              );
            }),
        if (widget.questionData.message.assetImage != "")
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 60.0),
              child: Image.network(
                widget.questionData.message.assetImage,
                height: 170,
                width: 170,
              ),
            ),
          ),
        if (widget.questionData.message.assetText != "")
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 60.0,right: 20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reason",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Libero, ut leo amet ullamcorper fusce lobortis eu senectus eget. Posuere turpis in tempus, senectus eget arcu in.",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 15),
                  )
                ],
              ),
            ),
          ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
