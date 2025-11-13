mixin ResponsiveMixin {
  double scale(double value, double deviceWidth, double designWidth) {
    return value * (deviceWidth / designWidth);
  }
}