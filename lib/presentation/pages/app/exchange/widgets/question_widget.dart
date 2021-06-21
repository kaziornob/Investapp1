import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/presentation/common/auro_text.dart';
import 'package:auroim/resources/resources.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final String title;
  final String question;
  final String answers;
  final String comments;
  final String likes;
  final VoidCallback onTap;
  final VoidCallback onUserTap;

  const QuestionWidget(
      {Key key,
      @required this.title,
      @required this.question,
      @required this.answers,
      @required this.comments,
      @required this.likes,
      @required this.onTap,
      @required this.onUserTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuroText(
                title,
                padding: EdgeInsets.only(left: 30),
                color: Colors.black,
                textType: TextType.headLine5,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.all(15.0),
                child: Text(
                  question,
                  style: TextStyle(
                      color: AllCoustomTheme.getNewSecondTextThemeColor(),
                      fontSize: ConstanceData.SIZE_TITLE16,
                      fontFamily: "Rosarivo",
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0.2),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  upvotesDownvotesWidget(votes) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Assets.like,
          height: 40,
        ),
        AuroText(
          "$votes",
          padding: EdgeInsets.symmetric(horizontal: 5),
          color: Colors.black,
          fontWeight: FontWeight.w300,
          textType: TextType.headLine5,
        ),
        Image.asset(
          Assets.dislike,
          height: 40,
        ),
      ],
    );
  }
}
