import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetController extends GetxController{


  late TextEditingController passController,confirmpassController;


  @override
  void onInit() {
    passController = TextEditingController();
    confirmpassController = TextEditingController();
    super.onInit();
  }

  RxBool isvisiable = false.obs;

  changeVisiability(){

    isvisiable.value =! isvisiable.value;
  }

  void reset(){
    passController.clear();
    confirmpassController.clear();
    update();

  }
}