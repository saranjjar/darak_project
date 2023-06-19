import 'package:darak_project/helpers/image_helper.dart';
import 'package:darak_project/module/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<SplashController>(builder: ((controller)=>Scaffold(
      body: Center(
        child: Image.asset(
          ImageHelper.logo,
        ),
      ),
    )));
  }
}




// import 'package:darak_project/const.dart';
// import 'package:darak_project/module/customer/customer_auth/customer_sign_in/sign_in_customer_screen.dart';
// import 'package:darak_project/module/splash/splash_controller.dart';
// import 'package:darak_project/module/worker/worker_sign_in/sign_in_screen.dart';
// import 'package:darak_project/services/common/config.dart';
// import 'package:darak_project/services/common/shared_pref.dart';
// import 'package:darak_project/widgets/components/components.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// class SplashScreen extends StatelessWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: GetBuilder<SplashController>(
//             builder: (controller) => Scaffold(
//                   body:  Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         D_MaterialButton(
//                             onPressed: () {
//
//                               StorageService.to.setString(Constants.STRORAGE_DEVICE_CUSTO_WORK_KEY, 'customer');
//                               Get.offAll(()=>SignInScreen());
//                             },
//
//                             child:  Text('Sign In as a Customer',style: buildTextStyleBtn(),), width: double.infinity
//
//                         ),
//                         SizedBox(height: 20.h,),
//                         D_MaterialButton(
//                             onPressed: () {
//                               ConfigStore.to.saveAlreadyOpen();
//                               StorageService.to.setString(Constants.STRORAGE_DEVICE_CUSTO_WORK_KEY, 'worker');
//                               Get.offAll(()=>SignInWoScreen());
//                             },
//
//                             child:  Text('Sign In as a Worker',style: buildTextStyleBtn(),), width: double.infinity
//
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//         )
//     );
//   }
// }
