
import 'package:get/get.dart';

class PhotosViewController extends GetxController{
  RxString url = ''.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.parameters;
    if(data['url']!=null){
      url.value = data['url']!;
    }
  }
}