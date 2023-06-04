
import 'package:darak_project/const.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:darak_project/services/common/shared_pref.dart';
import 'package:darak_project/widgets/components/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookDetailsController extends GetxController{

  var selectedDate = DateTime.now().obs;

  void handleSelectionChanged(DateRangePickerSelectionChangedArgs args) {

      selectedDate.value = args.value is DateTime ? args.value : null;
      String selsctedDate = DateFormat.yMMMd().format(selectedDate.value);
      StorageService.to.setString(Constants.STRORAGE_Date, selsctedDate);
      print(StorageService.to.getString(Constants.STRORAGE_Date));

  }
  var selectedTime = TimeOfDay.now().obs;

  Future chooseTime(context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime:selectedTime.value ,

    );
    if(pickedTime!=null) {
      selectedTime.value=pickedTime;
      StorageService.to.setString(Constants.STRORAGE_TIME, selectedTime.value.format(context).toString());
      print(StorageService.to.getString(Constants.STRORAGE_TIME));
    }
  }
  RxInt workingHours = 1.obs;

  void addHour(){
    if(workingHours.value==12)return;
    workingHours.value++;
    calculatePrice();
    StorageService.to.setString(Constants.STRORAGE_WORKING_HOURS, workingHours.toString());
    if (kDebugMode) {
      print(StorageService.to.getString(Constants.STRORAGE_WORKING_HOURS));
    }
  }
  void minHour(){
    if(workingHours.value==1)return;
    workingHours.value--;
    calculatePrice();
    StorageService.to.setString(Constants.STRORAGE_WORKING_HOURS, workingHours.toString());
    print(StorageService.to.getString(Constants.STRORAGE_WORKING_HOURS));
  }

  RxString? price =''.obs;

  RxDouble finalPrice=0.0.obs;
  double calculatePrice(){
    finalPrice.value = double.parse(price!.value) * workingHours.value;
    StorageService.to.setString(Constants.STRORAGE_PRICE, finalPrice.toString());

    return finalPrice.value;
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.parameters;
    price?.value = data['price']!;
  }

  void showDefaultDialog() {
    Get.defaultDialog(
      barrierDismissible: false,
      title: "",
      titleStyle: TextStyle(fontFamily: TextHelper.satoshiBold,fontSize: 18),
      content:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Icon(Icons.error_outline,color: Colors.red,),
            Column(
              children: [
                Text("Not Completed",
                  style: TextStyle(fontFamily: TextHelper.satoshiBold,fontSize: 16,color: Colors.red),textAlign: TextAlign.center,),
                SizedBox(height: 2.h,),
                Text("You have to enter all required Data",
                  style: TextStyle(fontFamily: TextHelper.satoshiMedium,fontSize: 16),textAlign: TextAlign.center,),
              ],
            ),
          ],
        ),
      ),
    );
  }

}