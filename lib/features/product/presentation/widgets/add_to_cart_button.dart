import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';

class AddToCartButton extends StatelessWidget {
  final Product product;

  const AddToCartButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(
          "Add to Cart - \$${product.price}",
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}