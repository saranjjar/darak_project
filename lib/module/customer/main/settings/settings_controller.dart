import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../const.dart';
import '../../../../model/user.dart';
import '../../../../services/common/shared_pref.dart';
import '../../../../services/common/user_store.dart';
import '../home/categories/profile_category/profile_category_controller.dart';

class SettingsController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  bool isSwitchedNo = false;

  onChangedNo(value) {
    isSwitchedNo = value;
    update();
    print(isSwitchedNo);
  }

  bool isSwitchedMo = false;

  onChangedMo(value) {
    isSwitchedMo = value;
    update();
    print(isSwitchedMo);
  }
}

class GetUserName extends GetxController {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  // final String documentId;
  final FirebaseFirestore profile = FirebaseFirestore.instance;
  RxList<QueryDocumentSnapshot<UserData>> prof =
      RxList<QueryDocumentSnapshot<UserData>>([]);
  var docId = null;
  final user_id = UserStore.t0.token;
  RxString fullName = ''.obs;
  RxString phone = ''.obs;
  RxString email = ''.obs;
  final token = UserStore.t0.token;

  @override
  void onInit() {
    super.onInit();
    docId = StorageService.to.getString(Constants.STRORAGE_DOC_UID);
    // fetchUserName();
  }

  String userName = '';

  Future<void> fetchUserName() async {
    // try {
    // var fromBooking = await profile.collection("users").withConverter(
    //     fromFirestore: BookingReview.fromFirestore,
    //     toFirestore: (BookingReview book,options)=>book.toFirestore()).where(
    //     "toUid",isEqualTo:token
    // ).get();
    // final snapshot =
    //       await profile.collection('users').where('id', isEqualTo: token).get();
    //   final userData = snapshot.docs.map((e) => UserData.fromSnapshot(e)).single;
    //
    //   CollectionReference categoryRef = profile.collection('users');
    //
    //   var subcategoriesSnapshot = await categoryRef
    //       .withConverter(
    //           fromFirestore: UserData.fromFirestore,
    //           toFirestore: (UserData subCategory, options) =>
    //               subCategory.toFirestore())
    //       .where("id", isEqualTo: token)
    //       .get();
    //   final DocumentSnapshot<Map<String, dynamic>> document =
    //       await profile.collection('users').doc(docId).get();
    //   print("$document +111");
    //
    //   if (!subcategoriesSnapshot.docs.isNotEmpty) {
    //     fullName.value = 'Document does not exist';
    //     phone.value = 'noooooooooo';
    //   } else {
    //     prof.assignAll(subcategoriesSnapshot.docs);
    //
    //     // // Review.clear();
    //     // // Review.assignAll(subcategoriesSnapshot.docs);
    //     // // //
    //     // // // isLoading.value = false;
    //     // final data = document.data();
    //     // fullName.value = '${data?['name']}';
    //     // email.value = '${data?['email']}';
    //     // phone.value = '${data?['photourl']}';
    //   }
    // } catch (e) {
    //   fullName.value = 'Something went wrong';
    //   phone.value = 'Something went wrong';
    //   print('Error fetching user name: $e');
    // }
    final userQuerySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: token)
        .get();
    if (userQuerySnapshot.docs.isNotEmpty) {
      final userDocument = userQuerySnapshot.docs.first;
      userName = userDocument['name'];
      email = userDocument['email'];
      print('User Name: $userName' 'User email: $email');
      update();
    }
  }

  Future<void> updateUserName(
    String newName,
    String docId,
  ) async {
    CustomFullScreenDialog.showDialog();
    await FirebaseFirestore.instance.collection('users').doc(docId).update({
      userName: newName,
    }).whenComplete(() {
      CustomFullScreenDialog.cancelDialog();
      clearEditingController();
      Get.back();
    }).catchError((e) {
      CustomFullScreenDialog.cancelDialog();
      clearEditingController();
    });
    // final userDocument = userQuerySnapshot.docs.first;
    // final userDocumentRef =
    //     FirebaseFirestore.instance.collection('users').doc(userDocument.id);
    //
    // await userDocumentRef.update({
    //   'name': newName,
    //   'email': 'newemail@example.com',
    // });
    // userName = userDocument['name'];
    // //   final DocumentReference documentRef =
    // //       profile.collection('users').doc(docId);
    // //
    // //   await documentRef.update({
    // //     'name': newName,
    // //   });
    // //
    // //   fullName.value = '$newName';
    // // } catch (e) {
    // //   print('Error updating user name: $e');
    // // }
  }

  Future<void> updateUserPhone(String newPhone) async {
    try {
      final DocumentReference documentRef =
          profile.collection('users').doc(docId);

      await documentRef.update({'photourl': newPhone});
      clearEditingController();
      Get.back();

      phone.value = 'Phone: $newPhone';
    } catch (e) {
      print('Error updating user name: $e');
    }
  }

  Future<void> updateUserEmail(
    String newEmail,
  ) async {
    try {
      final DocumentReference documentRef =
          profile.collection('users').doc(docId);

      await documentRef.update({
        'email': newEmail,
      });

      fullName.value = 'email: $newEmail';
    } catch (e) {
      print('Error updating user name: $e');
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    fullNameController.dispose();
    phoneController.dispose();
  }

  void clearEditingController() {
    fullNameController.clear();
    phoneController.clear();
  }
}
