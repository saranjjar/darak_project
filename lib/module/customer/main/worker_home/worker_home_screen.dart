import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/image_helper.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:darak_project/module/customer/main/worker_home/worker_home_controller.dart';
import 'package:darak_project/module/worker/addInfo/add_info_screen.dart';
import 'package:darak_project/services/common/user_store.dart';
import 'package:darak_project/widgets/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WorkerHomeScreen extends StatelessWidget {
   WorkerHomeScreen({Key? key}) : super(key: key);
    final _controller = Get.put(WorkerHomeController());
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GetBuilder<WorkerHomeController>(
          builder: (controller)=>
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, ${controller.userName} 👋',
                          style:
                          _buildTextStyle(),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          'Welcome back HandyHome',
                          style: TextStyle(
                              fontFamily: TextHelper.satoshiRegular,
                              fontSize: 14,
                              color: ColorHelper.offWhiteColor),
                        ),
                      ],
                    ),
                  ]),
                  SizedBox(height: 30.h,),
                  Row(
                    children: [
                      Text(
                        'My Services',
                        style:
                        _buildTextStyle(),
                      ),
                      Spacer(),
                      D_TextButton(onPressed: (){}, text: 'Edit',line: TextDecoration.none,color: ColorHelper.primaryColor,)
                    ],
                  ),
                  SizedBox(height: 10.h,),
                  controller.isLoading
                      ?
                   const Center(child: CircularProgressIndicator())
                      :
                  getService(),
                ],
              ),

        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add,color: Colors.white,),
        onPressed: (){
            Get.to(AddInfoScreen());
        },
      ),
    );
  }

   RefreshIndicator getService(){
     return RefreshIndicator(
         onRefresh: _controller.asyncLoadAllData,
         child: _controller.serviceList.isEmpty
             ?
         const Text('There is No any Request')
             :
         _buildMainBody(_controller)
     );
   }

  Widget _buildMainBody(WorkerHomeController controller) {
    return GridView.count(
      physics: const BouncingScrollPhysics(),
      crossAxisCount: 3,
      shrinkWrap: true,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: List.generate(controller.serviceList.length, (index) => _buildGridItem(index)),
    );
  }

  Container _buildGridItem(index) {
    var item = _controller.serviceList[index].data();
    return Container(
          height: 120.h,
          width: 50.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorHelper.offPurpleColor),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: ColorHelper.primaryColor,radius: 25.r,
                  child: SvgPicture.asset(ImageHelper.cleanIcon),),
                SizedBox(height: 10.h,),
                Text(item.service!,style: TextStyle(fontSize: 12,fontFamily: TextHelper.satoshiRegular),maxLines: 1,overflow: TextOverflow.ellipsis,),

              ],
            ),
          ),
        );
  }

  TextStyle _buildTextStyle({double? font}) => TextStyle(fontFamily: TextHelper.satoshiBold, fontSize:font?? 18);


}
/*
*
* import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/image_helper.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:darak_project/module/customer/main/worker_home/worker_home_controller.dart';
import 'package:darak_project/module/worker/addInfo/add_info_screen.dart';
import 'package:darak_project/services/common/user_store.dart';
import 'package:darak_project/widgets/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WorkerHomeScreen extends StatelessWidget {
   WorkerHomeScreen({Key? key}) : super(key: key);
    final _controller = Get.put(WorkerHomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GetBuilder<WorkerHomeController>(
          builder: (controller)=>
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, ${UserStore.t0.profile.displayName} 👋',
                          style:
                          _buildTextStyle(),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          'Welcome back Darak',
                          style: TextStyle(
                              fontFamily: TextHelper.satoshiRegular,
                              fontSize: 14,
                              color: ColorHelper.offWhiteColor),
                        ),
                      ],
                    ),
                  ]),
                  Row(
                    children: [
                      Text(
                        'Requests',
                        style:
                        _buildTextStyle(),
                      ),
                      const Spacer(),
                      D_TextButton(onPressed: () {}, text: 'View All',line: TextDecoration.none),
                    ],
                  ),
                  SizedBox(height: 10.h,),
                  _buildMainBody(controller),
                ],
              ),

        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add,color: Colors.white,),
        onPressed: (){
            Get.to(AddInfoScreen());
        },
      ),
    );
  }

   // RefreshIndicator getRequests(){
   //   return RefreshIndicator(
   //       onRefresh: _controller.asyncLoadAllData,
   //       child: _controller.reqList.isEmpty
   //           ?
   //       const Text('There is No any Request')
   //           :
   //       _buildMainBody(_controller)
   //   );
   // }

  Widget _buildMainBody(WorkerHomeController controller) {
    return Expanded(
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder:(context,index)=>_buildListItem(index),
                      separatorBuilder: (context,index)=>SizedBox(height: 10.h,),
                      itemCount: controller.reqList.length
                  ),
                );
  }

  Container _buildListItem(index) {
    var item = _controller.reqList[index].data();
    return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: ColorHelper.offPurpleColor)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.serviceName!,style: _buildTextStyle(font:16),maxLines: 1,overflow: TextOverflow.ellipsis,),
                SizedBox(height: 10.h,),
                _buildItem(icon: ImageHelper.bookIcon,title: item.date!),
                SizedBox(height: 10.h,),
                _buildItem(icon: ImageHelper.locationIcon,title: 'Gaza'),
                SizedBox(height: 10.h,),
                _buildItem(icon: ImageHelper.bookIcon,title: '${item.price}\$'),
                SizedBox(height: 10.h,),
                Row(
                  children: [
                    Expanded(child: D_MaterialButton(
                        onPressed: (){}, child: Text('Accept',style: buildTextStyleBtn(),))),
                    const SizedBox(width: 10,),
                    Expanded(
                        child: D_MaterialButton(
                            color: ColorHelper.offPurpleColor,
                            onPressed: (){}, child: Text('Cancel',style: buildTextStyleBtn(color: Colors.black),))),
                  ],
                )
              ],
            ),
          ),
        );
  }

  Row _buildItem({required String title, required String icon}) {
    return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(icon,color: ColorHelper.warmGrey,),
                    const SizedBox(width:5,),
                    Text(title,style: TextStyle(fontSize: 16,fontFamily: TextHelper.satoshiMedium,),maxLines: 1,overflow: TextOverflow.ellipsis,),
                  ],
                );
  }

  TextStyle _buildTextStyle({double? font}) => TextStyle(fontFamily: TextHelper.satoshiBold, fontSize:font?? 18);
}

* */
