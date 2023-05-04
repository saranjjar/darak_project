// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../app/app_router/app_router.dart';
//
//
// AppBar CustomAppBar(String title){
//   return AppBar(
//     elevation: 0,
//     backgroundColor: Colors.white,
//     automaticallyImplyLeading: false,
//     centerTitle: true,
//     leading: IconButton(
//         onPressed:(){
//
//         },icon: Icon(Icons.search_rounded,color: ColorManager.primaryBlue,)),
//     actions: [
//       IconButton(onPressed: (){
//         Get.toNamed(Routes.profileRoute);
//       }, icon: Icon(Icons.person_outline),color: ColorManager.primaryBlue)
//     ],
//     title: Center(
//       child: Text(
//         '${title}',
//         style: TextStyle(color: ColorManager.primaryBlue,fontSize: 20.sp),
//       ),
//     ),
//   );
// }
//
// AppBar customAppBar(String title,context,Color color){
//   return AppBar(
//     elevation: 0,
//     backgroundColor: color,
//     automaticallyImplyLeading: false,
//     centerTitle: true,
//     leading: IconButton(onPressed:(){
//       Navigator.pop(context);
//     },icon: Icon(Icons.arrow_back_ios,color: ColorManager.white,)),
//     title: Center(
//       child: Text(
//         '${title}',
//         style: TextStyle(color: ColorManager.white,fontSize: 20.sp),
//       ),
//     ),
//     actions: [
//       IconButton(
//           onPressed: (){},
//           icon: Icon(Icons.add,color: ColorManager.primaryBlue,))
//     ],
//   );
// }