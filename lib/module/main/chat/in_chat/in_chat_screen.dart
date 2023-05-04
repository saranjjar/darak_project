import 'package:cached_network_image/cached_network_image.dart';
import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/image_helper.dart';
import 'package:darak_project/helpers/texts_heleper.dart';
import 'package:darak_project/model/msg_content.dart';
import 'package:darak_project/module/main/chat/in_chat/inchat_controller.dart';
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
      appBar:_headerScreen(context),
      body: SafeArea(
          child: ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: Obx(
                    ()=>Stack(
                      children: [
                        chatList(),
                        Positioned(
                            height:50.h ,
                            bottom: 4.h,
                            left: 4.w,
                            right: 4.w,
                            child: SizedBox(
                              height: 50.h,
                              width: 360.w,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormFieldCustom(
                                      // hieght: 50.h,
                                      // width: 217.w,
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
                                      icon: SvgPicture.asset(ImageHelper.camIcon)),
                                  InkWell(
                                    onTap: (){
                                      _controller.sendMessage();
                                    },
                                    child: Container(
                                        width: 40.w,
                                        height: 40.h,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.circular(10),
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
      }, icon: const Icon(Icons.arrow_back_ios)),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundImage: AssetImage(ImageHelper.profileIcon),
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
                    'Sara',
                    style: TextStyle(
                        fontSize: 16, fontFamily: TextHelper.satoshiBold),
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

  Widget _buildItem({
    required String text1,
    required String text2,
    required String icon,
    void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: ColorHelper.primaryColor,
              radius: 25,
              child: SvgPicture.asset(icon),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text1,
                    style:  TextStyle(
                      fontSize: 14,
                      fontFamily: TextHelper.satoshiRegular,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    text2,
                    style:  TextStyle(
                        fontSize: 12,
                        fontFamily: TextHelper.satoshiRegular,
                        fontWeight: FontWeight.w400,
                        color: ColorHelper.primaryColor),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
/*
* Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(ImageHelper.camIcon)),
                      IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(ImageHelper.uploadIcon)),
                      Expanded(
                        child: TextFormFieldCustom(
                          hieght: 40.h,
                          hintText: 'Write',
                          textEditingController: TextEditingController(),
                          keyboardType: TextInputType.text,),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              color: ColorHelper.blueAccent),
                          child: SvgPicture.asset(
                            ImageHelper.sendIcon,
                            fit: BoxFit.none,
                          )),
                    ],
                  ),
                ),
              )
* */

//
//
//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:darak_project/helpers/colors_helper.dart';
// import 'package:darak_project/widgets/bubble_msg.dart';
// import 'package:darak_project/widgets/textformfield.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class InChatScreen extends StatefulWidget {
//   final String id;
//   final String name;
//   const InChatScreen( this.id,this.name ,{Key? key}) : super(key: key);
//
//   @override
//   State<InChatScreen> createState() => _InChatScreenState();
// }
//
// class _InChatScreenState extends State<InChatScreen> {
//   @override
//   Widget build(BuildContext context) {
//     var textMsg = TextEditingController();
//
//     _sendMessage() async{
//       FocusScope.of(context).unfocus();
//       final user = FirebaseAuth.instance.currentUser;
//       final userData = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
//       FirebaseFirestore.instance.collection('chats').add({
//         'text' : textMsg.text,
//         'username':userData['username'],
//         'userId':user.uid,
//         'createdAt': Timestamp.now(),
//       });
//       textMsg.clear();
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: ColorHelper.primaryColor,
//         title: Center(child: Text(widget.name??'',style: TextStyle(fontSize: 20.sp),)),
//         automaticallyImplyLeading: false,
//         leading: const Icon(Icons.arrow_back_ios_new_outlined),
//       ),
//       body: Stack(
//         children:[
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 Expanded(
//                     child: Message()
//                 ),
//                 Row(children: [
//                   Expanded(
//                       child: TextFormFieldCustom(
//                         suffixIcon:const Icon( Icons.camera_alt,
//                         color: ColorHelper.primaryColor),
//                         textEditingController: textMsg,
//                         keyboardType: TextInputType.text,
//                           ),
//                   ),
//                    SizedBox(
//                     width: 12.w
//                     ,
//                   ),
//                   Row(
//                     children: [
//                       buildContainerChat(iconData: Icons.mic),
//                       SizedBox(width: 5.w,),
//                       InkWell(
//                         onTap: (){
//                           textMsg.text == '' ? null : _sendMessage();
//                         },
//                           child: buildContainerChat(iconData: Icons.send,)),
//                     ],
//                   )
//                 ]),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Container buildContainerChat({required IconData iconData}) {
//     return Container(
//                       height: 50.h,
//                       width: 50.h,
//                       decoration: BoxDecoration(
//                         color: Colors.grey[200],
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child:  Center(
//                           child: Icon(
//                             iconData,
//                             color: ColorHelper.primaryColor,
//                           )),
//                     );
//   }
//
//   Widget Message(){
//     return StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('chats').orderBy('createdAt',descending: false).snapshots(),
//         builder: (context,snapShot){
//           if(snapShot.connectionState == ConnectionState.waiting){
//             return const Center(child: CircularProgressIndicator());
//           }
//           final docs = snapShot.data!.docs;
//           final user = FirebaseAuth.instance.currentUser;
//           return ListView.builder(
//               itemCount: docs.length,
//               itemBuilder: (context,index)=>BubbleMessage(
//                   msg: docs[index]['text'],
//                   username: docs[index]['username'],
//                   key1:  ValueKey(docs[index].id),
//                   isMe: docs[index]['userId']==user!.uid,
//               ),
//
//           );
//         }
//     );
//   }
//
// }
