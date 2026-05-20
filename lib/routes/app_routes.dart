import 'package:flutter/material.dart';
import '../features/home/home_screen.dart';
import '../features/ui_showcase/ui_showcase_screen.dart';
import '../features/bmi/bmi_screen.dart';
import '../features/discount/discount_screen.dart';
import '../features/todo/todo_screen.dart';

// All named routes in one place — easy to find and update
class AppRoutes {
  // Route name constants
  static const String home     = '/';
  static const String showcase = '/showcase';
  static const String bmi      = '/bmi';
  static const String discount = '/discount';
  static const String todo     = '/todo';

  // Map of route name → screen widget
  static Map<String, WidgetBuilder> get routes => {
    home:     (_) => const HomeScreen(),
    showcase: (_) => const UiShowcaseScreen(),
    bmi:      (_) => const BmiScreen(),
    discount: (_) => const DiscountScreen(),
    todo:     (_) => const TodoScreen(),
  };
}