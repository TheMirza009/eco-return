import 'dart:convert';

import 'package:eco_return/core/base/controllers/shared_pref_controller.dart';
import 'package:eco_return/root/data/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// StateNotifier to manage the current locale
class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('en')) {
    _loadLocale(); // Load locale from SharedPreferences on initialization
  }
  final exampleMap = {"value": 1};

  /// Change locale dynamically and save it in SharedPreferences
  Future<void> setLocale(Locale newLocale) async {
    state = newLocale; // Update state
    SharedPrefController.saveLocale(newLocale);
  }

  /// Load saved locale from SharedPreferences
  Future<void> _loadLocale() async {
    final savedLanguageCode = await SharedPrefController.loadLocale();
    state = Locale(savedLanguageCode);
  }
}

/// Riverpod provider for localization state
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});
