import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/image_helper.dart';
import 'package:darak_project/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class AdsScreen extends StatelessWidget {
   AdsScreen({Key? key}) : super(key: key);
  List<String> image = [
    ImageHelper.adsImg1,
    ImageHelper.adsImg2,
    ImageHelper.adsImg3,
    ImageHelper.adsImg4,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Special Offers'),
      body: SafeArea(
        child: ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context,index)=>buildItem(image[index]),
            separatorBuilder: (context,index)=> SizedBox(height: 10.h,),
            itemCount: image.length
        ),
      ),
    );
  }
  Widget buildItem(image){
    return Container(
      height: 140.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorHelper.light1,
          borderRadius: BorderRadius.circular(12)
      ),
      child: Image.asset(image)
    );

  }

}
