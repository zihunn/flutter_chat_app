// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zihun_chats/app/controllers/auth_controller.dart';
import 'package:zihun_chats/app/modules/home/controllers/home_controller.dart';

class CardList extends StatelessWidget {
  final Map data;
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> listDoc;
  const CardList({
    Key? key,
    required this.data,
    required this.listDoc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeCtrl = Get.put(HomeController());
    final authCtrl = Get.put(AuthController());
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      height: 75,
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.2),
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: ListTile(
        onTap: () => homeCtrl.goToChatRoom(
          "${listDoc[0].id}",
          authCtrl.user.value.email!,
          listDoc[0]["connection"],
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
            image: data['photoUrl'] != "noimage"
                ? DecorationImage(
                    image: NetworkImage(data['photoUrl']),
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
          "${listDoc[0]['msg']}",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              DateFormat.Hm().format(
                DateTime.parse(listDoc[0]['lastTime']),
              ),
              style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 7.0,
            ),
            listDoc[0]['total_unread'] != 0
                ? CircleAvatar(
                    radius: 12.0,
                    backgroundColor: Colors.green,
                    child: Text(
                      "${listDoc[0]['total_unread']}",
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
}
