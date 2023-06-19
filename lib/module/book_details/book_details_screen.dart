import 'package:darak_project/Application/app_router/app_router.dart';
import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:darak_project/module/book_details/book_details_controller.dart';
import 'package:darak_project/widgets/components/components.dart';
import 'package:darak_project/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
class BookDetailsScreen extends StatelessWidget {
   BookDetailsScreen({Key? key}) : super(key: key);
   final _controller = Get.put(BookDetailsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(title:'Book Details'),
      body:Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   child: Row(
                  //     children: [
                  //       Obx(() => Text(_controller.selectedDate.value.toString(),style: TextStyle(fontFamily: TextHelper.satoshiBold),),),
                  //       Icon(Icons.date_range,color: ColorHelper.warmGrey,)
                  //     ],
                  //   ),
                  // ),
                  Text('Choose Start Date',style: _buildTextStyle(),),
                  SizedBox(height:15.h),
                  Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border:Border.all(
                    color: ColorHelper.offPurpleColor
                  )
                ),

                    child: SfDateRangePicker(
                      selectionColor: ColorHelper.primaryColor,
                      monthCellStyle: const DateRangePickerMonthCellStyle(
                          blackoutDateTextStyle: TextStyle(
                              color: ColorHelper.primaryColor
                          )
                      ),
                      headerStyle: const DateRangePickerHeaderStyle(
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(
                          color: ColorHelper.primaryColor,
                          fontSize: 16,
                        ),
                      ),

                      onSelectionChanged: _controller.handleSelectionChanged,
                      selectionMode: DateRangePickerSelectionMode.single,

                    ),
                  ),
                  SizedBox(height: 30.h,),
                  Row(
                    children: [
                      Text('Working Hours',style: _buildTextStyle(),),
                      const Spacer(),
                      _buildCounter(
                         const Icon(Icons.add,color: ColorHelper.primaryColor),
                            (){
                              _controller.addHour();
                            },
                      ),
                      SizedBox(width: 10.w,),
                       Obx(() => Text(_controller.workingHours.value.toString(),style: TextStyle(fontFamily: TextHelper.satoshiBold,fontSize: 18),),),
                      SizedBox(width: 10.w,),
                      _buildCounter(
                        const Align(
                          alignment: Alignment.topCenter,
                          child: Icon(Icons.minimize_rounded,color: ColorHelper.primaryColor,)),
                            (){
                          _controller.minHour();
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text('Choose Start Time',style: _buildTextStyle(),),
                  SizedBox(
                    height: 15.h,
                  ),
                  Obx(
                          () =>InkWell(
                            onTap: (){
                              _controller.chooseTime(context);

                            },
                            child: Container(
                              width: double.infinity,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  color: ColorHelper.offPurpleColor,
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(_controller.selectedTime.value.format(context),style: TextStyle(
                                        fontFamily: TextHelper.satoshiMedium
                                    ),),
                                    const Spacer(),
                                    Icon(Icons.watch_later,color: ColorHelper.warmGrey,)
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
          Material(
            elevation: 2,

            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text('Total Price',style: _buildTextStyle(),),
                      SizedBox(height: 5.h,),
                      Obx(() =>Text(
                        _controller.calculatePrice().toString(),
                        style: TextStyle(color: ColorHelper.primaryColor,fontFamily: TextHelper.satoshiBold),))
                    ],
                  ),
                  SizedBox(width: 10.w,),
                  Expanded(
                    child: D_MaterialButton(
                        onPressed: () {

                            Get.toNamed(Routes.locationRoutes);

                        }, child: Text('Continue',style: buildTextStyleBtn(),)

                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ) ,
    );
  }

  TextStyle _buildTextStyle() => TextStyle(fontSize: 16,fontFamily: TextHelper.satoshiBold);

  Widget _buildCounter(Widget child,void Function()? onTap) {
    return InkWell(
                  onTap:onTap,
                  child:  CircleAvatar(
                    backgroundColor: ColorHelper.offPurpleColor,
                    radius: 20,
                    child: child
                  ),
                );
  }
  // Widget _buildListItem(){
  //  return Container(
  //    width: 100.w,
  //    decoration: BoxDecoration(
  //      borderRadius: BorderRadius.circular(50),
  //      border: Border.all(
  //        color: ColorHelper.warmGrey
  //      )
  //    ),
  //    child: Padding(
  //      padding: const EdgeInsets.all(3.0),
  //      child: Center(child: Text('02:00 am',style: TextStyle(fontFamily: TextHelper.satoshiBold),)),
  //    ),
  //  );
  // }

}
