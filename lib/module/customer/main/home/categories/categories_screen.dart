import 'package:darak_project/Application/app_router/app_router.dart';
import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/image_helper.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:darak_project/module/customer/main/home/categories/categories_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CategoriesScreen extends StatelessWidget {
   CategoriesScreen({Key? key}) : super(key: key);

   final _controller = Get.put(CategoriesController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: _controller.isLoading.value
                    ?
            const Center(child: CircularProgressIndicator())
                    :
            _buildMainBody(),
    ));
  }

  AppBar buildAppBar() {
    return AppBar(
      titleSpacing: 0,
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: (){
          Get.back();
        },
        icon: const Icon(Icons.arrow_back_ios,color: Colors.black,),
      ),
      title: Text(_controller.name_service!,style: TextStyle(color: Colors.black,fontFamily: TextHelper.satoshiBold,fontSize: 18),),
      actions: [
        IconButton(
            onPressed: (){},
            icon: SvgPicture.asset(ImageHelper.searchIcon)
        ),
      ],
    );
  }

  ListView _buildMainBody() {
    return ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context,index)=>_buildListItem(index),
        separatorBuilder: (context,index)=>Container(),
        itemCount: _controller.subCategoryList.length
    );
  }

  Widget _buildListItem(int index) {
    var item = _controller.subCategoryList[index].data();
   return InkWell(
     onTap: (){
       _controller.bookReview(_controller.subCategoryList[index].data());
       Get.toNamed(Routes.profileCategoryRoutes,parameters:{
        'service_name':item.service!,
        'username': item.username!,
        'bio': item.bio!,
        'price': item.price!,
        'location': item.location!,
        'photo': item.photo!,
       });
     },
     child: Padding(
       padding: const EdgeInsets.symmetric(
         horizontal: 20,
         vertical: 10
       ),
       child: Container(
         decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.circular(12),
           border: Border.all(
             width: 1,
             color: ColorHelper.divColor,
           )
         ),
         child: Padding(
           padding: const EdgeInsets.all(12.0),
           child: Row(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Container(
                   height: 120,
                   width: 120,
                   clipBehavior: Clip.antiAliasWithSaveLayer,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(8)
                   ),
                   child: Image.network(item.photo!,fit: BoxFit.cover,)),
               SizedBox(width: 10.w,),
               Expanded(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Text(item.username!,style: _textStyle(TextHelper.satoshiBold),
                       maxLines: 1,
                       overflow: TextOverflow.ellipsis,
                     ),
                     SizedBox(height: 8.h,),
                     Text(item.service!,style: _textStyle(TextHelper.satoshiRegular),
                       maxLines: 1,
                       overflow: TextOverflow.ellipsis,
                     ),
                     Padding(
                       padding:  EdgeInsets.symmetric(vertical: 8.h),
                       child: Text(
                         '${item.price}\$/hour',style: TextStyle(
                         fontSize: 16,
                         fontFamily: TextHelper.satoshiBold,
                         color: ColorHelper.primaryColor,
                       ),
                         maxLines: 1,
                         overflow: TextOverflow.ellipsis,
                       ),
                     ),
                     SizedBox(height: 4.h,),
                     Row(
                       children: [
                         SvgPicture.asset(ImageHelper.starIcon),
                         Text('4.9',style: _buildTextStyle(),),
                         SizedBox(width: 5.w,),
                         Container(
                           height: 14.h,
                           width: 1,
                           color: ColorHelper.warmGrey,
                         ),
                         SizedBox(width: 5.w,),
                         Text('124',style: _buildTextStyle(),),
                         Text('Reviews',style: _buildTextStyle(),),
                       ],
                     )
                   ],
                 ),
               )
             ],
           ),
         ),
       ),
     ),
   );
  }

  TextStyle _textStyle(String fontfamily) {
    return TextStyle(
                   fontSize: 16,
                   fontFamily: fontfamily,
                 );
  }

  TextStyle _buildTextStyle() {
    return TextStyle(
           fontSize: 12,
           fontFamily: TextHelper.satoshiLight,
         );
  }
}
