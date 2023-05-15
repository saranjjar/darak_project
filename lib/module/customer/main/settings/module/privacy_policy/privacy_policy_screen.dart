// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:open_market_project/Helper/color_helper.dart';
// import 'package:open_market_project/widgets/customAppBar.dart';
//
// import '../../../../../Helper/string_helper.dart';
//
// class PrivacyPolicyScreen extends StatelessWidget {
//   const PrivacyPolicyScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: customAppBar('Privacy Policy', context, ColorManager.primaryBlue),
//
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Privacy Policy',style: TextStyle(
//                 color: ColorManager.primaryOrange,
//                 fontSize: 25.sp,
//                 fontWeight: FontWeight.bold
//             ),),
//             SizedBox(height: 30.h,),
//             Text(StringManager.text1AboutUs,style: TextStyle(),),
//             SizedBox(height: 20.h,),
//             Text(StringManager.text2AboutUs,style: TextStyle(),)
//           ],
//         ),
//       ),
//     );
//   }
// }
