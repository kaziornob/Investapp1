import 'package:flutter/material.dart';

class Question {
  String text;
  bool hasComment;

  Question({this.text, this.hasComment = false});
}

class QuestionAnswerScreen extends StatefulWidget {
  const QuestionAnswerScreen({Key key}) : super(key: key);

  @override
  _QuestionAnswerScreenState createState() => _QuestionAnswerScreenState();
}

class _QuestionAnswerScreenState extends State<QuestionAnswerScreen> {
  TextEditingController addCommentController = TextEditingController();
  TextEditingController showCommentController = TextEditingController();
  List<Question> questionList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    questionList.add(Question(
        text:
            "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
        hasComment: false));
    questionList.add(Question(
        text:
            "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
        hasComment: true));
    questionList.add(Question(
        text:
            "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
        hasComment: false));
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
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                      height: 40,
                      child: TextFormField(
                        controller: addCommentController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 5, left: 10),
                            hintText: "Add Comment",
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: questionList.length,
                      itemBuilder: (c, i) {
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFECECEC),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                  top: 5,
                                ),
                                child: Text(questionList[i].text),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      setState(() {
                                        questionList[i].hasComment =
                                            !questionList[i].hasComment;
                                      });
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
                              margin: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Username",
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                            questionList[i].hasComment
                                ? showComment()
                                : Container()
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: kToolbarHeight + kToolbarHeight,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: Colors.yellow),
                ),
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
                  border: Border.all(width: 1, color: Colors.yellow),
                ),
                child: Text("Ask Auro"),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: Colors.yellow),
                ),
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

  showComment() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          height: 40,
          child: TextFormField(
            controller: showCommentController,
            decoration: InputDecoration(
              fillColor: Color(0xffECECEC),
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.only(top: 0, left: 20),
              hintText: 'Reply',
              hintStyle: TextStyle(
                fontSize: 15,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "assets/person_avatar.png",
                      height: 30,
                      width: 30,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Username",
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(right: 10),
                width: MediaQuery.of(context).size.width * 0.18,
                height: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(0xffECECEC),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 1, color: Colors.black)),
                child: Text("Post"),
              )
            ],
          ),
        ),
      ],
    );
  }
}
