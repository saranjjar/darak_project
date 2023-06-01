import 'package:cached_network_image/cached_network_image.dart';
import 'package:darak_project/Application/app_router/app_router.dart';
import 'package:darak_project/const.dart';
import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/image_helper.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:darak_project/model/msg_content.dart';
import 'package:darak_project/module/customer/main/chat/in_chat/inchat_controller.dart';
import 'package:darak_project/services/common/shared_pref.dart';
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
                                      _controller.sendMessage();
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
                   borderRadius: BorderRadius.circular(10),
                 ),
                 child: Text('${item.content}'))
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
               minHeight: 40.h
           ),
             child: Container(
                 margin: EdgeInsets.only(right: 10.w,top: 0.w),
                 padding: EdgeInsets.only(right: 10.w,top: 10.w,left: 10.w),
                 decoration:  BoxDecoration(
                   gradient: const LinearGradient(colors: [
                     Color.fromARGB(255, 176, 106, 231),
                     Color.fromARGB(255, 166, 112, 231),
                     Color.fromARGB(255, 131, 123, 231),
                     Color.fromARGB(255, 184, 132, 231),
                   ],
                     transform: GradientRotation(90),
                   ),
                   borderRadius: BorderRadius.circular(10),
                 ),
                 child: item.type=="text"
                     ?
                 Text('${item.content}')
                     :
                 ConstrainedBox(
                   constraints: BoxConstraints(
                       maxWidth: 90.w
                   ),
                   child: InkWell(
                       onTap: (){

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
