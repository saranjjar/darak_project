import 'package:get/get.dart';

class SettingsController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  bool isSwitchedNo = false;

  onChangedNo(value){
    isSwitchedNo = value;
    update();
    print(isSwitchedNo);
  }

  bool isSwitchedMo = false;

  onChangedMo(value){
    isSwitchedMo = value;
    update();
    print(isSwitchedMo);
  }
}