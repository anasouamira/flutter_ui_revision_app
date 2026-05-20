import 'package:flutter/material.dart';

// UI Showcase — one example per widget, grouped by sections
// This is the "revision notebook" of Flutter widgets
class UiShowcaseScreen extends StatefulWidget {
  const UiShowcaseScreen({super.key});

  @override
  State<UiShowcaseScreen> createState() => _UiShowcaseScreenState();
}

class _UiShowcaseScreenState extends State<UiShowcaseScreen> {
  // ── Local state for interactive widgets ──
  bool _checkboxValue = false;
  bool _switchValue   = false;
  int  _radioValue    = 1;
  double _sliderValue = 0.5;
  String _dropdownValue = 'Flutter';
  int _bottomNavIndex   = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ── AppBar ──
      appBar: AppBar(title: const Text('UI Showcase')),

      // ── Drawer ──
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Text('Drawer Header',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            ListTile(leading: Icon(Icons.home), title: Text('Home')),
            ListTile(leading: Icon(Icons.info), title: Text('About')),
          ],
        ),
      ),

      // ── FloatingActionButton ──
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('FAB tapped!')),
          );
        },
        child: const Icon(Icons.add),
      ),

      // ── BottomNavigationBar ──
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),    label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search),  label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person),  label: 'Profile'),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ════════════════════════════════
            // TEXT
            // ════════════════════════════════
            _SectionHeader('Text'),
            const Text('Default text'),
            const SizedBox(height: 4),
            const Text('Bold text', style: TextStyle(fontWeight: FontWeight.bold)),
            const Text('Large text', style: TextStyle(fontSize: 22)),
            const Text('Colored text', style: TextStyle(color: Colors.blue)),

            // ════════════════════════════════
            // CONTAINER
            // ════════════════════════════════
            _SectionHeader('Container'),
            Container(
              width: double.infinity,
              height: 60,
              color: Colors.indigo.shade100,
              alignment: Alignment.center,
              child: const Text('I am a Container'),
            ),

            // ════════════════════════════════
            // ROW
            // ════════════════════════════════
            _SectionHeader('Row'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ColorBox(Colors.red),
                _ColorBox(Colors.green),
                _ColorBox(Colors.blue),
              ],
            ),

            // ════════════════════════════════
            // COLUMN
            // ════════════════════════════════
            _SectionHeader('Column'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ColorBox(Colors.orange),
                const SizedBox(height: 6),
                _ColorBox(Colors.purple),
                const SizedBox(height: 6),
                _ColorBox(Colors.teal),
              ],
            ),

            // ════════════════════════════════
            // STACK
            // ════════════════════════════════
            _SectionHeader('Stack'),
            SizedBox(
              height: 80,
              child: Stack(
                children: [
                  Container(width: 80, height: 80, color: Colors.blue.shade100),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Container(width: 40, height: 40, color: Colors.blue),
                  ),
                  const Positioned(
                    top: 28,
                    left: 28,
                    child: Icon(Icons.star, color: Colors.white, size: 16),
                  ),
                ],
              ),
            ),

            // ════════════════════════════════
            // EXPANDED (inside a Row)
            // ════════════════════════════════
            _SectionHeader('Expanded'),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(height: 40, color: Colors.indigo.shade200,
                      alignment: Alignment.center, child: const Text('2')),
                ),
                const SizedBox(width: 4),
                Expanded(
                  flex: 1,
                  child: Container(height: 40, color: Colors.indigo.shade400,
                      alignment: Alignment.center,
                      child: const Text('1', style: TextStyle(color: Colors.white))),
                ),
              ],
            ),

            // ════════════════════════════════
            // ICON
            // ════════════════════════════════
            _SectionHeader('Icons'),
            const Row(
              children: [
                Icon(Icons.star,     color: Colors.amber,  size: 32),
                SizedBox(width: 8),
                Icon(Icons.favorite, color: Colors.red,    size: 32),
                SizedBox(width: 8),
                Icon(Icons.home,     color: Colors.indigo, size: 32),
                SizedBox(width: 8),
                Icon(Icons.settings, size: 32),
              ],
            ),

            // ════════════════════════════════
            // IMAGE (network placeholder)
            // ════════════════════════════════
            _SectionHeader('Image'),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://picsum.photos/400/120',
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(height: 120, color: Colors.grey.shade300,
                        alignment: Alignment.center,
                        child: const Text('Image not loaded')),
              ),
            ),

            // ════════════════════════════════
            // BUTTONS
            // ════════════════════════════════
            _SectionHeader('Buttons'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('ElevatedButton'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('TextButton'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('OutlinedButton'),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.thumb_up),
                  tooltip: 'IconButton',
                ),
              ],
            ),

            // ════════════════════════════════
            // TEXT FIELD
            // ════════════════════════════════
            _SectionHeader('TextField'),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Enter text',
                hintText: 'Type something...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit),
              ),
            ),

            // ════════════════════════════════
            // CHECKBOX
            // ════════════════════════════════
            _SectionHeader('Checkbox'),
            Row(
              children: [
                Checkbox(
                  value: _checkboxValue,
                  onChanged: (val) => setState(() => _checkboxValue = val!),
                ),
                Text(_checkboxValue ? 'Checked ✓' : 'Unchecked'),
              ],
            ),

            // ════════════════════════════════
            // RADIO
            // ════════════════════════════════
            _SectionHeader('Radio Buttons'),
            Column(
              children: [1, 2, 3].map((val) {
                return Row(
                  children: [
                    Radio<int>(
                      value: val,
                      groupValue: _radioValue,
                      onChanged: (v) => setState(() => _radioValue = v!),
                    ),
                    Text('Option $val'),
                  ],
                );
              }).toList(),
            ),

            // ════════════════════════════════
            // SWITCH
            // ════════════════════════════════
            _SectionHeader('Switch'),
            Row(
              children: [
                Switch(
                  value: _switchValue,
                  onChanged: (val) => setState(() => _switchValue = val),
                ),
                Text(_switchValue ? 'ON' : 'OFF'),
              ],
            ),

            // ════════════════════════════════
            // SLIDER
            // ════════════════════════════════
            _SectionHeader('Slider'),
            Slider(
              value: _sliderValue,
              onChanged: (val) => setState(() => _sliderValue = val),
            ),
            Text('Value: ${(_sliderValue * 100).toInt()}%'),

            // ════════════════════════════════
            // DROPDOWN
            // ════════════════════════════════
            _SectionHeader('DropdownButton'),
            DropdownButton<String>(
              value: _dropdownValue,
              items: ['Flutter', 'Dart', 'Firebase', 'Android']
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (val) => setState(() => _dropdownValue = val!),
            ),

            // ════════════════════════════════
            // CARD
            // ════════════════════════════════
            _SectionHeader('Card'),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.indigo),
                    SizedBox(width: 12),
                    Text('I am a Card widget'),
                  ],
                ),
              ),
            ),

            // ════════════════════════════════
            // LIST TILE
            // ════════════════════════════════
            _SectionHeader('ListTile'),
            const ListTile(
              leading:  Icon(Icons.person),
              title:    Text('John Doe'),
              subtitle: Text('Flutter Developer'),
              trailing: Icon(Icons.arrow_forward_ios, size: 14),
            ),

            // ════════════════════════════════
            // LIST VIEW (fixed height box)
            // ════════════════════════════════
            _SectionHeader('ListView (horizontal)'),
            SizedBox(
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(8, (i) {
                  return Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 8),
                    color: Colors.indigo.shade100,
                    alignment: Alignment.center,
                    child: Text('Item $i'),
                  );
                }),
              ),
            ),

            // ════════════════════════════════
            // GRID VIEW
            // ════════════════════════════════
            _SectionHeader('GridView'),
            SizedBox(
              height: 160,
              child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(8, (i) {
                  return Container(
                    color: Colors.indigo.shade100,
                    alignment: Alignment.center,
                    child: Text('$i'),
                  );
                }),
              ),
            ),

            // ════════════════════════════════
            // SNACKBAR
            // ════════════════════════════════
            _SectionHeader('Snackbar'),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Hello! I am a Snackbar.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('Show Snackbar'),
            ),

            // ════════════════════════════════
            // DIALOG
            // ════════════════════════════════
            _SectionHeader('Dialog'),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Alert Dialog'),
                    content: const Text('This is a simple dialog example.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Show Dialog'),
            ),

            // ════════════════════════════════
            // DIVIDER
            // ════════════════════════════════
            _SectionHeader('Divider'),
            const Text('Above divider'),
            const Divider(thickness: 1.5),
            const Text('Below divider'),

            // ════════════════════════════════
            // CHIP
            // ════════════════════════════════
            _SectionHeader('Chip'),
            const Wrap(
              spacing: 8,
              children: [
                Chip(label: Text('Flutter')),
                Chip(label: Text('Dart')),
                Chip(label: Text('Mobile')),
              ],
            ),

            // ════════════════════════════════
            // CIRCULAR PROGRESS INDICATOR
            // ════════════════════════════════
            _SectionHeader('CircularProgressIndicator'),
            const Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 16),
                Text('Loading...'),
              ],
            ),

            const SizedBox(height: 80), // Bottom padding for FAB
          ],
        ),
      ),
    );
  }
}

// ── Helpers ───────────────────────────────────

// Bold section header with a top margin
class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.indigo,
        ),
      ),
    );
  }
}

// Small colored square used in Row / Column examples
class _ColorBox extends StatelessWidget {
  final Color color;
  const _ColorBox(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(width: 48, height: 48, color: color);
  }
}