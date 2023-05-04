import 'dart:ui';

import 'package:darak_project/const.dart';
import 'package:darak_project/services/common/shared_pref.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ConfigStore extends GetxController{
  static ConfigStore get to => Get.find();

  bool isFirstOpen = false;
  PackageInfo? _platform;

  String get version=> _platform?.version??'-';
  bool get isRelease=> const bool.fromEnvironment('dart.vm.product');
  Locale locale = const Locale('en','us');
  List<Locale> languages= [
    const Locale('en'),
    const Locale('ar'),
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isFirstOpen = StorageService.to.getBool(Constants.STRORAGE_DEVICE_FIRST_OPEN_KEY);

  }

  Future<void> getPlatform() async {
    _platform = await PackageInfo.fromPlatform();
  }

  Future<bool> saveAlreadyOpen() async {
    return StorageService.to.setBool(Constants.STRORAGE_DEVICE_FIRST_OPEN_KEY, true);
  }



}