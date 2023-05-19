
import 'package:get/get.dart';

class ProfileCategoryController extends GetxController{
    String? serviceName,bio,photo,location,username,price;


  @override
  void onInit() {
    // TODO: implement onInit
      super.onInit();
      var data = Get.parameters;
      serviceName=data['service_name']??"";
      username=data['username']??"";
      location=data['location']??"";
      price=data['price']??"";
      bio=data['bio']??"";
      photo=data['photo']??"";
  }

}