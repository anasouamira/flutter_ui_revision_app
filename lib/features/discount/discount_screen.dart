import 'package:flutter/material.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';

// Discount Calculator screen
// Demonstrates: Form, validation, setState, simple arithmetic
class DiscountScreen extends StatefulWidget {
  const DiscountScreen({super.key});

  @override
  State<DiscountScreen> createState() => _DiscountScreenState();
}

class _DiscountScreenState extends State<DiscountScreen> {
  final _formKey         = GlobalKey<FormState>();
  final _priceController    = TextEditingController();
  final _discountController = TextEditingController();

  // Result state — null means "not calculated yet"
  double? _finalPrice;
  double? _savedAmount;

  // ── Calculate discounted price ──────────────
  void _calculate() {
    if (!_formKey.currentState!.validate()) return;

    final price    = double.parse(_priceController.text);
    final discount = double.parse(_discountController.text);

    // saved = price × (discount / 100)
    final saved = price * (discount / 100);
    final final_ = price - saved;

    setState(() {
      _savedAmount = saved;
      _finalPrice  = final_;
    });
  }

  // ── Reset ───────────────────────────────────
  void _reset() {
    _formKey.currentState!.reset();
    _priceController.clear();
    _discountController.clear();
    setState(() {
      _finalPrice  = null;
      _savedAmount = null;
    });
  }

  @override
  void dispose() {
    _priceController.dispose();
    _discountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Discount Calculator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              // ── Original price ──
              CustomTextField(
                label: 'Original Price (\$)',
                hint: 'e.g. 200',
                controller: _priceController,
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Please enter a price';
                  final n = double.tryParse(val);
                  if (n == null || n < 0) return 'Enter a valid price';
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // ── Discount percentage ──
              CustomTextField(
                label: 'Discount (%)',
                hint: 'e.g. 25',
                controller: _discountController,
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Please enter a discount';
                  final n = double.tryParse(val);
                  if (n == null || n < 0 || n > 100) return 'Enter 0 – 100';
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // ── Buttons ──
              CustomButton(
                label: 'Calculate',
                icon: Icons.calculate_outlined,
                onPressed: _calculate,
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: _reset,
                child: const Text('Reset'),
              ),

              const SizedBox(height: 24),

              // ── Result card ──
              if (_finalPrice != null)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // You save row
                        _ResultRow(
                          label: 'You Save',
                          value: '\$${_savedAmount!.toStringAsFixed(2)}',
                          valueColor: Colors.green,
                          icon: Icons.savings_outlined,
                        ),
                        const Divider(height: 28),
                        // Final price row
                        _ResultRow(
                          label: 'Final Price',
                          value: '\$${_finalPrice!.toStringAsFixed(2)}',
                          valueColor: Colors.indigo,
                          icon: Icons.attach_money,
                          large: true,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper row widget for result display
class _ResultRow extends StatelessWidget {
  final String label;
  final String value;
  final Color  valueColor;
  final IconData icon;
  final bool large;

  const _ResultRow({
    required this.label,
    required this.value,
    required this.valueColor,
    required this.icon,
    this.large = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: valueColor),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontSize: 16, color: Colors.black54)),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: large ? 26 : 18,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}