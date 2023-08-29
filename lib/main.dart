import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:zihun_chats/app/controllers/auth_controller.dart';
import 'package:zihun_chats/app/utils/splash_screen.dart';
import 'package:zihun_chats/firebase_options.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(AuthController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return kDebugMode
        ? GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "ChatApp",
            initialRoute: authC.isSkipIntro.isTrue
                ? authC.isAuth.isTrue
                    ? Routes.NAVIGATION
                    : Routes.LOGIN
                : Routes.INTRODUCTION,
            getPages: AppPages.routes,
          )
        : FutureBuilder(
            future: Future.delayed(Duration(seconds: 3)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Obx(
                  () => GetMaterialApp(
                    title: "ChatApp",
                    initialRoute: authC.isSkipIntro.isTrue
                        ? authC.isAuth.isTrue
                            ? Routes.NAVIGATION
                            : Routes.LOGIN
                        : Routes.INTRODUCTION,
                    getPages: AppPages.routes,
                  ),
                );
              }
              return FutureBuilder(
                future: authC.firstInitialized(),
                builder: (context, snapshot) => SplashScreen(),
              );
            },
          );
  }
}
