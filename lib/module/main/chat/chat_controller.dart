import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darak_project/Application/app_router/app_router.dart';
import 'package:darak_project/model/message.dart';
import 'package:darak_project/model/user.dart';
import 'package:darak_project/services/common/user_store.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ChatController extends GetxController{

  var count = 0.obs;

  final db = FirebaseFirestore.instance;
  final token = UserStore.t0.token;

  goChat(UserData to_userdata) async{
    print('object*********************************************************************');
    //From Message
    var from_messages = await db.collection('message').withConverter(
      fromFirestore: Message.fromFirestore,
      toFirestore: (Message msg,options)=>msg.toFirestore()).where(
          "from_uid",isEqualTo: token
      ).where(
          "to_uid",isEqualTo: to_userdata.id
      ).get();

    //To Message
    var to_messages = await db.collection('message').withConverter(
        fromFirestore: Message.fromFirestore,
        toFirestore: (Message msg,options)=>msg.toFirestore()).where(
        "from_uid",isEqualTo: to_userdata.id
    ).where(
        "to_uid",isEqualTo: token
    ).get();
    //There is No Messages between them yet
    if(from_messages.docs.isEmpty && to_messages.docs.isEmpty){
      String profile = await UserStore.t0.getProfile();
      Users userdata = Users.fromJson(jsonDecode(profile));
      var msgdata = Message(
        from_uid: userdata.accessToken,
        to_uid: to_userdata.id,
        from_name: userdata.displayName,
        to_name: to_userdata.name,
        from_avatar: userdata.photoUrl,
        to_avatar: to_userdata.photoUrl,
        last_msg: "",
        last_time: Timestamp.now(),
        msg_num: 0
      );
      db.collection('message').withConverter(
          fromFirestore: Message.fromFirestore,
          toFirestore: (Message msg,options)=>msg.toFirestore()
      ).add(msgdata).then((value){
        Get.toNamed(Routes.inChatScreenRoute,parameters: {
          "doc_id":value.id,
          "to_uid":to_userdata.id??"",
          "to_name":to_userdata.name??"",
          "to_avatar":to_userdata.photoUrl??""
        });
      });
    }
    else{
      if(from_messages.docs.isNotEmpty){
        Get.toNamed(Routes.inChatScreenRoute,parameters: {
          "doc_id":from_messages.docs.first.id,
          "to_uid":to_userdata.id??"",
          "to_name":to_userdata.name??"",
          "to_avatar":to_userdata.photoUrl??""
        });
      }
      if(to_messages.docs.isNotEmpty){
        Get.toNamed(Routes.inChatScreenRoute,parameters: {
          "doc_id":to_messages.docs.first.id,
          "to_uid":to_userdata.id??"",
          "to_name":to_userdata.name??"",
          "to_avatar":to_userdata.photoUrl??""
        });
      }
    }
  }
 //get user data method

  RxList<UserData> contactList = <UserData> [].obs;
  RxBool isLoading = false.obs;

  Future<void> asyncLoadAllData() async{
   isLoading.value = true;
    var userbase = await db.collection('users').where("id",isNotEqualTo: token).withConverter(
        fromFirestore: UserData.fromFirestore,
        toFirestore: (UserData userdata,options)=>userdata.toFirestore()).get();
    for(var doc in userbase.docs){
      contactList.add(doc.data());
    }
    isLoading.value = false;
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    asyncLoadAllData();
  }

}