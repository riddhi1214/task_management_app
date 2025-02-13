import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task.dart';
import '../services/task_database.dart';

class TaskViewModel extends StateNotifier<List<Task>> {
  final TaskDatabase _database;
  TaskViewModel(this._database) : super([]) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    state = await _database.getTasks();
  }

  void sortTasks(String sortBy) {
    if (sortBy == 'priority') {
      state = [
        ...state.where((task) => task.isPriority) // Show only priority tasks
      ];
    } else if (sortBy == 'date') {
      state = [...state]..sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
    } else {
      loadTasks(); // Reset to all tasks when "Show All" is clicked
    }
  }

  Future<void> toggleTaskCompletion(int taskId, bool isCompleted) async {
    await _database.toggleTaskCompletion(taskId, isCompleted);
    loadTasks();
  }

  Future<void> addOrUpdateTask(Task task) async {
    if (task.id != null) {
      await _database.updateTask(task);
    } else {
      await _database.insertTask(task);
    }
    loadTasks();
  }

  Future<void> deleteTask(int taskId) async {
    await _database.deleteTask(taskId);
    state = state.where((task) => task.id != taskId).toList();
  }
}
