import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/image_helper.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:darak_project/module/worker/sign_in/sign_in_screen.dart';
import 'package:darak_project/module/worker/sign_up/sign_up_controller.dart';
import 'package:darak_project/widgets/components/components.dart';
import 'package:darak_project/widgets/textformfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SignUpWoScreen extends StatelessWidget {
   SignUpWoScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final _controller = Get.put(SignUpWoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.primaryColor,
      body: _buildMainBody(context),
    );
  }

  Widget _buildMainBody(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding:
         EdgeInsets.only(top: 60.h),
        child: Form(
            key: formKey,
            child: SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(20))),

                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                          "Create your account now to help you and explore",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600)),
                      SizedBox(height: 20.h,),
                      TextFormFieldCustom(
                        label: 'user name',
                        prefixIcon:SvgPicture.asset( ImageHelper.userIcon,fit: BoxFit.none),
                        textEditingController: _controller.username,
                        keyboardType: TextInputType.text,
                        validator: (val) {
                          if (val!.isNotEmpty) {
                            return null;
                          } else {
                            return "Name cannot be empty";
                          }
                        },
                      ),
                       SizedBox(
                        height: 15.h,
                      ),
                      TextFormFieldCustom(
                        label: 'email',
                        textEditingController: _controller.email,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: SvgPicture.asset(ImageHelper.emailIcon,fit: BoxFit.none,),
                        // check tha validation
                        validator: (val) {
                          return RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val!)
                              ? null
                              : "Please enter a valid email";
                        },
                      ),
                       SizedBox(height: 15.h),
                      TextFormFieldCustom(
                        label: 'phone',
                        textEditingController: _controller.phone,
                        keyboardType: TextInputType.phone,
                        prefixIcon: SvgPicture.asset(ImageHelper.phoneIcon,fit: BoxFit.none),
                        // check tha validation
                        validator: (val) {
                          if(val!.isEmpty) {
                            return "Please enter a valid email";
                          }
                        },
                      ),
                       SizedBox(height: 15.h),
                      TextFormFieldCustom(
                        label: 'password',
                        prefixIcon: SvgPicture.asset(ImageHelper.lockIcon,fit: BoxFit.none,),
                        textEditingController: _controller.password,
                        keyboardType: TextInputType.text,
                        validator: (val) {
                          if (val!.length < 6) {
                            return "Password must be at least 6 characters";
                          } else {
                            return null;
                          }
                        },
                      ),
                       SizedBox(
                        height: 20.h,
                      ),
                       Obx(() =>                       _controller.isLoading.value
                           ?
                       Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor))
                           :
                       D_MaterialButton(
                         onPressed: () {
                           if (formKey.currentState!.validate()) {
                             _controller.registerWithEmail(context);
                           }
                         },
                         child: Text(
                           'Sign Up',
                           style: buildTextStyleBtn(),
                         ),
                         width: double.infinity,
                       ),),
                       SizedBox(
                        height: 20.h,
                      ),
                      buildChoicesSign(),
                       SizedBox(
                        height: 20.h,
                      ),
                      buildSignSM(),
                      // IconButton(
                      //     onPressed: ()async{
                      //   await _controller.signInWithFacebook();
                      // }, icon: const Icon(Icons.facebook)),
                       SizedBox(
                        height: 20.h,
                      ),
                      Center(
                        child: Text.rich(TextSpan(
                          text: "Already have an account? ",
                          style:  TextStyle(
                              color: Colors.black, fontSize: 15,
                          fontFamily: TextHelper.satoshiRegular
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Sign In",
                                style:  TextStyle(
                                    color: Colors.black,
                                    fontFamily: TextHelper.satoshiBold,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(() =>  SignInWoScreen());
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
