
import 'package:darak_project/const.dart';
import 'package:darak_project/model/user.dart';
import 'package:darak_project/services/common/shared_pref.dart';
import 'package:get/get.dart';

class ProfileCategoryController extends GetxController{
    String? serviceName,bio,photo,location,username,price,toUid,id;


  @override
  void onInit() {
    // TODO: implement onInit
      super.onInit();
      print('*******************${userData.name}');
      var data = Get.parameters;
      id=data['id']??"";
      location=data['location']??"";
      price=data['price']??"";
      bio=data['bio']??"";
      photo=data['photo']??"";
      serviceName = StorageService.to.getString(Constants.STRORAGE_SERVICE_NAME);
      username = StorageService.to.getString(Constants.STRORAGE_WORKER_NAME);
  }

    UserData userData = UserData(
      id: StorageService.to.getString(Constants.STRORAGE_ID_CHAT),
      name: StorageService.to.getString(Constants.STRORAGE_WORKER_NAME),
      photoUrl: StorageService.to.getString(Constants.STRORAGE_PHOTO_CHAT)
    );

}