import 'dart:ui';

class Languages {

  static const List<Locale> supportedLocales = [
    Locale('en'), // English
    Locale('hu'), // Hungarian
    Locale('de'), // German
    Locale('fr'), // French
  ];

  static String getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'en': return 'English';
      case 'hu': return 'Hungarian';
      case 'de': return 'German';
      case 'fr': return 'French';
      default: return languageCode.toUpperCase(); // Default to language code if not found
    }
  }
}
