import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../services/preferences_storage.dart';

class ThemeViewModel extends StateNotifier<bool> {
  final PreferencesStorage _storage;

  ThemeViewModel(this._storage) : super(false) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    bool savedTheme = await _storage.loadTheme();
    state = savedTheme;
  }

  void toggleTheme() async {
    state = !state;
    await _storage.saveTheme(state);
  }
}
