
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/di.dart';
import '../../../../config/theme/app_colors.dart';

import '../bloc/home_bloc.dart';
import '../widgets/home_header.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/home_categories.dart';
import '../widgets/home_banner.dart';
import '../widgets/product_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showAll = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(sl())..add(LoadProducts(limit: 12)),
      child: Scaffold(
        backgroundColor: AppColors.background,

        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [

                // -------------------------------- HEADER
                const SizedBox(height: 8),
                const HomeHeader(),
                const SizedBox(height: 16),

                // -------------------------------- Search Bar
                const HomeSearchBar(),
                const SizedBox(height: 18),

                // -------------------------------- Categories
                const HomeCategories(),
                const SizedBox(height: 18),

                // -------------------------------- SCROLL BODY
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // ---------- Banner ----------
                        const HomeBanner(),
                        const SizedBox(height: 24),

                        // ---------- Title + See All ----------
                        Row(
                          children: [
                            const Text(
                              "Top Selling Products",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                setState(() => showAll = !showAll);
                              },
                              child: Text(
                                showAll ? "Show Less" : "See All",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        // ---------- Product Grid ----------
                        BlocBuilder<HomeBloc, HomeState>(
                          builder: (_, state) {
                            if (state.status == HomeStatus.loading) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(24),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            if (state.status == HomeStatus.failure) {
                              return Center(
                                child: Text(
                                  "Error: ${state.error}",
                                  style: const TextStyle(color: Colors.red),
                                ),
                              );
                            }

                            final products = state.products;
                            final displayList = showAll
                                ? products
                                : products.take(4).toList();

                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.78,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                              itemCount: displayList.length,
                              itemBuilder: (_, i) =>
                                  ProductItemWidget(product: displayList[i]),
                            );
                          },
                        ),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}