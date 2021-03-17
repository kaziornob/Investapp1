import 'package:animator/animator.dart';
import 'package:auroim/constance/themes.dart';
import 'package:flutter/material.dart';

class AnimatedBackButton extends StatefulWidget {
  @override
  _AnimatedBackButtonState createState() => _AnimatedBackButtonState();
}

class _AnimatedBackButtonState extends State<AnimatedBackButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context,
            rootNavigator: true)
            .pop();
      },
      child: Animator(
        tween: Tween<Offset>(
          begin: Offset(0, 0),
          end: Offset(0.2, 0),
        ),
        duration: Duration(milliseconds: 500),
        cycles: 0,
        builder: (anim) =>
            FractionalTranslation(
              translation: anim.value,
              child: Icon(
                Icons.arrow_back_ios,
                color: AllCoustomTheme
                    .getTextThemeColor(),
              ),
            ),
      ),
    );
  }
}
