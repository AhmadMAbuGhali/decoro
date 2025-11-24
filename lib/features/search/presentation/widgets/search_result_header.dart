import 'package:flutter/material.dart';

class SearchResultHeader extends StatelessWidget {
  final String query;
  final int count;

  const SearchResultHeader({
    super.key,
    required this.query,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            'Result for "$query"',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Text(
            '$count founds',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}