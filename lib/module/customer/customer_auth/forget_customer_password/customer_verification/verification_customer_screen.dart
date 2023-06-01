
import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/image_helper.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../forget_password_customer_controller.dart';

class PinCodeVerificationScreen extends StatelessWidget {
  final controller = Get.put(ForgetPasswordController());

   PinCodeVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: const Icon(Icons.arrow_back,)),
                SizedBox(height: 20.h,),
                Text(
                  TextHelper.authCode,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: TextHelper.satoshiBold
                  ),
                ),
                 SizedBox(height: 15.h),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(ImageHelper.otp),
                  ),
                ),
                SizedBox(height: 10.h,),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: TextHelper.authCodeP,
                      children: [
                        TextSpan(
                            text: controller.number.text,
                            style:   TextStyle(
                              fontFamily: TextHelper.satoshiBold,
                            )),
                      ],
                      style:
                      TextStyle(color: Colors.black, fontSize: 15,
                        fontFamily: TextHelper.satoshiRegular,
                      ),
                  ),
                ),
                 SizedBox(
                  height: 15.h,
                ),
                OtpTextField(
                  numberOfFields: 6,
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  enabledBorderColor: Colors.transparent,
                  focusedBorderColor: ColorHelper.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  borderWidth: 1,
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,
                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                    //handle validation or checks here
                  },
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode){
                    controller.verifyMobileNumber(verificationCode);
                    //Get.offNamed(Routes.resetRoute);
                  }, // end onSubmit
                ),
                 SizedBox(
                  height: 15.h,
                ),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: TextHelper.reAuthCode,
                      style:
                      TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontFamily: TextHelper.satoshiRegular,
                        fontWeight: FontWeight.w100
                      ),
                      children: [
                        TextSpan(
                            text: 'send again',
                            style:   TextStyle(
                              fontFamily: TextHelper.satoshiBold,
                            )),
                      ],

                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}