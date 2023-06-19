import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darak_project/model/booking_review.dart';
import 'package:darak_project/services/common/user_store.dart';
import 'package:get/get.dart';

class BookingWorkerController extends GetxController{
  RxList<QueryDocumentSnapshot<BookingReview>> bookingList = <QueryDocumentSnapshot<BookingReview>> [].obs;
  RxList<QueryDocumentSnapshot<BookingReview>> upComingList = <QueryDocumentSnapshot<BookingReview>> [].obs;
  final token = UserStore.t0.token;
  final db = FirebaseFirestore.instance;

  @override
  void onReady(){
    asyncLoadPendingBook();
    asyncLoadUpComing();
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
        print('[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[object]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]');

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
        print('[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[object]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]');

        upComingList.assignAll(fromBooking.docs);
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
    }
        catch(error) {
      print('Failed to update status: $error');
    }

  }
}
