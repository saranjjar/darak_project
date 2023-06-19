import 'package:darak_project/helpers/texts_helper.dart';
import 'package:darak_project/widgets/components/components.dart';
import 'package:darak_project/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'layout_controller.dart';

class LayoutScreen extends StatelessWidget {
   LayoutScreen({Key? key}) : super(key: key);
  LayoutController cont = Get.put(LayoutController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LayoutController>(builder: (controller)=>SafeArea(
      child: Scaffold(
            backgroundColor: Colors.white,
            appBar:controller.currantScreenIndex!=0?buildAppBarPrimary(title: controller.titles[controller.currantScreenIndex]):null,
            body: controller.screens[controller.currantScreenIndex],
            bottomNavigationBar:
                BottomNavigationBar(
                  elevation: 1,
                  type: BottomNavigationBarType.fixed,
                  iconSize: 40,
                  items: controller.bottomNavIcon,
                  unselectedLabelStyle: TextStyle(
                    fontSize: 12,
                    fontFamily: TextHelper.satoshiMedium
                  ),
                  selectedLabelStyle: TextStyle(
                    fontSize: 12,
                    fontFamily: TextHelper.satoshiMedium
                  ),
                  onTap: (value) =>
                  controller.changeBottomNavigationBar(value, context),
                  currentIndex: controller.currantScreenIndex,
                ),
          ),
        ),
    );
  }
}