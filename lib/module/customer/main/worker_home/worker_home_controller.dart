import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darak_project/model/sub_category.dart';
import 'package:darak_project/services/common/user_store.dart';
import 'package:get/get.dart';

class WorkerHomeController extends GetxController{
  RxList<QueryDocumentSnapshot<SubCategory>> serviceList = <QueryDocumentSnapshot<SubCategory>> [].obs;
  final token = UserStore.t0.token;
  final db = FirebaseFirestore.instance;

  @override
  void onReady(){
    asyncLoadAllData();
    getUserName();
  }


  bool isLoading = false;
  Future<void> asyncLoadAllData() async{
    try{
      isLoading = true;
      update();
      var service = await db.collection('FavService').withConverter(
          fromFirestore: SubCategory.fromFirestore,
          toFirestore: (SubCategory subCategory,options)=>subCategory.toFirestore()).where(
          "id",isEqualTo:token
      ).get();
      if(service.docs.isNotEmpty){
        serviceList.assignAll(service.docs);
      }
      isLoading = false;
      update();
    }catch(error){
      print(error.toString());
      isLoading = false;
      update();
    }
  }

  String userName = '';

  getUserName()async{
    final userQuerySnapshot  = await FirebaseFirestore.instance
        .collection('users').where('id',isEqualTo: token)
        .get();
    if (userQuerySnapshot.docs.isNotEmpty) {
      final userDocument = userQuerySnapshot.docs.first;
      userName = userDocument['name'];
      print('User Name: $userName');
      update();
      // Update your state or perform further operations with the user name
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