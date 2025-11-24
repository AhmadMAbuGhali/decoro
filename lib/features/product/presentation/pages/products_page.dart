import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../product/data/repositories/product_repository_impl.dart';
import '../../../product/data/datasources/product_remote_data_source.dart';
import '../../../product/data/models/product_model.dart';
import '../../../product/presentation/bloc/product_list_bloc.dart';
import '../../../product/presentation/bloc/product_list_event.dart';
import '../../../product/presentation/bloc/product_list_state.dart';
import '../../../product/presentation/widgets/product_card.dart';
import '../../../product/presentation/widgets/shimmer_tile.dart';
import '../../../product/presentation/pages/product_detail_page.dart';
import '../../../../app/di.dart';
import '../../../../core/services/network/api_client.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late ProductListBloc bloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // نحضر الريبو من الـ DI بشكل صحيح
    final repo = ProductRepositoryImpl(
      ProductRemoteDataSource(sl<ApiClient>()),
    );

    bloc = ProductListBloc(repo: repo)..add(LoadProducts());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >
        _scrollController.position.maxScrollExtent - 250) {
      bloc.add(LoadMoreProducts());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    bloc.close();
    super.dispose();
  }

  Future<void> _refresh() async {
    bloc.add(LoadProducts(refresh: true));
    await bloc.stream.firstWhere((s) => !s.isLoading);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Products"),
        ),
        body: BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, state) {
            if (state.isLoading && state.products.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(12),
                child: GridView.builder(
                  itemCount: 6,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (_, __) => const ShimmerTile(),
                ),
              );
            }

            if (state.hasError && state.products.isEmpty) {
              return Center(
                child: Text(
                  'Error: ${state.errorMessage}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: _refresh,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: GridView.builder(
                  controller: _scrollController,
                  itemCount:
                  state.products.length + (state.hasMore ? 1 : 0),
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.78,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    if (index >= state.products.length) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final ProductModel product = state.products[index];

                    return ProductCard(
                      product: product,
                      onOpen: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailPage(
                              productId: product.id,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}