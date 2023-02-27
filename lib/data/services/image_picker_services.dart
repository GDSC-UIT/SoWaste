import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImageServices {
  static File? pickedImage;
  static Future<void> getImageFromCamera() async {
    try {
      final image = await ImagePicker().getImage(
        source: ImageSource.camera,
      );
      if (image == null) return;
      pickedImage = File(image.path);
    } on PlatformException catch (e) {
      print("Failed to pick image! : $e");
    }
  }

  static Future<void> getImageFromGallery() async {
    try {
      final image = await ImagePicker().getImage(source: ImageSource.gallery);
      if (image == null) return;
      pickedImage = File(image.path);
    } on PlatformException catch (e) {
      print("Failed to pick image from gallery : $e");
    }
  }
}
