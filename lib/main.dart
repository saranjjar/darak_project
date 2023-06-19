import 'package:darak_project/Application/app_binding/app_binding.dart';
import 'package:darak_project/Application/app_router/app_router.dart';
import 'package:darak_project/firebase_options.dart';
import 'package:darak_project/module/splash/splash_controller.dart';
import 'package:darak_project/services/common/config.dart';
import 'package:darak_project/services/common/shared_pref.dart';
import 'package:darak_project/services/common/user_store.dart';
import 'package:darak_project/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync<StorageService>(() => StorageService().init());
  Get.put<SplashController>(SplashController());
  Get.put<ConfigStore>(ConfigStore());
  Get.put<UserStore>(UserStore());

  // if(kIsWeb){
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');

  // late String home;
  //
  // if(!UserStore.t0.hasToken){
  //   home = Routes.signInRoute;
  //
  // }else{
  //
  //   home=Routes.layoutRoute;
  // }
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
  runApp(MyApp(/*home: home*/));
}

class MyApp extends StatelessWidget {
  late String home;

  MyApp({
    super.key,
    /*required this.home*/
  });
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            // themeMode:ThemeServices().theme!,
            theme: ThemeApp.light(),
            // darkTheme: ThemeApp.dark(),
            initialBinding: Binding(),
            getPages: appRoutes,
            //initialRoute: Routes.addInfoRoute,
          );
        });
  }
}
