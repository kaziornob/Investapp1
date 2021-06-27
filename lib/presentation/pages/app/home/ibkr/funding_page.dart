import 'package:auroim/presentation/common/auro_button.dart';
import 'package:auroim/presentation/common/auro_logo_header.dart';
import 'package:auroim/presentation/common/auro_text.dart';
import 'package:auroim/presentation/pages/app/home/ibkr/fundind_confirmation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FundingPage extends StatelessWidget {
  const FundingPage({Key key}) : super(key: key);

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
                "Hong Kong regulator requires residents to fund a new account with a minimum of HK\$10,000 for electronic account opening",
                textType: TextType.headLine6,
                maxLine: 10,
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 20.h),
              ),
              SizedBox(
                height: 40.h,
              ),
              AuroText(
                "Final Steps to complete your application Please Review and compair the following where applicable",
                textType: TextType.headLine6,
                maxLine: 10,
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 20.h),
              ),
              AuroButton(
                  text: "Fund your account with HK10, 000+",
                  borderColor: Colors.white,
                  borderThickness: 2,
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  onPressed: () {
                    Get.to(() => FundingConfirmationPage());
                  }),
              AuroText(
                "Or you can visit a local branch in which case no funding required. ",
                textType: TextType.headLine6,
                maxLine: 10,
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 40.h),
              ),
              AuroButton(
                  text: "Fund your account with HK10, 000+",
                  borderColor: Colors.white,
                  borderThickness: 2,
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  onPressed: () {
                    Get.to(() => FundingConfirmationPage());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
