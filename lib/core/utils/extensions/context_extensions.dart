import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  // Theme
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;

  // MediaQuery
  Size get size => MediaQuery.of(this).size;
  double get width => size.width;
  double get height => size.height;

  // Navigator
  void pop<T extends Object?>([T? result]) => Navigator.of(this).pop(result);
  Future<T?> push<T>(Widget page) =>
      Navigator.of(this).push(MaterialPageRoute(builder: (_) => page));

  // ColorScheme
  ColorScheme get colors => theme.colorScheme;
}