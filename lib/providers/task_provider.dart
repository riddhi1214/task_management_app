import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_managment_app/services/task_database.dart';
import '../viewmodels/task_viewmodel.dart';
import '../models/task.dart';

final taskProvider = StateNotifierProvider<TaskViewModel, List<Task>>(
      (ref) => TaskViewModel(TaskDatabase()),
);
