import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darak_project/Application/app_router/app_router.dart';
import 'package:darak_project/const.dart';
import 'package:darak_project/model/user.dart';
import 'package:darak_project/module/customer/main/layout/layout_screen.dart';
import 'package:darak_project/services/common/shared_pref.dart';
import 'package:darak_project/services/common/user_store.dart';
import 'package:darak_project/widgets/components/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController{

  late final TextEditingController email , password;

  RxBool isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;


  RxBool isvisiable = false.obs;

  changeVisiability(){
    isvisiable.value =! isvisiable.value;
  }
  @override
  onReady(){
    super.onReady();
    FirebaseAuth.instance.authStateChanges().listen((User? user) { 
      if(user==null){
        if (kDebugMode) {
          print('User is currently logged out');
        }

      }else{
        if (kDebugMode) {
          print('User logged in');
        }
      }
    });
  }

  login(context) async {
        isLoading.value = true;
      try {
        final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        if (userCredential.user != null) {
          // User was created successfully

          final user = userCredential.user;
          //String? displayName = user?.displayName;
          String email = user?.email ?? "";
          String id = user?.uid ?? "";
          String photoUrl = user?.photoURL ?? "";
          Users userProfile = Users();
          userProfile.email = email;
          userProfile.accessToken = id;
          //userProfile.displayName = displayName;
          userProfile.photoUrl = photoUrl;
          UserStore.t0.saveProfile(userProfile);
          await StorageService.to.setString(Constants.STRORAGE_DEVICE_CUSTO_WORK_KEY, 'CUSTOMER');
          Get.offAllNamed(Routes.layoutRoute);
        }
    //?? user?.email!
         else {
          // User was not created successfully
          showSnackbar(context, Colors.red, "User created failed");

        }
      } catch (error) {
        // Handle any errors that occur during sign up
        showSnackbar(context, Colors.red, error.toString());
    }
    isLoading.value = false;
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }
  @override
  void dispose() {

    email.dispose();
    password.dispose();
    super.dispose();
  }
}