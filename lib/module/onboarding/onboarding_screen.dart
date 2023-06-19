//
// import 'package:darak_project/Application/app_router/app_router.dart';
// import 'package:darak_project/const.dart';
// import 'package:darak_project/helpers/colors_helper.dart';
// import 'package:darak_project/helpers/image_helper.dart';
// import 'package:darak_project/helpers/texts_helper.dart';
// import 'package:darak_project/services/common/config.dart';
// import 'package:darak_project/services/common/shared_pref.dart';
// import 'package:darak_project/services/common/user_store.dart';
// import 'package:darak_project/widgets/components/components.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//
// class OnBoardingScreen extends StatelessWidget {
//    OnBoardingScreen({Key? key}) : super(key: key);
//    final _controller = Get.put(OnBoardingController());
//   var pageViewController = PageController();
//
//   List<modelItem> model = [
//     modelItem(ImageHelper.onb1, TextHelper.ptxt1),
//     modelItem(ImageHelper.onb1, TextHelper.ptxt2),
//     modelItem(ImageHelper.onb1, TextHelper.ptxt3),
//   ];
//
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     var width = size.width;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: Padding(
//                 padding:  EdgeInsets.only(
//                   top: 60.h,
//                 ),
//                 child: PageView.builder(
//                     physics: const BouncingScrollPhysics(),
//                     itemCount: model.length,
//                     onPageChanged: (index) {
//                       //first condition
//                       if (index == model.length - 1) {
//
//                            _controller.isLast.value = true;
//
//                       } else {
//
//                         _controller.isLast.value = false;
//
//                       }
//
//                       //second condition
//                       if (index == 0) {
//
//                         _controller.isFirst.value = true;
//
//                       } else {
//
//                         _controller.isFirst.value = false;
//
//                       }
//                     },
//                     controller: pageViewController,
//                     itemBuilder: (context, index) => buildItem(model[index])),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 15, left: 15, bottom: 30),
//               child: Column(
//                 children: [
//                   D_MaterialButton(
//                       color: ColorHelper.primaryColor,
//                       onPressed: () {
//                         if (_controller.isLast.value) {
//                           ConfigStore.to.saveAlreadyOpen();
//                           UserStore.t0.isLog();
//                           Get.offAllNamed(Routes.splashRoute);
//                         } else {
//                           pageViewController.nextPage(
//                             duration: const Duration(milliseconds: 800),
//                             curve: Curves.fastLinearToSlowEaseIn,
//                           );
//                         }
//                       },
//                       child: Text(
//                         _controller.isFirst.value ? 'Get Started' : 'Continue',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontFamily: TextHelper.satoshiBold),
//                       ),
//                       width: width),
//                   TextButton(
//                       onPressed: () {
//                         ConfigStore.to.saveAlreadyOpen();
//                         Get.toNamed(Routes.splashRoute);
//                       },
//                       child: Text(
//                         'Skip',
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontFamily: TextHelper.satoshiBold),
//                       ))
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   Widget buildItem(modelItem model) {
//     return Column(
//       children: [
//         Image(image: AssetImage(model.image,),height: 300.h,fit: BoxFit.cover,),
//         SizedBox(
//           height: 30.h,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8),
//           child: Text(
//             model.title,
//             style: TextStyle(
//                 color: Colors.black,
//                 fontFamily: TextHelper.satoshiRegular,
//                 fontSize: 18),
//             textAlign: TextAlign.center,
//           ),
//         ),
//         SizedBox(
//           height: 25.h,
//         ),
//         SmoothPageIndicator(
//           controller: pageViewController,
//           count: 3,
//           effect: ExpandingDotsEffect(
//             dotColor: Colors.grey.shade300,
//             dotHeight: 5,
//             dotWidth: 10,
//             spacing: 5,
//             expansionFactor: 2,
//             activeDotColor: ColorHelper.primaryColor,
//           ),
//         )
//       ],
//     );
//   }
// }
//
// class modelItem {
//   String image;
//   String title;
//   modelItem(this.image, this.title);
// }




import 'package:darak_project/Application/app_router/app_router.dart';
import 'package:darak_project/const.dart';
import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/image_helper.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:darak_project/services/common/config.dart';
import 'package:darak_project/services/common/shared_pref.dart';
import 'package:darak_project/services/common/user_store.dart';
import 'package:darak_project/widgets/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  var pageViewController = PageController();
  bool isLast = false;
  bool isFirst = true;

  List<modelItem> model = [
    modelItem(ImageHelper.onb1, TextHelper.ptxt1),
    modelItem(ImageHelper.onb2, TextHelper.ptxt2),
    modelItem(ImageHelper.onb3, TextHelper.ptxt3),
  ];

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(

              child: Padding(
                padding:  EdgeInsets.only(
                  top: 60.h,
                ),
                child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: model.length,
                    onPageChanged: (index) {
                      //first condition
                      if (index == model.length - 1) {
                        setState(() {
                          isLast = true;
                        });
                      } else {
                        setState(() {
                          isLast = false;
                        });
                      }

                      //second condition
                      if (index == 0) {
                        setState(() {
                          isFirst = true;
                        });
                      } else {
                        setState(() {
                          isFirst = false;
                        });
                      }
                    },
                    controller: pageViewController,
                    itemBuilder: (context, index) => buildItem(model[index])),
              ),
            ),

            SmoothPageIndicator(
              controller: pageViewController,
              count: 3,
              effect: ExpandingDotsEffect(
                dotColor: Colors.grey.shade300,
                dotHeight: 5,
                dotWidth: 10,
                spacing: 5,
                expansionFactor: 2,
                activeDotColor: ColorHelper.primaryColor,
              ),
            ),
            SizedBox(height: 30.h,),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 30),
              child: Column(
                children: [
                  D_MaterialButton(
                      color: ColorHelper.primaryColor,
                      onPressed: () {
                        if (isLast) {
                          ConfigStore.to.saveAlreadyOpen();
                          UserStore.t0.isLog();
                          Get.offAllNamed(Routes.splashRoute);
                        } else {
                          pageViewController.nextPage(
                            duration: const Duration(milliseconds: 800),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );
                        }
                      },
                      child: Text(
                        isFirst ? 'Get Started' : 'Continue',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: TextHelper.satoshiBold),
                      ),
                      width: width),
                  TextButton(
                      onPressed: () {
                        ConfigStore.to.saveAlreadyOpen();
                        Get.toNamed(Routes.splashRoute);
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: TextHelper.satoshiBold),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget buildItem(modelItem model) {
    return Column(
      children: [
        Image(image: AssetImage(model.image,),height: 300.h,),
         SizedBox(
          height: 30.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            model.title,
            style: TextStyle(
                color: Colors.black,
                fontFamily: TextHelper.satoshiRegular,
                fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),

      ],
    );
  }
}

class modelItem {
  String image;
  String title;
  modelItem(this.image, this.title);
}
