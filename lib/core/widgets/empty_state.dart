import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String message;
  final IconData icon;
  final VoidCallback? onRetry;

  const EmptyState({
    super.key,
    this.message = 'No data',
    this.icon = Icons.inbox_outlined,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 60, color: Colors.grey.shade400),
          const SizedBox(height: 12),
          Text(
            message,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 14),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text("Retry"),
            )
          ]
        ],
      ),
    );
  }
}