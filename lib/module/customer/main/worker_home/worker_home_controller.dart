import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darak_project/model/booking_review.dart';
import 'package:darak_project/services/common/user_store.dart';
import 'package:get/get.dart';

class WorkerHomeController extends GetxController{
  RxList<QueryDocumentSnapshot<BookingReview>> reqList = <QueryDocumentSnapshot<BookingReview>> [].obs;
  final token = UserStore.t0.token;
  final db = FirebaseFirestore.instance;
  //final RefreshController refreshController =RefreshController(initialRefresh: true);

  @override
  void onReady(){
    asyncLoadAllData();
  }

  // void onLoading(){
  //   asyncLoadAllData().then((_){
  //     //refreshController.loadComplete();
  //   }).catchError((_){
  //     //refreshController.loadFailed();
  //   });
  // }

  bool isLoading = false;
  Future<void> asyncLoadAllData() async{
    try{
      isLoading = true;
      update();
      var fromBooking = await db.collection("booking").withConverter(
          fromFirestore: BookingReview.fromFirestore,
          toFirestore: (BookingReview book,options)=>book.toFirestore()).where(
          "toUid",isEqualTo:token
      ).get();

      if(fromBooking.docs.isNotEmpty){
        reqList.assignAll(fromBooking.docs);
      }

      isLoading = false;
      update();
    }catch(error){
      print(error.toString());
      isLoading = false;
      update();
    }
  }
  // getFcmToken() async{
  //   final fcmToken = await FirebaseMessaging.instance.getToken();
  //   if(fcmToken!=null){
  //     var user = await db.collection("users").where("id",isEqualTo: token).get();
  //     if(user.docs.isNotEmpty){
  //       var docId = user.docs.first.id;
  //       await db.collection("users").doc(docId).update({"fcmtoken": fcmToken});
  //     }
  //   }
  // }
}