import 'package:auroim/investment_masterclass/chapter_quiz_body.dart';
import 'package:auroim/investment_masterclass/provider/ivm_chapter_quiz.dart';
import 'package:auroim/investment_masterclass/quiz_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class QuizDemo {
  String title;
  int answerValue;

  QuizDemo({this.title, this.answerValue});
}

class ChapterQuizScreen extends StatefulWidget {
  final int classId;

  const ChapterQuizScreen({Key key, this.classId}) : super(key: key);

  @override
  _ChapterQuizScreenState createState() => _ChapterQuizScreenState();
}

class _ChapterQuizScreenState extends State<ChapterQuizScreen> {
  PageController controller =
      PageController(initialPage: 0, viewportFraction: 1, keepPage: true);
  bool _isInit = true;

  int questionNumber = 0;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await Provider.of<IVMChapterQuizProvider>(context,listen: false)
          .getNextQuestion(widget.classId);
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<IVMChapterQuizProvider>(
          builder: (context, ivmProvider, _) {
            if(ivmProvider.nextQuestionModel != null){
              return ChapterQuizBody(questionData: ivmProvider.nextQuestionModel,);
            }else{
              return Center(child: CircularProgressIndicator());
            }
          },
        ),

        // PageView.builder(
        //   controller: controller,
        //   physics: NeverScrollableScrollPhysics(),
        //   itemCount: 5,
        //   itemBuilder: (context, index) {
        //     return ChapterQuizBody(pageController: controller,);
        //   },
        // ),
      ),
    );
  }
}
