
import 'package:darak_project/module/book_details/book_details_controller.dart';
import 'package:darak_project/module/book_details/location_details/location_details_controller.dart';
import 'package:darak_project/module/customer/customer_auth/customer_sign_in/sign_in_customer_controller.dart';
import 'package:darak_project/module/customer/customer_auth/customer_sign_up/sign_up_customer_controller.dart';
import 'package:darak_project/module/customer/customer_auth/forget_customer_password/customer_verification/reset_customer_password/reset_password_customer_controller.dart';
import 'package:darak_project/module/customer/customer_auth/forget_customer_password/customer_verification/verification_customer_controller.dart';
import 'package:darak_project/module/customer/customer_auth/forget_customer_password/forget_password_customer_controller.dart';
import 'package:darak_project/module/customer/main/booking/booking_controller.dart';
import 'package:darak_project/module/customer/main/chat/chat_controller.dart';
import 'package:darak_project/module/customer/main/chat/chat_history/chat_history_controller.dart';
import 'package:darak_project/module/customer/main/chat/in_chat/inchat_controller.dart';
import 'package:darak_project/module/customer/main/home/categories/categories_controller.dart';
import 'package:darak_project/module/customer/main/home/categories/profile_category/profile_category_controller.dart';
import 'package:darak_project/module/customer/main/home/home_controller.dart';
import 'package:darak_project/module/customer/main/settings/settings_controller.dart';
import 'package:darak_project/module/customer/main/worker_home/worker_home_controller.dart';
import 'package:darak_project/module/splash/splash_controller.dart';
import 'package:darak_project/module/worker/addInfo/add_info_controller.dart';
import 'package:darak_project/module/worker/worker_forget_password/forget_password_worker_controller.dart';
import 'package:darak_project/module/worker/worker_forget_password/worker_verification/verification_worker_controller.dart';
import 'package:darak_project/module/worker/worker_forget_password/worker_verification/worker_reset_password/reset_password_worker_controller.dart';
import 'package:darak_project/module/worker/worker_sign_in/sign_in_worker_controller.dart';
import 'package:darak_project/module/worker/worker_sign_up/sign_up_worker_controller.dart';
import 'package:darak_project/services/common/config.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(),fenix: true);
    Get.lazyPut(() => SignUpController(), fenix: true);
    Get.lazyPut(() => SignInController(), fenix: true);
    Get.lazyPut(() => ForgetPasswordController(), fenix: true);
    Get.lazyPut(() => VerificationController(), fenix: true);
    Get.lazyPut(() => ResetController(), fenix: true);
    Get.put(() => HomeController(), permanent: true);
    Get.lazyPut(() => WorkerHomeController(), fenix: true);
    Get.lazyPut(() => ConfigStore(), fenix: true);
    Get.lazyPut(() => ChatController(), fenix: true);
    Get.lazyPut(() => SettingsController(), fenix: true);
    Get.lazyPut(() => InChatController(), fenix: true);
    Get.lazyPut(() => ChatHistoryController(), fenix: true);
    Get.lazyPut(() => PhotoViewController(), fenix: true);
    Get.lazyPut(() => CategoriesController(), fenix: true);
    Get.lazyPut(() => ProfileCategoryController(), fenix: true);
    Get.lazyPut(() => BookDetailsController(), fenix: true);
    Get.lazyPut(() => LocationDetailsController(), fenix: true);
    Get.lazyPut(() => BookDetailsController(), fenix: true);
    Get.lazyPut(() => BookingController(), fenix: true);

    //worker
    Get.lazyPut(() => SignUpWoController(), fenix: true);
    Get.lazyPut(() => SignInWoController(), fenix: true);
    Get.lazyPut(() => ForgetPasswordWoController(), fenix: true);
    Get.lazyPut(() => VerificationWoController(), fenix: true);
    Get.lazyPut(() => ResetWoController(), fenix: true);
    Get.lazyPut(() => AddInfoController(), fenix: true);

  }
}