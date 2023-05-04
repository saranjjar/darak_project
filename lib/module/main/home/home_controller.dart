import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darak_project/model/user.dart';
import 'package:darak_project/services/firebase/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  @override
  void onInit() {
    //getAllUser();
    super.onInit();
  }
  // bool isLoading= false;
  // List<Users> listAllUsers = [];
  // final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  // Future<void> getAllUser()async {
  //   isLoading=true;
  //   update();
  //   listAllUsers = await DatabaseService.getAllUsers(currentUserId);
  //   isLoading = false;
  //   update();
  // }
}