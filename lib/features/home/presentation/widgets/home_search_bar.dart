import 'package:decoro/features/notifications/presentation/pages/notification_page.dart';
import 'package:decoro/features/search/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [


        Expanded(
          child: TextField(
            textInputAction: TextInputAction.search, // زر البحث في الكيبورد
            onSubmitted: (value) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(initialQuery: value),
                ),
              );
            },
            decoration: InputDecoration(
              hintText: 'Search for Furniture',
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              suffixIcon: const Icon(Icons.search_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Colors.black),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(80),
            border: Border.all(color: Colors.black),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationPage()),
              );
            },
            icon: const Icon(Icons.notifications_none),
            color: Colors.black,
          ),
        ),
        SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(80),
            border: Border.all(color: Colors.black),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_bag_outlined),
            color: Colors.black,
          ),
        ),

      ],
    );
  }
}