import 'package:flutter/material.dart';

import 'api/investment_masterclass_presenter.dart';
import 'invesment_masterclass_models/comment_answer_response_model.dart';

class ShowComment extends StatefulWidget {
  final int answerId;

  ShowComment({Key key, this.answerId}) : super(key: key);

  @override
  _ShowCommentState createState() => _ShowCommentState();
}

class _ShowCommentState extends State<ShowComment> {
  List<Comment> answerComments = [];

  TextEditingController showCommentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.answerId != null && widget.answerId != 0)
          FutureBuilder(
            future: InvestmentMasterclassPresenter().getClassAnswersComment(widget.answerId),
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
                answerComments = snapshot.data.message.comments;
                return Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    answerComments.length != 0
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            reverse: true,
                            shrinkWrap: true,
                            itemCount: answerComments.length,
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
                                      child: Text(answerComments[i].comment),
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
                                          onTap: () {},
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
                                  //    questionList[i].hasComment ? showComment() : Container()
                                  // showComment(),
                                ],
                              );
                            })
                        : Container(),
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
        Container(
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          height: 40,
          child: TextFormField(
            controller: showCommentController,
            decoration: InputDecoration(
                fillColor: Color(0xffECECEC),
                filled: true,
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: EdgeInsets.only(top: 0, left: 20),
                hintText: 'Reply',
                hintStyle: TextStyle(
                  fontSize: 15,
                ),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
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
              InkWell(
                onTap: () {
                  postAnswer(showCommentController.text.trim());
                },
                child: Container(
                    margin: EdgeInsets.only(right: 10),
                    width: MediaQuery.of(context).size.width * 0.18,
                    height: 25,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xffECECEC),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 1, color: Colors.black)),
                    child: Text("Post")),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<void> postAnswer(String value) async {
    var response = await InvestmentMasterclassPresenter().submitClassAnswersComment(widget.answerId, value);

    if (response) {
      Comment comment = Comment(
        comment: value,
        dislikes: 0,
        likes: 0,
      );

      answerComments.add(comment);
      showCommentController.clear();
      setState(() {});
    }
  }
}
