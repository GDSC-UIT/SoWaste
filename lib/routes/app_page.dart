import 'package:get/get.dart';
import 'package:sowaste/modules/dictionary/dictionary_binding.dart';
import 'package:sowaste/modules/dictionary/screens/detail_screen.dart';
import 'package:sowaste/modules/dictionary/screens/dictionary_overview_screen.dart';
import 'package:sowaste/modules/dictionary/screens/fail_quizz_screen.dart';
import 'package:sowaste/modules/dictionary/screens/questions_screen.dart';
import 'package:sowaste/modules/dictionary/screens/quizzes.dart';
import 'package:sowaste/modules/dictionary/screens/recent_types.dart';
import 'package:sowaste/modules/dictionary/screens/saved_types_screen.dart';
import 'package:sowaste/modules/home/home_binding.dart';
import 'package:sowaste/modules/onboarding/onboarding_binding.dart';
import 'package:sowaste/modules/onboarding/screens/onboarding_screen.dart';
import 'package:sowaste/modules/trash_detecting/screens/trash_decteting_screen.dart';

import '../modules/dictionary/screens/congratulation_quizz_screen.dart';
import '../modules/home/screens/home_screen.dart';
import '../modules/trash_detecting/trash_detecting_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    //home page
    GetPage(
      name: AppRoutes.homePage,
      page: () => HomeScreen(),
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
        page: () => DictionaryOverviewScreen(),
        transition: Transition.cupertino,
        binding: DictionaryBinding()),
    GetPage(
        name: AppRoutes.failedQuizPage,
        page: () => FailQuizScreen(),
        transition: Transition.cupertino,
        binding: DictionaryBinding()),
    GetPage(
        name: AppRoutes.passedQuizPage,
        page: () => CongratulationScreen(),
        transition: Transition.cupertino,
        binding: DictionaryBinding()),
    GetPage(
        name: AppRoutes.savedTypesPage,
        page: () => SavedTypesScreen(),
        transition: Transition.cupertino,
        binding: DictionaryBinding()),
    GetPage(
        name: AppRoutes.recentTypesPage,
        page: () => RecentTypesScreen(),
        transition: Transition.cupertino,
        binding: DictionaryBinding()),
    GetPage(
        name: AppRoutes.quizzesPage,
        page: () => QuizzesScreen(),
        transition: Transition.cupertino,
        binding: DictionaryBinding()),
    GetPage(
        name: AppRoutes.questionsPage,
        page: () => QuestionScreen(),
        transition: Transition.cupertino,
        binding: DictionaryBinding()),
    GetPage(
        name: AppRoutes.detailPage,
        page: () => DetailScreen(),
        transition: Transition.cupertino,
        binding: DictionaryBinding()),
    GetPage(
        name: AppRoutes.detectPage,
        page: () => TrashDetectingScreen(),
        transition: Transition.cupertino,
        binding: TrashDetectingBinding()),
  ];
}
