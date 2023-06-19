import 'package:darak_project/Application/app_router/app_router.dart';
import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/image_helper.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:darak_project/module/customer/main/worker_home/add_service/get_sub_category/get_sub_category_screen.dart';
import 'package:darak_project/module/customer/main/worker_home/worker_home_controller.dart';
import 'package:darak_project/module/worker/addInfo/add_info_screen.dart';
import 'package:darak_project/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
class AddServiceScreen extends StatelessWidget {
  AddServiceScreen({Key? key}) : super(key: key);
  final _controller = Get.put(WorkerHomeController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(title: 'My Services'),
      body: _controller.isLoading
          ?
      const Center(child: CircularProgressIndicator())
          :
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: getService(),
      )
      ,
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

  Widget _buildGridItem(index) {
    var item = _controller.serviceList[index].data();
    return InkWell(
      onTap: (){
        Get.toNamed(
            Routes.getSubRoutes,
            parameters:{
              'title':item.service!
            } );
      },
      child: Container(
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
      ),
    );
  }
}
