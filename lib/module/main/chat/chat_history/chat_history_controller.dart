import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darak_project/model/message.dart';
import 'package:darak_project/services/common/user_store.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChatHistoryController extends GetxController{
  RxList<QueryDocumentSnapshot<Message>> msgList = <QueryDocumentSnapshot<Message>> [].obs;
  final token = UserStore.t0.token;
  final db = FirebaseFirestore.instance;
  final RefreshController refreshController =RefreshController(initialRefresh: true);

  void onRefresh(){
    asyncLoadAllData().then((_){
      refreshController.refreshCompleted(resetFooterState: true);
    }).catchError((_){
      refreshController.refreshFailed();
    });
  }

  void onLoading(){
    asyncLoadAllData().then((_){
      refreshController.loadComplete();
    }).catchError((_){
      refreshController.loadFailed();
    });
  }

  asyncLoadAllData() async{
    var from_message = await db.collection("message").withConverter(
        fromFirestore: Message.fromFirestore,
        toFirestore: (Message msg,options)=>msg.toFirestore()).where(
      "from_uid",isEqualTo:token
    ).get();

    var to_message = await db.collection("message").withConverter(
        fromFirestore: Message.fromFirestore,
        toFirestore: (Message msg,options)=>msg.toFirestore()).where(
      "to_uid",isEqualTo:token
    ).get();
    msgList.clear();
    if(from_message.docs.isNotEmpty){
      msgList.assignAll(from_message.docs);
    }
    if(to_message.docs.isNotEmpty){
      msgList.assignAll(to_message.docs);
    }
  }
  getFcmToken() async{
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if(fcmToken!=null){
      var user = await db.collection("users").where("id",isEqualTo: token).get();
      if(user.docs.isNotEmpty){
        var doc_id = user.docs.first.id;
        await db.collection("users").doc(doc_id).update({"fcmtoken": fcmToken});
      }
    }
  }
}