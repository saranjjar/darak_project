import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darak_project/model/user.dart';
import 'package:darak_project/module/customer/main/layout/layout_screen.dart';
import 'package:darak_project/module/worker/addInfo/add_info_screen.dart';
import 'package:darak_project/services/common/user_store.dart';
import 'package:darak_project/widgets/components/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes:<String> [
      'openid'
    ]
);

class SignUpWoController extends GetxController{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User?> user = Rx<User?>(null);
  User? users = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> signInGoogle(context) async {

    try {
      isLoading.value = true;
      update();

      var user = await _googleSignIn.signIn();
      if(user!=null){

        final gAuth = await user.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: gAuth.idToken,
          accessToken: gAuth.accessToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);

        String displayName = user.displayName ?? user.email;
        String email = user.email;
        String id = user.id;
        String photoUrl = user.photoUrl ?? "";

        Users userProfile = Users();

        userProfile.email = email;
        userProfile.accessToken = id;
        userProfile.displayName = displayName;
        userProfile.photoUrl = photoUrl;
        UserStore.t0.saveProfile(userProfile);

        var userbase = await db.collection('users').withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData userdata,options)=>userdata.toFirestore(),).where('id', isEqualTo:id ).get();
        if(userbase.docs.isEmpty){
          final data = UserData(
            id: id,
            name: displayName,
            email: email,
            photoUrl: photoUrl,
            location: "",
            fcmtoken: "",
            addtime: Timestamp.now(),
          );
          await db.collection('users').withConverter(
            fromFirestore: UserData.fromFirestore,
            toFirestore: (UserData userdata,options)=>userdata.toFirestore(),).add(data);
        }
        showSnackbar(context, Colors.green, 'Login Success');
        Get.offAll(()=>AddInfoScreen());
      }

    }catch(e){
      showSnackbar(context, Colors.red, e.toString());
      if (kDebugMode) {
        print(e.toString());
      }
    }
    isLoading.value = false;
    update();
  }


  void updateDetail() async {
    await users?.updateDisplayName(username.text);
    await users?.updateEmail(email.text);
    await users?.updatePassword(password.text);
  }

  void displayUserDetails() async {
    if (kDebugMode) {
      print(users!.displayName);
      print(users!.email);
      print(users!.phoneNumber);    }
  }
  //logout
  void logOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      Get.snackbar("Account LogOut", "Welcome");
    } catch (ex) {
      Get.snackbar("Something Wrong", "$ex");
    }
  }
   late final TextEditingController email , password, username ,phone;

   RxBool isLoading = false.obs;

  //sign up
  Future registerWithEmail(context) async {

    try {
      isLoading.value = true;
      update();
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      if(userCredential.user!=null){
        final user = userCredential.user;

        String? displayName = user?.displayName ?? user?.email!;
        String email = user?.email ?? "";
        String id = user?.uid ?? "";
        String photoUrl = user?.photoURL ?? "";

        Users userProfile = Users();

        userProfile.email = email;
        userProfile.accessToken = id;
        userProfile.displayName = displayName;
        userProfile.photoUrl = photoUrl;
        UserStore.t0.saveProfile(userProfile);

        var userbase = await db.collection('users').withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData userdata,options)=>userdata.toFirestore(),).where('id', isEqualTo:id ).get();
        if(userbase.docs.isEmpty){
          final data = UserData(
            id: id,
            name: displayName,
            email: email,
            photoUrl: photoUrl,
            location: "",
            fcmtoken: "",
            addtime: Timestamp.now(),
          );
          await db.collection('users').withConverter(
            fromFirestore: UserData.fromFirestore,
            toFirestore: (UserData userdata,options)=>userdata.toFirestore(),).add(data);
        }

        showSnackbar(context, Colors.green, 'Login Success');
        Get.offAll(()=>AddInfoScreen());
      }
      else{
        // User was not created successfully
        showSnackbar(context, Colors.red, "User created failed");

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
      return error.message;
    }
    isLoading.value = false;
    update();
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