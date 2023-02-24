import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalData {
  static Future<String> get getFilePath async {
    final Directory directory = await getApplicationDocumentsDirectory();
    print("App File Path: ${directory.path}");
    return directory.path;
  }

  static Future<File> getFile(String fileName) async {
    final path = await getFilePath;
    return File('$path/$fileName.json');
  }

  static Future<Map<dynamic, dynamic>?> readFile(String fileName) async {
    try {
      final file = await getFile(fileName);
      String fileContent = await file.readAsString();
      Map jsonContent = json.decode(fileContent);
      print("File content: $fileContent");
      return jsonContent;
    } catch (error) {
      print("Fail to load data from local storage");
    }
    return null;
  }

  static Future<File> saveContent(Map content, String fileName) async {
    final file = await getFile(fileName);
    return file.writeAsString(json.encode(content));
  }
}
