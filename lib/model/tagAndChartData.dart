import 'dart:ui';

class TagData {
  final String id;
  final String tag;

  TagData(this.id, this.tag);
}


class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color color;
}