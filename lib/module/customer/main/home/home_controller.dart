import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darak_project/model/category.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCategory();
  }
  bool isLoading = false;

  List<QueryDocumentSnapshot<Category>> categoryList = <QueryDocumentSnapshot<Category>> [];
  final db = FirebaseFirestore.instance;
  getCategory() async{
    isLoading = true;
    update();
    var category = await db.collection("category").withConverter(
        fromFirestore: Category.fromFirestore,
        toFirestore: (Category ctg,options)=>ctg.toFirestore()).get();

    categoryList.clear();
    if(category.docs.isNotEmpty){
      categoryList.assignAll(category.docs);
    }
    isLoading = false;
    update();
  }
}