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
    var fromMessage = await db.collection("message").withConverter(
        fromFirestore: Message.fromFirestore,
        toFirestore: (Message msg,options)=>msg.toFirestore()).where(
      "from_uid",isEqualTo:token
    ).get();

    var toMessage = await db.collection("message").withConverter(
        fromFirestore: Message.fromFirestore,
        toFirestore: (Message msg,options)=>msg.toFirestore()).where(
      "to_uid",isEqualTo:token
    ).get();
    msgList.clear();
    if(fromMessage.docs.isNotEmpty){
      msgList.assignAll(fromMessage.docs);
    }
    if(toMessage.docs.isNotEmpty){
      msgList.assignAll(toMessage.docs);
    }
  }
  getFcmToken() async{
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if(fcmToken!=null){
      var user = await db.collection("users").where("id",isEqualTo: token).get();
      if(user.docs.isNotEmpty){
        var docId = user.docs.first.id;
        await db.collection("users").doc(docId).update({"fcmtoken": fcmToken});
      }
    }
  }
}