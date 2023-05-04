import 'dart:async';
import 'package:darak_project/const.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit()  {
    //await startDelay();
    print('${Constants.STRORAGE_DEVICE_FIRST_OPEN_KEY} ***************************************');
    super.onInit();
  }

  Timer? _timer;
  startDelay() {
    //_timer = Timer(Duration(seconds: 5), _goNext);
  }

  // _goNext() {
  //   Get.off(()=>SignInScreen());
  // }
}