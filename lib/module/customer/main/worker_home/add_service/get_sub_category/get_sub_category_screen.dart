import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/image_helper.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:darak_project/module/customer/main/worker_home/add_service/get_sub_category/get_sub_category_controller.dart';
import 'package:darak_project/widgets/components/components.dart';
import 'package:darak_project/widgets/customAppBar.dart';
import 'package:darak_project/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
class GetSubCategoryScreen extends StatelessWidget {
   GetSubCategoryScreen({Key? key}) : super(key: key);
   final _controller = Get.put(GetSubCategoryController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetSubCategoryController>(builder: (controller)=>Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(title:controller.title ),
      body: controller.isLoading
          ?
      const Center(child: CircularProgressIndicator(),)
          :
      getSubServiceRefresh(),
    ));
  }
   RefreshIndicator getSubServiceRefresh(){
     return RefreshIndicator(
         onRefresh: _controller.asyncLoadAllData,
         child: _controller.subServiceList.isEmpty
             ?
         Center(child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             SvgPicture.asset(ImageHelper.emptyBookIcon),
             SizedBox(height: 5.h,),
             Text('There is no any Booking now',style: TextStyle(fontFamily: TextHelper.satoshiLight),),
           ],
         ),)
             :
         _buildMainBody()
     );
   }

   Widget _buildMainBody() {
     return Padding(
       padding: const EdgeInsets.all(20.0),
       child: ListView.separated(
         physics: const BouncingScrollPhysics(),
         itemBuilder:(context,index)=>_buildListItem(context,index),
         separatorBuilder: (context,index)=>SizedBox(height: 10.h,),
         itemCount: _controller.subServiceList.length,
       ),
     );
   }

   Widget _buildListItem(context,index) {
     var item = _controller.subServiceList[index].data();
     return Slidable(
       startActionPane: ActionPane(
           motion:  const ScrollMotion(),
           children: [
             SlidableAction(
               borderRadius: BorderRadius.circular(15),
               onPressed: (context){
               deleteService(_controller.subServiceList[index].id);
               },
             backgroundColor: ColorHelper.redColor,
               icon: Icons.delete,
               
             ),
             const SizedBox(width: 5,),
             SlidableAction(
               borderRadius: BorderRadius.circular(15),
               onPressed:(c){
                 _openBottomSheet(context,_controller.subServiceList[index].id);
               },
               foregroundColor: Colors.white,
               backgroundColor: ColorHelper.greenColor,
               icon: Icons.edit,

             ),
             const SizedBox(width: 8,),
             ]),
       child: Container(
         decoration: BoxDecoration(
             color:ColorHelper.light1,
             borderRadius: BorderRadius.circular(15),
             border: Border.all(color: ColorHelper.offPurpleColor)),
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(item.subService!,style: _buildTextStyle1(font:16),maxLines: 1,overflow: TextOverflow.ellipsis,),
               SizedBox(height: 10.h,),
               Text(
                '${item.price!}\$/hour',style: _buildTextStyle1(font:16,color: ColorHelper.primaryColor),maxLines: 1,overflow: TextOverflow.ellipsis,),
               SizedBox(height: 10.h,),
               Row(
                 children: [
                   SvgPicture.asset(ImageHelper.starIcon),
                   SizedBox(width: 5.w,),
                   //const Icon(Icons.star,color: ColorHelper.yellow2,),
                   Text(
                    '4.9',style: _buildTextStyle1(font:14,family: TextHelper.satoshiLight),),
                   SizedBox(width: 8.w,),
                   Container(
                     height:14,
                     width: 1,
                     color: ColorHelper.greyColor,
                   ),
                   SizedBox(width: 8.w,),
                   Text(
                    '335 Review',style: _buildTextStyle1(font:14,family: TextHelper.satoshiLight),maxLines: 1,overflow: TextOverflow.ellipsis,),
                 ],
               ),

             ],
           ),
         ),
       ),
     );
   }

   TextStyle _buildTextStyle1({double? font,Color? color,String? family}) => TextStyle(
       fontFamily: family??TextHelper.satoshiBold,
       fontSize:font?? 18,
       color: color??Colors.black
   );
    _openBottomSheet(BuildContext context,String idDoc) {
     showModalBottomSheet(
       context: context,
       builder: (BuildContext context) {
         return _buildBottomSheet(context,idDoc);
       },
     );
   }

   Widget _buildBottomSheet(BuildContext context,String idDoc) {
     return Container(
       padding: EdgeInsets.only(
         bottom: MediaQuery.of(context).viewInsets.bottom,
       ),
       color: Colors.white,
       height: 300.h,
       child: Padding(
         padding: const EdgeInsets.all(20.0),
         child: ListView(
           physics: const BouncingScrollPhysics(),
           children: [
             SizedBox(height: 8.h,),
             Text('Service Name',style: TextStyle(fontFamily: TextHelper.satoshiMedium),),
             SizedBox(height: 8.h,),
             TextFormFieldCustom(
               fillColor: ColorHelper.fillFFColor,
                 textEditingController: _controller.serviceName,

                 keyboardType: TextInputType.text
             ),
             SizedBox(height: 8.h,),
             Text('Service Price / hour',style: TextStyle(fontFamily: TextHelper.satoshiMedium),),
             SizedBox(height: 8.h,),
             TextFormFieldCustom(
               fillColor: ColorHelper.fillFFColor,
                 textEditingController: _controller.servicePrice,
                 keyboardType: TextInputType.text
             ),
             SizedBox(height: 16.h,),
             D_MaterialButton(
               width: double.infinity,
                 onPressed: (){
                  _controller.updateInfoService(idDoc: idDoc);
                  Get.back();
                 }, child: Text('Saved',style: buildTextStyleBtn(),))
           ],
         ),
       ),
     );
   }

  void deleteService(String idDoc) {
      Get.defaultDialog(
        radius: 12,
        title: '',
        content: Column(
          children: [
            Text('Are you sure you want to delete it ?',style: TextStyle(fontFamily: TextHelper.satoshiRegular),),
            SizedBox(height: 8.h,),
            MyDivided(color: ColorHelper.divColor),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: D_TextButton(
                      onPressed: (){
                        _controller.deleteService(idDoc: idDoc);
                        Get.back();
                      }, text: 'Delete',line: TextDecoration.none,color: ColorHelper.redColor,)),
                Container(
                  width: 1,
                  height: 40,
                  color: ColorHelper.divColor,
                ),

                Expanded(
                    flex: 1,
                    child: D_TextButton(onPressed: (){
                      Get.back();
                    }, text: 'Cancel',line: TextDecoration.none,color: ColorHelper.greenColor,)),
              ],
            )
          ],
        )
      );
  }
}
