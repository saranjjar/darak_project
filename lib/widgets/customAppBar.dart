import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/texts_helper.dart';

AppBar buildAppBar({required String title}) {
  return AppBar(
    titleSpacing: 0,
    elevation: 0,
    backgroundColor: Colors.white,
    leading: IconButton(
      onPressed: (){
        Get.back();
      },
      icon: const Icon(Icons.arrow_back_ios,color: Colors.black,),
    ),
    title: Text(title,style: TextStyle(color: Colors.black,fontFamily: TextHelper.satoshiBold,fontSize: 18),),

  );
}
