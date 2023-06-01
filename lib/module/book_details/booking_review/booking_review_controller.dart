import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darak_project/Application/app_router/app_router.dart';
import 'package:darak_project/const.dart';
import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:darak_project/model/booking_review.dart';
import 'package:darak_project/services/common/shared_pref.dart';
import 'package:darak_project/services/common/user_store.dart';
import 'package:darak_project/widgets/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingReviewController extends GetxController {
  RxList<BookingReview> msgContact = <BookingReview>[].obs;
  var to_uid = ''.obs;
  var to_name = ''.obs;
  var to_avatar = ''.obs;
  var to_location = 'unKnown'.obs;
  var doc_id = null;

  RxBool isLoading = false.obs;
  String date = StorageService.to.getString(Constants.STRORAGE_Date) ?? '-';
  String time = StorageService.to.getString(Constants.STRORAGE_TIME) ?? '-';
  String price = StorageService.to.getString(Constants.STRORAGE_PRICE) ?? '-';
  String workingHour = StorageService.to.getString(Constants.STRORAGE_WORKING_HOURS) ?? '-';
  String toUid = StorageService.to.getString(Constants.STRORAGE_TO_UID) ?? '-';
  String worker = StorageService.to.getString(Constants.STRORAGE_WORKER_NAME)??'';
  String serviceName = StorageService.to.getString(Constants.STRORAGE_SERVICE_NAME)??"";

  final user_id = UserStore.t0.token;
  final db = FirebaseFirestore.instance;

  Future<void> sendBookingReview() async {
    try {
      // Create a new document in the "requests" collection
      final content = BookingReview(
          uid: user_id,
          toUid: toUid,
          nameCustomer: UserStore.t0.profile.displayName,
          serviceName: serviceName,
          category: StorageService.to.getString(Constants.STRORAGE_SERVICE_NAME),
          date: date,
          status: 'pending',
          worker: worker,
          workingHours: workingHour,
          price: price
      );
          await db
              .collection('booking')
              .withConverter(
              fromFirestore: BookingReview.fromFirestore,
              toFirestore: (BookingReview bookingReview, options) =>
                  bookingReview.toFirestore())
              .add(content)
              .then((DocumentReference doc) {
            Get.focusScope?.unfocus();
          });
    }catch(e){
      print(e.toString());
      isLoading.value=false;

    }
      isLoading.value = false;
      showDefaultDialog();
//       final requestDoc = FirebaseFirestore.instance.collection('requests').doc('Hello World').collection('clean').doc();
//       await requestDoc.set({
//         'serviceProviderId': to_uid.value,
//         'status': 'pending',
// //        'content':content,
//       });
//       print('Request sent successfully!');
//     } catch (e) {
//       print('Failed to send request: $e');
//     }
  }

  //send Message Method
  // sendBookingReview() async {
  //   try {
  //     isLoading.value = true;
  //     final content = BookingReview(
  //         uid: user_id,
  //         serviceName: 'Cleaning',
  //         category: "cleaning",
  //         date: date,
  //         status: 'pining',
  //         worker: 'Loss',
  //         workingHours: workingHour,
  //         price: price);
  //
  //     await db
  //         .collection('booking')
  //         .doc(doc_id)
  //         .collection('bookDetails')
  //         .withConverter(
  //         fromFirestore: BookingReview.fromFirestore,
  //         toFirestore: (BookingReview bookingReview, options) =>
  //             bookingReview.toFirestore())
  //         .add(content)
  //         .then((DocumentReference doc) {
  //       Get.focusScope?.unfocus();
  //     });
  //     StorageService.to.remove(Constants.STRORAGE_Date);
  //     StorageService.to.remove(Constants.STRORAGE_PRICE);
  //     StorageService.to.remove(Constants.STRORAGE_TIME);
  //     StorageService.to.remove(Constants.STRORAGE_WORKING_HOURS);
  //     StorageService.to.remove(Constants.STRORAGE_DOC_UID);
  //     StorageService.to.remove(Constants.STRORAGE_TO_UID);
  //     StorageService.to.remove(Constants.STRORAGE_TO_NAME);
  //     StorageService.to.remove(Constants.STRORAGE_TO_AVATAR);
  //   } catch (error) {
  //     isLoading.value = false;
  //     if (kDebugMode) {
  //       print(error.toString());
  //     }
  //   }
  //   isLoading.value = false;
  //   showDefaultDialog();
  // }

  void showDefaultDialog() {
    Get.defaultDialog(
      title: "",
      titleStyle: TextStyle(fontFamily: TextHelper.satoshiBold,fontSize: 18),
      content:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Icon(Icons.check_circle,size: 50,color: ColorHelper.green1,),
            Text("Booking Service Success",style: TextStyle(fontFamily: TextHelper.satoshiMedium,fontSize: 14),),
          ],
        ),
      ),
      confirm: D_MaterialButton(onPressed: (){
        Get.offAllNamed(Routes.layoutRoute);
      }, child: Text('Done',style: buildTextStyleBtn(),)),

    );
  }
  remove(){
    StorageService.to.remove(Constants.STRORAGE_WORKER_NAME);
    StorageService.to.remove(Constants.STRORAGE_SERVICE_NAME);
    StorageService.to.remove(Constants.STRORAGE_TO_UID);
    StorageService.to.remove(Constants.STRORAGE_Date);
    StorageService.to.remove(Constants.STRORAGE_PRICE);
    StorageService.to.remove(Constants.STRORAGE_TIME);
    StorageService.to.remove(Constants.STRORAGE_WORKING_HOURS);

  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    doc_id = StorageService.to.getString(Constants.STRORAGE_DOC_UID);
    to_uid.value = StorageService.to.getString(Constants.STRORAGE_TO_UID);
    to_name.value = StorageService.to.getString(Constants.STRORAGE_TO_NAME);
    to_avatar.value = StorageService.to.getString(Constants.STRORAGE_TO_AVATAR);
  }

// @override
// void onReady() {
//   // TODO: implement onReady
//   super.onReady();
//   var messages = db.collection('message').doc(doc_id).collection("msglist").withConverter(
//       fromFirestore: BookingReview.fromFirestore,
//       toFirestore: (BookingReview msgcontent,options)=>msgcontent.toFirestore()
//   ).orderBy("addtime",descending: false);
//   msgContact.clear();
//   listener = messages.snapshots().listen((event) {
//     for(var change in event.docChanges){
//       switch(change.type){
//         case DocumentChangeType.added:
//           if(change.doc.data()!=null){
//             msgContact.insert(0, change.doc.data()!);
//           }
//           break;
//         case DocumentChangeType.modified:
//           break;
//         case DocumentChangeType.removed:
//           break;
//
//       }
//     }
//   },
//       onError: (error)=>print('Listen Failed : $error')
//   );
// }
}











// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:darak_project/Application/app_router/app_router.dart';
// import 'package:darak_project/const.dart';
// import 'package:darak_project/helpers/colors_helper.dart';
// import 'package:darak_project/helpers/texts_helper.dart';
// import 'package:darak_project/model/booking_review.dart';
// import 'package:darak_project/services/common/shared_pref.dart';
// import 'package:darak_project/services/common/user_store.dart';
// import 'package:darak_project/widgets/components/components.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class BookingReviewController extends GetxController {
//   RxList<BookingReview> msgContact = <BookingReview>[].obs;
//   var to_uid = ''.obs;
//   var to_name = ''.obs;
//   var to_avatar = ''.obs;
//   var to_location = 'unKnown'.obs;
//   var doc_id = null;
//
//   RxBool isLoading = false.obs;
//   String date = StorageService.to.getString(Constants.STRORAGE_Date) ?? '-';
//   String time = StorageService.to.getString(Constants.STRORAGE_TIME) ?? '-';
//   String price = StorageService.to.getString(Constants.STRORAGE_PRICE) ?? '-';
//   String workingHour =
//       StorageService.to.getString(Constants.STRORAGE_WORKING_HOURS) ?? '-';
//
//   final textController = TextEditingController();
//
//   FocusNode contentNode = FocusNode();
//   final user_id = UserStore.t0.token;
//   final db = FirebaseFirestore.instance;
//
//   //send Message Method
//   sendBookingReview() async {
//     try {
//       isLoading.value = true;
//       final content = BookingReview(
//           uid: user_id,
//           serviceName: 'Cleaning',
//           category: "cleaning",
//           date: date,
//           status: 'pining',
//           worker: 'Loss',
//           workingHours: workingHour,
//           price: price);
//       await db
//           .collection('booking')
//           .doc(doc_id)
//           .collection('bookDetails')
//           .withConverter(
//               fromFirestore: BookingReview.fromFirestore,
//               toFirestore: (BookingReview bookingReview, options) =>
//                   bookingReview.toFirestore())
//           .add(content)
//           .then((DocumentReference doc) {
//         textController.clear();
//         Get.focusScope?.unfocus();
//       });
//       StorageService.to.remove(Constants.STRORAGE_Date);
//       StorageService.to.remove(Constants.STRORAGE_PRICE);
//       StorageService.to.remove(Constants.STRORAGE_TIME);
//       StorageService.to.remove(Constants.STRORAGE_WORKING_HOURS);
//       StorageService.to.remove(Constants.STRORAGE_DOC_UID);
//       StorageService.to.remove(Constants.STRORAGE_TO_UID);
//       StorageService.to.remove(Constants.STRORAGE_TO_NAME);
//       StorageService.to.remove(Constants.STRORAGE_TO_AVATAR);
//     } catch (error) {
//       isLoading.value = false;
//       if (kDebugMode) {
//         print(error.toString());
//       }
//     }
//     isLoading.value = false;
//     showDefaultDialog();
//   }
//
//   void showDefaultDialog() {
//     Get.defaultDialog(
//       title: "",
//       titleStyle: TextStyle(fontFamily: TextHelper.satoshiBold,fontSize: 18),
//       content:  Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             const Icon(Icons.check_circle,size: 50,color: ColorHelper.green1,),
//             Text("Booking Service Success",style: TextStyle(fontFamily: TextHelper.satoshiMedium,fontSize: 14),),
//           ],
//         ),
//       ),
//       confirm: D_MaterialButton(onPressed: (){
//         Get.offAllNamed(Routes.layoutRoute);
//       }, child: Text('Done',style: buildTextStyleBtn(),)),
//
//     );
//   }
//
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     doc_id = StorageService.to.getString(Constants.STRORAGE_DOC_UID);
//     to_uid.value = StorageService.to.getString(Constants.STRORAGE_TO_UID);
//     to_name.value = StorageService.to.getString(Constants.STRORAGE_TO_NAME);
//     to_avatar.value = StorageService.to.getString(Constants.STRORAGE_TO_AVATAR);
//   }
//
// // @override
// // void onReady() {
// //   // TODO: implement onReady
// //   super.onReady();
// //   var messages = db.collection('message').doc(doc_id).collection("msglist").withConverter(
// //       fromFirestore: BookingReview.fromFirestore,
// //       toFirestore: (BookingReview msgcontent,options)=>msgcontent.toFirestore()
// //   ).orderBy("addtime",descending: false);
// //   msgContact.clear();
// //   listener = messages.snapshots().listen((event) {
// //     for(var change in event.docChanges){
// //       switch(change.type){
// //         case DocumentChangeType.added:
// //           if(change.doc.data()!=null){
// //             msgContact.insert(0, change.doc.data()!);
// //           }
// //           break;
// //         case DocumentChangeType.modified:
// //           break;
// //         case DocumentChangeType.removed:
// //           break;
// //
// //       }
// //     }
// //   },
// //       onError: (error)=>print('Listen Failed : $error')
// //   );
// // }
// }
