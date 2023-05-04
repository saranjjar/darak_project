

import 'package:darak_project/module/auth/forget_password/forget_password_controller.dart';
import 'package:darak_project/module/auth/forget_password/verification/reset_password/reset_password_controller.dart';
import 'package:darak_project/module/auth/sign_in/sign_in_controller.dart';
import 'package:darak_project/module/auth/sign_up/sign_up_controller.dart';
import 'package:darak_project/module/auth/forget_password/verification/verification_controller.dart';
import 'package:darak_project/module/main/chat/chat_controller.dart';
import 'package:darak_project/module/main/chat/chat_history/chat_history_controller.dart';
import 'package:darak_project/module/main/chat/in_chat/inchat_controller.dart';
import 'package:darak_project/module/main/home/home_controller.dart';
import 'package:darak_project/module/main/home/home_screen.dart';
import 'package:darak_project/module/main/settings/settings_controller.dart';
import 'package:darak_project/module/splash/splash_controller.dart';
import 'package:darak_project/services/common/config.dart';
import 'package:darak_project/services/common/user_store.dart';
import 'package:get/get.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => SplashController(),);
    Get.lazyPut(() => SignUpController(), fenix: true);
    Get.lazyPut(() => SignInController(), fenix: true);
    Get.lazyPut(() => ForgetPasswordController(), fenix: true);
    Get.lazyPut(() => VerificationController(), fenix: true);
    Get.lazyPut(() => ResetController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => ConfigStore(), fenix: true);
    Get.lazyPut(() => ChatController(), fenix: true);
    Get.lazyPut(() => SettingsController(), fenix: true);
    Get.lazyPut(() => InChatController(), fenix: true);
    Get.lazyPut(() => ChatHistoryController(), fenix: true);
  }
}