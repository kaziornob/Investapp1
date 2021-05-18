import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:flutter/material.dart';

class Dialog1 extends StatelessWidget {
  final String text;
  final bool doublePop;

  const Dialog1({Key key, this.text, this.doublePop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
      title: Text(
        "",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AllCoustomTheme.getTextThemeColors(),
          fontWeight: FontWeight.bold,
          fontSize: ConstanceData.SIZE_TITLE18,
        ),
      ),
      content: Text(
        "$text",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AllCoustomTheme.getTextThemeColors(),
          fontWeight: FontWeight.bold,
          fontSize: ConstanceData.SIZE_TITLE18,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'Ok',
            style: TextStyle(
              color: AllCoustomTheme.getTextThemeColors(),
              fontWeight: FontWeight.bold,
              fontSize: ConstanceData.SIZE_TITLE18,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            if (doublePop) {
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
