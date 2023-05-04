import 'package:darak_project/Application/app_binding/app_binding.dart';
import 'package:darak_project/Application/app_router/app_router.dart';
import 'package:darak_project/firebase_options.dart';
import 'package:darak_project/module/splash/splash_controller.dart';
import 'package:darak_project/module/splash/splash_screen.dart';
import 'package:darak_project/services/common/config.dart';
import 'package:darak_project/services/common/shared_pref.dart';
import 'package:darak_project/services/common/user_store.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync<StorageService>(()=>StorageService().init());
  Get.put<SplashController>(SplashController());
  Get.put<ConfigStore>(ConfigStore());
  Get.put<UserStore>(UserStore());
  // if(kIsWeb){
     await Firebase.initializeApp(
       options: DefaultFirebaseOptions.currentPlatform,
     );
  //       options: FirebaseOptions(
  //           apiKey: Constants.apiKey,
  //           appId: Constants.appId,
  //           messagingSenderId:Constants.messagingSenderId,
  //           projectId: Constants.projectId
  //       )
  //   );
  // }else{
  //   await Firebase.initializeApp();
  // }
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return  GetMaterialApp(
            debugShowCheckedModeBanner: false,
            // themeMode:ThemeServices().theme!,
            // theme:ThemeApp.light(),
            // darkTheme: ThemeApp.dark(),
            initialBinding: Binding(),
            getPages: appRoutes,
          );
        });
  }
}
