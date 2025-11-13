import 'package:flutter/material.dart';

class AdaptiveText extends StatelessWidget {
  final String text;
  const AdaptiveText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.bodyMedium);
  }
}