import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sowaste/core/values/app_file_name.dart';
import 'package:sowaste/data/services/data_center.dart';

class LocalService {
  //get app file path
  static Future<String> get getFilePath async {
    final Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<Map?> readFile(String filePath) async {
    try {
      String fileContent = await File(filePath).readAsString();
      Map jsonContent = json.decode(fileContent);
      print("File content: $jsonContent");
      return jsonContent;
    } catch (error) {
      print("Fail to load data from local storage, $error");
    }
    return null;
  }

  static Future<File> saveContent(Map content, String filePath) async {
    return File(filePath).writeAsString(json.encode(content));
  }

  static Future<void> clearContent(String filePath) async {
    File(filePath).delete();
  }

  static Future<String> createFolderInAppDocDir(String folderName) async {
    //Get this App Document Directory

    final Directory _appDocDir = await getApplicationDocumentsDirectory();
    //App Document Directory + folder name
    final Directory _appDocDirFolder =
        Directory('${_appDocDir.path}/$folderName/');

    if (await _appDocDirFolder.exists()) {
      //if folder already exists return path
      return _appDocDirFolder.path;
    } else {
      //if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder =
          await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder.path;
    }
  }

  static Future<void> getAllFileDoneQuiz() async {
    DataCenter.doneQuizzesFolder =
        await LocalService.createFolderInAppDocDir(AppFileName.quizzes);

    String pdfDirectory = '${DataCenter.doneQuizzesFolder}/';
    final myDir = Directory(pdfDirectory);
    DataCenter.listQuizFile =
        myDir.listSync(recursive: true, followLinks: false);
  }
}
