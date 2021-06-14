import 'package:auroim/provider_abhinav/stock_pitch_provider.dart';
import 'package:auroim/static_data/static_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class StockPitchCommentsSection extends StatefulWidget {
  final userEmail;
  final pitchNumber;

  const StockPitchCommentsSection({
    Key key,
    this.pitchNumber,
    this.userEmail,
  }) : super(key: key);

  @override
  _StockPitchCommentsSectionState createState() =>
      _StockPitchCommentsSectionState();
}

class _StockPitchCommentsSectionState extends State<StockPitchCommentsSection> {
  TextEditingController addCommentController = TextEditingController();
  Map showReplyForComments = {};
  bool _isInit = true;

  @override
  void dispose() {
    addCommentController.dispose();
    // replyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            height: 40,
            child: TextFormField(
              style: TextStyle(
                color: Colors.black,
              ),
              controller: addCommentController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 5, left: 10),
                hintText: "Add Comment",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onFieldSubmitted: (String value) async {
                await Provider.of<StockPitchProvider>(context, listen: false)
                    .addComment(
                  widget.userEmail,
                  widget.pitchNumber,
                  value,
                );
                addCommentController.clear();
                setState(() {});
              },
            ),
          ),
          allComments(),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  allComments() {
    return FutureBuilder(
      future: Provider.of<StockPitchProvider>(context).getStockPitchComments(
        widget.userEmail,
        "${widget.pitchNumber}",
        // widget.userEmail,
        // widget.pitchNumber,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length != 0) {
            List allComments = snapshot.data;

            return Column(
              children: allComments.map<Widget>((data) {
                if (showReplyForComments["${data["id_answer"]}"] == null) {
                  showReplyForComments["${data["id_answer"]}"] = false;
                }
                return singleComment(data);
              }).toList(),
            );
          } else {
            return SizedBox();
          }
        } else {
          return SizedBox();
        }
      },
    );
  }

  singleReply(data) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
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
              child: Text("${data["comment"]}"),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Row(
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
                "${data["user_name"]}",
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }

  addReply(stateToChange, commentId) {
    TextEditingController replyController = TextEditingController();
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 10,
            top: 10,
          ),
          height: 40,
          child: TextFormField(
            controller: replyController,
            style: TextStyle(
              color: Colors.black,
            ),
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
              InkWell(
                onTap: () async {
                  print("jhjhjhjhjhj");
                  print(commentId);
                  print(replyController.text);

                  try {
                    var response = await Provider.of<StockPitchProvider>(
                            context,
                            listen: false)
                        .addCommentReply(
                      commentId,
                      replyController.text,
                    );
                    FocusScope.of(context).unfocus();
                    if (response == "") {
                      Toast.show("Some Error Occurred", context);
                    } else {
                      Toast.show("Reply Posted", context);
                      stateToChange(() {});
                    }
                  } catch (err) {
                    print(err.toString());
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  width: MediaQuery.of(context).size.width * 0.18,
                  height: 25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xffECECEC),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 1, color: Colors.black),
                  ),
                  child: Text("Post"),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  singleComment(data) {
    return StatefulBuilder(builder: (context, setStateComment) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
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
                child: Text("${data["answer"]}"),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
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
                      width: 6.0,
                    ),
                    Text(
                      "${data["user_score"]}",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
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
                  StaticData.badges["${data["user_badge"]}"] == null
                      ? StaticData.badges["Challenger"]["asset_path"]
                      : StaticData.badges["${data["user_badge"]}"]
                          ["asset_path"],
                  height: 30,
                  width: 50,
                  fit: BoxFit.contain,
                ),
                InkWell(
                  onTap: () => likeDislike(
                    "stock_pitch_answers",
                    data["id_answer"],
                    1,
                    setStateComment,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/like.png",
                        height: 30,
                        width: 30,
                      ),
                      SizedBox(
                        width: 6.0,
                      ),
                      Text("${data["likes"]}"),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => likeDislike(
                    "stock_pitch_answers",
                    data["id_answer"],
                    -1,
                    setStateComment,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/dislike.png",
                        height: 30,
                        width: 30,
                      ),
                      SizedBox(
                        width: 6.0,
                      ),
                      Text("${data["dislikes"]}"),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setStateComment(() {
                      showReplyForComments["${data["id_answer"]}"] =
                          !showReplyForComments["${data["id_answer"]}"];
                    });
                    print(showReplyForComments["${data["id_answer"]}"]);
                    print(showReplyForComments.toString());
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
          Visibility(
            visible: showReplyForComments["${data["id_answer"]}"] ?? false,
            child: Container(
              child: Column(
                children: [
                  addReply(setStateComment, "${data["id_answer"]}"),
                  FutureBuilder(
                    future: Provider.of<StockPitchProvider>(context)
                        .getStockPitchCommentReplies(
                      "${data["id_answer"]}",
                    ),
                    builder: (context, snapshot) {
                      print("in builder");
                      if (snapshot.hasData) {
                        print("replies data got");
                        List allReplies = snapshot.data;
                        return Column(
                          children: allReplies.map<Widget>((data) {
                            return singleReply(data);
                          }).toList(),
                        );
                      } else {
                        print("replies data not gottttt");
                        return SizedBox();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  likeDislike(category, id, vote, state) async {
    // print(vote);
   var message = await Provider.of<StockPitchProvider>(context,listen: false)
        .likeCommentReply(category, id, vote);
   Toast.show(message, context,duration: 3);
    setState(() {});
  }
}
