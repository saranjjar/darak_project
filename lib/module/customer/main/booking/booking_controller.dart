import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darak_project/model/booking_review.dart';
import 'package:darak_project/services/common/user_store.dart';
import 'package:get/get.dart';

class BookingController extends GetxController{
  RxList<QueryDocumentSnapshot<BookingReview>> bookingList = <QueryDocumentSnapshot<BookingReview>> [].obs;
  final token = UserStore.t0.token;
  final db = FirebaseFirestore.instance;
  //final RefreshController refreshController =RefreshController(initialRefresh: true);

  @override
  void onReady(){
    asyncLoadPendingBook();
  }

  // void onLoading(){
  //   asyncLoadAllData().then((_){
  //     //refreshController.loadComplete();
  //   }).catchError((_){
  //     //refreshController.loadFailed();
  //   });
  // }

  bool isLoading = false;
  Future<void> asyncLoadPendingBook() async{
    try{
      isLoading = true;
      update();
      var fromBooking = await db.collection("booking").withConverter(
          fromFirestore: BookingReview.fromFirestore,
          toFirestore: (BookingReview book,options)=>book.toFirestore()).where(
          "uid",isEqualTo:token
      ).where('status',isEqualTo: 'pending').get();

      if(fromBooking.docs.isNotEmpty){
        bookingList.assignAll(fromBooking.docs);
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
