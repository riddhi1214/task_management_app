import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_managment_app/providers/task_provider.dart';
import 'package:task_managment_app/view/add_task_view.dart';
import 'package:task_managment_app/viewmodels/task_viewmodel.dart';
import '../models/task.dart';
import 'package:intl/intl.dart';

class TaskListItem extends ConsumerWidget {
  final Task task;
  final VoidCallback onToggleCompletion;
  const TaskListItem(
      {super.key, required this.task, required this.onToggleCompletion});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskViewModel = ref.read(taskProvider.notifier);

    return Card(
      color: task.isPriority
          ? (Theme.of(context).brightness == Brightness.dark
              ? Colors.red.shade900
              : Colors.red.shade50)
          : (Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade800
              : Colors.white),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        title: Text(task.title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.description),
            SizedBox(height: 4),
            Text(
              "Date: ${DateFormat('yyyy-MM-dd HH:mm').format(task.dateCreated)}",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Edit Button - Navigates to Add Task Screen with existing task data
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTaskView(existingTask: task),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                _showDeleteConfirmation(context, taskViewModel, task.id!);
              },
            ),
            IconButton(
              icon: Icon(
                task.isCompleted
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: task.isCompleted ? Colors.green : Colors.grey,
              ),
              onPressed: onToggleCompletion, // Toggle task completion
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, TaskViewModel taskViewModel, int taskId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Task"),
        content: Text("Are you sure you want to delete this task?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              taskViewModel.deleteTask(taskId);
              Navigator.pop(context);
            },
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
