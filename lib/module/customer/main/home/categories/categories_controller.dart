import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darak_project/model/sub_category.dart';
import 'package:darak_project/services/common/user_store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  String? name_service;
  RxBool isLoading = false.obs;
  var db = FirebaseFirestore.instance;
  RxList<QueryDocumentSnapshot<SubCategory>> subCategoryList =
      <QueryDocumentSnapshot<SubCategory>>[].obs;
  Rx<RangeValues> sliderValues = Rx<RangeValues>(const RangeValues(40, 100));
  var _selectedList = List<String>.empty(growable: true).obs;
  getSelectedList() => _selectedList;
  setSelectedList(List<String> list) => _selectedList.value = list;
  var searchResults = [].obs;

  void searchUsingSlider(double minValue, double maxValue) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('FavService')
          .where('price', isGreaterThanOrEqualTo: minValue)
          .where('price', isLessThanOrEqualTo: maxValue)
          .get();
      print(querySnapshot);
      if (querySnapshot.docs.isNotEmpty) {
        print('55555');
        searchResults.value =
            querySnapshot.docs.map((doc) => doc.data()).toList();
      } else {
        searchResults.value = [];
        print('666');
      }
    } catch (e) {
      // Handle any potential errors
      print('Error searching data: $e');
    }
  }

  void onSliderChanged(RangeValues values) {
    sliderValues.value = values;
  }

  Future<void> getSubcategoriesInCategory(String categoryId) async {
    isLoading.value = true;
    CollectionReference categoryRef = db.collection('category');

    var categorySnapshot =
        categoryRef.doc(categoryId).collection('sub_category');

    var subcategoriesSnapshot = await categorySnapshot
        .withConverter(
            fromFirestore: SubCategory.fromFirestore,
            toFirestore: (SubCategory subCategory, options) =>
                subCategory.toFirestore())
        .get();
    subCategoryList.clear();
    if (subcategoriesSnapshot.docs.isNotEmpty) {
      subCategoryList.assignAll(subcategoriesSnapshot.docs);
    }
    isLoading.value = false;
  }

  final token = UserStore.t0.token;

  @override
  void onReady() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.parameters;
    name_service = data["service_name"] ?? "";
  }
}
