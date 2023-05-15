import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darak_project/module/customer/main/layout/layout_screen.dart';
import 'package:darak_project/module/worker/addInfo/add_info_screen.dart';
import 'package:darak_project/services/common/config.dart';
import 'package:darak_project/widgets/components/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInWoController extends GetxController{

  late final TextEditingController email , password;

  RxBool isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

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
          if(ConfigStore.to.isFirstOpen) {
            Get.to(()=> AddInfoScreen());
          } else{
            Get.to(()=> LayoutScreen());
          }
        }

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