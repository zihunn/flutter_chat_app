// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zihun_chats/app/controllers/auth_controller.dart';

class CustomAppbar extends StatelessWidget {
  final bool isTwoTitle;
  final bool isCenter;
  final String text1;
  final String? text2;
  const CustomAppbar({
    Key? key,
    this.isTwoTitle = true,
    this.isCenter = false,
    required this.text1,
    this.text2 = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    return SafeArea(
        child: Container(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
      height: 60,
      width: Get.width,
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        titleSpacing: 2,
        elevation: 0,
        actions: [
          CircleAvatar(
              radius: 24.0,
              backgroundImage: authC.user.value.photoUrl != "noimage"
                  ? NetworkImage("${authC.user.value.photoUrl}")
                  : NetworkImage(
                      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                    )),
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text1,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
            ),
            Text(
              text2!,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
