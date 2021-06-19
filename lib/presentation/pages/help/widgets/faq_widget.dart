import 'package:auroim/presentation/common/auro_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FaqWidget extends StatelessWidget {
  final String question;
  final String answer;
  const FaqWidget({Key key, @required this.question, @required this.answer})
      : super(key: key);

  factory FaqWidget.fromMap(Map<String, String> map) {
    return FaqWidget(
      answer: map['answer'],
      question: map['question'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10.h,
        ),
        AuroText(
          question,
          maxLine: 5,
          color: Colors.black,
          textType: TextType.headLine5,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        ),
        AuroText(
          answer,
          color: Colors.black,
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          maxLine: 100,
        )
      ],
    );
  }
}
