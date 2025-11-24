import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';

class ProductMainInfo extends StatelessWidget {
  final Product product;

  const ProductMainInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          Text(
            "\$${product.price}",
            style: const TextStyle(
              fontSize: 18,
              color: Colors.green,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}