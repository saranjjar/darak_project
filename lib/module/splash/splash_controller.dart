import 'dart:async';
import 'package:darak_project/Application/app_router/app_router.dart';
import 'package:darak_project/services/common/user_store.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    await startDelay();

    super.onInit();
  }

  Timer? _timer;
  startDelay() {
    _timer = Timer(const Duration(seconds: 5), routeScreen);
  }

  routeScreen(){
    if(UserStore.t0.isLogin==true){

      Get.offAllNamed(Routes.layoutRoute);
    }else if (UserStore.t0.isLogin==false){
      Get.offAllNamed(Routes.signInRoute);
    }
  }
}