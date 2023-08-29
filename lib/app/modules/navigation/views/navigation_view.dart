import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:zihun_chats/app/modules/home/views/home_view.dart';
import 'package:zihun_chats/app/modules/profile/views/profile_view.dart';
import 'package:zihun_chats/app/modules/search/views/search_view.dart';

import '../controllers/navigation_controller.dart';

class NavigationView extends GetView<NavigationController> {
  const NavigationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: IndexedStack(
            index: controller.navIndex,
            children: [
              HomeView(),
              SearchView(),
              ProfileView(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 0,
          unselectedFontSize: 0,
          currentIndex: controller.navIndex,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue.withOpacity(0.7),
          unselectedItemColor: Colors.grey[500],
          onTap: (index) => controller.changeNavIndex(index),
          items: const [
            BottomNavigationBarItem(
              label: "",
              activeIcon: Icon(
                Ionicons.chatbubble,
              ),
              icon: Icon(
                Ionicons.chatbubble_outline,
              ),
            ),
            BottomNavigationBarItem(
              label: "",
              activeIcon: Icon(
                Ionicons.search,
              ),
              icon: Icon(
                Ionicons.search_outline,
              ),
            ),
            BottomNavigationBarItem(
              label: "",
              activeIcon: Icon(
                Ionicons.person,
              ),
              icon: Icon(
                Ionicons.person_outline,
              ),
            ),
          ],
        ),
      );
    });
  }
}
