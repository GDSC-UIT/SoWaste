import 'package:get/get.dart';
import 'package:sowaste/modules/base/base_binding.dart';
import 'package:sowaste/modules/base/base_screen.dart';
import 'package:sowaste/modules/dictionary/dictionary_binding.dart';
import 'package:sowaste/modules/dictionary/screens/dictionary_overview_screen.dart';
import 'package:sowaste/modules/dictionary/screens/question_screen.dart';
import 'package:sowaste/modules/dictionary/screens/quizzes.dart';
import 'package:sowaste/modules/dictionary/screens/recent_trashes.dart';
import 'package:sowaste/modules/dictionary/screens/saved_trashes_screen.dart';
import 'package:sowaste/modules/dictionary/screens/trash_detail_screen.dart';
import 'package:sowaste/modules/env_news/env_news_binding.dart';
import 'package:sowaste/modules/env_news/screens/env_news_detailed_screen.dart';
import 'package:sowaste/modules/env_news/screens/env_news_search_screen.dart';
import 'package:sowaste/modules/home/home_binding.dart';
import 'package:sowaste/modules/map/screens/map_screen.dart';
import 'package:sowaste/modules/onboarding/onboarding_binding.dart';
import 'package:sowaste/modules/onboarding/screens/onboarding_screen.dart';
import 'package:sowaste/modules/trash_detecting/screens/pick_image_screen.dart';
import 'package:sowaste/modules/trash_detecting/screens/trash_decteting_screen.dart';

import '../modules/home/screens/home_screen.dart';
import '../modules/trash_detecting/trash_detecting_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    //home page
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => const HomeScreen(),
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
        page: () => const DictionaryOverviewScreen(),
        transition: Transition.cupertino,
        binding: DictionaryBinding()),

    GetPage(
        name: AppRoutes.savedTypesPage,
        page: () => const SavedTrashesScreen(),
        transition: Transition.cupertino,
        binding: DictionaryBinding()),
    GetPage(
        name: AppRoutes.recentTypesPage,
        page: () => const RecentTypesScreen(),
        transition: Transition.cupertino,
        binding: DictionaryBinding()),
    GetPage(
        name: AppRoutes.quizzesPage,
        page: () => const QuizzesScreen(),
        transition: Transition.cupertino,
        binding: DictionaryBinding()),

    GetPage(
        name: AppRoutes.trashDetailPage,
        page: () => const TrashDetailScreen(),
        transition: Transition.cupertino,
        binding: DictionaryBinding()),
    GetPage(
        name: AppRoutes.detectPage,
        page: () => TrashDetectingScreen(),
        transition: Transition.cupertino,
        binding: TrashDetectingBinding()),

    // env news
    GetPage(
        name: AppRoutes.environmentNewsPage,
        page: () => EnvironmentNewsOverviewScreen(),
        transition: Transition.cupertino,
        binding: EnvironmentBinding()),
    GetPage(
        name: AppRoutes.detailNewsPage,
        page: () => EnvsNewsDetailScreen(),
        transition: Transition.cupertino,
        binding: EnvironmentBinding()),
    //dictionary
    GetPage(
      name: AppRoutes.questionsPage,
      page: () => QuestionScreen(),
      transition: Transition.cupertino,
      binding: DictionaryBinding(),
    ),
    GetPage(
      name: AppRoutes.questionsPage,
      page: () => QuestionScreen(),
      transition: Transition.cupertino,
      binding: DictionaryBinding(),
    ),
    //base
    GetPage(
        name: AppRoutes.base,
        page: () => BaseScreen(),
        transition: Transition.cupertino,
        binding: BaseBinding()),

    GetPage(
        name: AppRoutes.mapPage,
        page: () => const MapScreen(),
        transition: Transition.cupertino,
        binding: BaseBinding()),
    //image
    GetPage(
      name: AppRoutes.pickImageScreen,
      page: () => PickImageScreen(),
      transition: Transition.cupertino,
    ),

    //Test tflite
  ];
}
