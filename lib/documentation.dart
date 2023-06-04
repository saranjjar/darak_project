///**Authentication
///1.Sign In
///   login(context) async {
//         isLoading.value = true;
//       try {
//         final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//           email: email.text,
//           password: password.text,
//         );
//         if (userCredential.user != null) {
//           // User was created successfully
//
//           final user = userCredential.user;
//           String email = user?.email ?? "";
//           String id = user?.uid ?? "";
//           String photoUrl = user?.photoURL ?? "";
//           Users userProfile = Users();
//           userProfile.email = email;
//           userProfile.accessToken = id;
//           //userProfile.displayName = displayName;
//           userProfile.photoUrl = photoUrl;
//           UserStore.t0.saveProfile(userProfile);
//           await StorageService.to.setString(Constants.STRORAGE_DEVICE_CUSTO_WORK_KEY, 'CUSTOMER');
//           Get.offAllNamed(Routes.layoutRoute);
//         }
//          else {
//           // User was not created successfully
//           showSnackbar(context, Colors.red, "User created failed");
//
//         }
//       } catch (error) {
//         // Handle any errors that occur during sign up
//         showSnackbar(context, Colors.red, error.toString());
//     }
//     isLoading.value = false;
//   }
///
///2.SignUp with gmail
///   Future<void> signInGoogle(context) async {
//
//     try {
//       isLoading.value = true;
//       update();
//
//       var user = await _googleSignIn.signIn();
//       if(user!=null){
//
//         final gAuth = await user.authentication;
//         final credential = GoogleAuthProvider.credential(
//           idToken: gAuth.idToken,
//           accessToken: gAuth.accessToken,
//         );
//         await FirebaseAuth.instance.signInWithCredential(credential);
//
//         String displayName = user.displayName!;
//         String email = user.email;
//         String id = user.id;
//         String photoUrl = user.photoUrl ?? "";
//
//         Users userProfile = Users();
//
//         userProfile.email = email;
//         userProfile.accessToken = id;
//         userProfile.displayName = displayName;
//         userProfile.photoUrl = photoUrl;
//         UserStore.t0.saveProfile(userProfile);
//
//         var userbase = await db.collection('users').withConverter(
//           fromFirestore: UserData.fromFirestore,
//           toFirestore: (UserData userdata,options)=>userdata.toFirestore(),).where('id', isEqualTo:id ).get();
//         if(userbase.docs.isEmpty){
//
//           final data = UserData(
//             id: id,
//             name: displayName,
//             email: email,
//             photoUrl: photoUrl,
//             location: "",
//             fcmtoken: "",
//             addtime: Timestamp.now(),
//           );
//           await db.collection('users').withConverter(
//             fromFirestore: UserData.fromFirestore,
//             toFirestore: (UserData userdata,options)=>userdata.toFirestore(),).add(data);
//         }
//
//         showSnackbar(context, Colors.green, 'Login Success');
//         await StorageService.to.setString(Constants.STRORAGE_DEVICE_CUSTO_WORK_KEY, 'CUSTOMER');
//         Get.offAll(()=>LayoutScreen());
//       }
//
//     }catch(e){
//       showSnackbar(context, Colors.red, e.toString());
//       isLoading.value = false;
//       if (kDebugMode) {
//         print(e.toString());
//       }
//     }
//     isLoading.value = false;
//     update();
//   }
///3.Verification Phone Number
///void singUpWithNumber() async {
//   try {
//     await auth.verifyPhoneNumber(
//       phoneNumber: '+970${number.text}',
//       verificationCompleted: (PhoneAuthCredential credential) {
//         if (kDebugMode) {
//           print(credential);
//         }
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         if (kDebugMode) {
//           print(e);
//         }
//       },
//       codeSent: (String verificationId, int? resendToken) {
//         verifyId = verificationId;
//         Get.snackbar(
//             "OTP Sent", "Otp sent on your mobile number ${number.text}");
//         Get.to(PinCodeVerificationScreen());
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {},
//     );
//   } catch (ex) {
//     Get.snackbar("$ex", "");
//     if (kDebugMode) {
//       print(ex);
//     }
//   }
// }
/// void verifyMobileNumber(String verificationCode) async {
//   try {
//     PhoneAuthCredential credential = PhoneAuthProvider.credential(
//       verificationId: verifyId,
//       smsCode: verificationCode,
//
//     );
//     await auth.signInWithCredential(credential);
//     Get.snackbar("OTP Versified", "Welcome to Flutter app");
//     Get.offAllNamed(Routes.resetRoute);
//   } catch (ex) {
//     if (kDebugMode) {
//       print(ex);
//     }
//   }
// }
///
/// 4.Sign Up with email
///   Future registerWithEmail(context) async {
//
//     try {
//       isLoading.value = true;
//       update();
//       final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//           email: email.text.trim(), password: password.text.trim());
//       if(userCredential.user!=null){
//         final user = userCredential.user;
//
//         String? displayName = username.text;
//         String email = user?.email ?? "";
//         String id = user?.uid ?? "";
//         String photoUrl = user?.photoURL ?? "";
//
//         Users userProfile = Users();
//
//         userProfile.email = email;
//         userProfile.accessToken = id;
//         userProfile.displayName = displayName;
//         userProfile.photoUrl = photoUrl;
//         UserStore.t0.saveProfile(userProfile);
//
//         var userbase = await db.collection('users').withConverter(
//           fromFirestore: UserData.fromFirestore,
//           toFirestore: (UserData userdata,options)=>userdata.toFirestore(),).where('id', isEqualTo:id ).get();
//         if(userbase.docs.isEmpty){
//           final data = UserData(
//             id: id,
//             name: displayName,
//             email: email,
//             photoUrl: photoUrl,
//             location: "",
//             fcmtoken: "",
//             addtime: Timestamp.now(),
//           );
//           await db.collection('users').withConverter(
//             fromFirestore: UserData.fromFirestore,
//             toFirestore: (UserData userdata,options)=>userdata.toFirestore(),).add(data);
//         }
//         showSnackbar(context, Colors.green, 'Login Success');
//         await StorageService.to.setString(Constants.STRORAGE_DEVICE_CUSTO_WORK_KEY, 'CUSTOMER');
//         Get.offAllNamed(Routes.layoutRoute);
//       }
//       else{
//         // User was not created successfully
//         showSnackbar(context, Colors.red, "User created failed");
//         isLoading.value = false;
//
//       }
//     } on FirebaseAuthException catch (error) {
//       isLoading.value = false;
//       String message='error occurred';
//       // Handle any errors that occur during sign up
//       if(error.code=='weak-password'){
//         message='The password provided is too weak.';
//       }else if(error.code=='email-already-in-use'){
//         message='The account already exists for that email.';
//       }
//       showSnackbar(context, Colors.red, message);
//       return error.message;
//     }
//     isLoading.value = false;
//   }
/// 5.SignUp with Facebook
///   Future<UserCredential> signInWithFacebook() async {
//     // Trigger the sign-in flow
//     final LoginResult loginResult = await FacebookAuth.instance.login();
//
//     // Create a credential from the access token
//     final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
//
//     // Once signed in, return the UserCredential
//     return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
//   }
/// 6. Logout
///   void logOut() async {
//     try {
//       await _googleSignIn.signOut();
//       await _auth.signOut();
//       UserStore.t0.onLogout();
//       await StorageService.to.remove(Constants.STRORAGE_DEVICE_CUSTO_WORK_KEY);
//       Get.offAllNamed(Routes.signInRoute);
//
//       Get.snackbar("Account LogOut", "Welcome");
//     } catch (ex) {
//       Get.snackbar("Something Wrong", "$ex");
//     }
//   }
///
///*** Chat (FireStore)
///
/// 1.Send Text Msg
///   sendMessage() async{
//     String sendContent = textController.text;
//     final content = MsgContent(
//       uid: user_id,
//       content: sendContent,
//       type: "text",
//       addtime: Timestamp.now()
//     );
//     await db.collection('message').doc(doc_id).collection('msglist').withConverter(
//         fromFirestore: MsgContent.fromFirestore,
//         toFirestore: (MsgContent msgContent,options)=>msgContent.toFirestore()
//     ).add(content).then((DocumentReference doc) {
//       textController.clear();
//       Get.focusScope?.unfocus();
//     });
//
//     await db.collection("message").doc(doc_id).update(
//       {
//         "last_msg":sendContent,
//         "last_time":Timestamp.now()
//       }
//     );
//   }
/// 2.Send Image Msg
///  sendImageMessage(String url) async{
//     final content = MsgContent(
//         uid: user_id,
//         content: url,
//         type: "image",
//         addtime: Timestamp.now()
//     );
//     await db.collection('message').doc(doc_id).collection('msglist').withConverter(
//         fromFirestore: MsgContent.fromFirestore,
//         toFirestore: (MsgContent msgContent,options)=>msgContent.toFirestore()
//     ).add(content).then((DocumentReference doc) {
//       textController.clear();
//       Get.focusScope?.unfocus();
//     });
//
//     await db.collection("message").doc(doc_id).update(
//         {
//           "last_msg":" [image] ",
//           "last_time":Timestamp.now()
//         }
//     );
//   }
///
/// ***Map to set Location
///   void getCurrentLocation() async {
//     LocationData locationData;
//     var location = Location();
//
//     try {
//       locationData = await location.getLocation();
//     } catch (e) {
//       print('Error getting location: $e');
//       return;
//     }
//
//     LatLng location = LatLng(locationData.latitude, locationData.longitude);
//     currentLocation.value = location;
//     updateMarkerPosition(location);
//     mapController.animateCamera(CameraUpdate.newLatLng(location));
//   }
//
//   void updateMarkerPosition(LatLng location) {
//     marker.value = Marker(
//       markerId: MarkerId('currentLocation'),
//       position: location,
//     );
//   }
// }
///
///*** Booking
///
///   Future<void> sendBookingReview() async {
//     try {
//       // Create a new document in the "requests" collection
//       final content = BookingReview(
//           uid: user_id,
//           toUid: toUid,
//           nameCustomer:  userName,
//           serviceName: serviceName,
//           subServiceName: subServiceName,
//           date: date,
//           time:time,
//           status: 'pending',
//           worker: worker,
//           workingHours: workingHour,
//           price: price,
//           location: location,
//       );
//           await db
//               .collection('booking')
//               .withConverter(
//               fromFirestore: BookingReview.fromFirestore,
//               toFirestore: (BookingReview bookingReview, options) =>
//                   bookingReview.toFirestore())
//               .add(content)
//               .then((DocumentReference doc) {
//             Get.focusScope?.unfocus();
//           });
//     }catch(e){
//       print(e.toString());
//       isLoading.value=false;
//
//     }
//       isLoading.value = false;
//
//   }
///
///*** getCategories
///   getCategory() async{
//     isLoading = true;
//     update();
//     var category = await db.collection("category").withConverter(
//         fromFirestore: Category.fromFirestore,
//         toFirestore: (Category ctg,options)=>ctg.toFirestore()).get();
//
//     categoryList.clear();
//     if(category.docs.isNotEmpty){
//       categoryList.assignAll(category.docs);
//     }
//     isLoading = false;
//     update();
//   }
///
///*** add Worker to category
///   addInfoWorker({required String subcategoryID}) async {
//     isLoadingRequest.value = true;
//     final information = SubCategory(
//       id: accessToken,
//       username: usernameController.text,
//       price: priceController.text,
//       location: locationController.text,
//       bio: bioController.text,
//       idNumber: IDController.text,
//       mobile: mobileController.text,
//       email: emailController.text??"",
//       photo: imgUrl,
//       service: subcategoryID,
//       subService: subService.text,
//
//     );
//
//     await db.collection('category').doc(subcategoryID).collection(
//         'sub_category').withConverter(
//         fromFirestore: SubCategory.fromFirestore,
//         toFirestore: (SubCategory subCategory, options) =>
//             subCategory.toFirestore()
//     ).add(information).then((DocumentReference doc) {
//       Get.focusScope?.unfocus();
//     });
//     await db.collection('FavService').withConverter(
//         fromFirestore: SubCategory.fromFirestore,
//         toFirestore: (SubCategory subCategory, options) =>
//             subCategory.toFirestore()
//     ).add(information).then((DocumentReference doc) {
//       Get.focusScope?.unfocus();
//     });
//     _controllerFavSer.asyncLoadAllData();
//     reset();
//       await StorageService.to.setString(Constants.STRORAGE_DEVICE_CUSTO_WORK_KEY, 'Worker');
//     isLoadingRequest.value = false;
//     Get.offNamed(Routes.layoutRoute);
//     }
///
///*** add service to booking(pending list)
///
///   Future<void> asyncLoadPendingBook() async{
//     try{
//       isLoading = true;
//       update();
//       var fromBooking = await db.collection("booking").withConverter(
//           fromFirestore: BookingReview.fromFirestore,
//           toFirestore: (BookingReview book,options)=>book.toFirestore()).where(
//           "uid",isEqualTo:token
//       ).where('status',isEqualTo: 'pending').get();
//
//       if(fromBooking.docs.isNotEmpty){
//         bookingList.assignAll(fromBooking.docs);
//       }
//
//       isLoading = false;
//       update();
//     }catch(error){
//       print(error.toString());
//       isLoading = false;
//       update();
//     }
//   }
///***Payment method(paypal)
/// Future<void> initiatePayment() async {
//     try {
//       // Initialize the PayPal SDK with your credentials
//       await _paypalSdk.initialize(
//         clientId: 'YOUR_PAYPAL_CLIENT_ID',
//         environment: PayPalEnvironment.sandbox,
//       );
//
//       final PayPalPayment payment = PayPalPayment(
//         amount: '10.0',
//         currency: 'USD',
//         shortDescription: 'Payment description',
//         intent: PayPalPaymentIntent.sale,
//       );
//
//       final PayPalResult result = await _paypalSdk.presentPaymentDialog(payment);
//
//       if (result.status == PayPalStatus.success) {
//         print('Payment successful');
//       } else {
//         print('Payment canceled or failed');
//       }
//     } catch (e) {
//       print('Error during payment: $e');
//     }
//   }
// }
///***worker add service
///  Future<void> asyncLoadAllData() async{
//     try{
//       isLoading = true;
//       update();
//       var service = await db.collection('FavService').withConverter(
//           fromFirestore: SubCategory.fromFirestore,
//           toFirestore: (SubCategory subCategory,options)=>subCategory.toFirestore()).where(
//           "id",isEqualTo:token
//       ).get();
//       if(service.docs.isNotEmpty){
//         serviceList.assignAll(service.docs);
//       }
//       isLoading = false;
//       update();
//     }catch(error){
//       print(error.toString());
//       isLoading = false;
//       update();
//     }
//   }
