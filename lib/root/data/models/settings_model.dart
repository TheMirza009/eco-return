import 'dart:ui';

class Settings {
  bool notifications;
  String languageCode;

  Settings({
    required this.notifications,
    required this.languageCode,
  });

  Map<String, dynamic> toJSON() {
    return {
      'notifications': notifications,
      'locale': languageCode,
    };
  }

  factory Settings.fromJSON(Map<String, dynamic> json) {
    return Settings(
      notifications: json['notifications'],
      languageCode: json['locale'],
    );
  }
}
