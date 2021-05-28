import 'package:auroim/constance/themes.dart';
import 'package:flutter/material.dart';

class SmallTabChip extends StatelessWidget {
  final bool selected;
  final Function callback;
  final String tabText;
  final double width;

  SmallTabChip({
    this.selected,
    this.callback,
    this.tabText,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0),
      child: GestureDetector(
        onTap: callback,
        child: Container(
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(20),
            // color: selected
            //     ? Color(0xff7499C6)
            //     : Colors.white,
            border: selected
                ? Border(
                    bottom: BorderSide(
                      color: selected
                          ? AllCoustomTheme.getHeadingThemeColors()
                          : AllCoustomTheme.getTextThemeColors(),
                      width: 2,
                    ),
                  )
                : null,
          ),
          width: width,
          height: 40,
          child: Center(
            child: Text(
              "$tabText",
              style: TextStyle(
                fontFamily: 'Roboto',
                color: selected
                    ? AllCoustomTheme.getHeadingThemeColors()
                    : AllCoustomTheme.getTextThemeColors(),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
