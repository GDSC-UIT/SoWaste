import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImageSize {
  final double? width;
  final double? height;
  ImageSize({this.width, this.height});
}

class ImageServices {
  static File? pickedImage;
  static double? imageWidth;
  static double? imageHeight;
  static Future<void> getImageFromCamera() async {
    pickedImage = null;
    try {
      final image = await ImagePicker().getImage(
        source: ImageSource.camera,
      );

      if (image == null) return;
      pickedImage = File(image.path);
    } on PlatformException catch (e) {}
  }

  static Future<void> getImageFromGallery() async {
    pickedImage = null;
    try {
      final image = await ImagePicker().getImage(source: ImageSource.gallery);
      if (image == null) return;
      pickedImage = File(image.path);
    } on PlatformException catch (e) {}
  }

  static Future<ImageSize> getImageSize(String imageUrl) async {
    // get the bytes from the image
    final ByteData data =
        await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl);
    final Uint8List bytes = data.buffer.asUint8List();

    // decode the bytes to get the image size
    final decodedImage = await decodeImageFromList(bytes);

    // set the state
    return ImageSize(
        width: decodedImage.width.toDouble(),
        height: decodedImage.height.toDouble());
  }
}
