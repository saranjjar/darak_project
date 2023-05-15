import 'package:darak_project/Application/app_router/app_router.dart';
import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/image_helper.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:darak_project/module/customer/auth/sign_in/sign_in_controller.dart';
import 'package:darak_project/module/customer/auth/sign_up/sign_up_controller.dart';
import 'package:darak_project/module/customer/auth/sign_up/sign_up_screen.dart';
import 'package:darak_project/widgets/components/components.dart';
import 'package:darak_project/widgets/textformfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final controller = Get.put(SignInController());
  final _controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.primaryColor,
      body: _buildMainBody(context),
    );
  }

  SafeArea _buildMainBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 60.h),
        child: Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(TextHelper.welcomeBack,
                          style: TextStyle(
                              fontFamily: TextHelper.satoshiBold,
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                      SizedBox(
                        height: 35.h,
                      ),
                      TextFormFieldCustom(
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
                      const SizedBox(height: 15),
                      TextFormFieldCustom(
                        label: TextHelper.hintPass,
                        suffixIcon: SvgPicture.asset(ImageHelper.eyeIcon),
                        textEditingController: controller.password,
                        keyboardType: TextInputType.text,
                        validator: (val) {
                          if (val!.length < 6) {
                            return "Password must be at least 6 characters";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Checkbox(value: false, onChanged: (val) {}),
                          Text(
                            TextHelper.remem,
                            style: buildTextStyle(),
                          ),
                          const Spacer(),
                          D_TextButton(
                              onPressed: () {
                                Get.toNamed(Routes.forgetRoute);
                              },
                              text: 'Forget password ?',
                              fontSize: 14),
                        ],
                      ),
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
                                  if (formKey.currentState!.validate()) {
                                    controller.login(context);
                                  }
                                },
                                child: Text(
                                  'Sign In',
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
                                  _controller.signInGoogle(context);
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
                          text: "Don't have an account? ",
                          style: TextStyle(
                              color: ColorHelper.offWhiteColor,
                              fontFamily: TextHelper.satoshiRegular,
                              fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Sign Up",
                                style: buildTextStyleBtn(
                                    color: ColorHelper.blackColor,
                                    line: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(SignUpScreen());
                                  }),
                          ],
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
