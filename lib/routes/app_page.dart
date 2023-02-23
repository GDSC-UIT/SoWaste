import 'package:get/get.dart';
import 'package:sowaste/modules/base/base_screen.dart';
import 'package:sowaste/modules/dictionary/dictionary_binding.dart';
import 'package:sowaste/modules/dictionary/screens/dictionary_main_screen.dart';
import 'package:sowaste/modules/dictionary/screens/fail_quizz_screen.dart';
import 'package:sowaste/modules/env_news/screens/env_news_screen.dart';
import 'package:sowaste/modules/home/home_binding.dart';
import 'package:sowaste/modules/onboarding/onboarding_binding.dart';
import 'package:sowaste/modules/onboarding/screens/onboarding_screen.dart';

import '../modules/dictionary/screens/congratulation_quizz_screen.dart';
import '../modules/home/screens/home_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    //home page
    GetPage(
      name: AppRoutes.baseScreen,
      page: () => const BaseScreen(),
      transition: Transition.cupertino,
      binding: HomeBinding(),
    ),
    GetPage(
        name: AppRoutes.onboardingPage,
        page: () => OnboardingScreen(),
        transition: Transition.cupertino,
        binding: OnBoardingBinding()),
    GetPage(
        name: AppRoutes.dictionaryPage,
        page: () => const DictionaryMainScreen(),
        transition: Transition.cupertino,
        binding: DictionaryBinding()),
    GetPage(
        name: AppRoutes.failedQuizPage,
        page: () => const FailQuizScreen(),
        transition: Transition.cupertino,
        binding: DictionaryBinding()),
    GetPage(
        name: AppRoutes.passedQuizPage,
        page: () => const CongratulationScreen(),
        transition: Transition.cupertino,
        binding: DictionaryBinding()),

    // env news page
    GetPage(
        name: AppRoutes.envNewsScreen,
        page: () => const EnvNewsScreen(),
        transition: Transition.cupertino,
        binding: DictionaryBinding()),
  ];
}
