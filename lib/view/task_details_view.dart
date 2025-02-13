import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskDetailsView extends StatelessWidget {
  final Task task;

  const TaskDetailsView({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(task.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(task.description),
      ),
    );
  }
}