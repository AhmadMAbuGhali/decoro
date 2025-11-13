import 'package:flutter/material.dart';
import 'app.dart';
import 'bootstrap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bootstrap(); // initialize DI, services, logging, etc.
  runApp(App());
}