import 'package:auroim/presentation/common/auro_button.dart';
import 'package:auroim/presentation/common/auro_logo_header.dart';
import 'package:auroim/presentation/common/auro_text.dart';
import 'package:auroim/presentation/pages/app/home/ibkr/fund_your_account_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LinkIbHelpPage extends StatelessWidget {
  const LinkIbHelpPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 40.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuroLogoHeader(),
              AuroText(
                "To link your existing IB Account under us, follow the procedure below:",
                textType: TextType.headLine6,
                maxLine: 10,
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 40.h),
              ),
              AuroText(
                "1.    Log into your IB account",
                textType: TextType.headLine6,
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10.h),
              ),
              AuroText(
                "1.    Go to settings > account settings >\n        configuration",
                textType: TextType.headLine6,
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10.h),
              ),
              AuroText(
                "1.    Select “Move your account to an advisor\n        or broker",
                textType: TextType.headLine6,
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10.h),
              ),
              AuroText(
                "1.    Select “Move my Entire Account”",
                textType: TextType.headLine6,
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10.h),
              ),
              AuroText(
                "5.    Specify the Auroville Investment\n        Management details:",
                textType: TextType.headLine6,
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10.h),
              ),
              SizedBox(
                height: 80.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuroText(
                      "Account ID: F6639980",
                      textType: TextType.headLine6,
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                    ),
                    AuroText(
                      "Account Title: Auroville Investment Management (HK) Limited",
                      textType: TextType.headLine6,
                      color: Colors.white,
                      padding: EdgeInsets.only(bottom: 80.h),
                    ),
                  ],
                ),
              ),
              AuroButton(
                  text: "Click to link IB Proceed",
                  borderColor: Colors.white,
                  borderThickness: 2,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  onPressed: () {
                    Get.to(() => FundYourAccountPage());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
