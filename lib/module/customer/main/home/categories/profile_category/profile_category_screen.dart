
import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/image_helper.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:darak_project/widgets/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
class ProfileCategoryScreen extends StatelessWidget {
  const ProfileCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorHelper.divColor,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16
                  ),
                  child: Container(
                      height: 150.h,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: ColorHelper.primaryColor,
                        //borderRadius: BorderRadius.circular(12),
                      )
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 30.h,
                    width: 100.w,
                    decoration:  BoxDecoration(
                      color: ColorHelper.light1,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child:Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: (
                      Row(children:[SvgPicture.asset(ImageHelper.msgIcon),const Text('Caht'),])
                      ),
                    )
              ),
                ),

              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  buildWorkerItem(),
                  SizedBox(height: 8.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Review (120)',style: TextStyle(fontFamily: TextHelper.satoshiBold,fontSize: 15),),
                      D_TextButton(
                          onPressed: () {

                          },
                        text: 'See All',

                        line: TextDecoration.none
                      ),
                    ],
                  ),
                  Container(
                    width:double.infinity,
                    height: 150.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text('Sara Jehad',style: TextStyle(fontFamily: TextHelper.satoshiBold),),
                                  SizedBox(height: 4.h,),
                                  Row(
                                    children: [
                                      SvgPicture.asset(ImageHelper.starIcon),
                                      SvgPicture.asset(ImageHelper.starIcon),
                                      SvgPicture.asset(ImageHelper.starIcon),
                                      SvgPicture.asset(ImageHelper.starIcon),
                                      SvgPicture.asset(ImageHelper.starIcon),
                                    ],
                                  )
                                ],
                              ),
                              const Spacer(),
                              Text('7/10/2023',style: TextStyle(color: ColorHelper.hintColor,fontFamily: TextHelper.satoshiLight),)
                            ],
                          ),
                          SizedBox(height: 10.h,),
                          Text(
                            TextHelper.parRat,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontFamily: TextHelper.satoshiRegular),),
                          Wrap(
                            spacing: 10.w,
                            children: [
                              SvgPicture.asset(ImageHelper.ratImg),
                              SvgPicture.asset(ImageHelper.ratImg),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
                right: 20,
                left: 20
              ),
              child: D_MaterialButton(
                  onPressed: (){},
                  child:  Text('Book Now',style: buildTextStyleBtn(),), width: double.infinity),
            )
          ],
        ),
      ),
    );
  }

  Widget buildWorkerItem() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ColorHelper.light1
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Contact Info',style: TextStyle(fontFamily: TextHelper.satoshiBold),),
            SizedBox(height: 10.h,),
            Row(
              children: [
                SvgPicture.asset(ImageHelper.profileIcon),
                SizedBox(width: 4.w,),
                Text(
                  'Ahmed Ali',
                  style: TextStyle(
                      fontFamily: TextHelper.satoshiRegular,
                  ),
                ),
                SizedBox(width: 12.w,),
                Text(
                  '4.1',
                  style: TextStyle(
                      fontFamily: TextHelper.satoshiLight,
                  ),
                ),
                SizedBox(width: 2.w,),
                SvgPicture.asset(ImageHelper.starIcon),

                              ],
            ),
            buildDivider(),
            Row(
              children: [
                SvgPicture.asset(ImageHelper.locationIcon),
                SizedBox(width: 4.w,),
                Text(
                  '181 Herzog Light Suite 092, Wilson',
                  style: TextStyle(
                    fontFamily: TextHelper.satoshiRegular
                  ),),
              ],
            ),
            buildDivider(),
            Row(
              children: [
                SvgPicture.asset(ImageHelper.locationIcon),
                SizedBox(width: 4.w,),
                RichText(
                    text:  TextSpan(
                      text: '20\$',
                      style: TextStyle(color: ColorHelper.blackColor,fontFamily: TextHelper.satoshiBold,fontSize: 16),
                      children: [
                        TextSpan(text: ' \\ hour',style: TextStyle(color: Colors.black,fontFamily: TextHelper.satoshiRegular),
                        ),
                      ]
                    ),
                ),
              ],
            ),
            buildDivider(),
            Text(
                'I am a skilled and experienced worker, dedicated to providing high-quality services to my clients. I am committed to ensuring customer, Read more',
              style: TextStyle(
                fontFamily: TextHelper.satoshiRegular,

              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildDivider() {
    return Padding(
            padding:  EdgeInsets.all(8.0.h),
            child: Container(height: 0.5,width: double.infinity,color: Colors.grey[400],),
          );
  }

  AppBar buildAppBar() {
    return AppBar(
      titleSpacing: 0,
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: (){},
        icon: const Icon(Icons.arrow_back_ios,color: Colors.black,),
      ),
      title: Text('Service',style: TextStyle(color: Colors.black,fontFamily: TextHelper.satoshiBold),),
      actions: [
        IconButton(
            onPressed: (){},
            icon: SvgPicture.asset(ImageHelper.searchIcon)
        ),
      ],
    );
  }

}
