import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Revision',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // Named routes defined in app_routes.dart
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
    );
  }
}