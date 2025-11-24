import 'package:flutter/material.dart';

class ProductReviews extends StatelessWidget {
  const ProductReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "No reviews yet.",
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }
}