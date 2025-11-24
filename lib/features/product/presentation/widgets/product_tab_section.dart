import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';

class ProductTabSection extends StatefulWidget {
  final Product product;

  const ProductTabSection({super.key, required this.product});

  @override
  State<ProductTabSection> createState() => _ProductTabSectionState();
}

class _ProductTabSectionState extends State<ProductTabSection>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ------------------- Tabs -------------------
        TabBar(
          controller: _controller,
          labelColor: Colors.brown,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.brown,
          tabs: const [
            Tab(text: "Details"),
            Tab(text: "Reviews"),
            Tab(text: "Similar"),
          ],
        ),

        SizedBox(
          height: 200,
          child: TabBarView(
            controller: _controller,
            children: [
              Center(child: Text("Product details info...")),
              Center(child: Text("Reviews section...")),
              Center(child: Text("Similar items here...")),
            ],
          ),
        )
      ],
    );
  }
}