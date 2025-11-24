import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  final double stroke;

  const LoadingIndicator({
    super.key,
    this.size = 40,
    this.stroke = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          strokeWidth: stroke,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}