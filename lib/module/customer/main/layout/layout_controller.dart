import 'package:darak_project/const.dart';
import 'package:darak_project/helpers/image_helper.dart';
import 'package:darak_project/module/customer/main/booking/booking_screen.dart';
import 'package:darak_project/module/customer/main/booking/booking_worker/booking_worker_screen.dart';
import 'package:darak_project/module/customer/main/chat/chat_history/chat_history_screen.dart';
import 'package:darak_project/module/customer/main/home/home_screen.dart';
import 'package:darak_project/module/customer/main/settings/settings_screen.dart';
import 'package:darak_project/module/customer/main/worker_home/worker_home_screen.dart';
import 'package:darak_project/services/common/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LayoutController extends GetxController {


  List<Widget> screens = [
    if(StorageService.to.getString(Constants.STRORAGE_DEVICE_CUSTO_WORK_KEY)=='CUSTOMER')
     HomeScreen()
    else if(StorageService.to.getString(Constants.STRORAGE_DEVICE_CUSTO_WORK_KEY)=='Worker')  WorkerHomeScreen()

    else Container(),
    if(StorageService.to.getString(Constants.STRORAGE_DEVICE_CUSTO_WORK_KEY)=='CUSTOMER')
      BookingScreen()
    else if(StorageService.to.getString(Constants.STRORAGE_DEVICE_CUSTO_WORK_KEY)=='Worker')  BookingWorkerScreen()

    else Container(),
    ChatHistoryScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Booking',
    'Chat',
    'Profile',
  ];

  List<BottomNavigationBarItem> bottomNavIcon = [
    BottomNavigationBarItem(
      label: 'Home',
      icon: SvgPicture.asset(ImageHelper.home1Icon),
      activeIcon: SvgPicture.asset(ImageHelper.homeIcon)
    ),
    BottomNavigationBarItem(
    label: 'Booking',
    icon: SvgPicture.asset(ImageHelper.bookIcon),
    activeIcon: SvgPicture.asset(ImageHelper.book1Icon),
    ),
    BottomNavigationBarItem(
        label: 'chat',
        icon: SvgPicture.asset(ImageHelper.chatIcon),
        activeIcon: SvgPicture.asset(ImageHelper.fillChatIcon)
    ),
    BottomNavigationBarItem(
    label: 'Profile',
    icon: SvgPicture.asset(ImageHelper.profileIcon),
    activeIcon: SvgPicture.asset(ImageHelper.profile1Icon)
    ),
  ];
  int currantScreenIndex = 0;

  void changeBottomNavigationBar(int index, context) {
    currantScreenIndex = index;
    update();
  }

}