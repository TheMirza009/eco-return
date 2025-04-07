import 'dart:convert';
import 'dart:io';
import 'package:eco_return/root/data/models/settings_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart'; // For saving the file locally

final userProvider = StateProvider<User>((ref) => User());

class User {
  String? email;
  String? password;
  String? name;
  File? photo;
  String? address;
  String? phoneNumber;
  DateTime? dob;
  String? gender;
  Settings? settings;

  User({
    this.email = "example@company.com",
    this.password = '',
    this.name = "Josh",
    this.photo,
    this.address,
    this.phoneNumber,
    this.dob,
    this.gender,
    this.settings,
  });

  //? Static instance of a null user with default values
  static User nullUser = User(
    email: '',
    password: '',
    name: '',
    photo: null, // Set photo to null
    address: '',
    phoneNumber: '',
    dob: DateTime(2000, 1, 1),
    gender: '',
    settings: Settings(
      notifications: false,
      languageCode: 'en',
    ),
  );

  //? Convert User to a JSON map
  Future<Map<String, dynamic>> toJson() async {
    String? photoBase64 = '';
    if (photo != null && photo!.existsSync()) {
      final photoBytes = await photo!.readAsBytes();
      photoBase64 = base64Encode(photoBytes);
    }

    return {
      'email': email,
      'password': password,
      'name': name,
      'photo': photoBase64, // Save the base64 string for the photo
      'address': address,
      'phoneNumber': phoneNumber,
      'dob': dob?.toIso8601String(), // Handle potential null DateTime
      'gender': gender,
      'settings': settings?.toJSON(), // Handle potential null settings
    };
  }

  //? Create a User from a JSON map
  static Future<User> fromJson(Map<String, dynamic> json) async {
    File? photo = await photoDecode(json); // Handle null return from photoDecode

    return User(
      email: json['email'],
      password: json['password'],
      name: json['name'],
      photo: photo,
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      dob: DateTime.parse(json['dob']),
      gender: json['gender'],
      settings: Settings.fromJSON(json['settings']),
    );
  }

  // Decode photo from base64 and save it as a file
  static Future<File?> photoDecode(Map<String, dynamic> json) async {
    String? photoBase64 = json['photo'];
    if (photoBase64 != null && photoBase64.isNotEmpty) {
      // Decode base64 string and save the image locally
      final photoBytes = base64Decode(photoBase64);
      final directory = await getApplicationDocumentsDirectory();
      final photoPath = '${directory.path}/profile_photo.jpg';
      File photo = File(photoPath)..writeAsBytesSync(photoBytes);
      return photo;
    }
    return null; // Return null if no photo exists
  }
}
