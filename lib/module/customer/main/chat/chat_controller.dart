import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darak_project/Application/app_router/app_router.dart';
import 'package:darak_project/model/message.dart';
import 'package:darak_project/model/user.dart';
import 'package:darak_project/services/common/user_store.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  var count = 0.obs;

  final db = FirebaseFirestore.instance;
  final token = UserStore.t0.token;

  goChat(UserData toUserdata) async {
    var fromMessages = await db
        .collection('message')
        .withConverter(
            fromFirestore: Message.fromFirestore,
            toFirestore: (Message msg, options) => msg.toFirestore())
        .where("from_uid", isEqualTo: token)
        .where("to_uid", isEqualTo: toUserdata.id)
        .get();
    var toMessages = await db
        .collection('message')
        .withConverter(
            fromFirestore: Message.fromFirestore,
            toFirestore: (Message msg, options) => msg.toFirestore())
        .where("from_uid", isEqualTo: toUserdata.id)
        .where("to_uid", isEqualTo: token)
        .get();
    if (fromMessages.docs.isEmpty && toMessages.docs.isEmpty) {
      String profile = await UserStore.t0.getProfile();
      Users userdata = Users.fromJson(jsonDecode(profile));
      var msgData = Message(
          from_uid: userdata.accessToken,
          to_uid: toUserdata.id,
          from_name: userdata.displayName,
          to_name: toUserdata.name,
          from_avatar: userdata.photoUrl,
          to_avatar: toUserdata.photoUrl,
          last_msg: "",
          last_time: Timestamp.now(),
          msg_num: 0);
      db
          .collection('message')
          .withConverter(
              fromFirestore: Message.fromFirestore,
              toFirestore: (Message msg, options) => msg.toFirestore())
          .add(msgData)
          .then((value) {
        Get.toNamed(Routes.inChatScreenRoute, parameters: {
          "doc_id": value.id,
          "to_uid": toUserdata.id ?? "",
          "to_name": toUserdata.name ?? "",
          "to_avatar": toUserdata.photoUrl ?? ""
        });
      });
    } else {
      if (fromMessages.docs.isNotEmpty) {
        Get.toNamed(Routes.inChatScreenRoute, parameters: {
          "doc_id": fromMessages.docs.first.id,
          "to_uid": toUserdata.id ?? "",
          "to_name": toUserdata.name ?? "",
          "to_avatar": toUserdata.photoUrl ?? ""
        });
      }
      if (toMessages.docs.isNotEmpty) {
        Get.toNamed(Routes.inChatScreenRoute, parameters: {
          "doc_id": toMessages.docs.first.id,
          "to_uid": toUserdata.id ?? "",
          "to_name": toUserdata.name ?? "",
          "to_avatar": toUserdata.photoUrl ?? ""
        });
      }
    }
  }
  //get user data method

  RxList<UserData> contactList = <UserData>[].obs;
  RxBool isLoading = false.obs;

  Future<void> asyncLoadAllData() async {
    isLoading.value = true;
    var userbase = await db
        .collection('users')
        .where("id", isNotEqualTo: token)
        .withConverter(
            fromFirestore: UserData.fromFirestore,
            toFirestore: (UserData userdata, options) => userdata.toFirestore())
        .get();
    for (var doc in userbase.docs) {
      contactList.add(doc.data());
    }
    isLoading.value = false;
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    asyncLoadAllData();
  }
}
