import 'package:flutter/material.dart';

class ProductDescription extends StatelessWidget {
  final String text;

  const ProductDescription({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }
}