import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImageServices {
  static File? pickedImage;
  static Future<void> getImageFormCamera() async {
    try {
      final image = await ImagePicker().getImage(source: ImageSource.camera);
      if (image == null) return;
      pickedImage = File(image.path);
    } on PlatformException catch (e) {
      print("Failed to pick image!");
    }
  }
}
