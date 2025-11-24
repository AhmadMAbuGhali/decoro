import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/di.dart';
import '../../../../config/theme/app_colors.dart';
import '../../domin/repositories/search_repository.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';
import '../bloc/search_state.dart';
import '../widgets/search_result_grid.dart';
import '../widgets/search_result_header.dart';
import 'filter_bottom_sheet.dart';

class SearchPage extends StatefulWidget {
  final String initialQuery;

  const SearchPage({super.key, required this.initialQuery});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchBloc bloc;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.initialQuery);

    bloc = SearchBloc(sl<SearchRepository>())
      ..add(LoadSearchResults());

    // 🔥 ننتظر تحميل البيانات قبل تشغيل البحث
    Future.delayed(const Duration(milliseconds: 150), () {
      bloc.add(SearchQueryChanged(widget.initialQuery));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ------------------ Search Bar ------------------
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: _buildSearchBar(),
                  ),

                  // ------------------ Header ------------------
                  SearchResultHeader(
                    query: controller.text,
                    count: state.filteredResults.length,
                  ),

                  const SizedBox(height: 10),

                  // ------------------ Grid Results ------------------
                  Expanded(
                    child: state.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SearchResultGrid(results: state.filteredResults),
                  ),

                  // ------------------ Filter Button ------------------
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 10),
                    child: Center(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: AppColors.primary,
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            builder: (_) => BlocProvider.value(
                              value: bloc,
                              child: const FilterBottomSheet(),
                            ),
                          );
                        },
                        icon:
                        const Icon(Icons.filter_list, color: Colors.white),
                        label: const Text(
                          "Filter",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // ---------------- Build Search Bar ----------------
  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        onChanged: (value) =>
            bloc.add(SearchQueryChanged(value)), // 🔥 بحث مباشر
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: "Search",
          border: InputBorder.none,
        ),
      ),
    );
  }
}