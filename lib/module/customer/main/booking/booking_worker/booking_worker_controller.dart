import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darak_project/model/booking_review.dart';
import 'package:darak_project/services/common/user_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingWorkerController extends GetxController{
  RxList<QueryDocumentSnapshot<BookingReview>> bookingList = <QueryDocumentSnapshot<BookingReview>> [].obs;
  RxList<QueryDocumentSnapshot<BookingReview>> upComingList = <QueryDocumentSnapshot<BookingReview>> [].obs;
  RxList<QueryDocumentSnapshot<BookingReview>> completedList = <QueryDocumentSnapshot<BookingReview>> [].obs;

  final token = UserStore.t0.token;
  final db = FirebaseFirestore.instance;
  ScrollController bookScrolling = ScrollController();

  @override
  void onReady(){
    asyncLoadPendingBook();
    asyncLoadUpComing();
    asyncLoadCompleted();
  }


  bool isLoading = false;
  Future<void> asyncLoadPendingBook() async{
    try{
      isLoading = true;
      update();
      var fromBooking = await db.collection("booking").withConverter(
          fromFirestore: BookingReview.fromFirestore,
          toFirestore: (BookingReview book,options)=>book.toFirestore()).where(
          "toUid",isEqualTo:token
      ).where('status',isEqualTo: 'pending').get();

      if(fromBooking.docs.isNotEmpty){
        bookingList.assignAll(fromBooking.docs);
      }
      isLoading = false;
      update();
    }catch(error){
      if (kDebugMode) {
        print(error.toString());
      }
      isLoading = false;
      update();
    }
  }

  bool isLoadingUp = false;
  Future<void> asyncLoadUpComing() async{
    try{
      isLoadingUp = true;
      update();
      var fromBooking = await db.collection("booking").withConverter(
          fromFirestore: BookingReview.fromFirestore,
          toFirestore: (BookingReview book,options)=>book.toFirestore()).where(
          "toUid",isEqualTo:token
      ).where('status',isEqualTo: 'upcoming').get();

      if(fromBooking.docs.isNotEmpty){
        upComingList.assignAll(fromBooking.docs);
        upComingList.sort((a, b) {
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

  bool isLoadingComp = false;
  Future<void> asyncLoadCompleted() async{
    try{
      isLoadingUp = true;
      update();
      var fromBooking = await db.collection("booking").withConverter(
          fromFirestore: BookingReview.fromFirestore,
          toFirestore: (BookingReview book,options)=>book.toFirestore()).where(
          "toUid",isEqualTo:token
      ).where('status',isEqualTo: 'completed').get();

      if(fromBooking.docs.isNotEmpty){
        completedList.assignAll(fromBooking.docs);
        completedList.sort((a, b) {
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



  Future<void> updateBookingStatus({required String idDoc,required String valueSt}) async {
     try{ db.collection("booking").doc(idDoc).update({'status': valueSt});
      print('Status updated successfully');
    await asyncLoadPendingBook();
    update();
    }
        catch(error) {
      print('Failed to update status: $error');
    }

  }

}
