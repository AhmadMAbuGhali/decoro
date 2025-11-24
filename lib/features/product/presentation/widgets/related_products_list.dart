// import 'package:flutter/material.dart';
// import '../../data/datasources/product_local_data.dart';
// import '../../domain/entities/product.dart';
// import '../pages/product_detail_page.dart';
//
// class RelatedProductsList extends StatelessWidget {
//   final String category;
//
//   const RelatedProductsList({super.key, required this.category});
//
//   @override
//   Widget build(BuildContext context) {
//     final local = ProductLocalDataSourceImpl();
//
//     return FutureBuilder<List<Product>>(
//       future: local.getRelatedProducts(category),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         final related = snapshot.data!;
//
//         return SizedBox(
//           height: 230,
//           child: ListView.separated(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             scrollDirection: Axis.horizontal,
//             itemCount: related.length,
//             separatorBuilder: (_, __) => const SizedBox(width: 12),
//             itemBuilder: (_, i) {
//               final product = related[i];
//
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (_) => ProductDetailPage(product: product)),
//                   );
//                 },
//                 child: SizedBox(
//                   width: 150,
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(12),
//                           child: Image.asset(
//                             product.images.first,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 6),
//                       Text(
//                         product.name,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }