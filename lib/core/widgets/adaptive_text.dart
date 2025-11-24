import 'package:flutter/material.dart';

class AdaptiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign align;
  final int? maxLines;

  const AdaptiveText(
      this.text, {
        super.key,
        this.style,
        this.align = TextAlign.start,
        this.maxLines,
      });

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.of(context).textScaleFactor.clamp(0.9, 1.2);

    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: (style ?? Theme.of(context).textTheme.bodyMedium)
          ?.copyWith(fontSize: (style?.fontSize ?? 14) * scale),
    );
  }
}