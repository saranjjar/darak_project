import 'package:darak_project/module/customer/main/home/categories/profile_category/profile_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../../../../../widgets/components/components.dart';

class AddReview extends StatelessWidget {
  final _controller = Get.put(ProfileCategoryController());

  AddReview({Key? key, this.text, this.addEditFlag, this.docId})
      : super(key: key);
  String? text;
  int? addEditFlag;
  String? docId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16),
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: _controller.formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rate & Review',
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Tap to Rate:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RatingBar.builder(
                            initialRating: _controller.rating.value,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            // glow: true,
                            glowColor: Colors.yellow,
                            unratedColor: Colors.grey[300],
                            itemSize: 60.0,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              _controller.onRatingChanged(rating);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Add Review',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            maxLines: 8,
                            decoration: InputDecoration(
                                hintText: 'Add Review',
                                fillColor: Color(0xffF3F4F6),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(Icons.edit),
                                )),
                            controller: _controller.reviewController,
                            validator: (value) {
                              return _controller.validateReview(value!);
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 20, right: 10, left: 10),
                    child: D_MaterialButton(
                        onPressed: () {
                          _controller.SaveUpdateReview(
                              _controller.reviewController.text,
                              // _controller.rating.value as String,
                              // _controller.reviewController.text,
                              _controller.to_docId,
                              addEditFlag!);
                          _controller.isUploading.value = true;
                        },
                        child: Text(
                          'Submit',
                          style: buildTextStyleBtn(),
                        ),
                        width: double.infinity),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
// Text('Add Image'),
// Expanded(
//   child: Obx(
//     () => GridView.builder(
//       itemCount: _controller.imageList.length + 1,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3),
//       itemBuilder: (context, index) {
//         return index == 0
//             ? Center(
//                 child: IconButton(
//                   onPressed: () {
//                     _controller.chooseImage();
//                     // _controller.imgFromGallery(ImageSource.gallery);
//                   },
//                   icon: Icon(
//                     Icons.add,
//                     color: Colors.black,
//                   ),
//                 ),
//               )
//             : Container(
//                 margin: EdgeInsets.all(3),
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: FileImage(
//                         _controller.imageList[index - 1]),
//                   ),
//                 ),
//               );
//       },
//     ),
//   ),
// ),
// Obx(() => _controller.isUploading.value
//     ? Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               child: Text(
//                 'Uploading...',
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             CircularProgressIndicator(
//               value: _controller.progressValue.value,
//               valueColor:
//                   AlwaysStoppedAnimation<Color>(Colors.green),
//             )
//           ],
//         ),
//       )
//     : Container()),
// SizedBox(
//   height: 8,
// ),
