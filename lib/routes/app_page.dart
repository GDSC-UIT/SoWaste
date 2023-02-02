import 'package:get/get.dart';
import 'package:sowaste/modules/home/home_binding.dart';

import '../modules/home/screens/home_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    //home page
    GetPage(
      name: AppRoutes.homePage,
      page: () => HomeScreen(),
      transition: Transition.cupertino,
      binding: HomeBinding(),
    )
  ];
}
