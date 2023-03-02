import 'package:get/get.dart';
import 'package:sowaste/data/services/data_center.dart';
import 'package:sowaste/data/services/local_data.dart';
import 'package:sowaste/modules/dictionary/screens/dictionary_overview_screen.dart';
import 'package:sowaste/modules/env_news/screens/env_news_search_screen.dart';
import 'package:sowaste/modules/home/screens/home_screen.dart';
import 'package:sowaste/modules/trash_detecting/screens/pick_image_screen.dart';

class BaseController extends GetxController {
  RxInt currentIndex = 0.obs;
  @override
  void onInit() async {
    DataCenter.doneQuizzesFolder =
        await LocalService.createFolderInAppDocDir("quizzes");
    await LocalService.getAllFileDoneQuiz();
    for (var element in DataCenter.listQuizFile) {
      print(element.path);
    }
    super.onInit();
  }

  var pages = [
    HomeScreen(),
    EnvironmentNewsOverviewScreen(),
    const PickImageScreen(),
    const DictionaryOverviewScreen(),
    HomeScreen(),
  ].obs;
}
