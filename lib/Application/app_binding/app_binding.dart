
import 'package:darak_project/module/customer/auth/forget_password/forget_password_controller.dart';
import 'package:darak_project/module/customer/auth/forget_password/verification/reset_password/reset_password_controller.dart';
import 'package:darak_project/module/customer/auth/forget_password/verification/verification_controller.dart';
import 'package:darak_project/module/customer/auth/sign_in/sign_in_controller.dart';
import 'package:darak_project/module/customer/auth/sign_up/sign_up_controller.dart';
import 'package:darak_project/module/customer/main/chat/chat_controller.dart';
import 'package:darak_project/module/customer/main/chat/chat_history/chat_history_controller.dart';
import 'package:darak_project/module/customer/main/chat/in_chat/inchat_controller.dart';
import 'package:darak_project/module/customer/main/home/categories/categories_controller.dart';
import 'package:darak_project/module/customer/main/home/categories/profile_category/profile_category_controller.dart';
import 'package:darak_project/module/customer/main/home/home_controller.dart';
import 'package:darak_project/module/customer/main/settings/settings_controller.dart';
import 'package:darak_project/module/splash/splash_controller.dart';
import 'package:darak_project/module/worker/addInfo/add_info_controller.dart';
import 'package:darak_project/module/worker/forget_password/forget_password_controller.dart';
import 'package:darak_project/module/worker/forget_password/verification/reset_password/reset_password_controller.dart';
import 'package:darak_project/module/worker/forget_password/verification/verification_controller.dart';
import 'package:darak_project/module/worker/sign_in/sign_in_controller.dart';
import 'package:darak_project/module/worker/sign_up/sign_up_controller.dart';
import 'package:darak_project/services/common/config.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

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
    Get.lazyPut(() => PhotoViewController(), fenix: true);
    Get.lazyPut(() => CategoriesController(), fenix: true);
    Get.lazyPut(() => ProfileCategoryController(), fenix: true);

    //worker
    Get.lazyPut(() => SignUpWoController(), fenix: true);
    Get.lazyPut(() => SignInWoController(), fenix: true);
    Get.lazyPut(() => ForgetPasswordWoController(), fenix: true);
    Get.lazyPut(() => VerificationWoController(), fenix: true);
    Get.lazyPut(() => ResetWoController(), fenix: true);
    Get.lazyPut(() => AddInfoController(), fenix: true);

  }
}