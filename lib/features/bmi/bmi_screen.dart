import 'package:flutter/material.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';

// BMI Calculator screen
// Demonstrates: Form, validation, setState, simple math
class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  // Form key — used to trigger validation
  final _formKey = GlobalKey<FormState>();

  // Controllers hold the text inside each field
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  // Result state
  double? _bmi;           // The calculated BMI value
  String  _category = ''; // e.g. "Normal", "Overweight"

  // ── Calculate BMI ──────────────────────────
  void _calculate() {
    // Only proceed if all fields pass validation
    if (!_formKey.currentState!.validate()) return;

    final heightCm = double.parse(_heightController.text);
    final weightKg = double.parse(_weightController.text);

    // BMI formula: weight(kg) / (height(m))^2
    final heightM = heightCm / 100;
    final bmi     = weightKg / (heightM * heightM);

    // Determine category based on standard BMI ranges
    String category;
    if (bmi < 18.5) {
      category = 'Underweight';
    } else if (bmi < 25.0) {
      category = 'Normal weight';
    } else if (bmi < 30.0) {
      category = 'Overweight';
    } else {
      category = 'Obese';
    }

    // setState re-builds the widget with new values
    setState(() {
      _bmi      = bmi;
      _category = category;
    });
  }

  // ── Reset everything ────────────────────────
  void _reset() {
    _formKey.currentState!.reset();
    _heightController.clear();
    _weightController.clear();
    setState(() {
      _bmi      = null;
      _category = '';
    });
  }

  // ── Pick result card color by category ──────
  Color _categoryColor() {
    switch (_category) {
      case 'Underweight': return Colors.blue;
      case 'Normal weight': return Colors.green;
      case 'Overweight': return Colors.orange;
      case 'Obese': return Colors.red;
      default: return Colors.grey;
    }
  }

  @override
  void dispose() {
    // Always dispose controllers to free memory
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMI Calculator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              // ── Height input ──
              CustomTextField(
                label: 'Height (cm)',
                hint: 'e.g. 175',
                controller: _heightController,
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Please enter your height';
                  final n = double.tryParse(val);
                  if (n == null || n <= 0 || n > 300) return 'Enter a valid height (1–300 cm)';
                  return null; // null means valid
                },
              ),

              const SizedBox(height: 16),

              // ── Weight input ──
              CustomTextField(
                label: 'Weight (kg)',
                hint: 'e.g. 70',
                controller: _weightController,
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Please enter your weight';
                  final n = double.tryParse(val);
                  if (n == null || n <= 0 || n > 500) return 'Enter a valid weight (1–500 kg)';
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // ── Action buttons ──
              CustomButton(
                label: 'Calculate BMI',
                icon: Icons.calculate,
                onPressed: _calculate,
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: _reset,
                child: const Text('Reset'),
              ),

              const SizedBox(height: 24),

              // ── Result card — only shown after calculation ──
              if (_bmi != null)
                Card(
                  color: _categoryColor().withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: _categoryColor(), width: 1.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Text('Your BMI',
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                        const SizedBox(height: 8),
                        Text(
                          _bmi!.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 52,
                            fontWeight: FontWeight.bold,
                            color: _categoryColor(),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _category,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: _categoryColor(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // BMI scale reference
                        const Divider(),
                        const SizedBox(height: 8),
                        _BmiRange('< 18.5',      'Underweight',  Colors.blue),
                        _BmiRange('18.5 – 24.9', 'Normal',       Colors.green),
                        _BmiRange('25.0 – 29.9', 'Overweight',   Colors.orange),
                        _BmiRange('≥ 30.0',      'Obese',        Colors.red),
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

// Small helper widget — shows one row of the BMI reference table
class _BmiRange extends StatelessWidget {
  final String range;
  final String label;
  final Color  color;

  const _BmiRange(this.range, this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(range, style: const TextStyle(fontSize: 13, color: Colors.black54)),
          Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: color)),
        ],
      ),
    );
  }
}