import 'package:darak_project/module/photo_view/photo_view_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class PhotoImageScreen extends StatelessWidget {
   PhotoImageScreen({Key? key}) : super(key: key);
    final _controller = Get.put(PhotosViewController());
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: PhotoView(
        imageProvider: NetworkImage(_controller.url.value),
      ),
    );
  }

}
