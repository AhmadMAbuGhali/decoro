import 'package:decoro/features/home/presentation/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_bloc.dart';
import '../../../product/data/models/product_model.dart';

class ProductGrid extends StatelessWidget {
  final bool showAll;
  const ProductGrid({super.key, this.showAll = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (_, state) {
        List<ProductModel> list = state.products;

        if (!showAll) {
          list = list.take(4).toList();
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.78,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (_, i) => ProductItemWidget(product: list[i]),
        );
      },
    );
  }
}