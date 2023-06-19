import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SearchsController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<DocumentSnapshot> searchResults = RxList<DocumentSnapshot>([]);
  void search(String keyword) {
    firestore
        .collection('category')
        .where(
          'service_name',
          isGreaterThanOrEqualTo: keyword,
        )
        .get()
        .then((QuerySnapshot snapshot) {
      searchResults.value = snapshot.docs;
    }).catchError((error) {
      print('Error searching Firestore: $error');
    });
  }
  // RxList<Categorys> Category = RxList<Categorys>();
  // TextEditingController searchController = TextEditingController();
  //
  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchProducts();
  // }
  //
  // void fetchProducts() {
  //   // Fetch products from Firestore collection
  //   FirebaseFirestore.instance
  //       .collection('category')
  //       .snapshots()
  //       .listen((snapshot) {
  //     Category.clear();
  //     snapshot.docs.forEach((doc) {
  //       Category.add(Categorys.fromSnapshot(doc));
  //     });
  //   });
  // }
  //
  // void filterProducts(String query) {
  //   // Filter products based on search query
  //   final filteredProducts =
  //       Category.where((product) => product.name.contains(query)).toList();
  //   Category.assignAll(filteredProducts);
  // }
}

// class Categorys {
//   late String name;
//   // late String toName;
//
//   Categorys(this.name);
//
//   Categorys.fromSnapshot(DocumentSnapshot snapshot) {
//     name = snapshot['service_name'];
//     // toName = snapshot['to_name'];
//   }
// }
