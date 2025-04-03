import 'dart:io';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PhotoHandler {
  // Function to pick an image from gallery or camera
  static Future<File?> pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery, // Use ImageSource.camera for the camera
    );

    if (pickedFile != null) {
      // Optionally, crop the image
      File? croppedImage = await cropImage(File(pickedFile.path));
      return croppedImage;
    }
    return null;
  }

  // Function to crop an image
  static Future<File?> cropImage(File imageFile) async {
    try {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        // Optional: Uncomment to enable aspect ratio presets
        // aspectRatioPresets: [
        //   CropAspectRatioPreset.square,
        //   CropAspectRatioPreset.original,
        //   CropAspectRatioPreset.ratio16x9,
        // ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: ThemeConstants.ecoGreen,
            toolbarWidgetColor: Colors.white,
            activeControlsWidgetColor:  ThemeConstants.ecoGreen,
            initAspectRatio: CropAspectRatioPreset.square,
            aspectRatioPresets: [CropAspectRatioPreset.square],
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: 'Crop Image',
          ),
        ],
      );

      if (croppedFile != null) {
        return File(croppedFile.path);
      } else {
        debugPrint("Cropping was canceled or failed.");
      }
    } catch (e) {
      debugPrint("Error cropping image: $e");
    }
    return null;
  }
}
