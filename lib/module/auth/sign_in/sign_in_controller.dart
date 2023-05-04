import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darak_project/model/user.dart';
import 'package:darak_project/module/main/layout/layout_screen.dart';
import 'package:darak_project/services/common/user_store.dart';
import 'package:darak_project/widgets/components/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes:<String> [
    'openid'
  ]
);
class SignInController extends GetxController{

  late final TextEditingController email , password;

  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> signInGoogle(context) async {
    try {
      var user = await _googleSignIn.signIn();
      if(user!=null){

        final _gAuth = await user.authentication;
        final _credential = GoogleAuthProvider.credential(
          idToken: _gAuth.idToken,
          accessToken: _gAuth.accessToken,
        );
        await FirebaseAuth.instance.signInWithCredential(_credential);

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
        Get.to(()=>LayoutScreen());
      }

    }catch(e){
      showSnackbar(context, Colors.red, e.toString());
      print(e.toString());
    }
  }

  @override
  onReady(){
    super.onReady();
    FirebaseAuth.instance.authStateChanges().listen((User? user) { 
      if(user==null){
        print('User is currently logged out');

      }else{
        print('User logged in');
      }
    });
  }

  login(context) async {
        isLoading = true;
        update();
      try {
        final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        if (userCredential.user != null) {
          // User was created successfully
          Get.to(()=> LayoutScreen());
        } else {
          // User was not created successfully
          showSnackbar(context, Colors.red, "User created failed");
            isLoading = false;
            update();
        }
      } catch (error) {
        // Handle any errors that occur during sign up
        showSnackbar(context, Colors.red, error.toString());
          isLoading = false;

    }
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