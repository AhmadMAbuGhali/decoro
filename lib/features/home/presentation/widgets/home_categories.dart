import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/theme/app_colors.dart';
import '../bloc/home_bloc.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,

      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: state.categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final cat = state.categories[index];
              final selected = index == state.selectedCategoryIndex;

              return GestureDetector(
                onTap: () => context.read<HomeBloc>().add(SelectCategory(index)),
                child: Column(
                  children: [
                    // 🔵 Image Box (Card)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: selected
                            ? AppColors.primary.withOpacity(0.12)
                            : AppColors.card,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: selected
                              ? AppColors.primary
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Container(
                        height: 62,
                        width: 62,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.chair,
                            size: 20,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 6),

                    // 🔵 Title outside the card
                    Text(
                      cat.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color:
                        selected ? AppColors.primary : Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}