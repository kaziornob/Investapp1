import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoinsInfoButton extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback onTap;
  const CoinsInfoButton(
      {Key key,
      @required this.image,
      @required this.text,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(children: <Widget>[
        new Image(
            height: 100.h, fit: BoxFit.cover, image: new AssetImage(image)),
        SizedBox(
          height: 10.h,
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ]),
    );
  }
}
