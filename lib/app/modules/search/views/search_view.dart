import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:zihun_chats/app/controllers/auth_controller.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController2> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              height: 70,
              width: Get.width,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.09),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(14.0),
                        ),
                      ),
                      child: TextFormField(
                          initialValue: null,
                          controller: controller.searchC,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(top: 13),
                            prefixIcon: Icon(
                              Ionicons.search_outline,
                              color: Colors.grey,
                            ),
                            filled: true,
                            border: InputBorder.none,
                            fillColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            hintText: "Search new friend",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          onChanged: (value) => controller.searchFriend(
                              value, "${authC.user.value.email}")),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => controller.tempSearch.length == 0
                    ? Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: Get.width * 0.7,
                          height: Get.width * 0.7,
                          child: Lottie.asset("assets/lottie/empty.json"),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: controller.tempSearch.length,
                        itemBuilder: (context, index) => ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.black26,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: controller.tempSearch[index]["photoUrl"] ==
                                      "noimage"
                                  ? Image.asset(
                                      "assets/logo/noimage.png",
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      controller.tempSearch[index]["photoUrl"],
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          title: Text(
                            "${controller.tempSearch[index]["name"]}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            "${controller.tempSearch[index]["email"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () => authC.addNewConnection(
                              controller.tempSearch[index]["email"],
                            ),
                            child: Chip(
                              label: Text("Message"),
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
