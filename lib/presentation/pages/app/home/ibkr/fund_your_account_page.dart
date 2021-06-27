import 'package:auroim/presentation/common/auro_button.dart';
import 'package:auroim/presentation/common/auro_logo_header.dart';
import 'package:auroim/presentation/common/auro_text.dart';
import 'package:auroim/presentation/common/photo_viewer_page.dart';
import 'package:auroim/presentation/pages/app/home/ibkr/funding_page.dart';
import 'package:auroim/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FundYourAccountPage extends StatelessWidget {
  const FundYourAccountPage({Key key}) : super(key: key);

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
                "It should only take you a few minutes. To make the sign-on process easier for you, we’ve pre-populated some of the information, but please review and change, as necessary. After you’re done you should see the following screen:",
                textType: TextType.headLine6,
                maxLine: 10,
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 20.h),
              ),
              AuroText(
                "Final Steps to complete your application Please Review and compair the following where applicable",
                textType: TextType.headLine6,
                maxLine: 10,
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 20.h),
              ),
              AuroText(
                "Fund your account",
                textType: TextType.headLine6,
                maxLine: 10,
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 20.h),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => PhotoViewerPage(
                        imagePathOrUrl: Assets.ibImage,
                      ));
                },
                child: Image.asset(
                  Assets.ibImage,
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              AuroButton(
                  text: "Continue",
                  borderColor: Colors.white,
                  borderThickness: 2,
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  onPressed: () {
                    Get.to(() => FundingPage());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
