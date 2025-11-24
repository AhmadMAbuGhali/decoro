import 'package:flutter/material.dart';

class ProductMaterialSelector extends StatelessWidget {
  final List<String> materials;

  const ProductMaterialSelector({super.key, required this.materials});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemCount: materials.length,
        itemBuilder: (_, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(materials[index]),
          );
        },
      ),
    );
  }
}