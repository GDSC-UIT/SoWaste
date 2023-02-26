import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/core/values/app_file_path.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/data/services/local_data.dart';
import 'package:sowaste/routes/app_page.dart';

import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DataCenter.appFilePath = await LocalService.getFilePath;
  var response = await LocalService.readFile("app");
  if (response == null) {
    LocalService.saveContent({"isTheFirstTime": true}, AppFilePath.app);
    DataCenter.isFirstTime = true;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute:
          DataCenter.isFirstTime ? AppRoutes.onboardingPage : AppRoutes.base,
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
    );
  }
}
