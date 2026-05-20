import 'package:flutter/material.dart';

// Reusable ElevatedButton with a label and optional icon
// Keeps button style consistent across screens
class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // If icon is provided, show icon + label button
    if (icon != null) {
      return ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label),
      );
    }

    // Otherwise plain elevated button
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}