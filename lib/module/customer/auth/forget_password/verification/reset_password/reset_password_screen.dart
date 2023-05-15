import 'package:darak_project/Application/app_router/app_router.dart';
import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:darak_project/module/customer/auth/forget_password/verification/reset_password/reset_password_controller.dart';
import 'package:darak_project/widgets/components/components.dart';
import 'package:darak_project/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(ResetController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 40;

    return Scaffold(
      backgroundColor: ColorHelper.light1,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: const Icon(Icons.arrow_back,)),
                  SizedBox(height: 20.h,),
                  Text(TextHelper.newPass,style: TextStyle(
                    fontFamily: TextHelper.satoshiBold,
                    fontSize: 20
                  ),),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(TextHelper.newPassP,style: TextStyle(
                    fontFamily: TextHelper.satoshiRegular,
                    fontSize: 16
                  ),),
                  SizedBox(
                    height: 20.h,
                  ),
                  Obx(() => TextFormFieldCustom(
                    textEditingController: controller.passController,
                    keyboardType: TextInputType.text,
                    hintText: 'Enter new password'.tr,
                    maxline: 1,
                    obscureText: !controller.isvisiable.value,
                    suffixIcon: InkWell(
                      onTap: (){
                        controller.changeVisiability();
                      },
                      child: controller.isvisiable.value?const Icon(Icons.visibility_off):const Icon(Icons.visibility) ,
                    ),
                    validator: (value){
                      if(value!.isEmpty) {
                        return 'must enter value'.tr;
                      }
                    },
                  ),),
                  SizedBox(
                    height: 20.h,
                  ),
                  Obx(() => TextFormFieldCustom(
                    textEditingController: controller.confirmpassController,
                    keyboardType: TextInputType.text,
                    hintText: 'Enter Confirm new password',
                    maxline: 1,
                    obscureText: !controller.isvisiable.value,
                    suffixIcon: InkWell(
                      onTap: (){
                        controller.changeVisiability();
                      },
                      child:
                      controller.isvisiable.value
                          ?
                      const Icon(Icons.visibility_off)
                          :
                      const Icon(Icons.visibility) ,
                    ),
                    validator: (value){
                      if(value!.isEmpty) {
                        return 'must enter value';
                      }
                    },
                  ),),
                  SizedBox(
                    height: 20.h,
                  ),
                  D_MaterialButton(
                      color: ColorHelper.primaryColor,
                      onPressed: (){
                        if(_formKey.currentState!.validate()) {
                          return Get.offAllNamed(Routes.layoutRoute);
                        }
                      }, child:  Text(
                    'Done',
                    style: buildTextStyleBtn(),
                  ), width: width),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
