
import 'package:darak_project/module/ads/ads_screen.dart';
import 'package:darak_project/module/book_details/book_details_screen.dart';
import 'package:darak_project/module/book_details/booking_review/booking_review_screen.dart';
import 'package:darak_project/module/book_details/location_details/location_details_screen.dart';
import 'package:darak_project/module/book_details/payment_method/payment_method_screen.dart';
import 'package:darak_project/module/customer/customer_auth/customer_sign_in/sign_in_customer_screen.dart';
import 'package:darak_project/module/customer/customer_auth/customer_sign_up/sign_up_customer_screen.dart';
import 'package:darak_project/module/customer/customer_auth/forget_customer_password/forget_password_customer_screen.dart';
import 'package:darak_project/module/onboarding/onboarding_screen.dart';
import 'package:darak_project/module/splash/splash_screen.dart';
import 'package:darak_project/module/worker/addInfo/add_info_screen.dart';
import 'package:darak_project/module/worker/worker_forget_password/forget_password_worker_screen.dart';
import 'package:darak_project/module/worker/worker_forget_password/worker_verification/verification_worker_screen.dart';
import 'package:darak_project/module/worker/worker_forget_password/worker_verification/worker_reset_password/reset_password_screen.dart';
import 'package:darak_project/module/worker/worker_sign_up/sign_up_worker_screen.dart';
import 'package:darak_project/services/common/middleware/welcome_mw.dart';
import 'package:get/get.dart';

import '../../module/customer/customer_auth/forget_customer_password/customer_verification/reset_customer_password/reset_password_customer_screen.dart';
import '../../module/customer/customer_auth/forget_customer_password/customer_verification/verification_customer_screen.dart';
import '../../module/customer/main/chat/chat_history/chat_history_screen.dart';
import '../../module/customer/main/chat/in_chat/in_chat_screen.dart';
import '../../module/customer/main/home/categories/categories_screen.dart';
import '../../module/customer/main/home/categories/profile_category/profile_category_screen.dart';
import '../../module/customer/main/layout/layout_screen.dart';
import '../../module/customer/main/worker_home/add_service/get_sub_category/get_sub_category_screen.dart';
import '../../module/customer/photo_view/photo_view_screen.dart';

class Routes {
   static const String onBoardRoute = '/';
   static const String splashRoute = '/splash';
   static const String addInfoRoute = '/add';
   static const String signInRoute = '/signIn';
   static const String signUpRoute = '/signUp';
   static const String forgetRoute = '/forget';
   static const String verificationRoute = '/verification';
   static const String resetRoute = '/reset';
   static const String layoutRoute = '/layout';
   static const String inChatScreenRoute = '/inChat';
   static const String chatHistoryRoute = '/chatHistory';
   static const String photoViewRoutes = '/photoView';
   static const String categoriesRoutes = '/category';
   static const String profileCategoryRoutes = '/categoryProfile';
   static const String bookRoutes = '/book';
   static const String locationRoutes = '/location';
   static const String paymentRoutes = '/payment';
   static const String bookingRevRoutes = '/booking';
   static const String adsRoutes = '/ads';
   static const String getSubRoutes = '/getSub';
    //worker
   static const String signWoInRoute = '/signInWo';
   static const String signUpWoRoute = '/signUpWo';
   static const String forgetWoRoute = '/forgetWo';
   static const String verificationWoRoute = '/verificationWo';
   static const String resetWoRoute = '/resetWo';

}

List<GetPage<dynamic>> appRoutes = [

  GetPage(
    name: Routes.onBoardRoute,
    page: () =>  OnBoardingScreen(),
    //arguments: RouteWelcomeMW(priority: 1),
    // middlewares: [
    //  RouteWelcomeMW(priority: 1),
    // ]
  ),
  GetPage(
    name: Routes.splashRoute,
    page: () => const SplashScreen(),
  ), GetPage(
    name: Routes.signInRoute,
    page: () => SignInScreen(),
  ), GetPage(
    name: Routes.signUpRoute,
    page: () => SignUpScreen(),
  ),GetPage(
    name: Routes.forgetRoute,
    page: () => ForgetPasswordScreen(),
  ),GetPage(
    name: Routes.verificationRoute,
    page: () => PinCodeVerificationScreen(),
  ),GetPage(
    name: Routes.resetRoute,
    page: () => ResetPasswordScreen(),
  ),GetPage(
    name: Routes.layoutRoute,
    page: () =>  LayoutScreen(),
  ) ,GetPage(
     name: Routes.inChatScreenRoute,
     page: () =>    InChatScreen(),
   ),GetPage(
     name: Routes.chatHistoryRoute,
     page: () => ChatHistoryScreen(),
   ),GetPage(
     name: Routes.photoViewRoutes,
     page: () => PhotoViewScreen(),
   ),GetPage(
     name: Routes.categoriesRoutes,
     page: () => CategoriesScreen(),
   ),GetPage(
     name: Routes.profileCategoryRoutes,
     page: () =>  ProfileCategoryScreen(),
   ),GetPage(
     name: Routes.addInfoRoute,
     page: () =>  AddInfoScreen(),
   ),GetPage(
     name: Routes.bookRoutes,
     page: () =>   BookDetailsScreen(),
   ),GetPage(
     name: Routes.locationRoutes,
     page: () =>  const LocationDetailsScreen(),
   ),GetPage(
     name: Routes.paymentRoutes,
     page: () =>   const PaymentMethodScreen(),
   ),GetPage(
     name: Routes.bookingRevRoutes,
     page: () =>    BookingReviewScreen(),
   ),
  //Worker
      GetPage(
      name: Routes.signWoInRoute,
      page: () => SignInScreen(),
   ), GetPage(
      name: Routes.signUpWoRoute,
      page: () => SignUpWoScreen(),
   ),GetPage(
      name: Routes.forgetWoRoute,
      page: () => ForgetPasswordWoScreen(),
   ),GetPage(
      name: Routes.verificationWoRoute,
      page: () => PinCodeVerificationWoScreen(),
   ),GetPage(
      name: Routes.resetWoRoute,
      page: () => ResetPasswordWoScreen(),
   ),GetPage(
      name: Routes.adsRoutes,
      page: () =>  AdsScreen(),
   ),GetPage(
      name: Routes.getSubRoutes,
      page: () => GetSubCategoryScreen(),
   ),
];