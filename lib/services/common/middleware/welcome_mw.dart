// import 'package:darak_project/Application/app_router/app_router.dart';
// import 'package:darak_project/services/common/config.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
//
// class RouteWelcomeMW extends GetMiddleware {
//   @override
//   int? priority = 0;
//
//   RouteWelcomeMW({required this.priority});
//
//   @override
//   RouteSettings? redirect(String? route) {
//     print("2222${ConfigStore.to.isFirstOpen}");
//     if (ConfigStore.to.isFirstOpen == false) {
//       return const RouteSettings(name: Routes.splashRoute);
//     }
//     // else if (UserStore.t0.isLogin == true) {
//     //   return const RouteSettings(name: Routes.layoutRoute);
//     // }
//     else {
//       return const RouteSettings(name: Routes.onBoardRoute);
//     }
//   }
// }
