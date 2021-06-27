import 'package:auroim/presentation/common/auro_button.dart';
import 'package:auroim/presentation/common/auro_text.dart';
import 'package:auroim/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuroLogoHeader extends StatelessWidget {
  const AuroLogoHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
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
    );
  }
}
