import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_managment_app/services/preferences_storage.dart';
import '../viewmodels/theme_viewmodel.dart';

final themeProvider = StateNotifierProvider<ThemeViewModel, bool>((ref) {
  return ThemeViewModel(PreferencesStorage());
});