import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darak_project/Application/app_router/app_router.dart';
import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/model/message.dart';
import 'package:darak_project/module/main/chat/chat_history/chat_history_controller.dart';
import 'package:darak_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChatHistoryScreen extends StatelessWidget {
  ChatHistoryScreen({Key? key}) : super(key: key);
  final _controller = Get.put(ChatHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() => SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            controller: _controller.refreshController,
            onLoading: _controller.onLoading,
            onRefresh: _controller.onRefresh,
            header: const WaterDropHeader(),
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.w,
                    vertical: 0.w,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      var item = _controller.msgList[index];
                      return messageListItem(item);
                    },childCount: _controller.msgList.length),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget messageListItem(QueryDocumentSnapshot<Message> item){
    return Container(
      padding: EdgeInsets.only(top: 10.w,left: 15.w,right: 15.w),
      child: InkWell(
        onTap: (){
            var to_uid = "";
            var to_name = "";
            var to_avatar = "";
            if(item.data().from_uid==_controller.token){
              to_uid = item.data().to_uid ?? "";
              to_name = item.data().to_name ?? "";
              to_avatar = item.data().to_avatar ?? "";
            }else{
              to_uid = item.data().from_uid ?? "";
              to_name = item.data().from_name ?? "";
              to_avatar = item.data().from_avatar ?? "";
            }
            Get.toNamed(Routes.inChatScreenRoute,parameters: {
              "doc_id":item.id,
              "to_uid":to_uid,
              "to_name":to_name,
              "to_avatar":to_avatar,
            });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 0.w,left: 0.w,right: 10.w),
              child: SizedBox(
                width: 50.w,
                height: 50.h,
                child: CachedNetworkImage(
                    imageUrl: item.data().from_uid == _controller.token
                        ?
                    item.data().to_avatar!
                        :
                    item.data().from_avatar!,
                  imageBuilder: (context,imageProvider)=>Container(
                    width: 50.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.w,left: 15.w,right: 15.w),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: ColorHelper.offWhiteColor,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 180.w,
                    height: 50.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.data().from_uid==_controller.token
                              ?
                          item.data().to_name!
                              :
                          item.data().from_name!,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ),
                        Text(
                          item.data().last_msg??"",
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 54.h,
                    width: 60.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          duTimeFormat((item.data().last_time!).toDate()),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ),

                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
