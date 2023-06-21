import 'package:darak_project/Application/app_router/app_router.dart';
import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:darak_project/module/customer/customer_auth/customer_sign_up/sign_up_customer_controller.dart';
import 'package:darak_project/module/customer/main/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
   SettingsScreen({Key? key}) : super(key: key);

   final controllerSignUp = Get.put(SignUpController());

   @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(builder:(controller)=> SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 80.h,
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: ColorHelper.primaryColor,
                      radius:30.r,
                      child: const Icon(Icons.notifications,color: Colors.white,size: 28,),
                    ),
                    SizedBox(width: 20.w,),
                    Expanded(
                      child: Text(
                        'Notification',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: TextHelper.satoshiMedium
                        ),
                      ),
                    ),
                    Switch(
                      value: controller.isSwitchedNo,
                      onChanged: controller.onChangedNo,
                      activeTrackColor: ColorHelper.primaryColor,
                      activeColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 80.h,
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: ColorHelper.primaryColor,
                      radius:30.r,
                      child: const Icon(Icons.nightlight_round_rounded,color: Colors.white,size: 28,),
                    ),
                    SizedBox(width: 20.w,),
                     Expanded(
                      child: Text(
                        'Night System',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: TextHelper.satoshiMedium
                        ),
                      ),
                    ),
                    Switch(
                      value: controller.isSwitchedMo,
                      onChanged: controller.onChangedMo,
                      activeTrackColor: ColorHelper.primaryColor,
                      activeColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
          buildListSettings(controller,iconData: Icons.language,settings: 'Change Language',route: Routes.layoutRoute),
          buildListSettings(controller,iconData: Icons.lock,settings: 'Change Password',route: Routes.layoutRoute),
          buildListSettings(controller,iconData: Icons.person,settings: 'Block People',route:Routes.layoutRoute),
          buildListSettings(controller,iconData: Icons.web_rounded,settings: 'Term Of Use',route:Routes.layoutRoute),
          buildListSettings(controller,iconData: Icons.wysiwyg_rounded,settings: 'Privacy Policy',route: Routes.layoutRoute),
          buildListSettings(controller,iconData: Icons.logout,settings: 'Log Out',),
        ],
      ),
    ));
  }

   Widget buildListSettings(
       SettingsController controller,
       {required IconData iconData,required String settings, String? route,}) {
     return GestureDetector(
       onTap: (){
         if(route!=null) {
           Get.toNamed(route);
         }else{
           controllerSignUp.logOut();

         }



      },
       child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: double.infinity,
            height: 80.h,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: ColorHelper.primaryColor,
                    radius:30.r,
                    child: Icon(iconData,color: Colors.white,size: 28,),
                  ),
                  SizedBox(width: 20.w,),
                  Expanded(
                      child: Text(
                        settings,
                        style:  TextStyle(

                            fontSize: 18,
                            fontFamily: TextHelper.satoshiMedium

                        ),
                      ),
                  ),
                  const Icon(Icons.arrow_forward,color: ColorHelper.primaryColor)

                ],
              ),
            ),
          ),
        ),
     );
   }
}
