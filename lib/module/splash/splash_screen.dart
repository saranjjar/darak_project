import 'package:darak_project/module/auth/sign_in/sign_in_screen.dart';
import 'package:darak_project/module/splash/splash_controller.dart';
import 'package:darak_project/services/common/config.dart';
import 'package:darak_project/widgets/components/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';



class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GetBuilder<SplashController>(
            builder: (controller) => Scaffold(
                  body:  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: D_MaterialButton(
                          onPressed: () {
                            ConfigStore.to.saveAlreadyOpen();
                            Get.offAll(()=>SignInScreen());
                          },

                          child: const Text('Sign In'), width: double.infinity

                      ),
                    ),
                  ),
                )
        )
    );
  }
}
