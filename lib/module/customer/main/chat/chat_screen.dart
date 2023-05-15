import 'package:cached_network_image/cached_network_image.dart';
import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/module/customer/main/chat/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
   ChatScreen({Key? key}) : super(key: key);
  final _controller = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        _controller.isLoading.value
            ?
        const Center(child: CircularProgressIndicator())
            :
        buildMainBody());
  }

  Widget buildMainBody() {
    return RefreshIndicator(
      onRefresh:()  {
        return _controller.asyncLoadAllData();
      },
     child: Column(
      children: [
        _controller.contactList.isEmpty
            ?
        const Text('The List is Empty:(')
            :
        Expanded(
          child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsetsDirectional.all(8),
              scrollDirection:Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context,index)=>_buildListItem(index),
              separatorBuilder: (context,index)=> SizedBox(height: 10.h,),
              itemCount: _controller.contactList.length,
          ),
        )
      ],
  ),
    );
  }

  Widget _buildListItem(int index) {
    var list = _controller.contactList[index];
    return InkWell(
      onTap: (){
        if(list.id!=null) {
          _controller.goChat(list);
        }
      },
      child: Container(
          width: double.infinity,
          height: 90.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: ColorHelper.warmGrey,
              width: 0.1,
            )
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: list.photoUrl!,
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),

                    ),
                  ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        list.name!,
                        style: const TextStyle(
                            fontSize: 20,
                            color: ColorHelper.blueAccent
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                          list.email!,
                          style: _textStyle1()
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
    );
  }
  TextStyle _textStyle1(){
    return const TextStyle(
        fontSize: 14,
        color: ColorHelper.darkHeaderBarBackground
    );
  }
}
