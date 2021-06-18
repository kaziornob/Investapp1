import 'package:auroim/investment_masterclass/congratulations_radio_tile.dart';
import 'package:auroim/investment_masterclass/invesment_masterclass_models/next_question_model.dart';
import 'package:auroim/investment_masterclass/provider/ivm_chapter_quiz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CongratulationScreen extends StatefulWidget {
  const CongratulationScreen({Key key}) : super(key: key);

  @override
  _CongratulationScreenState createState() => _CongratulationScreenState();
}

class _CongratulationScreenState extends State<CongratulationScreen> {
  List<NextQuestionModel> questionsData;
  List<int> optionsSelectedd = [0,1,2,3];
  List<int> optionsSelected;
  List<NextQuestionModel> dataToShowAtLastt = [
    NextQuestionModel(
      auth: true,
      message: Message(
          questionId: 5,
          question: "Why learn Blockchain? Please choose the one WRONG option from below?",
          classId: 2,
          answers: {
            "21": ["It enables digital information to be distributed.", "true"],
            "148": [
              "Many new business applications will result in the usage of Blockchain such as Crowdfunding, smart contracts, supply chain auditing, Internet of Things(IoT), etc.",
              "true"
            ],
            "275": ["Because it is more valuable than Bitcoin", "false"],
            "402": ["Design, test and deploy secure Smart Contracts", "true"]
          },
          assetImage: "",
          assetText: "",
          assetVideo: "https://youtu.be/WO-O2K_Fqw0",
          questionType: 1),
    ),
    NextQuestionModel(
      auth: true,
      message: Message(
          questionId: 5,
          question: "Why learn Blockchain? Please choose the one WRONG option from below?",
          classId: 2,
          answers: {
            "21": ["It enables digital information to be distributed.", "true"],
            "148": [
              "Many new business applications will result in the usage of Blockchain such as Crowdfunding, smart contracts, supply chain auditing, Internet of Things(IoT), etc.",
              "true"
            ],
            "275": ["Because it is more valuable than Bitcoin", "false"],
            "402": ["Design, test and deploy secure Smart Contracts", "true"]
          },
          assetImage: "",
          assetText: "",
          assetVideo: "https://youtu.be/WO-O2K_Fqw0",
          questionType: 1),
    ),
    NextQuestionModel(
      auth: true,
      message: Message(
          questionId: 5,
          question: "Why learn Blockchain? Please choose the one WRONG option from below?",
          classId: 2,
          answers: {
            "21": ["It enables digital information to be distributed.", "true"],
            "148": [
              "Many new business applications will result in the usage of Blockchain such as Crowdfunding, smart contracts, supply chain auditing, Internet of Things(IoT), etc.",
              "true"
            ],
            "275": ["Because it is more valuable than Bitcoin", "false"],
            "402": ["Design, test and deploy secure Smart Contracts", "true"]
          },
          assetImage: "",
          assetText: "",
          assetVideo: "https://youtu.be/WO-O2K_Fqw0",
          questionType: 1),
    ),
    NextQuestionModel(
      auth: true,
      message: Message(
          questionId: 5,
          question: "Why learn Blockchain? Please choose the one WRONG option from below?",
          classId: 2,
          answers: {
            "21": ["It enables digital information to be distributed.", "true"],
            "148": [
              "Many new business applications will result in the usage of Blockchain such as Crowdfunding, smart contracts, supply chain auditing, Internet of Things(IoT), etc.",
              "true"
            ],
            "275": ["Because it is more valuable than Bitcoin", "false"],
            "402": ["Design, test and deploy secure Smart Contracts", "true"]
          },
          assetImage: "",
          assetText: "",
          assetVideo: "https://youtu.be/WO-O2K_Fqw0",
          questionType: 1),
    ),
  ];

  @override
  void initState() {
    questionsData = Provider.of<IVMChapterQuizProvider>(context, listen: false).dataToShowAtLast;
    optionsSelected = Provider.of<IVMChapterQuizProvider>(context, listen: false).answersSelectedByUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // physics: NeverScrollableScrollPhysics(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/correct.png',
                      width: 70,
                      height: 70,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, top: 10),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "Congratulations",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 40),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35.0, right: 35, top: 5),
              child: Text(
                "You have passed the chapter quiz and you can proceed to the next chapter. Please check right answers below.",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              color: Color(0xffdddbdb),
            ),
            const SizedBox(
              height: 10,
            ),
            if(questionsData.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: questionsData.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 25,
                        ),
                        Text(
                          "Q${index + 1}.",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                           questionsData[index].message.question,
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                    CongratulationsRadioTiles(questionData: questionsData[index],optionSelected: optionsSelected[index],),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
