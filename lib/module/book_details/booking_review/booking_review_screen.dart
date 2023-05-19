import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/image_helper.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:darak_project/module/book_details/booking_review/booking_review_controller.dart';
import 'package:darak_project/widgets/components/components.dart';
import 'package:darak_project/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
class BookingReviewScreen extends StatelessWidget {

  BookingReviewScreen({Key? key}) : super(key: key);
  final _controller =Get.put(BookingReviewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Booking Review'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorHelper.offPurpleColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildItem('Service','Cleaning'),
                    buildDivider(),
                    buildItem('Category','Cleaning'),
                    buildDivider(),
                    buildItem('Worker','Cleaning'),
                    buildDivider(),
                    buildItem('Date & Time', '${_controller.date} ${_controller.time}',),
                    buildDivider(),
                    buildItem('Working Hours',_controller.workingHour),
                  ],
                ),
              ),
              SizedBox(height: 20.h,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorHelper.offPurpleColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildItem('sweeping floor','${_controller.price}\$'),
                    buildDivider(),
                    buildItem('discount','0'),
                    buildDivider(),
                    buildItem('price','${_controller.price}\$'),
                  ],
                ),
              ),
              SizedBox(height: 20.h,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorHelper.offPurpleColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(ImageHelper.cashIcon),
                      SizedBox(width: 10.w,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Cash Card',style: TextStyle(fontFamily: TextHelper.satoshiBold),),
                          Text('********85',style: TextStyle(fontFamily: TextHelper.satoshiLight),)
                        ],
                      ),
                      const Spacer(),
                      D_TextButton(onPressed: (){}, text: 'Change',line: TextDecoration.none)
                    ],
                  ),
                )
              ),
              SizedBox(height: 20.h,),
              Obx(() =>_controller.isLoading.value
                  ?
              const Center(child: CircularProgressIndicator())
                  :
              D_MaterialButton(
                  width: double.infinity,
                  onPressed: (){
                    _controller.sendBookingReview();
                  },
                  child: Text('Confirm Booking',style: buildTextStyleBtn(),)
              ),)
            ],
          ),
        ),
      ),
    );
  }

  Padding buildDivider() {
    return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(height: 1,width: double.infinity,color: ColorHelper.warmGrey,),
                );
  }

  Padding buildItem(String title,String value) {
    return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Text(title,style: TextStyle(fontFamily: TextHelper.satoshiLight),),
                    const Spacer(),
                    Text(value,style: TextStyle(fontFamily: TextHelper.satoshiMedium),)
                  ],
                ),
              );
  }
}
