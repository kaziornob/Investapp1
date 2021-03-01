import 'package:flutter/material.dart';


class TabChip extends StatelessWidget {
  final Widget child;
  final Function callback;
  final Color backgroundColor;

  TabChip({
    this.child,
    this.backgroundColor,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: GestureDetector(
        onTap: callback,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: backgroundColor,
          ),
          width: 90,
          height: 40,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}