import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../helpers/image_helper.dart';

enum PaymentMethod { paypal, mastercard,cash }
PaymentMethod? _character = PaymentMethod.cash;
class RadioButtonWidget extends StatefulWidget {

   RadioButtonWidget({Key? key,required this.title}) : super(key: key);
    String title;
  @override
  State<RadioButtonWidget> createState() => _RadioButtonWidgetState();
}

class _RadioButtonWidgetState extends State<RadioButtonWidget> {
  @override
  Widget build(BuildContext context) {

      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ColorHelper.offPurpleColor
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: RadioListTile<PaymentMethod>(
            title: Row(
              children: [
                SvgPicture.asset(ImageHelper.paypalIcon),
                SizedBox(width: 10.w,),
                Text(widget.title,style: TextStyle(fontFamily: TextHelper.satoshiBold,fontSize: 18),),
              ],
            ),
            value: PaymentMethod.paypal,
            groupValue: _character,
            onChanged: (value){
              setState(() {
                _character = value;
              });
            },
          ),
        ),
      );
    }}

