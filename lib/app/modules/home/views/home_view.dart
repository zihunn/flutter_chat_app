import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zihun_chats/app/controllers/auth_controller.dart';
import 'package:zihun_chats/app/modules/search/controllers/search_controller.dart';
import 'package:zihun_chats/app/widgets/appbar/custom_appbar.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<AuthController>();

  

  @override
  Widget build(BuildContext context) {
    final searchCtrl = Get.put(SearchController2());
    final authCtrl = Get.put(AuthController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomAppbar(
            text1: "Hello ${authC.user.value.name?.split(" ")[0]},",
            text2: "Xreach message",
          ),
          Divider(
            thickness: 1,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: controller.chatsStream(authC.user.value.email!),
              builder: (context, snapshot1) {
                if (snapshot1.connectionState == ConnectionState.active) {
                  var listDocsChats = snapshot1.data!.docs;
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: listDocsChats.length,
                    itemBuilder: (context, index) {
                      return StreamBuilder<
                          DocumentSnapshot<Map<String, dynamic>>>(
                        stream: controller
                            .friendStream(listDocsChats[index]["connection"]),
                        builder: (context, snapshot2) {
                          if (snapshot2.connectionState ==
                              ConnectionState.active) {
                            var data = snapshot2.data!.data();
                            var dataDoc = listDocsChats[index];
                            print("ini print 000 ${dataDoc}");
                            print("ini print friend ${data}");
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              height: 75,
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.05),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                              ),
                              child: ListTile(
                                onTap: () => controller.goToChatRoom(
                                  "${listDocsChats[index].id}",
                                  authC.user.value.email!,
                                  listDocsChats[index]["connection"],
                                ),
                                contentPadding: EdgeInsets.zero,
                                leading: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12.0),
                                    ),
                                    image: data!['photoUrl'] != "noimage"
                                        ? DecorationImage(
                                            image:
                                                NetworkImage(data['photoUrl']),
                                            fit: BoxFit.cover,
                                          )
                                        : DecorationImage(
                                            image: NetworkImage(
                                              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                subtitle: Text(
                                  "${listDocsChats[index]['msg']}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      DateFormat.Hm().format(
                                        DateTime.parse(
                                            listDocsChats[0]['lastTime']),
                                      ),
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 7.0,
                                    ),
                                    listDocsChats[index]['total_unread'] != 0
                                        ? CircleAvatar(
                                            radius: 12.0,
                                            backgroundColor: Colors.green,
                                            child: Text(
                                              "${listDocsChats[index]['total_unread']}",
                                            ))
                                        : SizedBox()
                                  ],
                                ),
                                title: Text(
                                  data['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
