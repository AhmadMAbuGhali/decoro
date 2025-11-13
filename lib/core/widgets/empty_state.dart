import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String message;
  const EmptyState({super.key, this.message = 'No data'});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message));
  }
}