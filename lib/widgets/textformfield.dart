
import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/texts_heleper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormFieldCustom extends StatelessWidget {

  final String? hintText;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController textEditingController;
  double? width ;
  bool? enabled = true;
  double? hieght = 55.h;
  int? maxline;
  String? label;
  FocusNode? focusNode;
  bool? auto_focus;


  TextFormFieldCustom({super.key,
    this.hintText,
    this.obscureText = false,
    this.validator,
    this.onSaved,
    this.prefixIcon,
    this.suffixIcon,
    this.maxline,
    this.width,
    this.hieght,
    this.enabled,
    this.label,
    required this.textEditingController,
    required TextInputType keyboardType,
    this.focusNode,
    this.auto_focus,

  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: hieght,
      width: width,
      child: TextFormField(
        autofocus:auto_focus??false ,
        focusNode: focusNode,
        enabled: enabled,
        controller: textEditingController,
        maxLines: maxline,
        decoration: InputDecoration(
          fillColor: ColorHelper.fillFFColor,
          filled: true,
          label: Text(label??''),
          labelStyle: TextStyle(
            fontSize: 15,
            fontFamily: TextHelper.satoshiRegular,
          ),
          hintText: hintText,
          hintStyle:  TextStyle(
            color: ColorHelper.hintColor,
            fontSize: 14,
            fontFamily: TextHelper.satoshiRegular,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          errorBorder:  const OutlineInputBorder(

            borderSide: BorderSide(color: ColorHelper.red1, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          enabledBorder:  const OutlineInputBorder(
            borderSide: BorderSide.none,

            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorHelper.offWhiteColor, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        obscureText: obscureText!,
        validator: validator,
        onSaved: onSaved,

      ),
    );
  }
}
