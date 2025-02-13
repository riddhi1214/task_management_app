import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task_managment_app/providers/theme_provider.dart';
import 'package:task_managment_app/view/add_task_view.dart';
import 'view/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const ProviderScope(child: MyApp()));
}


class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(themeProvider);
    return MaterialApp(
      title: 'Task Management App',
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: const HomeView(),
      routes: {
        '/addTask': (context) => const AddTaskView(),
      },
    );
  }
}
