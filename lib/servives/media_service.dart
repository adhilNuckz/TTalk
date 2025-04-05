import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MediaService {
  final ImagePicker _imagePicker = ImagePicker();

  MediaService() {
    // Initialize any necessary resources here
  }
  Future<XFile?> getImageFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      return image;
    } catch (e) {
      print("Error picking image: $e");
      return null;
    }
  }

}