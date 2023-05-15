import 'package:darak_project/helpers/texts_helper.dart';
import 'package:darak_project/widgets/components/components.dart';
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
            //appBar: CustomAppBar(controller.titles[controller.currantScreenIndex]),
            body: controller.screens[controller.currantScreenIndex],
            bottomNavigationBar:
                BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  iconSize: 40,
                  items: controller.bottomNavIcon,
                  unselectedLabelStyle: TextStyle(
                    fontSize: 12,
                    fontFamily: TextHelper.satoshiRegular
                  ),
                  selectedLabelStyle: TextStyle(
                    fontSize: 12,
                    fontFamily: TextHelper.satoshiRegular
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