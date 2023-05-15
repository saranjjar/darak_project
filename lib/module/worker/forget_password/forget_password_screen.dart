import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:darak_project/module/worker/forget_password/forget_password_controller.dart';
import 'package:darak_project/widgets/components/components.dart';
import 'package:darak_project/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(ForgetPasswordWoController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 40;

    return Scaffold(
      backgroundColor: ColorHelper.light1,
      //appBar: customAppBar(),
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
                       child: const Icon(Icons.clear,)),
                   SizedBox(height: 20.h,),
                   Text(
                    'Forget Password?',
                  style: TextStyle(
                    fontFamily: TextHelper.satoshiBold,
                    fontSize: 20
                  ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    TextHelper.forgPass,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: TextHelper.satoshiRegular
                  ),
                  ),
                  SizedBox(height: 30.h,),
                  TextFormFieldCustom(
                    textEditingController: controller.number,
                    keyboardType: TextInputType.number,
                    hintText: 'Enter your phone',
                    validator: (value){
                      if(value!.isEmpty) {
                        return 'must enter value';
                      }
                    },
                  ),
                  SizedBox(height: 30.h,),
                  D_MaterialButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate()) {
                          return controller.singUpWithNumber();
                        }
                      }, child:  Text(
                    'Continue',style: buildTextStyleBtn(),

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
