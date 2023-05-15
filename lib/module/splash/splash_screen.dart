import 'package:darak_project/module/customer/auth/sign_in/sign_in_screen.dart';
import 'package:darak_project/module/splash/splash_controller.dart';
import 'package:darak_project/module/worker/addInfo/add_info_screen.dart';
import 'package:darak_project/module/worker/sign_in/sign_in_screen.dart';
import 'package:darak_project/services/common/config.dart';
import 'package:darak_project/widgets/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GetBuilder<SplashController>(
            builder: (controller) => Scaffold(
                  body:  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        D_MaterialButton(
                            onPressed: () {
                              ConfigStore.to.saveAlreadyOpen();
                              Get.offAll(()=>SignInScreen());
                            },

                            child:  Text('Sign In as a Customer',style: buildTextStyleBtn(),), width: double.infinity

                        ),
                        SizedBox(height: 20.h,),
                        D_MaterialButton(
                            onPressed: () {
                              ConfigStore.to.saveAlreadyOpen();
                              Get.offAll(()=>SignInScreen());
                            },

                            child:  Text('Sign In as a Worker',style: buildTextStyleBtn(),), width: double.infinity

                        ),
                      ],
                    ),
                  ),
                )
        )
    );
  }
}
