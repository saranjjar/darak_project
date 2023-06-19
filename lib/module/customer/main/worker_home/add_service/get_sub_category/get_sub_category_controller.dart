import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darak_project/model/sub_category.dart';
import 'package:darak_project/services/common/user_store.dart';
import 'package:darak_project/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GetSubCategoryController extends GetxController{
  var title;
  late TextEditingController serviceName , servicePrice;
  @override
  void onInit() {
    var data = Get.parameters;
    title = data['title'];
    asyncLoadAllData();
    serviceName = TextEditingController();
    servicePrice = TextEditingController();
    super.onInit();
  }

  final token = UserStore.t0.token;
  final db = FirebaseFirestore.instance;

  RxList<QueryDocumentSnapshot<SubCategory>> subServiceList = <QueryDocumentSnapshot<SubCategory>> [].obs;

  bool isLoading = false;
  Future<void> asyncLoadAllData() async{
    try{
      isLoading = true;
      update();
      var service = await db.collection('FavService').withConverter(
          fromFirestore: SubCategory.fromFirestore,
          toFirestore: (SubCategory subCategory,options)=>subCategory.toFirestore()).where(
          "id",isEqualTo:token
      ).where('service',isEqualTo: title).get();
      if(service.docs.isNotEmpty){
        subServiceList.assignAll(service.docs);
      }
      isLoading = false;
      update();
    }catch(error){
      print(error.toString());
      isLoading = false;
      update();
    }
  }

  Future<void> updateInfoService({required String idDoc}) async {
    try{ db.collection("FavService").doc(idDoc).update({'subService': serviceName.text,'price':servicePrice.text});
    print('Status updated successfully');
    await asyncLoadAllData();
    dismissKeyboard();
    }
    catch(error) {
      print('Failed to update status: $error');
    }

  }

}