import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_managment_app/models/task.dart';
import 'package:task_managment_app/providers/task_provider.dart';

class AddTaskView extends ConsumerStatefulWidget {
  final Task? existingTask;

  const AddTaskView({super.key, this.existingTask});

  @override
  ConsumerState<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends ConsumerState<AddTaskView> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isPriority = false;

  @override
  void initState() {
    super.initState();
    if (widget.existingTask != null) {
      _titleController.text = widget.existingTask!.title;
      _descriptionController.text = widget.existingTask!.description;
      _isPriority = widget.existingTask!.isPriority;
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskViewModel = ref.read(taskProvider.notifier);

    return Scaffold(
      appBar: AppBar(
          title: Text(widget.existingTask == null ? "Add Task" : "Edit Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "Task Title"),
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: _descriptionController,
              decoration: InputDecoration(labelText: "Task Description"),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Mark as Priority", style: TextStyle(fontWeight: FontWeight.bold)),
                Switch(
                  value: _isPriority,
                  onChanged: (value) {
                    setState(() {
                      _isPriority = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newTask = Task(
                  id: widget.existingTask?.id,
                  title: _titleController.text,
                  description: _descriptionController.text,
                  dateCreated: DateTime.now(),
                  isPriority: _isPriority,
                );
                taskViewModel.addOrUpdateTask(newTask);
                Navigator.pop(context);
              },
              child: Text(
                  widget.existingTask == null ? "Add Task" : "Update Task"),
            ),
          ],
        ),
      ),
    );
  }
}
