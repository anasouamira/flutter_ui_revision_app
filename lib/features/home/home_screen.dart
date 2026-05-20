import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

// Home screen — simple list of cards, one per feature
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Each entry: (title, subtitle, icon, route)
    final items = [
      _MenuItem(
        title: 'UI Showcase',
        subtitle: 'Explore Flutter widgets & layouts',
        icon: Icons.widgets_outlined,
        route: AppRoutes.showcase,
      ),
      _MenuItem(
        title: 'BMI Calculator',
        subtitle: 'Calculate your body mass index',
        icon: Icons.monitor_weight_outlined,
        route: AppRoutes.bmi,
      ),
      _MenuItem(
        title: 'Discount Calculator',
        subtitle: 'Find final price after discount',
        icon: Icons.discount_outlined,
        route: AppRoutes.discount,
      ),
      _MenuItem(
        title: 'Todo App',
        subtitle: 'Add, complete, and delete tasks',
        icon: Icons.checklist_outlined,
        route: AppRoutes.todo,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Revision App'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            child: ListTile(
              leading: Icon(item.icon, color: Colors.indigo, size: 32),
              title: Text(
                item.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item.subtitle),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () => Navigator.pushNamed(context, item.route),
            ),
          );
        },
      ),
    );
  }
}

// Simple data class to hold menu item info
class _MenuItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final String route;

  const _MenuItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
  });
}