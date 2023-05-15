import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darak_project/model/sub_category.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  RxString name_service = ''.obs;
  RxBool isLoading = false.obs;
  var db = FirebaseFirestore.instance;
  RxList<QueryDocumentSnapshot<SubCategory>> subCategoryList = <QueryDocumentSnapshot<SubCategory>>[].obs;

  Future<void> getSubcategoriesInCategory(String categoryId) async {
    isLoading.value = true ;
    CollectionReference categoryRef =
    db.collection('category');

    var categorySnapshot = await categoryRef.doc(categoryId).collection('sub_category');

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


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.parameters;
    name_service.value = data['name']??"";
  }

}