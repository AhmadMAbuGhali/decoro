import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onOpen;

  const ProductCard({
    super.key,
    required this.product,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = product.mainImage?['url'] ??
        (product.gallery.isNotEmpty ? product.gallery.first['url'] : null);

    return GestureDetector(
      onTap: onOpen,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: imageUrl != null
                    ? Image.network(
                  imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                  const Icon(Icons.broken_image),
                )
                    : Container(
                  color: Colors.grey.shade200,
                  child: const Center(
                    child: Icon(Icons.image_not_supported),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "\$${product.price.toStringAsFixed(2)}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}