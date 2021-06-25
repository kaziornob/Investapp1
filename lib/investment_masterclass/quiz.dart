import 'package:auroim/investment_masterclass/quiz_body.dart';
import 'package:flutter/material.dart';

class QuizDemo {
  String title;
  int answerValue;

  QuizDemo({this.title, this.answerValue});
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  PageController controller =
      PageController(initialPage: 0, viewportFraction: 1, keepPage: true);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView.builder(
          controller: controller,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return QuizPageBody(
              pageController: controller,
            );
          },
        ),
      ),
    );
  }
}
