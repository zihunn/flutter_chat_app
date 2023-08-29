import 'package:get/get.dart';
import 'package:zihun_chats/app/modules/home/controllers/home_controller.dart';
import 'package:zihun_chats/app/modules/profile/controllers/profile_controller.dart';
import 'package:zihun_chats/app/modules/search/controllers/search_controller.dart';

import '../controllers/navigation_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationController>(
      () => NavigationController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<SearchController2>(
      () => SearchController2(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
