import 'package:darak_project/Application/app_router/app_router.dart';
import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/image_helper.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:darak_project/module/customer/customer_auth/customer_sign_in/sign_in_customer_screen.dart';
import 'package:darak_project/module/customer/customer_auth/customer_sign_up/sign_up_customer_controller.dart';
import 'package:darak_project/module/worker/worker_sign_up/sign_up_worker_controller.dart';
import 'package:darak_project/module/worker/worker_sign_up/sign_up_worker_screen.dart';
import 'package:darak_project/utils/utils.dart';
import 'package:darak_project/widgets/components/components.dart';
import 'package:darak_project/widgets/textformfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
   SignUpScreen({Key? key}) : super(key: key);

  final controller = Get.put(SignUpController());

   final formKey = GlobalKey<FormState>();
   final formKey2 = GlobalKey<FormState>();
   final controllerWo = Get.put(SignUpWoController());
   final controllerWO = Get.put(SignUpWoController());

   @override
  Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Colors.white,
       body: Padding(
         padding: const EdgeInsets.all(20.0),
         child: SafeArea(
           child: DefaultTabController(
             length: 2,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 SizedBox(height: 20.h,),
                 Text(TextHelper.welcomeBack,
                     style: TextStyle(
                         fontFamily: TextHelper.satoshiBold,
                         fontSize: 18,
                         fontWeight: FontWeight.w600)),
                 SizedBox(
                   height: 5.h,
                 ),
                 Text('Sign in to access your account 🤩',
                     style: TextStyle(
                       fontFamily: TextHelper.satoshiRegular,
                       fontSize: 16,
                     )),
                 SizedBox(height: 15.h,),
                 Container(
                   width: double.infinity,
                   height: 40,
                   decoration: BoxDecoration(
                     color: Colors.grey.shade400,
                     borderRadius: BorderRadius.circular(12),
                   ),
                   child: TabBar(
                     indicatorSize: TabBarIndicatorSize.tab,
                     indicator: _buildTabDecoration(),
                     indicatorColor: ColorHelper.primaryColor,
                     automaticIndicatorColorAdjustment: false,
                     labelColor: ColorHelper.primaryColor,
                     unselectedLabelColor: ColorHelper.blackColor,
                     tabs: [
                       Tab(
                         child:
                         Text('Customer', style: _buildTextStyle()),
                       ),
                       Tab(
                         child: Text(
                           'Worker',
                           style: _buildTextStyle(),
                         ),
                       ),
                     ],
                   ),
                 ),
                 SizedBox(height: 20.h,),
                 Expanded(
                   child: TabBarView(
                       children: [
                         _buildMainBodyCustomer(context),
                         _buildMainBodyWorker(context),
                       ]),
                 )
               ],
             ),

           ),
         ),
       ),

     );
   }

   Widget _buildMainBodyCustomer(BuildContext context) {
     return SafeArea(
       child: Form(
           key: formKey,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               SizedBox(height: 10.h,),
               TextFormFieldCustom(
                 prefixIcon: Icon(Icons.person,color: ColorHelper.warmGrey,),
                 label: 'User Name',
                 // check tha validation
                 validator: (val) {
                   return val!.isEmpty?"Please enter a valid username":null;
                 },
                 textEditingController: controller.username,
                 keyboardType: TextInputType.text,
               ),
               SizedBox(height: 10.h),
               TextFormFieldCustom(
                 prefixIcon: Icon(Icons.email,color: ColorHelper.warmGrey,),
                 label: TextHelper.hintEmail,
                 // check tha validation
                 validator: (val) {
                   return RegExp(
                       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                       .hasMatch(val!)
                       ? null
                       : "Please enter a valid email";
                 },
                 textEditingController: controller.email,
                 keyboardType: TextInputType.emailAddress,
               ),
               SizedBox(height: 10.h),
               TextFormFieldCustom(
                 prefixIcon: Icon(Icons.phone,color: ColorHelper.warmGrey,),
                 label: 'Phone',
                 // check tha validation
                 validator: (val) {
                   return val!.isEmpty?"Please enter a valid email":null;
                 },
                 textEditingController: controller.phone,
                 keyboardType: TextInputType.phone,
               ),
               SizedBox(height: 10.h),
               Obx(() => TextFormFieldCustom(
                 label: TextHelper.hintPass,
                 suffixIcon: InkWell(
                   onTap: (){
                     controller.changeVisiability();
                   },
                   child: controller.isvisiable.value ? const Icon(Icons.visibility):const Icon(Icons.visibility_off),
                 ),
                 obscureText: controller.isvisiable.value,
                 maxline: 1,
                 textEditingController: controller.password,
                 keyboardType: TextInputType.text,
                 validator: (val) {
                   if (val!.length < 6) {
                     return "Password must be at least 6 characters";
                   } else {
                     return null;
                   }
                 },
               ),),

               SizedBox(height: 10.h),
               Obx(
                     () => controller.isLoading.value
                     ?
                 const Center(
                   child: CircularProgressIndicator(
                       color: ColorHelper.primaryColor),
                 )
                     :
                 D_MaterialButton(
                   onPressed: () {
                     dismissKeyboard();
                     if (formKey.currentState!.validate()) {
                       controller.registerWithEmail(context);
                     }
                   },
                   child: Text(
                     'Sign Up',
                     style: buildTextStyleBtn(),
                   ),
                   width: double.infinity,
                 ),
               ),
               SizedBox(
                 height: 20.h,
               ),
               buildChoicesSign(),
               SizedBox(
                 height: 10.h,
               ),
               Center(
                 child: SizedBox(
                   width: 200.w,
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       InkWell(
                         onTap: () {
                           controller.signInGoogle(context);
                         },
                         child: CircleAvatar(
                           radius: 25,
                           backgroundColor: ColorHelper.fillFFColor,
                           child:
                           SvgPicture.asset(ImageHelper.googleIcon),
                         ),
                       ),
                       CircleAvatar(
                         radius: 25,
                         backgroundColor: ColorHelper.fillFFColor,
                         child: SvgPicture.asset(ImageHelper.macIcon),
                       ),
                       CircleAvatar(
                         radius: 25,
                         backgroundColor: ColorHelper.fillFFColor,
                         child: SvgPicture.asset(ImageHelper.faceIcon),
                       ),
                     ],
                   ),
                 ),
               ),
               SizedBox(
                 height: 30.h,
               ),
               Center(
                 child: Text.rich(TextSpan(
                   text: "already have an account? ",
                   style: TextStyle(
                       color: ColorHelper.offWhiteColor,
                       fontFamily: TextHelper.satoshiRegular,
                       fontSize: 16),
                   children: <TextSpan>[
                     TextSpan(
                         text: "Sign In",
                         style: buildTextStyleBtn(
                             color: ColorHelper.blackColor,
                             line: TextDecoration.underline),
                         recognizer: TapGestureRecognizer()
                           ..onTap = () {
                             Get.to(SignInScreen());
                           }),
                   ],
                 )),
               ),
             ],
           )),
     );
   }
   Widget _buildMainBodyWorker(BuildContext context) {
     return SafeArea(
       child: Form(
           key: formKey2,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               SizedBox(height: 10.h),
               TextFormFieldCustom(
                 prefixIcon: Icon(Icons.person,color: ColorHelper.warmGrey,),
                 label: 'User Name',
                 // check tha validation
                 validator: (val) {
                   if(val!.isEmpty)
                     return "Please enter a valid username";
                 },
                 textEditingController: controllerWo.username,
                 keyboardType: TextInputType.text,
               ),
               SizedBox(height: 10.h,),
               TextFormFieldCustom(
                 prefixIcon: Icon(Icons.email,color: ColorHelper.warmGrey,),
                 label: TextHelper.hintEmail,
                 // check tha validation
                 validator: (val) {
                   return RegExp(
                       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                       .hasMatch(val!)
                       ? null
                       : "Please enter a valid email";
                 },
                 textEditingController: controllerWo.email,
                 keyboardType: TextInputType.emailAddress,
               ),
               SizedBox(height: 10.h),
               TextFormFieldCustom(
                 prefixIcon: Icon(Icons.phone,color: ColorHelper.warmGrey,),
                 label: 'Phone',
                 // check tha validation
                 validator: (val) {
                   if(val!.isEmpty)
                   return "Please enter a valid phone";
                 },
                 textEditingController: controllerWo.phone,
                 keyboardType: TextInputType.phone,
               ),
               SizedBox(height: 10.h),
               Obx(() => TextFormFieldCustom(
                 label: TextHelper.hintPass,
                 suffixIcon: InkWell(
                   onTap: (){
                     controllerWo.changeVisiability();
                   },
                   child: controllerWo.isvisiable.value ? const Icon(Icons.visibility):const Icon(Icons.visibility_off),
                 ),
                 obscureText: controllerWo.isvisiable.value,
                 maxline: 1,
                 textEditingController: controllerWo.password,
                 keyboardType: TextInputType.text,
                 validator: (val) {
                   if (val!.length < 6) {
                     return "Password must be at least 6 characters";
                   } else {
                     return null;
                   }
                 },
               ),),

               SizedBox(height: 10.h),
               Obx(
                     () => controllerWo.isLoading.value
                     ?
                 const Center(
                   child: CircularProgressIndicator(
                       color: ColorHelper.primaryColor),
                 )
                     :
                 D_MaterialButton(
                   onPressed: () {
                     dismissKeyboard();
                     if (formKey2.currentState!.validate()) {
                       controllerWo.registerWithEmail(context);
                     }
                   },
                   child: Text(
                     'Sign Up',
                     style: buildTextStyleBtn(),
                   ),
                   width: double.infinity,
                 ),
               ),
               SizedBox(
                 height: 20.h,
               ),
               buildChoicesSign(),
               SizedBox(
                 height: 10.h,
               ),
               Center(
                 child: SizedBox(
                   width: 200.w,
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       InkWell(
                         onTap: () {
                           controllerWO.signInGoogle(context);
                         },
                         child: CircleAvatar(
                           radius: 25,
                           backgroundColor: ColorHelper.fillFFColor,
                           child:
                           SvgPicture.asset(ImageHelper.googleIcon),
                         ),
                       ),
                       CircleAvatar(
                         radius: 25,
                         backgroundColor: ColorHelper.fillFFColor,
                         child: SvgPicture.asset(ImageHelper.macIcon),
                       ),
                       CircleAvatar(
                         radius: 25,
                         backgroundColor: ColorHelper.fillFFColor,
                         child: SvgPicture.asset(ImageHelper.faceIcon),
                       ),
                     ],
                   ),
                 ),
               ),
               SizedBox(
                 height: 30.h,
               ),
               Center(
                 child: Text.rich(TextSpan(
                   text: "already have an account? ",
                   style: TextStyle(
                       color: ColorHelper.offWhiteColor,
                       fontFamily: TextHelper.satoshiRegular,
                       fontSize: 16),
                   children: <TextSpan>[
                     TextSpan(
                         text: "Sign In",
                         style: buildTextStyleBtn(
                             color: ColorHelper.blackColor,
                             line: TextDecoration.underline),
                         recognizer: TapGestureRecognizer()
                           ..onTap = () {
                             Get.to(SignInScreen());
                           }),
                   ],
                 )),
               ),
             ],
           )),
     );
   }

   BoxDecoration _buildTabDecoration() {
     return BoxDecoration(
         color: ColorHelper.offPurpleColor,
         borderRadius: BorderRadius.circular(10));
   }

   TextStyle _buildTextStyle() => TextStyle(fontSize: 15,fontFamily: TextHelper.satoshiBold);
}
