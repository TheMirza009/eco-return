import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

/// StateNotifier to manage the current locale
class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('en')); // Default to English

  /// Change locale dynamically
  void setLocale(Locale newLocale) {
    state = newLocale;
  }
}

/// Riverpod provider for localization state
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});
