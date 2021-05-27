import 'package:flutter/material.dart';

class CustomSliderThumbCircle extends SliderComponentShape {
  final double thumbRadius;
  final int min;
  final int max;

  const CustomSliderThumbCircle({
    @required this.thumbRadius,
    this.min = 0,
    this.max = 10,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
    double textScaleFactor,
    Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    Paint paintCircle = Paint()..color = Colors.white;
    Paint paintBorder = Paint()
      ..color = Color(0xFF1D6177)
      ..strokeWidth = thumbRadius * .1
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, thumbRadius * .8, paintCircle);
    canvas.drawCircle(center, thumbRadius * .9, paintBorder);
  }
}

// import 'package:flutter/material.dart';
// import 'dart:math' as math;
//
// class CustomSliderThumbCircle extends SliderComponentShape {
//   /// Create a slider thumb that draws a circle.
//   const CustomSliderThumbCircle({
//     this.enabledThumbRadius = 10.0,
//     this.disabledThumbRadius,
//     this.elevation = 1.0,
//     this.pressedElevation = 6.0,
//   });
//
//   /// The preferred radius of the round thumb shape when the slider is enabled.
//   ///
//   /// If it is not provided, then the material default of 10 is used.
//   final double enabledThumbRadius;
//
//   /// The preferred radius of the round thumb shape when the slider is disabled.
//   ///
//   /// If no disabledRadius is provided, then it is equal to the
//   /// [enabledThumbRadius]
//   final double disabledThumbRadius;
//   double get _disabledThumbRadius => disabledThumbRadius ?? enabledThumbRadius;
//
//   /// The resting elevation adds shadow to the unpressed thumb.
//   ///
//   /// The default is 1.
//   ///
//   /// Use 0 for no shadow. The higher the value, the larger the shadow. For
//   /// example, a value of 12 will create a very large shadow.
//   ///
//   final double elevation;
//
//   /// The pressed elevation adds shadow to the pressed thumb.
//   ///
//   /// The default is 6.
//   ///
//   /// Use 0 for no shadow. The higher the value, the larger the shadow. For
//   /// example, a value of 12 will create a very large shadow.
//   final double pressedElevation;
//
//   @override
//   Size getPreferredSize(bool isEnabled, bool isDiscrete) {
//     return Size.fromRadius(isEnabled == true ? enabledThumbRadius : _disabledThumbRadius);
//   }
//
//   @override
//   void paint(
//       PaintingContext context,
//       Offset center, {
//         Animation<double> activationAnimation,
//         @required Animation<double> enableAnimation,
//         bool isDiscrete,
//         TextPainter labelPainter,
//         RenderBox parentBox,
//         @required SliderThemeData sliderTheme,
//         TextDirection textDirection,
//         double value,
//         double textScaleFactor,
//         Size sizeWithOverflow,
//       }) {
//     assert(context != null);
//     assert(center != null);
//     assert(enableAnimation != null);
//     assert(sliderTheme != null);
//     assert(sliderTheme.disabledThumbColor != null);
//     assert(sliderTheme.thumbColor != null);
//
//     final Canvas canvas = context.canvas;
//     final Tween<double> radiusTween = Tween<double>(
//       begin: _disabledThumbRadius,
//       end: enabledThumbRadius,
//     );
//     final ColorTween colorTween = ColorTween(
//       begin: sliderTheme.disabledThumbColor,
//       end: sliderTheme.thumbColor,
//     );
//
//     final Color color = colorTween.evaluate(enableAnimation);
//     final double radius = radiusTween.evaluate(enableAnimation);
//
//     final Tween<double> elevationTween = Tween<double>(
//       begin: elevation,
//       end: pressedElevation,
//     );
//
//     final double evaluatedElevation = elevationTween.evaluate(activationAnimation);
//     final Path path = Path()
//       ..addArc(Rect.fromCenter(center: center, width: 2 * radius, height: 2 * radius), 0, math.pi * 2);
//     canvas.drawShadow(path, Colors.black, evaluatedElevation, true);
//
//     canvas.drawCircle(
//       center,
//       radius,
//       Paint()
//         ..color = color
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 1,
//     );
//   }
// }
