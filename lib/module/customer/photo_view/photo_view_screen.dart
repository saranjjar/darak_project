import 'package:darak_project/module/customer/photo_view/photo_view_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewScreen extends GetView<PhotoViewController> {
   PhotoViewScreen({Key? key}) : super(key: key);
    final _controller = Get.put(PhotosViewController());
  @override
  Widget build(BuildContext context) {
    return  PhotoView(
      imageProvider: NetworkImage(_controller.url.value),
    );
  }

}
