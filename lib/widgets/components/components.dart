
import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../helpers/image_helper.dart';

void NavigatorTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
      builder: (context) => widget),
);

void NavigateAnfFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
      builder: (context) => widget
  ),
      (rout) => false,
);

Widget D_MaterialButton(
    {
      required Function() onPressed,
      bool isUpperCase = true,
      required Widget child,
      Color textColor = Colors.white,
      double raduis = 12.0,
       double? width,
      Color? color = ColorHelper.primaryColor,
      Color colorb = Colors.transparent,
      double elevation = 0,
      double?height = 55
    }) =>
    Material(
      elevation: elevation,
      clipBehavior: Clip.antiAliasWithSaveLayer,

      borderRadius: BorderRadius.circular(raduis),
      child: Container(
        height: height,
        width: width,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(raduis),
          border: Border.all(
            color: colorb,
            width: 0.5
          )
        ),
        child: MaterialButton(
          color: color,
          onPressed: onPressed,
          height: height,
          elevation: elevation,
          child: child,
          ),
      ),
    );

Widget D_TextButton ({
  required Function() onPressed,
  required String text,
  double? fontSize=14,
  TextDecoration line = TextDecoration.underline,
  FontWeight? fontWeight,
  Color? color=ColorHelper.blackColor,
}) => TextButton(
  onPressed: onPressed,
  child: Text(
    text,
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontFamily: TextHelper.satoshiBold,
        decoration:line

    ),
  ),
);


Widget MyDivided ({required Color color, double? withOpacity}) => Container(
  width: double.infinity,
  height: 1,
  color: color,
);

void printFullText(String text){

  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

//Components for app

Row buildChoicesSign() {
  return Row(
    children: [
      Expanded(
        flex: 2,
        child: Container(
          //width: double.infinity,
          height: 1,
          color: ColorHelper.divColor,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 10),
        child: Text(
          TextHelper.signWith,
          style: buildTextStyle(
              color: ColorHelper.offWhiteColor),
        ),
      ),
      Expanded(
        flex: 2,
        child: Container(
          // width: double.infinity,
          height: 1,
          color: ColorHelper.divColor,
        ),
      ),
    ],
  );
}

Center buildSignSM() {
  return Center(
    child: SizedBox(
      width: 200.w,
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){

            },
            child: CircleAvatar(
              radius: 25,
              backgroundColor: ColorHelper.fillFFColor,
              child: SvgPicture.asset(
                  ImageHelper.googleIcon),
            ),
          ),
          CircleAvatar(
            radius: 25,
            backgroundColor: ColorHelper.fillFFColor,
            child:
            SvgPicture.asset(ImageHelper.macIcon),
          ),
          CircleAvatar(
            radius: 25,
            backgroundColor: ColorHelper.fillFFColor,
            child: SvgPicture.asset(
                ImageHelper.faceIcon),
          ),
        ],
      ),
    ),
  );
}

TextStyle buildTextStyle({Color? color}) {
  return TextStyle(
      fontFamily: TextHelper.satoshiRegular,
      fontSize: 14,
      color: color ?? Colors.black);
}

//
// Widget textFormFailed({
//   String? initialValue,
//   String? hintText,
//   IconData? prefixIcon,
//   Widget? suffixIcon,
//   String? Function(String?)? onSaved,
//   required TextInputType keyboardType,
//   required TextEditingController textEditingController,
//   required String? Function(String?)? validator,
//   Future<String?> Function(String?)? onSubmit,
//   Function(String?)? onChanged,
//   bool isobscureText = false,
//   Color? color = Colors.white,
//   double radius = 10,
//   Color? prefixIconColor = Colors.grey,
//   int maxline = 1,
//   double width = double.infinity,
//
// }){
//   return Container(
//     width: width,
//     decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(radius),
//         border: Border.all(
//         width: 1,
//       color: ColorManager.greyBorder
//     )
//     ),
//     clipBehavior: Clip.antiAliasWithSaveLayer,
//     child: TextFormField(
//
//       onFieldSubmitted: onSubmit,
//       onChanged: onChanged,
//       initialValue: initialValue,
//       maxLines: maxline,
//       decoration: InputDecoration(
//         focusColor: Colors.cyan,
//         border: InputBorder.none,
//         hintText: hintText,
//         hintStyle: TextStyle(color: ColorManager.greyBorder),
//         prefixIcon: Icon(prefixIcon,color: prefixIconColor,size: 14,),
//         suffixIcon: suffixIcon,
//         errorBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.red),
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.red),
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//       ),
//
//       keyboardType: keyboardType,
//       controller: textEditingController,
//       onSaved :onSaved,
//       validator: validator,
//       obscureText: isobscureText,
//       style: TextStyle(
//         color: Colors.black,
//         fontWeight: FontWeight.normal,
//       ),
//
//     ),
//   );
// }

void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 14),
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: "OK",
        onPressed: () {},
        textColor: Colors.white,
      ),
    ),
  );
}

//Texts Style
TextStyle buildTextStyleBtn({Color? color,TextDecoration? line}) {
  return TextStyle(
      fontFamily: TextHelper.satoshiBold,
      color: color ?? Colors.white,
      decoration: line ?? TextDecoration.none,
      fontSize: 16);
}

AppBar CustomAppBar(String title){
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    centerTitle: true,
    leading: IconButton(
        onPressed:(){

        },icon: Icon(Icons.search_rounded,color: ColorHelper.primaryColor,)),
    actions: [
      IconButton(onPressed: (){
      //  Get.toNamed(Routes.profileRoute);
      }, icon: const Icon(Icons.person_outline),color: ColorHelper.primaryColor)
    ],
    title: Center(
      child: Text(
        '${title}',
        style: TextStyle(color: ColorHelper.primaryColor,fontSize: 20.sp),
      ),
    ),
  );
}

AppBar customAppBar(String title,context,Color color){
  return AppBar(
    elevation: 0,
    backgroundColor: color,
    automaticallyImplyLeading: false,
    centerTitle: true,
    leading: IconButton(onPressed:(){
      Navigator.pop(context);
    },icon: const Icon(Icons.arrow_back_ios,color: ColorHelper.light1,)),
    title: Center(
      child: Text(
        '${title}',
        style: const TextStyle(color: ColorHelper.light1,fontSize: 20),
      ),
    ),
    actions: [
      IconButton(
          onPressed: (){},
          icon: const Icon(Icons.add,color: ColorHelper.primaryColor,))
    ],
  );
}