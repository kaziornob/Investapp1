import 'package:auroim/presentation/common/auro_button.dart';
import 'package:auroim/presentation/common/auro_logo_header.dart';
import 'package:auroim/presentation/common/auro_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../homeScreen.dart';

class FundingConfirmationPage extends StatelessWidget {
  const FundingConfirmationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 40.w),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuroLogoHeader(),
              SizedBox(
                height: 20.h,
              ),
              AuroText(
                "You currently have \$10,000 in your account in cash",
                textType: TextType.headLine6,
                maxLine: 10,
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 20.h),
              ),
              SizedBox(
                height: 40.h,
              ),
              AuroButton(
                  text: "Add more Funds",
                  borderColor: Colors.white,
                  borderThickness: 2,
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  onPressed: () {
                    Get.back();
                  }),
              AuroText(
                "Or",
                textType: TextType.headLine6,
                maxLine: 10,
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 30.h),
              ),
              AuroButton(
                  text: "Proceed to invest cash in Auro Portfolio",
                  borderColor: Colors.white,
                  borderThickness: 2,
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  onPressed: () {
                    Get.to(() => HomeScreen());
                  }),
              AuroText(
                "Or",
                textType: TextType.headLine6,
                maxLine: 10,
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 30.h),
              ),
              AuroButton(
                  text: "Sell your Auro Portfolio",
                  borderColor: Colors.white,
                  borderThickness: 2,
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  onPressed: () {
                    Get.to(() => HomeScreen());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
