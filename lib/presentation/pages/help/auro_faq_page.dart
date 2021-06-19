import 'package:auroim/presentation/common/auro_text.dart';
import 'package:auroim/presentation/pages/help/widgets/faq_widget.dart';
import 'package:auroim/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'data/faq_data.dart';

class AuroFaqPage extends StatelessWidget {
  AuroFaqPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuroText(
                    'AUR',
                    fontSize: 50.sp,
                    color: Color(0xffD8AF4F),
                  ),
                  Image.asset(
                    Assets.appIcon,
                    width: 50.w,
                  ),
                  AuroText(
                    '.AI FAQ',
                    fontSize: 50.sp,
                    color: Color(0xffD8AF4F),
                  ),
                ],
              ),
            ),
            AuroText(
              "Investment Algo/Robo Advisory",
              fontWeight: FontWeight.w600,
              color: Colors.black,
              textType: TextType.headLine5,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 22,
              itemBuilder: (context, index) =>
                  FaqWidget.fromMap(FaqData.content[index]),
            ),
            AuroText(
              "Other",
              fontWeight: FontWeight.w600,
              color: Colors.black,
              textType: TextType.headLine5,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: FaqData.content.length - 22,
              itemBuilder: (context, index) =>
                  FaqWidget.fromMap(FaqData.content[index + 22]),
            ),
          ],
        ),
      ),
    );
  }
}
