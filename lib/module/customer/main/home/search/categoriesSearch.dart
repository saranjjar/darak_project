import 'package:another_xlider/another_xlider.dart';
import 'package:darak_project/Application/app_router/app_router.dart';
import 'package:darak_project/const.dart';
import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/image_helper.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:darak_project/module/customer/main/chat/chat_controller.dart';
import 'package:darak_project/module/customer/main/home/categories/categories_controller.dart';
import 'package:darak_project/module/customer/main/home/categories/profile_category/profile_category_controller.dart';
import 'package:darak_project/services/common/shared_pref.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../widgets/components/components.dart';
import '../search/search_screen.dart';

class CategoriesSearch extends StatelessWidget {
  CategoriesSearch({Key? key}) : super(key: key);
  void openFilterDialog(BuildContext context) async {
    await FilterListDialog.display<String>(context,
        listData: defaultList,
        selectedListData: _controller.getSelectedList(),
        headlineText: 'Choose Rating',
        // searchFieldHintText: "Search Here",
        // applyButtonTextStyle: TextStyle(fontSize: 20),
        choiceChipLabel: (item) => item,
        validateSelectedItem: (list, val) => list!.contains(val),
        onItemSearch: (list, text) {
          return list.toLowerCase().contains(text.toLowerCase());
        },
        onApplyButtonClick: (list) {
          _controller.setSelectedList(List<String>.from(list!));
          Navigator.of(context).pop();
        });
  }

  final _controller = Get.put(CategoriesController());
  final chatController = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: Colors.white,
          appBar: buildAppBar(),
          body: _controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : _buildMainBody(context),
        ));
  }

  AppBar buildAppBar() {
    return AppBar(
      titleSpacing: 0,
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
      title: Text(
        _controller.name_service!,
        style: TextStyle(
            color: Colors.black,
            fontFamily: TextHelper.satoshiBold,
            fontSize: 18),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Get.off(() => SearchScreen());
            },
            icon: SvgPicture.asset(ImageHelper.searchIcon)),
      ],
    );
  }

  SingleChildScrollView _buildMainBody(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 15, top: 8, right: 15, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Search Result'),
                    Text(
                      "${_controller.subCategoryList.length} founds",
                      style: TextStyle(color: Colors.deepPurple[300]),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      // openFilterDialog(context);
                      Get.bottomSheet(FilterBottomSheet());
                    },
                    icon: Icon(Icons.filter)),
              ],
            ),
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => _buildListItem(index),
              separatorBuilder: (context, index) => Container(),
              itemCount: _controller.subCategoryList.length),
        ],
      ),
    );
  }

  Widget _buildListItem(int index) {
    var item = _controller.subCategoryList[index].data();
    final controller = Get.put(ProfileCategoryController());

    var photo = item.photo;
    var id = item.id;
    return InkWell(
      onTap: () async {
        await StorageService.to.setString(Constants.STRORAGE_ID_CHAT, id!);
        await StorageService.to
            .setString(Constants.STRORAGE_PHOTO_CHAT, photo!);
        await StorageService.to
            .setString(Constants.STRORAGE_WORKER_NAME, item.username!);
        Get.toNamed(Routes.profileCategoryRoutes, parameters: {
          'bio': item.bio!,
          'price': item.price!,
          'location': item.location!,
          'photo': item.photo!,
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                width: 1,
                color: ColorHelper.divColor,
              )),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 120,
                    width: 120,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: Image.network(
                      item.photo!,
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        item.username!,
                        style: _textStyle(TextHelper.satoshiBold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        item.service!,
                        style: _textStyle(TextHelper.satoshiRegular),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Text(
                          '${item.price}\$/hour',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: TextHelper.satoshiBold,
                            color: ColorHelper.primaryColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(ImageHelper.starIcon),
                          Obx(
                            () => Text(
                              '${controller.sum}',
                              style: _buildTextStyle(),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Container(
                            height: 14.h,
                            width: 1,
                            color: ColorHelper.warmGrey,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            '${controller.Review.length}',
                            style: _buildTextStyle(),
                          ),
                          Text(
                            'Reviews',
                            style: _buildTextStyle(),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle _textStyle(String fontfamily) {
    return TextStyle(
      fontSize: 16,
      fontFamily: fontfamily,
    );
  }

  TextStyle _buildTextStyle() {
    return TextStyle(
      fontSize: 12,
      fontFamily: TextHelper.satoshiLight,
    );
  }

  Future<void> getWorkerData(item) async {
    await StorageService.to.setString(Constants.STRORAGE_TO_UID, item.id ?? "");
    await StorageService.to
        .setString(Constants.STRORAGE_WORKER_NAME, item.username ?? "");
    await StorageService.to
        .setString(Constants.STRORAGE_SERVICE_NAME, item.service ?? "");
  }
}

List<String> defaultList = [
  '5',
  '4',
  '3',
  '2',
  '1',
];

class FilterBottomSheet extends StatelessWidget {
  FilterBottomSheet({
    super.key,
  });
  final _controller = Get.put(CategoriesController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.clear,
                      color: Color(0xff9CA3AF),
                    ))
              ],
            ),
            SizedBox(height: 15.0),
            Text(
              'Price',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Obx(
              () => FlutterSlider(
                values: [
                  _controller.sliderValues.value.start,
                  _controller.sliderValues.value.end
                ],
                rangeSlider: true,
                min: 0.0,
                max: 300.0,
                onDragging: (handlerIndex, lowerValue, upperValue) {
                  _controller
                      .onSliderChanged(RangeValues(lowerValue, upperValue));
                  // _controller.searchUsingSlider(lowerValue, upperValue);
                },
              ),
            ),

            SizedBox(height: 15.0),
            Obx(
              () => Text(
                'Price in hour: ${_controller.sliderValues.value.start.toStringAsFixed(1)} \$ - ${_controller.sliderValues.value.end.toStringAsFixed(1)}\$',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            SizedBox(height: 25),
            Text(
              'Rating',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Colors.deepPurpleAccent;
                  },
                  // onFocusChange: Colors.deepPurpleAccent,
                  child: RatingContainer(
                    text: 'All',
                  ),
                ),
                InkWell(
                  onTap: () {},
                  // onFocusChange: Colors.deepPurpleAccent,
                  child: RatingContainer(
                    text: '5',
                  ),
                ),
                InkWell(
                  onTap: () {},
                  // onFocusChange: Colors.deepPurpleAccent,
                  child: RatingContainer(text: '4'),
                ),
                InkWell(
                  onTap: () {},
                  // onFocusChange: Colors.deepPurpleAccent,
                  child: RatingContainer(
                    text: '3',
                  ),
                ),
                InkWell(
                  onTap: () {},
                  // onFocusChange: Colors.deepPurpleAccent,
                  child: RatingContainer(
                    text: '2',
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 10, right: 20, left: 20, top: 20),
              child: D_MaterialButton(
                  onPressed: () {
                    _controller.searchUsingSlider(
                      _controller.sliderValues.value.start,
                      _controller.sliderValues.value.end,
                    );
                    Get.to(() => Filtering());
                  },
                  child: Text(
                    'Apply',
                    style: buildTextStyleBtn(),
                  ),
                  width: double.infinity),
            )
            // RangeSlider(
            //   values: _controller.sliderValues.value,
            //   max: 100,
            //   divisions: 5,
            //   labels: RangeLabels(
            //     _controller.sliderValues.value.start.round().toString(),
            //     _controller.sliderValues.value.end.round().toString(),
            //   ),
            //   onChanged: (RangeValues values) {
            //     _controller.onSliderChanged(values);
            //   },
            //
            // )
          ],
        ),
      ),
    );
  }
}

class Filtering extends StatelessWidget {
  Filtering({Key? key}) : super(key: key);
  final _controller = Get.put(CategoriesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Text('${_controller.searchResults.length}'),
            Obx(() {
              if (_controller.searchResults.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Image(
                        image: AssetImage(ImageHelper.search),
                        width: 250,
                        height: 250,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Not Found',
                          style:
                              TextStyle(fontSize: 24, color: Color(0xff3B3B3B)),
                        ),
                      ),
                      Text(
                        'We couldnt find any matches for your search.\n Please check your spelling or try searchin for\n                             something else.',
                        style:
                            TextStyle(fontSize: 14, color: Color(0xff3B3B3B)),
                      ),
                    ],
                  ),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: _controller.searchResults.length,
                    itemBuilder: (context, index) {
                      final result = _controller.searchResults[index];
                      // Display the search results in the UI
                      return ListTile(
                        title: Text(result['title']),
                        subtitle: Text(result['description']),
                      );
                    },
                  ),
                );
              }
            })
          ],
        ),
      ),
    );
  }
}

class RatingContainer extends StatelessWidget {
  RatingContainer({
    super.key,
    required this.text,
  });
  String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 55,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), border: Border.all()),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ImageHelper.starIcon,
            ),
            SizedBox(width: 5.0),
            Text(text)
          ],
        ),
      ),
    );
  }
}
