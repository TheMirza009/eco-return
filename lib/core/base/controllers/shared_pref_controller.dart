import 'dart:convert';
import 'dart:ui';
import 'package:eco_return/root/data/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefController {

  // Reuse the SharedPreferences instance to optimize performance
  static Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  /// Save variable to Shared Preferences
  static Future<void> savePrefs(dynamic data, String key) async {
    final prefs = await _getPrefs();
    String dataToSave = data is String ? data : jsonEncode(data); // Encode non-string data
    await prefs.setString(key, dataToSave);
  }

  /// Load variable from Shared Preferences and decode if necessary
  static Future<dynamic> loadPrefs(String key) async {
    final prefs = await _getPrefs();
    final loadedData = prefs.getString(key);
    if (loadedData != null && loadedData.isNotEmpty) {
      return jsonDecode(loadedData);
    }
    return null; // Return null if data is not found or is empty
  }

  /// Save variable to Shared Preferences
  static Future<void> saveUserData(dynamic data) async {
    final prefs = await _getPrefs();
    String dataToSave = data is String ? data : jsonEncode(data); // Encode non-string data
    await prefs.setString('user', dataToSave);
  }
  
  /// Load variable from Shared Preferences and decode if necessary
  static Future<void> loadUserData(WidgetRef ref) async {
    final prefs = await _getPrefs();
    final loadedData = prefs.getString('user');

    // Log loaded data for debugging
    print("Loaded data: $loadedData");

    if (loadedData != null && loadedData.isNotEmpty) {
      try {
        final userMap = jsonDecode(loadedData); // Decode JSON string
        ref.read(userProvider.notifier).state = await User.fromJson(userMap); // Set user state
      } catch (e) {
        print("Error decoding user data: $e");
        ref.read(userProvider.notifier).state =  User.nullUser; // In case of any decoding error
      }
    } else {
      // If no data is found or it's empty, use the nullUser
      ref.read(userProvider.notifier).state = User.nullUser;
    }
  }

  /// Save the locale code in SharedPreferences
  static Future<void> saveLocale(Locale newLocale) async {
    final prefs = await _getPrefs();
    await prefs.setString('language', newLocale.languageCode); // Save language code
  }

  /// Load saved locale from SharedPreferences
  static Future<String> loadLocale() async {
    final prefs = await _getPrefs();
    return prefs.getString('language') ?? 'en'; // Default to English if not found
  }
}
