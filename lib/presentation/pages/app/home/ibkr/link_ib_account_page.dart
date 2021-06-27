import 'package:auroim/presentation/common/auro_button.dart';
import 'package:auroim/presentation/common/auro_logo_header.dart';
import 'package:auroim/presentation/common/auro_text.dart';
import 'package:auroim/presentation/pages/app/home/ibkr/link_ib_account_help.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LinkIbAccountPage extends StatelessWidget {
  const LinkIbAccountPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 40.w),
          child: Column(
            children: [
              AuroLogoHeader(),
              AuroText(
                'In order to trade a live Auro Portfolio, you’ll need to create an account with our strategic partner, Interactive Brokers (IB), one of thee largest brokers in the world.',
                textType: TextType.headLine6,
                maxLine: 10,
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 40.h),
              ),
              AuroText(
                "Click here if you already have an IB Account to link it under us:",
                textType: TextType.headLine6,
                color: Colors.white,
              ),
              AuroButton(
                  text: "Click to link IB Account",
                  borderColor: Colors.white,
                  borderThickness: 2,
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  onPressed: () {
                    Get.to(() => LinkIbHelpPage());
                  }),
              SizedBox(
                height: 80.h,
              ),
              AuroText(
                "Click here if you already have an IB Account to link it under us:",
                textType: TextType.headLine6,
                color: Colors.white,
              ),
              AuroButton(
                  text: "Click to link IB Account",
                  borderColor: Colors.white,
                  borderThickness: 2,
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  onPressed: () {
                    Get.to(() => LinkIbHelpPage());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
