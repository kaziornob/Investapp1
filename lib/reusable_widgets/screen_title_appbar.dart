import 'package:auroim/constance/constance.dart';
import 'package:flutter/material.dart';

class ScreenTitleAppbar extends StatefulWidget {
  final String title;
  final Color colorText;

  const ScreenTitleAppbar({Key key, this.title, this.colorText})
      : super(key: key);

  @override
  _ScreenTitleAppbarState createState() => _ScreenTitleAppbarState();
}

class _ScreenTitleAppbarState extends State<ScreenTitleAppbar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
          ),
          child: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios,
            ),
            onTap: () => Navigator.of(context).pop(),
          ),
        ),
        Text(
          widget.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: widget.colorText == null ? Colors.black : widget.colorText,
            fontWeight: FontWeight.bold,
            fontSize: ConstanceData.SIZE_TITLE20,
          ),
        ),
        SizedBox(),
      ],
    );
  }
}
