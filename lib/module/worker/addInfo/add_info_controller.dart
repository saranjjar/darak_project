import 'dart:io';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darak_project/model/sub_category.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:random_string/random_string.dart';

class AddInfoController extends GetxController{

  String serviceName = 'Choose service';
  int categoryIndex = 0;

  getService(){
    return serviceName;
  }
  void chooseServiceType({required String service}) {
    serviceName = service;
    update();
  }

  late TextEditingController
      usernameController,
      bioController ,
      priceController ,
      locationController ,
      emailController,
      mobileController,
      IDController;

  @override
  void onInit() {
    usernameController = TextEditingController();
    priceController = TextEditingController();
    bioController = TextEditingController();
    locationController = TextEditingController();
    emailController = TextEditingController();
    mobileController = TextEditingController();
    IDController = TextEditingController();

    super.onInit();
  }


  RxBool isLoadingRequest = false.obs;


  File? photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery(ImageSource image) async {
    final pickedFile = await _picker.getImage(source:image);
    if(pickedFile!=null){
      photo = File(pickedFile.path);
      uploadFile();
    }else{
      if (kDebugMode) {
        print("No image selected");
      }
    }
  }

  Future getImageUrl(String name) async{
    final spaceRef = FirebaseStorage.instance.ref("sub_category").child(name);
    var str = await spaceRef.getDownloadURL();
    return str??"";
  }
  String imgUrl = '';
  Future uploadFile()async{
    if(photo==null)return;
    final fileName = randomAlphaNumeric(15)+extension(photo!.path);
    try{
      final ref = FirebaseStorage.instance.ref("sub_category").child(fileName);
      ref.putFile(photo!).snapshotEvents.listen((event) async{
        switch(event.state){
          case TaskState.running:
            break;
          case TaskState.paused:
            break;
          case TaskState.success:
             imgUrl = await getImageUrl(fileName);
            update();
        }
      });
    }catch(error){
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }


  void reset(){
    usernameController.clear();
    priceController.clear();
    locationController.clear();
    bioController.clear();
    emailController.clear();
    mobileController.clear();
    IDController.clear();

    update();

  }

  final db = FirebaseFirestore.instance;

  addInfoWorker({required String subcategoryID}) async {
    isLoadingRequest.value = true;
    final information = SubCategory(
      username: usernameController.text,
      price: priceController.text,
      location: locationController.text,
      bio: bioController.text,
      idNumber: IDController.text,
      mobile: mobileController.text,
      email: emailController.text,
      photo: imgUrl,
      service: subcategoryID,
    );
    await db.collection('category').doc(subcategoryID).collection(
        'sub_category').withConverter(
        fromFirestore: SubCategory.fromFirestore,
        toFirestore: (SubCategory subCategory, options) =>
            subCategory.toFirestore()
    ).add(information).then((DocumentReference doc) {
      //textController.clear();
      Get.focusScope?.unfocus();
    });
    isLoadingRequest.value = false;
  }
}