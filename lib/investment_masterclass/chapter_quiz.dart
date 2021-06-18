import 'package:auroim/investment_masterclass/chapter_quiz_body.dart';
import 'package:auroim/investment_masterclass/congratulations_screen.dart';
import 'package:auroim/investment_masterclass/invesment_masterclass_models/oops_screen.dart';
import 'package:auroim/investment_masterclass/provider/ivm_chapter_quiz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChapterQuizScreen extends StatefulWidget {
  final int classId;
  final String classTitle;

  const ChapterQuizScreen({Key key, this.classId, this.classTitle}) : super(key: key);

  @override
  _ChapterQuizScreenState createState() => _ChapterQuizScreenState();
}

class _ChapterQuizScreenState extends State<ChapterQuizScreen> {
  PageController controller = PageController(initialPage: 0, viewportFraction: 1, keepPage: true);
  bool _isInit = true;

  int questionNumber = 0;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await Provider.of<IVMChapterQuizProvider>(context, listen: false).getNextQuestion(widget.classId);
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<IVMChapterQuizProvider>(context, listen: false).onBackCallback();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Consumer<IVMChapterQuizProvider>(
            builder: (context, ivmProvider, _) {
              if (ivmProvider.testPassed == null) {
                if (ivmProvider.nextQuestionModel != null) {
                  return ChapterQuizBody(
                    questionData: ivmProvider.nextQuestionModel,
                    classId: widget.classId,
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              } else {
                if (ivmProvider.testPassed) {
                  return CongratulationScreen();
                } else {
                  return OopsScreen(classTitle: widget.classTitle,);
                }
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
      ),
    );
  }
}
