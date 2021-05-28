import 'package:animator/animator.dart';
import 'package:flutter/cupertino.dart';

class WidgetScaleAnimation extends StatefulWidget {
  final Widget child;

  WidgetScaleAnimation({
    this.child,
  });

  @override
  _WidgetScaleAnimationState createState() => _WidgetScaleAnimationState();
}

class _WidgetScaleAnimationState extends State<WidgetScaleAnimation> {
  @override
  Widget build(BuildContext context) {
    return Animator(
      tween: Tween<double>(
          begin: 0.8, end: 1.1),
      curve: Curves.easeInToLinear,
      cycles: 0,
      builder: (anim) =>
          Transform.scale(
            scale: anim.value,
            child: Padding(
              padding:
              const EdgeInsets.only(
                  right: 16),
              child: widget.child,
            ),
          ),
    );
  }
}
