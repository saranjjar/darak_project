import 'package:cached_network_image/cached_network_image.dart';
import 'package:darak_project/Application/app_router/app_router.dart';
import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/image_helper.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:darak_project/model/msg_content.dart';
import 'package:darak_project/module/customer/main/chat/in_chat/inchat_controller.dart';
import 'package:darak_project/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class InChatScreen extends StatelessWidget {
   InChatScreen({Key? key}) : super(key: key);
  final _controller =  Get.put(InChatController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar:_headerScreen(context),
      body: SafeArea(
          child: ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: Obx(
                    ()=>Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: chatList(),
                        ),
                        Positioned(
                            height:50.h ,
                            bottom: 20.h,
                            left: 8.w,
                            right: 8.w,
                            child: SizedBox(
                              height: 50.h,
                              width: 360.w,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormFieldCustom(
                                      textEditingController: _controller.textController,
                                      keyboardType: TextInputType.multiline,
                                      maxline: 3,
                                      focusNode: _controller.contentNode,
                                      auto_focus: false,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        _controller.showPicker(context);
                                      },
                                      icon: SvgPicture.asset(ImageHelper.camIcon,color:ColorHelper.primaryColor)),
                                  InkWell(
                                    onTap: (){
                                      if(_controller.textController.text.isNotEmpty) {
                                        _controller.sendMessage();
                                      }
                                    },
                                    child: Container(
                                        width: 35.w,
                                        height: 35.h,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: ColorHelper.primaryColor),
                                        child: SvgPicture.asset(
                                          ImageHelper.sendIcon,
                                          fit: BoxFit.none,
                                        )),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
            )
          )),
    );
  }

  AppBar _headerScreen(context) {
    return AppBar(
      backgroundColor: ColorHelper.primaryColor,
      leading: IconButton(onPressed: () {
        Get.back();
      }, icon: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundImage: NetworkImage(_controller.to_avatar.value),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    _controller.to_name.value,
                    style: TextStyle(
                        fontSize: 16, fontFamily: TextHelper.satoshiBold,color: Colors.white),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: ColorHelper.green1,
                        radius: 3,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                       Text(
                        'online',
                        style: TextStyle(
                            color: ColorHelper.light1,
                            fontSize: 12,
                            fontFamily: TextHelper.satoshiRegular),
                      )
                    ],
                  )
                ],
              )),
        ],
      ),

    );
  }

  //chat list
  Widget chatList(){
    return Container(
      color: ColorHelper.light1,
      padding: EdgeInsets.only(bottom: 50.h),
      child: CustomScrollView(
        reverse: true,
        controller: _controller.msgScrolling,
        slivers: [
          SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 0.w,horizontal: 0.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context,index){
                      var item = _controller.msgContact[index];
                      if(_controller.user_id==item.uid){
                        return chatRightItem(item);
                      }else{
                        return chatLeftItem(item);
                      }
                    },
                  childCount: _controller.msgContact.length
                ),
              ),
          ),
        ],
      ),
    );
  }

  //chat item
  Widget chatRightItem(MsgContent item){
     return Padding(
       padding:  EdgeInsets.only(
         top: 10.h,
         bottom: 10.h,
         right: 15.w,
         left: 15.w,
       ),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.start,
         children: [
           ConstrainedBox(constraints: BoxConstraints(
               maxWidth: 230.w,
               minHeight: 30.h
           ),
             child: item.type=="text"
                 ?
             Container(
                 margin: EdgeInsets.only(right: 10.w,top: 0.w),
                 padding: EdgeInsets.only(right: 10.w,top: 10.w,left: 10.w),
                 decoration:  BoxDecoration(
                   color: ColorHelper.primaryColor.withOpacity(0.8),
                   borderRadius: const BorderRadius.only(bottomRight: Radius.circular(12),topLeft:Radius.circular(12),topRight: Radius.circular(12) ),
                 ),
                 child: Text('${item.content}',style: TextStyle(color: Colors.white,fontFamily: TextHelper.satoshiMedium),))
                 :
             Container(
               clipBehavior: Clip.antiAliasWithSaveLayer,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(12)
               ),
               child: ConstrainedBox(
                 constraints: BoxConstraints(
                     maxWidth: 90.w
                 ),
                 child: InkWell(
                     onTap: (){
                        Get.toNamed(Routes.photoViewRoutes,parameters: {"url":item.content??""});
                     },
                     child: CachedNetworkImage(imageUrl: '${item.content}')),
               ),
             ),
           )
         ],
       ),
     );
   }
  //chat item
  Widget chatLeftItem(MsgContent item){
     return Padding(
       padding:  EdgeInsets.only(
         top: 10.h,
         bottom: 10.h,
         right: 15.w,
         left: 15.w,
       ),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.end,
         children: [
           ConstrainedBox(constraints: BoxConstraints(
               maxWidth: 230.w,
               minHeight: 30.h
           ),
             child: Container(
                 margin: EdgeInsets.only(right: 10.w,top: 0.w),
                 padding: EdgeInsets.only(right: 10.w,top: 10.w,left: 10.w),
                 decoration:   BoxDecoration(
                   color: Colors.grey.shade400,

                   borderRadius: BorderRadius.only(bottomLeft: Radius.circular(18),topLeft:Radius.circular(12),topRight: Radius.circular(12) ),
                 ),
                 child: item.type=="text"
                     ?
                 Text('${item.content}',style: TextStyle(color: Colors.white,fontFamily: TextHelper.satoshiMedium),)
                     :
                 ConstrainedBox(
                   constraints: BoxConstraints(
                       maxWidth: 90.w
                   ),
                   child: InkWell(
                       onTap: (){
                         Get.toNamed(Routes.photoViewRoutes,parameters: {"url":item.content??""});

                       },
                       child: CachedNetworkImage(imageUrl: '${item.content}')),
                 )
             ),
           )
         ],
       ),
     );
   }

  TextStyle hintTextStyle() {
    return  TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: TextHelper.satoshiRegular,
        color: ColorHelper.primaryColor);
  }

  TextStyle firstTextStyle() {
    return  TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 18,
      fontFamily: TextHelper.satoshiBold,
    );
  }

  TextStyle secondTextStyle() {
    return  TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: TextHelper.satoshiRegular,
        color: ColorHelper.primaryColor
    );
  }

 }
