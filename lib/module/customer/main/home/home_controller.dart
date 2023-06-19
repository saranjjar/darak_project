import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darak_project/const.dart';
import 'package:darak_project/model/category.dart';
import 'package:darak_project/services/common/shared_pref.dart';
import 'package:darak_project/services/common/user_store.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getNotification();
    getCategory();
    getUserName();
    StorageService.to.setString(Constants.STRORAGE_NAME_USER, userName);
    StorageService.to.setString(Constants.STRORAGE_EMAIL, email);
    StorageService.to.setString(Constants.STRORAGE_PHOTO, photourl);
    print(StorageService.to.getString(Constants.STRORAGE_NAME_USER));
  }

  final notification = <RemoteNotification?>[].obs;
  void getNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        notification.add(message.notification);
        update();
        print(
            'Message also contained a notification: ${message.notification!.title}');
      }
    });
  }

  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  bool isLoading = false;

  List<QueryDocumentSnapshot<Category>> categoryList =
      <QueryDocumentSnapshot<Category>>[];
  final db = FirebaseFirestore.instance;
  getCategory() async {
    isLoading = true;
    update();
    var category = await db
        .collection("category")
        .withConverter(
            fromFirestore: Category.fromFirestore,
            toFirestore: (Category ctg, options) => ctg.toFirestore())
        .get();

    categoryList.clear();
    if (category.docs.isNotEmpty) {
      categoryList.assignAll(category.docs);
    }
    isLoading = false;
    update();
  }

  final token = UserStore.t0.token;

  String userName = '';
  String email = '';
  String photourl = '';

  getUserName() async {
    final userQuerySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: token)
        .get();
    if (userQuerySnapshot.docs.isNotEmpty) {
      final userDocument = userQuerySnapshot.docs.first;
      userName = userDocument['name'];
      email = userDocument['email'];
      photourl = userDocument['photourl'];
      print('User Name: $userName');
      update();
      // Update your state or perform further operations with the user name
    }
  }
}
