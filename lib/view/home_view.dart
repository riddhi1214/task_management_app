import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_managment_app/providers/task_provider.dart';
import 'package:task_managment_app/providers/theme_provider.dart';
import 'package:task_managment_app/widgets/task_list_item.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskProvider);
    final taskViewModel = ref.read(taskProvider.notifier);
    final bool isDarkMode = ref.watch(themeProvider);
    final themeNotifier = ref.read(themeProvider.notifier);

    final filteredTasks = tasks.where((task) {
      return task.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          task.description.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Management'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              themeNotifier.toggleTheme();
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              taskViewModel.sortTasks(value);
            },
            itemBuilder: (BuildContext context) {
              return ['all', 'date', 'priority'].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice == 'date'
                      ? 'Sort by Date'
                      : choice == 'priority'
                      ? 'Show Priority Tasks'
                      : 'Show All'),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // **Search Bar**
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search tasks...',
                prefixIcon: Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: filteredTasks.length,
              itemBuilder: (context, index) => TaskListItem(
                task: filteredTasks[index],
                onToggleCompletion: () {
                  taskViewModel.toggleTaskCompletion(filteredTasks[index].id!,
                      !filteredTasks[index].isCompleted);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/addTask'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
