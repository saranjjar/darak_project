import 'package:darak_project/helpers/image_helper.dart';
import 'package:darak_project/module/customer/main/chat/chat_screen.dart';
import 'package:darak_project/module/customer/main/home/home_screen.dart';
import 'package:darak_project/module/customer/main/notification/notification_screen.dart';
import 'package:darak_project/module/customer/main/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LayoutController extends GetxController {


  List<Widget> screens = [
     HomeScreen(),
     ChatScreen(),
    const NotificationScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chat',
    'Notification',
    'Settings',
  ];

  List<BottomNavigationBarItem> bottomNavIcon = [
    BottomNavigationBarItem(
      label: 'Home',
      icon: SvgPicture.asset(ImageHelper.lockIcon),
      activeIcon: SvgPicture.asset(ImageHelper.lockIcon)
    ),
    BottomNavigationBarItem(
      label: 'chat',
      icon: SvgPicture.asset(ImageHelper.chatIcon),
      activeIcon: SvgPicture.asset(ImageHelper.lockIcon)
    ),
    BottomNavigationBarItem(
    label: 'Calender',
    icon: SvgPicture.asset(ImageHelper.calenderIcon),
    activeIcon: SvgPicture.asset(ImageHelper.calenderIcon),
    ),
    BottomNavigationBarItem(
    label: 'Profile',
    icon: SvgPicture.asset(ImageHelper.profileIcon),
    activeIcon: SvgPicture.asset(ImageHelper.profileIcon)
    ),
  ];
  int currantScreenIndex = 0;

  void changeBottomNavigationBar(int index, context) {
    currantScreenIndex = index;
    update();
  }

}