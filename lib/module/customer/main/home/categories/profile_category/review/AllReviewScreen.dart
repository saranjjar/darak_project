import 'package:darak_project/module/customer/main/home/categories/profile_category/profile_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../../../helpers/colors_helper.dart';
import '../../../../../../../helpers/image_helper.dart';
import '../../../../../../../helpers/texts_helper.dart';
import '../../../home_controller.dart';
import '../profile_category_screen.dart';
import 'addReview.dart';

class AllReview extends StatelessWidget {
  AllReview({Key? key}) : super(key: key);
  final _controller = Get.put(ProfileCategoryController());
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorHelper.primaryColor,
        title: const Text(
          'Review',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        leading: IconButton(
            onPressed: () {
              Get.off(() => ProfileCategoryScreen());
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: _buildListItem(),
    );
  }

  Widget _buildListItem() {
    // var item = _controller.Review[index].data();

    return SafeArea(
      child: Expanded(
        child: Obx(() => Container(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _controller.Review.length,
                itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      _controller.reviewController.text =
                          _controller.Review[index].data().comment!;
                      Get.to(() => AddReview(
                          text: "UPDATE",
                          addEditFlag: 2,
                          docId: _controller.to_docId!));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.purpleAccent[500],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ' ${_controller.Review[index].data().name!}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: TextHelper.satoshiBold),
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(ImageHelper.starIcon),
                                        SvgPicture.asset(ImageHelper.starIcon),
                                        SvgPicture.asset(ImageHelper.starIcon),
                                        SvgPicture.asset(ImageHelper.starIcon),
                                        SvgPicture.asset(ImageHelper.starIcon),
                                        SizedBox(
                                          width: 8.h,
                                        ),
                                        Text(
                                          '${_controller.Review[index].data().currentRating!}',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  '12/5/2023',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: TextHelper.satoshiLight),
                                ),
                              ]),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            "${_controller.Review[index].data().comment!}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: TextHelper.satoshiRegular),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          // TextButton(
                          //     onPressed: () {
                          //       // Get.to(() => nnn());
                          //     },
                          //     child: Text('See Image')),
                          // Container(
                          //   height: 50,
                          //   width: double.infinity,
                          //   child: ListView.builder(
                          //       itemCount: _controller.imageUrls.length,
                          //       scrollDirection: Axis.horizontal,
                          //       itemBuilder: (context, index) {
                          //         return Image.network(
                          //           _controller.Review[index].data().url!,
                          //           fit: BoxFit.cover,
                          //           height: 30,
                          //           width: 30,
                          //         );
                          //       }),
                          // )
                        ],
                      ),
                    )),
              ),
            )),
      ),
    );
  }
}
