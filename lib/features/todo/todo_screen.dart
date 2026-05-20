import 'package:flutter/material.dart';

// Todo App screen
// Demonstrates: setState with a list, add, delete, toggle complete
class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

// Simple data class to represent one task
class _TodoItem {
  String  title;
  bool    isDone;

  _TodoItem({required this.title, this.isDone = false});
}

class _TodoScreenState extends State<TodoScreen> {
  // The list of tasks — setState rebuilds the UI when this changes
  final List<_TodoItem> _todos = [
    _TodoItem(title: 'Learn Flutter widgets'),
    _TodoItem(title: 'Practice setState'),
    _TodoItem(title: 'Build a mini app'),
  ];

  // Controller for the "add task" text field
  final _controller = TextEditingController();

  // ── Add a new task ──────────────────────────
  void _addTask() {
    final text = _controller.text.trim();
    if (text.isEmpty) return; // ignore blank input

    setState(() {
      _todos.add(_TodoItem(title: text));
    });

    _controller.clear(); // clear the field after adding
  }

  // ── Toggle task done / not done ─────────────
  void _toggleDone(int index) {
    setState(() {
      _todos[index].isDone = !_todos[index].isDone;
    });
  }

  // ── Delete a task ───────────────────────────
  void _deleteTask(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Count how many tasks are done
    final doneCount = _todos.where((t) => t.isDone).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        // Show progress in subtitle
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(24),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              '$doneCount / ${_todos.length} completed',
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ),
        ),
      ),
      body: Column(
        children: [

          // ── Add task input bar ──
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Add a new task...',
                      border: OutlineInputBorder(),
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                    // Allow submitting with keyboard "done" button
                    onSubmitted: (_) => _addTask(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addTask,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),

          // ── Empty state message ──
          if (_todos.isEmpty)
            const Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.checklist, size: 64, color: Colors.grey),
                    SizedBox(height: 12),
                    Text('No tasks yet. Add one above!',
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),

          // ── Task list ──
          if (_todos.isNotEmpty)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _todos.length,
                itemBuilder: (context, index) {
                  final task = _todos[index];
                  return _TodoCard(
                    task: task,
                    onToggle:  () => _toggleDone(index),
                    onDelete:  () => _deleteTask(index),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

// ── Individual task card ────────────────────────
class _TodoCard extends StatelessWidget {
  final _TodoItem  task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const _TodoCard({
    required this.task,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        // Checkbox on the left
        leading: Checkbox(
          value: task.isDone,
          onChanged: (_) => onToggle(),
        ),
        // Task title — strikethrough when done
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isDone ? TextDecoration.lineThrough : null,
            color:      task.isDone ? Colors.grey : Colors.black,
          ),
        ),
        // Status chip
        subtitle: Text(
          task.isDone ? 'Completed ✓' : 'Pending',
          style: TextStyle(
            fontSize: 12,
            color: task.isDone ? Colors.green : Colors.orange,
          ),
        ),
        // Delete button on the right
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          onPressed: onDelete,
          tooltip: 'Delete task',
        ),
      ),
    );
  }
}