import 'package:darak_project/Application/app_router/app_router.dart';
import 'package:darak_project/module/customer/customer_auth/forget_customer_password/customer_verification/verification_customer_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController{
  FirebaseAuth auth = FirebaseAuth.instance;
  late TextEditingController number ,otp;
  String verifyId = "";
  RxString userMobileNumber = "".obs;

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
      userMobileNumber.value = users!.phoneNumber.toString();
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
          if (kDebugMode) {
            print(credential);
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          if (kDebugMode) {
            print(e);
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          verifyId = verificationId;
          Get.snackbar(
              "OTP Sent", "Otp sent on your mobile number ${number.text}");
          Get.to(PinCodeVerificationScreen());
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (ex) {
      Get.snackbar("$ex", "");
      if (kDebugMode) {
        print(ex);
      }
    }
  }

  void verifyMobileNumber(String verificationCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verifyId,
        smsCode: verificationCode,

      );
      await auth.signInWithCredential(credential);
      Get.snackbar("OTP Versified", "Welcome to Flutter app");
      Get.offAllNamed(Routes.resetRoute);
    } catch (ex) {
      if (kDebugMode) {
        print(ex);
      }
    }
  }





  void reset(){
    otp.clear();
    update();

  }
}