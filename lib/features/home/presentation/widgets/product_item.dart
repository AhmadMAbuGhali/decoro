import 'package:flutter/material.dart';
import '../../../product/data/models/product_model.dart';
import '../../../product/presentation/pages/product_detail_page.dart';
import '../../../../config/theme/app_colors.dart';

class ProductItemWidget extends StatefulWidget {
  final ProductModel product;
  const ProductItemWidget ({super.key, required this.product});

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  bool isFav = false;
  String _imageUrl() {
    if (widget.product.mainImage != null &&
        widget.product.mainImage!['url'] != null &&
        widget.product.mainImage!['url'] != '') return widget.product.mainImage!['url'];

    if (widget.product.gallery.isNotEmpty &&
        widget.product.gallery.first['url'] != null) {
      return widget.product.gallery.first['url'];
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    final image = _imageUrl();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailPage(productId: widget.product.id),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ---------------- IMAGE + HEART ----------------
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Container(
                              color: Colors.grey.shade200,
                              child: const Icon(Icons.broken_image),
                            ),
                      ),
                    ),
                  ),

                  // Heart Icon
                  Positioned(
                    right: 6,
                    top: 6,
                    child: GestureDetector(
                      onTap: () {
                        setState(() => isFav = !isFav);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.95),
                        ),
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          size: 18,
                          color: isFav ? Colors.red : Colors.black87,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 8),

            // ---------------- NAME ----------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                widget.product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),

            const SizedBox(height: 6),

            // ---------------- PRICE + BLUE ARROW ----------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(

                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Color(0XffE3E8EF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.shopping_bag_outlined,
                      color: AppColors.primary,
                      size: 16,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Color(0XffE3E8EF),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "\$${widget.product.price.toStringAsFixed(2)}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 4),

                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.north_east,
                                color: Colors.white,
                                size: 16,
                              ),
                            )
                          ],
                        ),
                      ),

                    ],
                  ),




                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}