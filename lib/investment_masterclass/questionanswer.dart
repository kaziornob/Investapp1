import 'package:auroim/investment_masterclass/api/investment_masterclass_presenter.dart';
import 'package:auroim/investment_masterclass/invesment_masterclass_models/comment_response_models.dart';
import 'package:flutter/material.dart';

import 'comment_screen.dart';
import 'invesment_masterclass_models/comment_answer_response_model.dart';

class Question {
  String text;
  bool hasComment;

  Question({this.text, this.hasComment = false});
}

class QuestionAnswerScreen extends StatefulWidget {
  final int classId;

  const QuestionAnswerScreen({Key key, this.classId}) : super(key: key);

  @override
  _QuestionAnswerScreenState createState() => _QuestionAnswerScreenState();
}

class _QuestionAnswerScreenState extends State<QuestionAnswerScreen> {
  TextEditingController addCommentController = TextEditingController();
  TextEditingController showCommentController = TextEditingController();

  // List<Question> questionList = [];
  List<Answer> answerList = [];
  List<Comment> answerComments = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // questionList.add(Question(
    //     text:
    //         "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    //     hasComment: false));
    // questionList.add(Question(
    //     text:
    //         "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    //     hasComment: true));
    // questionList.add(Question(
    //     text:
    //         "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    //     hasComment: false));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                if (widget.classId != null && widget.classId != 0)
                  FutureBuilder(
                    future: InvestmentMasterclassPresenter().getClassAnswers(widget.classId),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'No Answers available.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            )
                          ],
                        );
                      }

                      if (snapshot.hasData) {
                        answerList = snapshot.data.message.answers;
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                              height: 40,
                              child: TextFormField(
                                controller: addCommentController,
                                keyboardType: TextInputType.name,
                                onFieldSubmitted: (value) {
                                  postAnswer(value);
                                },
                                style: TextStyle(color: Colors.black, fontSize: 15),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(top: 5, left: 10),
                                    hintText: "Add Comment",
                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25))),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            answerList.length != 0
                                ? ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    reverse: true,
                                    shrinkWrap: true,
                                    itemCount: answerList.length,
                                    itemBuilder: (c, i) {
                                      return Column(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            margin: EdgeInsets.only(left: 10, right: 10),
                                            decoration: BoxDecoration(
                                                color: Color(0xFFECECEC), borderRadius: BorderRadius.circular(10)),
                                            child: Container(
                                              padding: EdgeInsets.all(8),
                                              margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                                              child: Text(answerList[i].answer),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 10, right: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(20),
                                                      child: Image.asset(
                                                        "assets/person_avatar.png",
                                                        height: 30,
                                                        width: 30,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  "15K",
                                                  style: TextStyle(fontSize: 15),
                                                ),
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(20),
                                                  child: Image.asset(
                                                    "assets/person_avatar.png",
                                                    height: 30,
                                                    width: 30,
                                                  ),
                                                ),
                                                Image.asset(
                                                  "assets/idea.png",
                                                  height: 30,
                                                  width: 30,
                                                ),
                                                Image.asset(
                                                  "assets/like.png",
                                                  height: 30,
                                                  width: 30,
                                                ),
                                                Image.asset(
                                                  "assets/dislike.png",
                                                  height: 30,
                                                  width: 30,
                                                ),
                                                InkWell(
                                                  onTap: () {

                                                      answerList[i].showComment.value = !answerList[i].showComment.value;

                                                  },
                                                  child: Image.asset(
                                                    "assets/comment.png",
                                                    height: 30,
                                                    width: 30,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Username",
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          ),
                                          ValueListenableBuilder<bool>(
                                             valueListenable: answerList[i].showComment,
                                            builder: (BuildContext context, value, Widget child) {
                                              return Visibility(
                                                visible: value,
                                                child: ShowComment(answerId: answerList[i].idAnswer),
                                                replacement: Container(),
                                              );
                                            },

                                          )
                                          // answerList[i].showComment ?  : Container(),
                                        ],
                                      );
                                    })
                                : Column(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                        "No question and answers available at the moment.",
                                        style:
                                            TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                            SizedBox(
                              height: kToolbarHeight + kToolbarHeight,
                            ),
                          ],
                        );
                      }
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.black,
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), border: Border.all(width: 1, color: Colors.yellow)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Icon(Icons.arrow_back),
                ),
              ),
              Container(
                height: 30,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 2.5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: Colors.yellow)),
                child: Text("Ask Auro"),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), border: Border.all(width: 1, color: Colors.yellow)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Icon(Icons.arrow_forward),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> postAnswer(String value) async {
    var response = await InvestmentMasterclassPresenter().submitClassAnswers(widget.classId, value);

    if (response) {
      Answer answer = Answer(answer: value, dislikes: 0, likes: 0);

      answerList.add(answer);
      addCommentController.clear();
      setState(() {});
    }
  }
}
