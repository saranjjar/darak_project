// import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:get/get.dart';
// class ThemeServices {
//   final _box = GetStorage();
//
//   final _key = 'isDarkMode';
//
//   bool _isLoadingTheme() => _box.read(_key)??false;
//
//   saveTheme(bool isDark)=>_box.write(_key, isDark);
//   ThemeMode? get theme =>_isLoadingTheme()? ThemeMode.dark :ThemeMode.light;
//   void switchTheme(){
//     Get.changeThemeMode(_isLoadingTheme()? ThemeMode.light :ThemeMode.dark);
//     saveTheme(!_isLoadingTheme());
//   }
//
// }
