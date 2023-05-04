// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:open_market_project/Api/Repo/users/change_pass_repo.dart';
// import 'package:open_market_project/model/user.dart';
//
// class ChangePassController extends GetxController {
//
//
//   TextEditingController oldPassController = TextEditingController();
//   TextEditingController newPassController = TextEditingController();
//   TextEditingController confirmPassController = TextEditingController();
//
//   @override
//   void onInit() {
//     super.onInit();
//     oldPassController = TextEditingController();
//     newPassController = TextEditingController();
//     confirmPassController = TextEditingController();
//   }
//
//
//   bool _isLoadingRequest = false;
//
//
//   void apiChangePass() async {
//     try {
//       _isLoadingRequest = true;
//       update();
//       TUser res = await ChangePassRepo.instance.changePass(
//         oldPass: oldPassController.text,
//         newPass: newPassController.text,
//         cnewPass: confirmPassController.text,
//       );
//       if (res.status!) {
//         Get.snackbar(
//           '', '${res.message}',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.green,
//         );
//
//       } else {
//         Get.snackbar(
//           '', '${res.message}',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//         );
//       }
//       _isLoadingRequest = false;
//       update();
//     } catch (error) {
//
//     }
//   }
//
//
// }