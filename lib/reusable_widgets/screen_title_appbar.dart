import 'package:auroim/constance/constance.dart';
import 'package:auroim/widgets/animated_widgets/animated_back_button.dart';
import 'package:flutter/material.dart';

class ScreenTitleAppbar extends StatefulWidget {
  final String title;

  const ScreenTitleAppbar({Key key, this.title}) : super(key: key);
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
          child: AnimatedBackButton(
            color: Colors.black,
          ),
        ),
        Text(
          widget.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: ConstanceData.SIZE_TITLE20,
          ),
        ),
        SizedBox(),
      ],
    );
  }
}
