import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';

class ProductImageHeader extends StatelessWidget {
  final Product product;

  const ProductImageHeader({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // 🔥 جمع الصور الأساسية + الجاليري
    final List<String> allImages = [
      if (product.mainImageUrl != null && product.mainImageUrl!.isNotEmpty)
        product.mainImageUrl!,
      ...product.galleryUrls,
    ];

    return SizedBox(
      height: 320,
      child: PageView(
        children: allImages.isNotEmpty
            ? allImages
            .map(
              (img) => Image.network(
            img,
            fit: BoxFit.cover,
            width: double.infinity,
            errorBuilder: (_, __, ___) =>
            const Icon(Icons.broken_image, size: 60),
          ),
        )
            .toList()
            : [
          const Center(
            child: Icon(Icons.broken_image, size: 80),
          )
        ],
      ),
    );
  }
}