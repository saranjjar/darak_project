import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darak_project/const.dart';
import 'package:darak_project/model/user.dart';
import 'package:darak_project/services/common/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../model/ReviewModel.dart';
import '../../../../../../services/common/user_store.dart';

class ProfileCategoryController extends GetxController {
  String? subServiceName, bio, photo, location, username, price, toUid1, id;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  var to_uid = ''.obs;
  var to_name = ''.obs;
  var to_docId = null;
  Rx<double> rating = Rx<double>(0.0);
  RxList<File> imageList = RxList<File>([]);
  RxList<String> imageUrls = <String>[].obs;
  Rx<num> sum = 10.0.obs;
  String userName = '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController reviewController;
  late CollectionReference category = firebaseFirestore.collection("reviews");

  final picker = ImagePicker();
  RxBool isUploading = RxBool(false);
  RxDouble progressValue = RxDouble(0);
  RxBool isLoading = false.obs;
  String toUid = StorageService.to.getString(Constants.STRORAGE_TO_UID) ?? '-';
  String worker =
      StorageService.to.getString(Constants.STRORAGE_WORKER_NAME) ?? '';
  final user_id = UserStore.t0.token;
  RxList<QueryDocumentSnapshot<ReviewModel>> Review =
      <QueryDocumentSnapshot<ReviewModel>>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    to_docId = StorageService.to.getString(Constants.STRORAGE_DOC_UID);
    to_uid.value = StorageService.to.getString(Constants.STRORAGE_TO_UID);
    to_name.value = StorageService.to.getString(Constants.STRORAGE_TO_NAME);
    // imgRef = FirebaseFirestore.instance.collection('review');
    reviewController = TextEditingController();
    print('*******************${userData.name}');
    var data = Get.parameters;
    id = data['id'] ?? "";
    location = data['location'] ?? "";
    price = data['price'] ?? "";
    bio = data['bio'] ?? "";
    photo = data['photo'] ?? "";
    getUserName();
    subServiceName =
        StorageService.to.getString(Constants.STRORAGE_SUB_SERVICE_NAME);
    username = StorageService.to.getString(Constants.STRORAGE_WORKER_NAME);
  }

  Future<void> calculateSum() async {
    final QuerySnapshot querySnapshot = await category.get();

    querySnapshot.docs.forEach((element) async {
      ReviewModel value = element.data() as ReviewModel;

      num val = value.currentRating as num;
      sum.value = sum.value + val;
    });
  }

  String? name_Worker;

  @override
  void onReady() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.parameters;
    name_Worker = data["nameWorker"] ?? "";
    price = data['price'] ?? "";
    bio = data['bio'] ?? "";
    photo = data['photo'] ?? "";
    id = data['id'] ?? "";
    location = data['location'] ?? "";
    username = StorageService.to.getString(Constants.STRORAGE_WORKER_NAME);
    subServiceName =
        StorageService.to.getString(Constants.STRORAGE_SUB_SERVICE_NAME);
    to_docId = StorageService.to.getString(Constants.STRORAGE_DOC_UID);
  }

  Future<void> getSubcategoriesInCategory() async {
    isLoading.value = true;
    CollectionReference ReviewRef = firebaseFirestore.collection('reviews');

    var ReviewSnapshot = await ReviewRef.withConverter(
            fromFirestore: ReviewModel.formMap,
            toFirestore: (ReviewModel review, options) => review.toFirestore())
        .get();
    Review.clear();
    if (ReviewSnapshot.docs.isNotEmpty) {
      Review.assignAll(ReviewSnapshot.docs);
    }
    isLoading.value = false;
  }

  void chooseImage() async {
    try {
      final pickerFile = await picker.getImage(source: ImageSource.gallery);
      if (pickerFile != null) {
        imageList.add(File(pickerFile.path));
        retrieveLostData();
      }
      // Use the picked image
    } catch (e) {
      // Handle the exception
      print('Error picking image1111111111: $e');
    }
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      imageList.add(File(response.file!.path));
    } else {
      print(response.file);
    }
  }

  String? validateReview(String value) {
    if (value.isEmpty) {
      return 'Review cant be empty';
    }
    return null;
  }

  void onRatingChanged(double value) {
    rating.value = value;
  }

  final token = UserStore.t0.token;

  getUserName() async {
    final userQuerySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: token)
        .get();
    if (userQuerySnapshot.docs.isNotEmpty) {
      final userDocument = userQuerySnapshot.docs.first;
      userName = userDocument['name'];
      await StorageService.to.setString(Constants.STRORAGE_NAME_USER, userName);

      print('User Name: $userName');
      update();
      // Update your state or perform further operations with the user name
    }
  }

  Future<void> SaveUpdateReview(
      String comment, String docId, int addEditFlag) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    final double currentRating = rating.value;
    formKey.currentState!.save();
    if (addEditFlag == 1) {
      CustomFullScreenDialog.showDialog();
      final content = ReviewModel(
        uid: user_id,
        toUid: toUid,
        name: userName,
        nameWorker: worker,
        currentRating: currentRating,
        comment: comment,
      );
      await category
          .withConverter(
              fromFirestore: ReviewModel.formMap,
              toFirestore: (ReviewModel bookingReview, options) =>
                  bookingReview.toFirestore())
          .add(content)
          .whenComplete(() {
        CustomFullScreenDialog.cancelDialog();
        clearEditingController();
        Get.back();
        rating.value = 0;
      }).catchError((e) {
        CustomFullScreenDialog.cancelDialog();
      });
      // i++;
      isLoading.value = false;
      //     });
      //   });
      // }
    } else if (addEditFlag == 2) {
      CustomFullScreenDialog.showDialog();
      category.doc(docId).update({
        "uid": user_id,
        "toUid": toUid,
        'name': userName,
        'nameWorker': worker,
        'rating': currentRating,
        'comment': comment,
        // 'day': FieldValue.serverTimestamp(),
      }).whenComplete(() {
        CustomFullScreenDialog.cancelDialog();
        clearEditingController();
        Get.back();
      }).catchError((e) {
        CustomFullScreenDialog.cancelDialog();
        clearEditingController();
      });
    }
    Get.back();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    reviewController.dispose();
  }

  void clearEditingController() {
    reviewController.clear();
  }

  UserData userData = UserData(
      id: StorageService.to.getString(Constants.STRORAGE_ID_CHAT),
      name: StorageService.to.getString(Constants.STRORAGE_WORKER_NAME),
      photoUrl: StorageService.to.getString(Constants.STRORAGE_PHOTO_CHAT));
}

class CustomFullScreenDialog {
  static void showDialog() {
    Get.dialog(
      WillPopScope(
        child: Center(
          child: CircularProgressIndicator(),
        ),
        onWillPop: () => Future.value(false),
      ),
      barrierDismissible: false,
      barrierColor: Color(0xff141A31).withOpacity(0.3),
      useSafeArea: true,
    );
  }

  static void cancelDialog() {
    Get.back();
  }
}
