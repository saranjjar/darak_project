// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:open_market_project/Helper/image_helper.dart';
// import 'package:open_market_project/widgets/customAppBar.dart';
// import '../../../../../Helper/color_helper.dart';
// import '../../../../../widgets/components/components.dart';
// import 'change_password_controller.dart';
//
// class ChangePasswordScreen extends StatelessWidget {
//   ChangePasswordScreen({Key? key}) : super(key: key);
//
//   final ChangePassController _controller = Get.put(ChangePassController());
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ChangePassController>(builder: (controller)=>Scaffold(
//       backgroundColor: Colors.white,
//       appBar: customAppBar('Change Password', context, ColorManager.primaryBlue),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: SingleChildScrollView(
//           child: SafeArea(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Center(
//                     child: Text('LOGO',style: TextStyle(
//                         color: ColorManager.primaryBlue,
//                         fontSize: 35.sp,
//                         fontWeight: FontWeight.bold
//                     ),),
//                   ),
//                   SizedBox(height: 30.h,),
//                   Text('Old Password',style: _styleHint(),),
//                   SizedBox(height: 15.h,),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(35),
//                           borderSide: BorderSide(
//                             color: ColorManager.greyBorder,
//                           )
//                       ),
//                       hintText: '.......',
//                       hintStyle: hintStyle(),
//                       prefixIcon: Icon(Icons.lock_outline,color: ColorManager.primaryOrange,),
//                     ),
//                     obscureText: true,
//                     keyboardType: TextInputType.emailAddress,
//                     controller: _controller.oldPassController,
//                   ),
//                   SizedBox(height: 20.h,),
//                   Text(' New Password',style: _styleHint(),),
//                   SizedBox(height: 15.h,),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(35),
//                           borderSide: BorderSide(
//                             color: ColorManager.greyBorder,
//                           )
//                       ),
//                       hintText: '.......',
//                       hintStyle: hintStyle(),
//                       prefixIcon: Icon(Icons.lock_outline,color: ColorManager.primaryOrange,),
//                     ),
//                     obscureText: true,
//                     keyboardType: TextInputType.emailAddress,
//                     controller: _controller.newPassController,
//                   ),
//
//                   SizedBox(height: 20,),
//                   Text('Confirm New Password',style: _styleHint(),),
//                   SizedBox(height: 15.h,),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(35),
//                           borderSide: BorderSide(
//                             color: ColorManager.greyBorder,
//                           )
//                       ),
//                       hintText: '......',
//                       hintStyle: hintStyle(),
//                       prefixIcon: Icon(Icons.lock_outline,color: ColorManager.primaryOrange,),
//                     ),
//                     keyboardType: TextInputType.emailAddress,
//                     controller: _controller.confirmPassController,
//                     obscureText: true,
//                   ),
//                   SizedBox(height: 30,),
//                   D_MaterialButton(
//                       width: double.infinity,
//                       color: ColorManager.primaryOrange,
//                       colorBorder: ColorManager.primaryOrange,
//                       onPressed: (){
//                         _controller.apiChangePass();
//                       }, child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SvgPicture.asset(ImageManager.sendIcon),
//                       SizedBox(width: 15.w,),
//                       Text('Send',style: _styleTxtBtn(ColorManager.white),)
//                     ],
//                   )
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     ));
//   }
//
//   TextStyle _styleHint(){
//     return TextStyle(
//         fontSize: 16.sp,
//         color: ColorManager.greyBorder
//     );
//   }
//
//   TextStyle _styleTxtBtn(Color color){
//     return TextStyle(
//         fontSize: 18.sp,
//         color: color
//     );
//   }
//   TextStyle hintStyle (){
//     return TextStyle(
//       color: ColorManager.greyBorder,
//       fontSize: 14.sp,
//     );
//   }
// }
