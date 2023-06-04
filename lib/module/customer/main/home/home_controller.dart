import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darak_project/const.dart';
import 'package:darak_project/model/category.dart';
import 'package:darak_project/services/common/shared_pref.dart';
import 'package:darak_project/services/common/user_store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCategory();
    getUserName();
    StorageService.to.setString(Constants.STRORAGE_NAME_USER, userName);
    print(StorageService.to.getString(Constants.STRORAGE_NAME_USER));
  }

  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  bool isLoading = false;

  List<QueryDocumentSnapshot<Category>> categoryList = <QueryDocumentSnapshot<Category>> [];
  final db = FirebaseFirestore.instance;
  getCategory() async{
    isLoading = true;
    update();
    var category = await db.collection("category").withConverter(
        fromFirestore: Category.fromFirestore,
        toFirestore: (Category ctg,options)=>ctg.toFirestore()).get();

    categoryList.clear();
    if(category.docs.isNotEmpty){
      categoryList.assignAll(category.docs);
    }
    isLoading = false;
    update();
  }

  final token = UserStore.t0.token;

  String userName = '';

  getUserName()async{
      final userQuerySnapshot  = await FirebaseFirestore.instance
          .collection('users').where('id',isEqualTo: token)
          .get();
      if (userQuerySnapshot.docs.isNotEmpty) {
        final userDocument = userQuerySnapshot.docs.first;
         userName = userDocument['name'];
        print('User Name: $userName');
        update();
        // Update your state or perform further operations with the user name
      }
    }
}