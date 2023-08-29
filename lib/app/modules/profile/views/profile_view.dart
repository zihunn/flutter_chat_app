import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zihun_chats/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';
import '../../../controllers/auth_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final authC = Get.find<AuthController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Get.isDarkMode ? Color(0xFF373A40) : Colors.white,
        actions: [
          IconButton(
            onPressed: () => authC.logout(),
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                Obx(
                  () => AvatarGlow(
                    endRadius: 110,
                    glowColor: Colors.black,
                    duration: Duration(seconds: 2),
                    child: Container(
                      margin: EdgeInsets.all(15),
                      width: 175,
                      height: 175,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: authC.user.value.photoUrl! == "noimage"
                            ? Image.asset(
                                "assets/logo/noimage.png",
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                authC.user.value.photoUrl!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    "${authC.user.value.name!}",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  "${authC.user.value.email!}",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  ListTile(
                    onTap: () => Get.toNamed(Routes.CHANGE_PROFILE),
                    leading: Icon(Icons.person),
                    title: Text(
                      "Change Profile",
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    trailing: Icon(Icons.arrow_right),
                  ),
               
                ],
              ),
            ),
          ),
          Container(
            margin:
                EdgeInsets.only(bottom: context.mediaQueryPadding.bottom + 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Chat App",
                  style: TextStyle(
                    color: Get.isDarkMode ? Colors.white54 : Colors.black54,
                  ),
                ),
                Text(
                  "v.1.0",
                  style: TextStyle(
                    color: Get.isDarkMode ? Colors.white54 : Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
