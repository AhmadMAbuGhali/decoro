import 'package:flutter/material.dart';

enum SnackType { info, success, error }

void showAppSnackbar(
    BuildContext context,
    String message, {
      SnackType type = SnackType.info,
    }) {
  final color = switch (type) {
    SnackType.success => Colors.green,
    SnackType.error => Colors.red,
    SnackType.info => Colors.blueGrey,
  };

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
    ),
  );
}