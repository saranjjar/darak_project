import 'package:darak_project/Application/app_router/app_router.dart';
import 'package:darak_project/module/auth/forget_password/verification/verification_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController{
  FirebaseAuth auth = FirebaseAuth.instance;
  late TextEditingController number ,otp;
  String verifyId = "";
  RxString userMobilerNumber = "".obs;

  User? users = FirebaseAuth.instance.currentUser;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    otp=TextEditingController();
    number=TextEditingController();
    getUserData();
  }

  void getUserData() {
    // print(users!.displayName);
    // print(users!.phoneNumber);
    // print(users!.email);
    if (users != null) {
      userMobilerNumber.value = users!.phoneNumber.toString();
    }
  }

  void logoutUser() async {
    await auth.signOut();
    getUserData();
  }

  void singUpWithNumber() async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: '+970${number.text}',
        verificationCompleted: (PhoneAuthCredential credential) {
          print(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e);
        },
        codeSent: (String verificationId, int? resendToken) {
          verifyId = verificationId;
          Get.snackbar(
              "OTP Sended", "Otp sended on your mobiler number ${number.text}");
          Get.to(PinCodeVerificationScreen());
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (ex) {
      Get.snackbar("$ex", "");
      print(ex);
    }
  }

  void verifyMobilerNumber(String verificationCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verifyId,
        smsCode: verificationCode,

      );
      await auth.signInWithCredential(credential);
      Get.snackbar("OTP Verifed", "Welcome to Flutter app");
      Get.offAllNamed(Routes.resetRoute);
    } catch (ex) {
      print(ex);
    }
  }





  void reset(){
    otp.clear();
    update();

  }
}