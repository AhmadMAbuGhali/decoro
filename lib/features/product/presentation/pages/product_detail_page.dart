import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/di.dart';
import '../../data/models/product_model.dart';
import '../../domain/repositories/product_repository.dart';


class ProductDetailPage extends StatefulWidget {
  final String productId;
  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool loading = true;
  ProductModel? product;
  String? error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() { loading = true; error = null; });
    try {
      final repo = sl<ProductRepository>();
      final p = await repo.getProduct(widget.productId);
      setState(() { product = p; loading = false; });
    } catch (e) {
      setState(() { error = e.toString(); loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (error != null) return Scaffold(body: Center(child: Text('Error: $error')));
    final p = product!;
    final main = p.mainImage?['url'] ?? (p.gallery.isNotEmpty ? p.gallery.first['url'] : null);
    return Scaffold(
      appBar: AppBar(title: Text(p.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PageView gallery
            SizedBox(
              height: 320,
              child: PageView(
                children: [
                  if (main != null) Image.network(main, fit: BoxFit.cover, width: double.infinity, errorBuilder: (_,__,___)=> const Icon(Icons.broken_image)),
                  ...p.gallery.map((g) => Image.network(g['url'], fit: BoxFit.cover, width: double.infinity, errorBuilder: (_,__,___)=> const Icon(Icons.broken_image))),
                ],
              ),
            ),
            Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(p.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('\$${p.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Text(p.description),
              const SizedBox(height: 12),
              Wrap(spacing: 8, children: p.materials.map((m) => Chip(label: Text(m))).toList()),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: (){}, child: const Text('Add to Cart')),
            ])),
          ],
        ),
      ),
    );
  }
}