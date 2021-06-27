import 'package:auroim/presentation/common/auro_button.dart';
import 'package:auroim/presentation/common/auro_logo_header.dart';
import 'package:auroim/presentation/common/auro_text.dart';
import 'package:auroim/presentation/pages/app/home/ibkr/link_ib_account_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ManagementFeeOptionPage extends StatelessWidget {
  const ManagementFeeOptionPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              AuroLogoHeader(),
              AuroText(
                'Select your management fee option:',
                textType: TextType.headLine6,
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 40.h),
              ),
              SizedBox(
                height: 20.h,
              ),
              AuroButton(
                text: '',
                onPressed: () {
                  Get.to(() => LinkIbAccountPage());
                },
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                padding: EdgeInsets.symmetric(vertical: 20.h),
                color: Color(0xFF1D3767),
                borderColor: Color(0xFFA1B1CD),
                borderRadius: 20,
                borderThickness: 3,
                customWidget: Column(
                  children: [
                    AuroText(
                      "Management Fee: 0.75%",
                      textType: TextType.headLine5,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    AuroText("Performance Fee: 5%",
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                        textType: TextType.headLine5)
                  ],
                ),
              ),
              AuroButton(
                text: '',
                onPressed: () {
                  Get.to(() => LinkIbAccountPage());
                },
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                padding: EdgeInsets.symmetric(vertical: 20.h),
                color: Color(0xFF1D3767),
                borderColor: Color(0xFFA1B1CD),
                borderRadius: 20,
                borderThickness: 3,
                customWidget: Column(
                  children: [
                    AuroText(
                      "Management Fee: 0.50%",
                      textType: TextType.headLine5,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    AuroText("Performance Fee: 10%",
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                        textType: TextType.headLine5)
                  ],
                ),
              ),
              AuroButton(
                text: '',
                onPressed: () {
                  Get.to(() => LinkIbAccountPage());
                },
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                padding: EdgeInsets.symmetric(vertical: 20.h),
                color: Color(0xFF1D3767),
                borderColor: Color(0xFFA1B1CD),
                borderRadius: 20,
                borderThickness: 3,
                customWidget: Column(
                  children: [
                    AuroText(
                      "Management Fee: 0%",
                      textType: TextType.headLine5,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    AuroText("Performance Fee: 25%",
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                        textType: TextType.headLine5)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
