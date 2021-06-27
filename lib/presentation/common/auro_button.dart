import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'auro_text.dart';

class AuroButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final Color color;
  final EdgeInsets margin;
  final Color textColor;
  final double width;
  final TextType textType;
  final EdgeInsets padding;
  final double borderRadius;
  final Color borderColor;
  final double borderThickness;
  final Widget customWidget;
  final bool showRightArrow;
  const AuroButton(
      {Key key,
      @required this.text,
      @required this.onPressed,
      this.color,
      this.width = double.infinity,
      this.textColor = Colors.white,
      this.margin,
      this.borderRadius = 50,
      this.textType = TextType.headLine6,
      this.padding,
      this.showRightArrow = false,
      this.customWidget,
      this.borderColor,
      this.borderThickness = 1})
      : super(key: key);

  factory AuroButton.goldRectangleButton(
      {@required String text, @required VoidCallback onPressed, double width}) {
    return AuroButton(
      text: text,
      onPressed: onPressed,
      margin: EdgeInsets.zero,
      color: Color(0xFFD8AF4F),
      borderRadius: 10.sp,
      width: width,
      textColor: Colors.white,
      showRightArrow: false,
    );
  }
  factory AuroButton.goldRoundedButton(
      {@required String text, @required VoidCallback onPressed}) {
    return AuroButton(
      text: text,
      onPressed: onPressed,
      margin: EdgeInsets.zero,
      color: Color(0xFFD8AF4F),
      width: 200.w,
      textColor: Colors.white,
      borderRadius: 50.sp,
      showRightArrow: false,
    );
  }
  factory AuroButton.blackRoundedButton(
      {@required String text, @required VoidCallback onPressed}) {
    return AuroButton(
      text: text,
      onPressed: onPressed,
      margin: EdgeInsets.zero,
      color: Colors.lightGreen[400],
      width: 200.w,
      borderRadius: 50.sp,
      textColor: Colors.white,
      showRightArrow: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin ?? EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: padding ?? EdgeInsets.all(8.w),
          // elevation: 0,
          primary: color ?? Color(0xFFD8AF4F),
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            side: borderColor != null
                ? BorderSide(color: borderColor, width: borderThickness)
                : BorderSide.none,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: showRightArrow
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            if (customWidget != null)
              customWidget
            else
              AuroText(text,
                  color: textColor ?? Theme.of(context).colorScheme.primary,
                  maxLine: 1,
                  fontWeight: FontWeight.w400,
                  textType: textType),
            if (showRightArrow)
              Icon(
                Icons.chevron_right_outlined,
                color: textColor,
                size: 30.sp,
              )
          ],
        ),
      ),
    );
  }
}
