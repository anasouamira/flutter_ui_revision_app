import 'package:flutter/material.dart';

// ══════════════════════════════════════════════════════
// EXERCISE SCREEN — Student Registration Form
// Combines: TextField, Checkbox, Radio, Switch,
//           DropdownButton, Button, result Card
// Everything is in ONE file — easy to read and review
// ══════════════════════════════════════════════════════

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {

  // ── TextField controllers ──
  final _nameController = TextEditingController();
  final _ageController  = TextEditingController();

  // ── Checkbox ──
  bool _termsAccepted = false;

  // ── Radio — gender ──
  String _gender = 'Male'; // default selection

  // ── Switch — notifications ──
  bool _notificationsOn = false;

  // ── Dropdown — city ──
  String _selectedCity = 'Casablanca';
  final List<String> _cities = [
    'Casablanca',
    'Rabat',
    'Fes',
    'Marrakech',
    'Tangier',
  ];

  // ── Result — null means button not pressed yet ──
  Map<String, String>? _result;

  // ── Dispose controllers to free memory ──
  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  // ══════════════════════════════════════════════
  // Called when "Show Result" button is pressed
  // Collects all values and stores them in _result
  // ══════════════════════════════════════════════
  void _showResult() {
    // Simple check — name must not be empty
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name')),
      );
      return;
    }

    // Collect all values into a simple map
    setState(() {
      _result = {
        'Name'          : _nameController.text.trim(),
        'Age'           : _ageController.text.trim().isEmpty
            ? 'Not entered'
            : _ageController.text.trim(),
        'Gender'        : _gender,
        'City'          : _selectedCity,
        'Notifications' : _notificationsOn ? 'Enabled' : 'Disabled',
        'Terms Accepted': _termsAccepted   ? 'Yes ✓'   : 'No ✗',
      };
    });
  }

  // ══════════════════════════════════════════════
  // Reset everything back to defaults
  // ══════════════════════════════════════════════
  void _reset() {
    _nameController.clear();
    _ageController.clear();
    setState(() {
      _termsAccepted    = false;
      _gender           = 'Male';
      _notificationsOn  = false;
      _selectedCity     = 'Casablanca';
      _result           = null;
    });
  }

  // ══════════════════════════════════════════════
  // BUILD
  // ══════════════════════════════════════════════
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise — Registration Form'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── Info banner ──
            const Text(
              'Fill in the form and press Show Result',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 20),

            // ════════════════════════════════
            // TEXT FIELD — Name
            // ════════════════════════════════
            const Text('Full Name', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Enter your full name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),

            const SizedBox(height: 16),

            // ════════════════════════════════
            // TEXT FIELD — Age
            // ════════════════════════════════
            const Text('Age', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter your age',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.cake_outlined),
              ),
            ),

            const SizedBox(height: 20),

            // ════════════════════════════════
            // RADIO — Gender
            // ════════════════════════════════
            const Text('Gender', style: TextStyle(fontWeight: FontWeight.bold)),
            RadioGroup<String>(
              groupValue: _gender,
              onChanged: (val) => setState(() => _gender = val!),
              child: Row(
                children: ['Male', 'Female', 'Other'].map((option) {
                  return Row(
                    children: [
                      Radio<String>(value: option),
                      Text(option),
                      const SizedBox(width: 8),
                    ],
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 16),

            // ════════════════════════════════
            // DROPDOWN — City
            // ════════════════════════════════
            const Text('City', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              value: _selectedCity,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_city_outlined),
              ),
              items: _cities.map((city) {
                return DropdownMenuItem(value: city, child: Text(city));
              }).toList(),
              onChanged: (val) => setState(() => _selectedCity = val!),
            ),

            const SizedBox(height: 20),

            // ════════════════════════════════
            // SWITCH — Notifications
            // ════════════════════════════════
            const Text('Notifications', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Switch(
                  value: _notificationsOn,
                  onChanged: (val) => setState(() => _notificationsOn = val),
                ),
                const SizedBox(width: 8),
                Text(
                  _notificationsOn ? 'Enabled' : 'Disabled',
                  style: TextStyle(
                    color: _notificationsOn ? Colors.green : Colors.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // ════════════════════════════════
            // CHECKBOX — Terms
            // ════════════════════════════════
            Row(
              children: [
                Checkbox(
                  value: _termsAccepted,
                  onChanged: (val) => setState(() => _termsAccepted = val!),
                ),
                const Text('I accept the terms and conditions'),
              ],
            ),

            const SizedBox(height: 24),

            // ════════════════════════════════
            // BUTTONS
            // ════════════════════════════════
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _showResult,
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Show Result'),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                onPressed: _reset,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset'),
              ),
            ),

            const SizedBox(height: 24),

            // ════════════════════════════════
            // RESULT CARD
            // Only shown after button is pressed
            // ════════════════════════════════
            if (_result != null) ...[
              const Text(
                'Result',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: _result!.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Label
                            Text(
                              entry.key,
                              style: const TextStyle(color: Colors.grey),
                            ),
                            // Value
                            Text(
                              entry.value,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}