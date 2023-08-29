// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zihun_chats/app/controllers/auth_controller.dart';
import 'package:zihun_chats/app/modules/search/controllers/search_controller.dart';

class SearchTextfield extends StatelessWidget {
  const SearchTextfield({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchCtrl = Get.put(SearchController2());
    final authCtrl = Get.put(AuthController());
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.09),
        borderRadius: const BorderRadius.all(
          Radius.circular(14.0),
        ),
      ),
      child: TextFormField(
        controller: searchCtrl.searchC,
        onChanged: (value) => searchCtrl.searchFriend(
          value,
          authCtrl.user.value.email!,
        ),
        initialValue: null,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 13),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
          filled: true,
          border: InputBorder.none,
          fillColor: Colors.transparent,
          hoverColor: Colors.transparent,
          hintText: "Find your product",
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
