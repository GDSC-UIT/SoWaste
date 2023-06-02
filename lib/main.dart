import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/core/themes/app_themes.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/data/services/local_data.dart';
import 'package:sowaste/routes/app_page.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DataCenter.AppFilePath = await LocalService.getFilePath;
  runApp(const App());
  configLoading();
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  // ignore: library_private_types_in_public_api
  AppState createState() => AppState();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = AppColors.background
    ..indicatorColor = AppColors.primary
    ..textColor = AppColors.primary
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class AppState extends State<App> {
  late String initialRoute = AppRoutes.temp;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: initialRoute,
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      builder: EasyLoading.init(),
    );
  }
}
