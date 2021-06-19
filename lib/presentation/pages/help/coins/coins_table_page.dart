import 'package:auroim/presentation/common/auro_text.dart';
import 'package:auroim/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InvestMentTrackRecord extends StatelessWidget {
  const InvestMentTrackRecord({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
              ],
            ),
          ),
          AuroText(
            "Investment Track Record",
            fontWeight: FontWeight.w600,
            color: Colors.black,
            textType: TextType.headLine5,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          ),
          Row(
            children: [
              AuroText(
                'Activity',
                textType: TextType.headLine5,
                color: Color(0xffD8AF4F),
              ),
              AuroText(
                'Coins Earned',
                textType: TextType.headLine5,
                color: Color(0xffD8AF4F),
              ),
            ],
          )
        ],
      ),
    );
  }
}
