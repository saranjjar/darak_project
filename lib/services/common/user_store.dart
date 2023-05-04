import 'dart:convert';

import 'package:darak_project/const.dart';
import 'package:darak_project/model/user.dart';
import 'package:darak_project/services/common/shared_pref.dart';
import 'package:get/get.dart';

class UserStore extends GetxController{
  static UserStore get t0 =>Get.find();

  final _isLogin = false.obs;

  String token = '';

  final _profile = Users().obs;

  bool get isLogin => _isLogin.value;

  Users get profile => _profile.value;

  bool get hasToken => token.isNotEmpty;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    token = StorageService.to.getString(Constants.STRORAGE_USER_TOKEN_KEY);
    var profileOffline = StorageService.to.getString(Constants.STRORAGE_USER_PROFILE_KEY);
    if(profileOffline.isNotEmpty){
      _isLogin.value=true;
      _profile(Users.fromJson(jsonDecode(profileOffline)));
    }
  }

  Future<void> setToken(String value) async {
    await StorageService.to.setString(Constants.STRORAGE_USER_TOKEN_KEY, value);
    token = value;
  }

  Future<String> getProfile() async {
    if(token.isEmpty) return '';
    return StorageService.to.getString(Constants.STRORAGE_USER_PROFILE_KEY);
  }
  Future<void> saveProfile(Users profile) async {
    _isLogin.value = true;
    StorageService.to.setString(Constants.STRORAGE_USER_PROFILE_KEY, jsonEncode(profile));
    setToken(profile.accessToken!);
  }

  Future<void> onLogout() async {
    await StorageService.to.remove(Constants.STRORAGE_USER_TOKEN_KEY);
    await StorageService.to.remove(Constants.STRORAGE_USER_PROFILE_KEY);
    _isLogin.value = false;
    token = '';
  }
}