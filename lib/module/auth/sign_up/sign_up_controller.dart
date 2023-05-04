import 'package:darak_project/module/main/layout/layout_screen.dart';
import 'package:darak_project/services/firebase/database_service.dart';
import 'package:darak_project/widgets/components/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User?> user = Rx<User?>(null);
  User? users = FirebaseAuth.instance.currentUser;

  void updateDetail() async {
    await users?.updateDisplayName(username.text);
    await users?.updateEmail(email.text);
    await users?.updatePassword(password.text);
  }

  void displayUserDetails() async {
    print(users!.displayName);
    print(users!.email);
    print(users!.phoneNumber);
  }

  //
  // void loginWithEmail() async {
  //   try {
  //     await _auth.signInWithEmailAndPassword(
  //         email: "admin@gmail.com", password: "Admin123");
  //     Get.snackbar("Accound Logined", "Welcome");
  //     print(user.value!.email);
  //     print(user.value!.displayName);
  //   } catch (ex) {
  //     Get.snackbar("Something Wrong", "$ex");
  //   }
  // }

  // void logOut() async {
  //   try {
  //     await _auth.signOut();
  //     Get.snackbar("Accound LogOut", "Welcome");
  //   } catch (ex) {
  //     Get.snackbar("Something Wrong", "$ex");
  //   }
  // }
   late final TextEditingController email , password, username ,phone;

   bool isLoading = false;
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  //
  // //register app
  // register(context) async {
  //
  //     try {
  //       final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
  //         email: email.text,
  //         password: password.text,
  //       );
  //       if (userCredential.user != null) {
  //         // User was created successfully
  //         Get.to(()=>const LayoutScreen());
  //       } else {
  //
  //       }
  //     } catch (error) {
  //
  //   }
  // }
  // register method
  Future registerWithEmail(context) async {
    isLoading = true;
    update();
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());

      if (user != null) {
        // call our database service to update the user data.
        Get.to(()=> LayoutScreen());
        await DatabaseService(uid: userCredential.user!.uid).savingUserData(
          username.text.trim(),
          email.text.trim(),
          phone.text.trim(),
          password.text.trim(),

            );
        return true;
      }else{
        // User was not created successfully
        showSnackbar(context, Colors.red, "User created failed");

        isLoading = false;
        update();
      }
    } on FirebaseAuthException catch (error) {
      String message='error occurred';
      // Handle any errors that occur during sign up
      if(error.code=='weak-password'){
        message='The password provided is too weak.';
      }else if(error.code=='email-already-in-use'){
        message='The account already exists for that email.';
      }
      showSnackbar(context, Colors.red, message);
      isLoading = false;
      update();
      return error.message;
    }
  }

  //register facebook
  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
  @override
  void onInit() {
    username = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    password = TextEditingController();
    user.bindStream(_auth.authStateChanges());
    super.onInit();
  }
  @override
  void dispose() {

    username.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    super.dispose();
  }
}