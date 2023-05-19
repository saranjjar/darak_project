import 'package:darak_project/Application/app_router/app_router.dart';
import 'package:darak_project/helpers/image_helper.dart';
import 'package:darak_project/widgets/components/components.dart';
import 'package:darak_project/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
class LocationDetailsScreen extends StatelessWidget {
  const LocationDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: buildAppBar(title: 'Location Details'),
      body: Column(
        children: [
          Expanded(
            child: InteractiveViewer(
              child: SizedBox(
                  height: 400.h,
                  width: double.infinity,
                  child: Image.asset(ImageHelper.mapImg,fit: BoxFit.cover,)),
            ),
          ),
          SizedBox(height: 20.h,),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                D_MaterialButton(
                    width: double.infinity,
                    onPressed: (){
                      Get.toNamed(Routes.paymentRoutes);
                    },
                    child: Text('Continue',style: buildTextStyleBtn(),)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
