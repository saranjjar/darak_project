
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darak_project/Application/app_router/app_router.dart';
import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/image_helper.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:darak_project/model/category.dart';
import 'package:darak_project/module/customer/main/home/categories/categories_controller.dart';
import 'package:darak_project/module/customer/main/home/home_controller.dart';
import 'package:darak_project/services/common/user_store.dart';
import 'package:darak_project/widgets/components/components.dart';
import 'package:darak_project/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {

    HomeScreen({Key? key}) : super(key: key);
    final _controllerCategory = Get.put(CategoriesController());
    final _controller = Get.put(HomeController());
    var pageViewController = PageController();
    bool isLast = false;
    bool isFirst = true;

    List<modelItem> model = [
      modelItem(ImageHelper.adsImg1),
      modelItem(ImageHelper.adsImg2),
      modelItem(ImageHelper.adsImg3),
    ];

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
                height: 5.h,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hi, ${UserStore.t0.profile.displayName}👋',style: TextStyle(
                          fontFamily: TextHelper.satoshiBold,
                          fontSize: 18
                      ),),
                      Text('Welcome back HandyHome',style: TextStyle(
                          fontFamily: TextHelper.satoshiRegular,
                          fontSize: 14,
                          color: ColorHelper.offWhiteColor
                      ),),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: (){

                      }, icon: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:Border.all(
                          color: ColorHelper.offWhiteColor
                        )
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Icon(Icons.notifications_none_outlined,color: ColorHelper.offWhiteColor,),
                      )))
                ],
              ),
              SizedBox(height: 15.h,),
              TextFormFieldCustom(
                textEditingController: TextEditingController(),
                keyboardType: TextInputType.text,
                prefixIcon: SvgPicture.asset(ImageHelper.searchIcon,fit: BoxFit.none,),
                label: 'Search',
              ),
              SizedBox(height: 10.h,),
              Row(
                children: [
                  Text(TextHelper.specialOff,style: _buildTextStyle(),),
                  const Spacer(),
                  D_TextButton(
                      text: TextHelper.view,
                      line: TextDecoration.none,
                      color: ColorHelper.greyColor,
                      fontSize: 14,
                      onPressed: (){
                        Get.toNamed(Routes.adsRoutes);
                      }
                  ),
                ],
              ),
              SizedBox(height: 5.h,),
              Container(
                height: 170.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ColorHelper.light1,
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: model.length,
                          onPageChanged: (index) {
                            controller.currentPage.value = index;
                          },
                         controller: pageViewController,
                          itemBuilder: (context, index) => buildItem(model[index])),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SmoothPageIndicator(
                      controller: pageViewController,
                      count: 3,
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.grey.shade300,
                        dotHeight: 5,
                        dotWidth: 10,
                        spacing: 5,
                        expansionFactor: 2,
                        activeDotColor: ColorHelper.primaryColor,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10.h,),
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
                          (index) => _controller.isLoading
                              ?
                              shimmer()
                              :
                          InkWell(
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

     return Container(
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

   Widget shimmer(){
     return Shimmer(
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
     );

   }

   Widget buildItem(modelItem model) {
      return Image.asset(model.image,fit: BoxFit.fitWidth,);
    }

}
class modelItem {
  String image;
  modelItem(this.image);
}

