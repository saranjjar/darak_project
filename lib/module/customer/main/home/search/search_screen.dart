import 'package:darak_project/module/customer/main/home/home_controller.dart';
import 'package:darak_project/module/customer/main/home/search/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../Application/app_router/app_router.dart';
import '../../../../../helpers/image_helper.dart';
import '../../../../../widgets/textformfield.dart';
import '../categories/categories_controller.dart';
import '../categories/profile_category/profile_category_controller.dart';

class SearchScreen extends StatelessWidget {
  final SearchsController searchController = Get.put(SearchsController());
  final _controllerCategory = Get.put(CategoriesController());
  final controller = Get.put(HomeController());
  final _Profcontroller = Get.put(ProfileCategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text('Search'),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormFieldCustom(
                textEditingController: TextEditingController(),
                keyboardType: TextInputType.text,
                onChange: (value) => searchController.search(value),
                prefixIcon: SvgPicture.asset(
                  ImageHelper.searchIcon,
                  fit: BoxFit.none,
                ),
                hintText: 'Search',
              ),
              SizedBox(
                height: 10,
              ),
              Obx(() {
                if (searchController.searchResults.isEmpty) {
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
                            style: TextStyle(
                                fontSize: 24, color: Color(0xff3B3B3B)),
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
                      itemCount: searchController.searchResults.length,
                      itemBuilder: (context, index) {
                        final doc = searchController.searchResults[index];
                        // Build your UI based on the search results

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: TextButton(
                                onPressed: () {
                                  _controllerCategory
                                      .getSubcategoriesInCategory(
                                          controller.categoryList[index].id);
                                  Get.toNamed(Routes.categoriesSearch,
                                      parameters: {
                                        //   "doc_id":_controller.categoryList[index].id,
                                        "name": controller.categoryList[index]
                                            .data()
                                            .serviceName!,
                                      });
                                  _Profcontroller.getSubcategoriesInCategory(
                                      // _Profcontroller.Review[index].id
                                      );
                                },
                                child: Text(
                                  doc['service_name'],
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ),
                              // subtitle: Text(doc['description']),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
  // final SearchsController _productController = Get.put(SearchsController());
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: TextField(
  //         controller: _productController.searchController,
  //         onChanged: (value) => _productController.filterProducts(value),
  //         decoration: InputDecoration(
  //           hintText: 'Search',
  //         ),
  //       ),
  //     ),
  //     body: GetX<SearchsController>(
  //       builder: (controller) {
  //         if (controller.Category.isEmpty) {
  //           return Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //
  //         return ListView.builder(
  //           itemCount: controller.Category.length,
  //           itemBuilder: (context, index) {
  //             final product = controller.Category[index];
  //             return ListTile(
  //               title: Text(product.name),
  //               // Add more fields as needed
  //             );
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }
}
