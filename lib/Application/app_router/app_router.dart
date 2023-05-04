
import 'package:darak_project/module/auth/forget_password/forget_password_screen.dart';
import 'package:darak_project/module/auth/forget_password/verification/reset_password/reset_password_screen.dart';
import 'package:darak_project/module/auth/forget_password/verification/verification_screen.dart';
import 'package:darak_project/module/auth/sign_in/sign_in_screen.dart';
import 'package:darak_project/module/auth/sign_up/sign_up_screen.dart';
import 'package:darak_project/module/main/chat/chat_history/chat_history_controller.dart';
import 'package:darak_project/module/main/chat/chat_history/chat_history_screen.dart';
import 'package:darak_project/module/main/chat/in_chat/in_chat_screen.dart';
import 'package:darak_project/module/main/layout/layout_screen.dart';
import 'package:darak_project/module/splash/splash_screen.dart';
import 'package:darak_project/services/common/middleware/welcome_mw.dart';
import 'package:get/get.dart';

class Routes {
   static const String splashRoute = '/';
   static const String signInRoute = '/signIn';
   static const String signUpRoute = '/signUp';
   static const String forgetRoute = '/forget';
   static const String verificationRoute = '/verification';
   static const String resetRoute = '/reset';
   static const String layoutRoute = '/layout';
   static const String inChatScreenRoute = '/inChat';
   static const String chatHistoryRoute = '/chatHistory';
}

List<GetPage<dynamic>> appRoutes = [

  GetPage(
    name: Routes.splashRoute,
    page: () => const SplashScreen(),
    middlewares: [
     RouteWelcomeMW(priority: 1),
    ]
  ),
  GetPage(
    name: Routes.signInRoute,
    page: () => SignInScreen(),
  ),
  GetPage(
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
   ),

];