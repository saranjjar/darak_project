import 'package:darak_project/Application/app_router/app_router.dart';
import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/image_helper.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:darak_project/widgets/components/components.dart';
import 'package:darak_project/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


enum SingingCharacter { paypal, mastercard,cash }

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});


  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  SingingCharacter? _character = SingingCharacter.cash;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Payment Method'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: <Widget>[
                  _buildRadio(
                      title: 'Paypal',
                      icon: ImageHelper.paypalIcon,
                      onChanged: (value){
                        setState(() {
                          _character = value;
                        });
                      },
                      value: SingingCharacter.paypal
                  ),
                  SizedBox(height: 15.h,),
                  _buildRadio(
                      title: 'Master Card',
                      icon: ImageHelper.cashIcon,
                      onChanged: (value){
                        setState(() {
                          _character = value;
                        });
                      },
                      value: SingingCharacter.mastercard
                  ),
                  SizedBox(height: 15.h,),
                  _buildRadio(
                      title: 'Cash',
                      icon: ImageHelper.cashIcon,
                      onChanged: (value){
                        setState(() {
                          _character = value;
                        });
                      },
                      value: SingingCharacter.cash
                  ),
                ],
              ),
            ),
            D_MaterialButton(
                onPressed: (){
                  Get.toNamed(Routes.bookingRevRoutes);
                  },
                child: Text(
                  'Continue',
                  style: buildTextStyleBtn(),
                ),
                width: double.infinity
            ),
          ],
        ),
      ),
    );
  }

  Container _buildRadio({
    required String title,
    required String icon,
    required void Function(SingingCharacter?)? onChanged,
    required SingingCharacter value,
  }) {
    return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorHelper.offPurpleColor
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: RadioListTile<SingingCharacter>(
                activeColor: ColorHelper.primaryColor,
                title: Row(
                  children: [
                    SvgPicture.asset(icon),
                    SizedBox(width: 10.w,),
                     Text(title,style: TextStyle(fontFamily: TextHelper.satoshiBold,fontSize: 18),),
                  ],
                ),
                value: value,
                groupValue: _character,
                onChanged: onChanged
    ),
            ),
    );
  }
}