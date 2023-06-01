
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darak_project/model/message.dart';
import 'package:darak_project/model/sub_category.dart';
import 'package:darak_project/model/user.dart';
import 'package:darak_project/services/common/shared_pref.dart';
import 'package:darak_project/services/common/user_store.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  String? name_service ;
  RxBool isLoading = false.obs;
  var db = FirebaseFirestore.instance;
  RxList<QueryDocumentSnapshot<SubCategory>> subCategoryList = <QueryDocumentSnapshot<SubCategory>>[].obs;

  Future<void> getSubcategoriesInCategory(String categoryId) async {
    isLoading.value = true ;
    CollectionReference categoryRef =
    db.collection('category');

    var categorySnapshot = categoryRef.doc(categoryId).collection('sub_category');

    var subcategoriesSnapshot = await categorySnapshot.withConverter(
        fromFirestore: SubCategory.fromFirestore,
        toFirestore: (SubCategory subCategory, options) =>
            subCategory.toFirestore()).get();
    subCategoryList.clear();
    if (subcategoriesSnapshot.docs.isNotEmpty) {
      subCategoryList.assignAll(subcategoriesSnapshot.docs);
    }
    isLoading.value = false ;
  }

  final token = UserStore.t0.token;
  //
  // bookReview(SubCategory toSubCategory) async{
  //   //From Message
  //   var fromBooking = await db.collection('booking').withConverter(
  //       fromFirestore: Message.fromFirestore,
  //       toFirestore: (Message msg,options)=>msg.toFirestore()).where(
  //       "from_uid",isEqualTo: token
  //   ).where(
  //       "to_uid",isEqualTo: toSubCategory.id
  //   ).get();
  //
  //   //To Message
  //   var toBooking = await db.collection('booking').withConverter(
  //       fromFirestore: Message.fromFirestore,
  //       toFirestore: (Message msg,options)=>msg.toFirestore()).where(
  //       "from_uid",isEqualTo: toSubCategory.id
  //   ).where(
  //       "to_uid",isEqualTo: token
  //   ).get();
  //   //There is No Messages between them yet
  //   if(fromBooking.docs.isEmpty && toBooking.docs.isEmpty){
  //     String profile = await UserStore.t0.getProfile();
  //     Users userdata = Users.fromJson(jsonDecode(profile));
  //     var msgData = Message(
  //         from_uid: userdata.accessToken,
  //         to_uid: toSubCategory.id,
  //         from_name: userdata.displayName,
  //         to_name: toSubCategory.username,
  //         from_avatar: userdata.photoUrl,
  //         to_avatar: toSubCategory.photo,
  //         last_msg: "",
  //         last_time: Timestamp.now(),
  //         msg_num: 0
  //     );
  //     db.collection('booking').withConverter(
  //         fromFirestore: Message.fromFirestore,
  //         toFirestore: (Message msg,options)=>msg.toFirestore()
  //     ).add(msgData).then((value){
  //       StorageService.to.setString(Constants.STRORAGE_DOC_UID, value.id);
  //       StorageService.to.setString(Constants.STRORAGE_TO_UID, toSubCategory.id??"");
  //       StorageService.to.setString(Constants.STRORAGE_TO_UID, toSubCategory.username??"");
  //       StorageService.to.setString(Constants.STRORAGE_TO_UID, toSubCategory.photo??"");
  //
  //       // Get.toNamed(Routes.bookingRevRoutes,parameters: {
  //       //   "doc_id":value.id,
  //       //   "to_uid":toSubCategory.id??"",
  //       //   "to_name":toSubCategory.username??"",
  //       //   "to_avatar":toSubCategory.photo??""
  //       // });
  //     });
  //   }
  //   else{
  //     if(fromBooking.docs.isNotEmpty){
  //       StorageService.to.setString(Constants.STRORAGE_DOC_UID, fromBooking.docs.first.id);
  //       StorageService.to.setString(Constants.STRORAGE_TO_UID, toSubCategory.id??"");
  //       StorageService.to.setString(Constants.STRORAGE_TO_UID, toSubCategory.username??"");
  //       StorageService.to.setString(Constants.STRORAGE_TO_UID, toSubCategory.photo??"");
  //
  //       // Get.toNamed(Routes.bookingRevRoutes,parameters: {
  //       //
  //       //   "doc_id":fromBooking.docs.first.id,
  //       //   "to_uid":toSubCategory.id??"",
  //       //   "to_name":toSubCategory.username??"",
  //       //   "to_avatar":toSubCategory.photo??""
  //       // });
  //     }
  //     if(toBooking.docs.isNotEmpty){
  //       StorageService.to.setString(Constants.STRORAGE_DOC_UID, toBooking.docs.first.id);
  //       StorageService.to.setString(Constants.STRORAGE_TO_UID, toSubCategory.id??"");
  //       StorageService.to.setString(Constants.STRORAGE_TO_UID, toSubCategory.username??"");
  //       StorageService.to.setString(Constants.STRORAGE_TO_UID, toSubCategory.photo??"");
  //
  //       // Get.toNamed(Routes.bookingRevRoutes,parameters: {
  //       //   "doc_id":toBooking.docs.first.id,
  //       //   "to_uid":toSubCategory.id??"",
  //       //   "to_name":toSubCategory.username??"",
  //       //   "to_avatar":toSubCategory.photo??""
  //       // });
  //     }
  //   }
  // }

  @override
  void onReady() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.parameters;
    name_service = data["service_name"]??"";
  }

}