
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darak_project/Application/app_router/app_router.dart';
import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/image_helper.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:darak_project/model/category.dart';
import 'package:darak_project/module/customer/main/home/categories/categories_controller.dart';
import 'package:darak_project/module/customer/main/home/home_controller.dart';
import 'package:darak_project/widgets/components/components.dart';
import 'package:darak_project/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class HomeScreen extends StatelessWidget {

    HomeScreen({Key? key}) : super(key: key);
    final _controllerCategory = Get.put(CategoriesController());
    final _controller = Get.put(HomeController());
   @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller)=> _buildMainBody(controller)
    );
  }

   SafeArea _buildMainBody(HomeController controller) {
     return SafeArea(
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
                  physics: const BouncingScrollPhysics(),
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: List.generate(
                      controller.categoryList.length,
                          (index) => InkWell(
                        onTap:(){
                          _controllerCategory.getSubcategoriesInCategory(controller.categoryList[index].id);
                          print(controller.categoryList[index].data().serviceName!);
                          Get.toNamed( Routes.categoriesRoutes,parameters: {
                              "service_name" : controller.categoryList[index].data().serviceName!,
                          });
                        },
                        child: _buildGridItem(controller.categoryList[index]),
                      )
                  ),

                ),
              )]),
      )


  );
   }

   Widget _buildGridItem(QueryDocumentSnapshot<Category> item) {

     return _controller.isLoading
                ?
           Shimmer(
             child: Container(
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
                       backgroundColor: Colors.grey.shade300,
                       radius: 25.r,
                       ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Container(
                         width:50.w,
                         height: 5,
                         clipBehavior: Clip.antiAliasWithSaveLayer,
                         decoration: BoxDecoration(
                           color: Colors.grey.shade300,
                           borderRadius: BorderRadius.circular(25)
                         ),
                       ),
                     )
                   ],
                 )),
           )
                :
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
               child: Image.network(item.data().icon!),),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text(item.data().serviceName!,style: TextStyle(
                 fontSize: 12,
                 fontFamily: TextHelper.satoshiMedium,
               ),),
             )
           ],
         ));

   }

   TextStyle _buildTextStyle() {
     return TextStyle(
                    fontFamily: TextHelper.satoshiBold,
                    fontSize: 16,
                  );
   }

}

