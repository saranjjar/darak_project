
import 'package:darak_project/Application/app_router/app_router.dart';
import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/image_helper.dart';
import 'package:darak_project/helpers/texts_heleper.dart';
import 'package:darak_project/module/main/home/home_controller.dart';
import 'package:darak_project/widgets/components/components.dart';
import 'package:darak_project/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
   const HomeScreen({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller)=>SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hi, Ahmed 👋',style: TextStyle(
                          fontFamily: TextHelper.satoshiBold,
                          fontSize: 18
                        ),),
                        SizedBox(height: 5.h,),
                        Text('Welcome back Darak',style: TextStyle(
                          fontFamily: TextHelper.satoshiRegular,
                          fontSize: 14,
                          color: ColorHelper.offWhiteColor
                        ),),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: (){

                        }, icon: const Icon(Icons.notifications_none_outlined,color: ColorHelper.offWhiteColor,))
                  ],
                ),
                SizedBox(height: 15.h,),
                TextFormFieldCustom(
                    textEditingController: TextEditingController(),
                    keyboardType: TextInputType.text,
                    prefixIcon: SvgPicture.asset(ImageHelper.searchIcon,fit: BoxFit.none,),
                    hintText: 'Search',
                ),
                SizedBox(height: 15.h,),
                Row(
                  children: [
                    Text(TextHelper.specialOff,style: _buildTextStyle(),),
                    const Spacer(),
                    D_TextButton(
                      text: TextHelper.view,
                      line: TextDecoration.none,
                      fontSize: 14,
                      onPressed: (){
                          Get.toNamed(Routes.chatHistoryRoute);
                      }
                    ),
                  ],
                ),
                SizedBox(height: 10.h,),
                Container(
                  height: 130.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorHelper.primaryColor,
                    borderRadius: BorderRadius.circular(12)
                  ),
                ),
                SizedBox(height: 15.h,),
                Text(TextHelper.services,style: _buildTextStyle(),),
                SizedBox(height: 10.h,),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: [
                    Container(
                          height: 120.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: ColorHelper.offPurpleColor
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  backgroundColor:ColorHelper.primaryColor,
                                  radius: 25.r,
                                  child: SvgPicture.asset(ImageHelper.cleanIcon)),
                              Text('Cleaning',style: TextStyle(
                                fontSize: 12,
                                fontFamily: TextHelper.satoshiRegular,
                              ),)
                            ],
                          )),
                    Container(
                          height: 120.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: ColorHelper.offPurpleColor
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  backgroundColor:ColorHelper.primaryColor,
                                  radius: 25.r,
                                  child: SvgPicture.asset(ImageHelper.cleanIcon)),
                              Text('Cleaning',style: TextStyle(
                                fontSize: 12,
                                fontFamily: TextHelper.satoshiRegular,
                              ),)
                            ],
                          )),
                    Container(
                          height: 120.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: ColorHelper.offPurpleColor
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  backgroundColor:ColorHelper.primaryColor,
                                  radius: 25.r,
                                  child: SvgPicture.asset(ImageHelper.cleanIcon)),
                              Text('Cleaning',style: TextStyle(
                                fontSize: 12,
                                fontFamily: TextHelper.satoshiRegular,
                              ),)
                            ],
                          )),
                    Container(
                        height: 120.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: ColorHelper.offPurpleColor
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                backgroundColor:ColorHelper.primaryColor,
                                radius: 25.r,
                                child: SvgPicture.asset(ImageHelper.cleanIcon)),
                            Text('Cleaning',style: TextStyle(
                              fontSize: 12,
                              fontFamily: TextHelper.satoshiRegular,
                            ),)
                          ],
                        )),
                    Container(
                        height: 120.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: ColorHelper.offPurpleColor
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                backgroundColor:ColorHelper.primaryColor,
                                radius: 25.r,
                                child: SvgPicture.asset(ImageHelper.cleanIcon)),
                            Text('Cleaning',style: TextStyle(
                              fontSize: 12,
                              fontFamily: TextHelper.satoshiRegular,
                            ),)
                          ],
                        )),
                    Container(
                          height: 120.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: ColorHelper.offPurpleColor
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  backgroundColor:ColorHelper.primaryColor,
                                  radius: 25.r,
                                  child: SvgPicture.asset(ImageHelper.cleanIcon)),
                              Text('Cleaning',style: TextStyle(
                                fontSize: 12,
                                fontFamily: TextHelper.satoshiRegular,
                              ),)
                            ],
                          )),


              ],

          ),
                )]),
          )


    ));
  }

   TextStyle _buildTextStyle() {
     return TextStyle(
                    fontFamily: TextHelper.satoshiBold,
                    fontSize: 16,
                  );
   }

  // RefreshIndicator _buildMainBody() {
  //     return RefreshIndicator(
  //         onRefresh: () {
  //           return _homeController.getHomeList();
  //         },
  //         child: _homeController.listHome.isEmpty
  //             ? Text(
  //           "empty",
  //           style: TextStyle(fontSize: 50),
  //         ): GridView.count(
  //         physics: const NeverScrollableScrollPhysics(),
  //         crossAxisCount: 3,
  //         mainAxisSpacing: 10,
  //         childAspectRatio: 116.w / 130.h,
  //         shrinkWrap: true,
  //         crossAxisSpacing: 10,
  //         padding: EdgeInsetsDirectional.all(10),
  //         children: List.generate(_homeController.listHome.length, (index) {
  //           return GestureDetector(
  //                 onTap: (){
  //                 },
  //                 child: _gridItem(index));
  //
  //         }),
  //       )
  //     );
  // }

  // Widget _gridItem(index){
  //   return Material(
  //     elevation: 0,
  //     clipBehavior: Clip.antiAliasWithSaveLayer,
  //     color: ColorManager.lightGrey,
  //     borderRadius: BorderRadius.circular(5),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           CircleAvatar(
  //             radius: 35.r,
  //             backgroundColor: Colors.white,
  //             child: Image(
  //                 image: NetworkImage('${_homeController.listHome[index].parent!.icon}')),
  //           ),
  //           SizedBox(height: 10.h,),
  //           Text('${_homeController.listHome[index].parent!.name}',style: _textCard(),)
  //         ],
  //       ),
  //
  //   );
  // }

}
