import 'package:flutter/material.dart';

Future<void> showAppDialog(BuildContext context, String title, String message) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(title: Text(title), content: Text(message), actions: [
      TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))
    ]),
  );
}