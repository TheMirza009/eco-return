import 'package:eco_return/core/collections/language_code.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:ui';

class LocaleController {

  // Constructor
  // LocaleHelper();

  // Get current language name based on context
  static String getCurrentLanguageName(BuildContext context) {
    String languageCode = Localizations.localeOf(context).languageCode;
    return LanguageCode.getName(languageCode).name; // Get name from LanguageCode class
  }

  // Get language name from language code
  static String getLanguageName(String? languageCode) {
    // Default to 'en' if no language code is provided
    String code = languageCode ?? 'en';
    return LanguageCode.getName(code).name; // Get name from LanguageCode class
  }

  // Method to get localized strings (requires context)
  static AppLocalizations getLocale(BuildContext context) {
    return AppLocalizations.of(context)!;
  }

  // List of supported locales
  static const List<Locale> supportedLocales = [
    Locale('en'), // English
    Locale('hu'), // Hungarian
    Locale('de'), // German
    Locale('fr'), // French
  ];
}
