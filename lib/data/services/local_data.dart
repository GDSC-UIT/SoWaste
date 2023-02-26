import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sowaste/data/services/data_center.dart';

class LocalService {
  //get app file path
  static Future<String> get getFilePath async {
    final Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> getFile(String fileName) async {
    final path = DataCenter.appFilePath;
    return File('$path/$fileName.json');
  }

  static Future<Map?> readFile(String fileName) async {
    try {
      final file = await getFile(fileName);
      String fileContent = await file.readAsString();
      Map jsonContent = json.decode(fileContent);
      print("File content: $jsonContent");
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

  static Future<void> clearContent(String fileName) async {
    final file = await getFile(fileName);
    file.delete();
  }
}
