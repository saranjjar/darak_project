import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darak_project/model/booking_review.dart';
import 'package:darak_project/services/common/user_store.dart';
import 'package:get/get.dart';

class BookingController extends GetxController{
  RxList<QueryDocumentSnapshot<BookingReview>> bookingsList = <QueryDocumentSnapshot<BookingReview>> [].obs;
  RxList<QueryDocumentSnapshot<BookingReview>> upComingsList = <QueryDocumentSnapshot<BookingReview>> [].obs;
  RxList<QueryDocumentSnapshot<BookingReview>> completedList = <QueryDocumentSnapshot<BookingReview>> [].obs;

  final token = UserStore.t0.token;
  final db = FirebaseFirestore.instance;

  @override
  void onReady(){
    asyncLoadPendingBook();
    asyncLoadUpComing();
    asyncLoadCompleted();
  }


  //upcoming
  bool isLoadingUp = false;
  Future<void> asyncLoadUpComing() async{
    try{
      isLoadingUp = true;
      update();
      var fromBooking = await db.collection("booking").withConverter(
          fromFirestore: BookingReview.fromFirestore,
          toFirestore: (BookingReview book,options)=>book.toFirestore()).where(
          "uid",isEqualTo:token
      ).where('status',isEqualTo: 'upcoming').get();

      if(fromBooking.docs.isNotEmpty){
        upComingsList.assignAll(fromBooking.docs);
        upComingsList.sort((a, b) {
          var dateA = a.data().date;
          var dateB = b.data().date;
          return dateA!.compareTo(dateB!);
        });
      }

      isLoadingUp = false;
      update();
    }catch(error){
      print(error.toString());
      isLoadingUp = false;
      update();
    }
  }

  //pending
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
        bookingsList.assignAll(fromBooking.docs);
      }

      isLoading = false;
      update();
    }catch(error){
      print(error.toString());
      isLoading = false;
      update();
    }
  }

  bool isLoadingComp = false;
  Future<void> asyncLoadCompleted() async{
    try{
      isLoadingComp = true;
      update();
      var fromBooking = await db.collection("booking").withConverter(
          fromFirestore: BookingReview.fromFirestore,
          toFirestore: (BookingReview book,options)=>book.toFirestore()).where(
          "uid",isEqualTo:token
      ).where('status',isEqualTo: 'completed').get();

      if(fromBooking.docs.isNotEmpty){
        completedList.assignAll(fromBooking.docs);
        completedList.sort((a, b) {
          var dateA = a.data().date;
          var dateB = b.data().date;
          return dateA!.compareTo(dateB!);
        });
      }

      isLoadingComp = false;
      update();
    }catch(error){
      print(error.toString());
      isLoadingComp = false;
      update();
    }
  }
}
