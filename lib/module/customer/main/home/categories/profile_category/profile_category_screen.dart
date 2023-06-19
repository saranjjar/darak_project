import 'package:darak_project/Application/app_router/app_router.dart';
import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/image_helper.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:darak_project/module/customer/main/chat/chat_controller.dart';
import 'package:darak_project/module/customer/main/home/categories/profile_category/profile_category_controller.dart';
import 'package:darak_project/module/customer/main/home/home_controller.dart';
import 'package:darak_project/widgets/components/components.dart';
import 'package:darak_project/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'review/AllReviewScreen.dart';
import 'review/addReview.dart';

class ProfileCategoryScreen extends StatelessWidget {
  ProfileCategoryScreen({Key? key}) : super(key: key);
  final _controller = Get.put(ProfileCategoryController());
  final controllerChat = Get.put(ChatController());
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileCategoryController>(
        builder: (controller) => Scaffold(
            backgroundColor: ColorHelper.divColor,
            appBar: buildAppBar(title: _controller.subServiceName!),
            body: _buildMainBody()));
  }

  Widget _buildMainBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Container(
                    height: 150.h,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: ColorHelper.primaryColor,
                      //borderRadius: BorderRadius.circular(12),
                    )),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {
                    controllerChat.goChat(_controller.userData);
                  },
                  child: Container(
                      height: 30.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: ColorHelper.light1,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: (Row(children: [
                          SvgPicture.asset(ImageHelper.msgIcon),
                          const Text('Chat'),
                        ])),
                      )),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                buildWorkerItem(),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Text(
                        'Review (${_controller.Review.length})',
                        style: TextStyle(
                            fontFamily: TextHelper.satoshiBold, fontSize: 15),
                      ),
                    ),
                    D_TextButton(
                        onPressed: () {
                          Get.to(() => AddReview(
                              text: "Save",
                              addEditFlag: 1,
                              docId: _controller.to_docId));
                        },
                        text: 'Add Review',
                        line: TextDecoration.none),
                    D_TextButton(
                        onPressed: () {
                          Get.off(() => AllReview());
                        },
                        text: 'See All',
                        line: TextDecoration.none),
                  ],
                ),
                Container(
                    width: double.infinity,
                    height: 120.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Flexible(
                      child: Container(
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
                                    docId: _controller.to_docId));
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${_controller.Review[index].data().name!}',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily:
                                                        TextHelper.satoshiBold),
                                              ),
                                              SizedBox(
                                                height: 4.h,
                                              ),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      ImageHelper.starIcon),
                                                  SvgPicture.asset(
                                                      ImageHelper.starIcon),
                                                  SvgPicture.asset(
                                                      ImageHelper.starIcon),
                                                  SvgPicture.asset(
                                                      ImageHelper.starIcon),
                                                  SvgPicture.asset(
                                                      ImageHelper.starIcon),
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
                                                fontFamily:
                                                    TextHelper.satoshiLight),
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
                                          fontFamily:
                                              TextHelper.satoshiRegular),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),

                                    // Container(
                                    //   height: 50,
                                    //   width: double.infinity,
                                    //   child: ListView.builder(
                                    //       itemCount:
                                    //           _controller.imageUrls.length,
                                    //       scrollDirection: Axis.horizontal,
                                    //       itemBuilder: (context, index) {
                                    //         return Image.network(
                                    //           _controller.Review[index]
                                    //               .data()
                                    //               .url!,
                                    //           fit: BoxFit.cover,
                                    //           height: 30,
                                    //           width: 30,
                                    //         );
                                    //       }),
                                    // )
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    // Image(image: image)

                                    // Stack(
                                    //   children: [
                                    //     Container(
                                    //       color: Colors.purpleAccent,
                                    //       padding: EdgeInsets.all(4),
                                    //       child: GetBuilder<
                                    //               ProfileCategoryController>(
                                    //           init:
                                    //               ProfileCategoryController(),
                                    //           builder: (c) => Container(
                                    //                 child: GridView.builder(
                                    //                     itemCount: 3,
                                    //                     gridDelegate:
                                    //                         SliverGridDelegateWithFixedCrossAxisCount(
                                    //                       crossAxisCount: 2,
                                    //                     ),
                                    //                     itemBuilder:
                                    //                         (BuildContext
                                    //                                 context,
                                    //                             int index) {
                                    //                       final imageUrl =
                                    //                           _controller
                                    //                               .Review[
                                    //                                   index]
                                    //                               .url!;
                                    //                       return Image
                                    //                           .network(
                                    //                               imageUrl,
                                    //                               fit: BoxFit
                                    //                                   .cover);
                                    //                     }),
                                    //               )),
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 20, left: 20),
            child: D_MaterialButton(
                onPressed: () {
                  Get.toNamed(Routes.bookRoutes,
                      parameters: {'price': _controller.price!});
                },
                child: Text(
                  'Book Now',
                  style: buildTextStyleBtn(),
                ),
                width: double.infinity),
          )
        ],
      ),
    );
  }

  Widget buildWorkerItem() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: ColorHelper.light1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Info',
              style: TextStyle(fontFamily: TextHelper.satoshiBold),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                SvgPicture.asset(ImageHelper.profileIcon),
                SizedBox(
                  width: 4.w,
                ),
                Text(
                  _controller.username!,
                  style: TextStyle(
                    fontFamily: TextHelper.satoshiRegular,
                  ),
                ),
                SizedBox(
                  width: 12.w,
                ),
                Text(
                  '4.1',
                  style: TextStyle(
                    fontFamily: TextHelper.satoshiLight,
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                SvgPicture.asset(ImageHelper.starIcon),
              ],
            ),
            buildDivider(),
            Row(
              children: [
                SvgPicture.asset(ImageHelper.locationIcon),
                SizedBox(
                  width: 4.w,
                ),
                Text(
                  _controller.location!,
                  style: TextStyle(fontFamily: TextHelper.satoshiRegular),
                ),
              ],
            ),
            buildDivider(),
            Row(
              children: [
                SvgPicture.asset(ImageHelper.locationIcon),
                SizedBox(
                  width: 4.w,
                ),
                RichText(
                  text: TextSpan(
                      text: '${_controller.price!}\$',
                      style: TextStyle(
                          color: ColorHelper.blackColor,
                          fontFamily: TextHelper.satoshiBold,
                          fontSize: 16),
                      children: [
                        TextSpan(
                          text: ' \\ hour',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: TextHelper.satoshiRegular),
                        ),
                      ]),
                ),
              ],
            ),
            buildDivider(),
            Text(
              _controller.bio!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: TextHelper.satoshiRegular,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildDivider() {
    return Padding(
      padding: EdgeInsets.all(8.0.h),
      child: Container(
        height: 0.5,
        width: double.infinity,
        color: Colors.grey[400],
      ),
    );
  }
}
