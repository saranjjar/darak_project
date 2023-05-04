// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:open_market_project/widgets/components/components.dart';
// import 'package:open_market_project/widgets/customAppBar.dart';
//
// import '../../../../../Helper/color_helper.dart';
//
// class BlockAccountScreen extends StatelessWidget {
//   const BlockAccountScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: customAppBar('Block Account', context, ColorManager.primaryBlue),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: _buildTextFormFailed(),
//           ),
//           Expanded(
//             child: ListView.separated(
//                 itemBuilder: (context,index)=>buildListBlock(),
//                 separatorBuilder: (context,index)=>SizedBox(height: 1,),
//                 itemCount: 3),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   Widget buildListBlock() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         width: double.infinity,
//         height: 100.h,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(
//             width: 0.1,
//           color: ColorManager.grayContainer
//         )
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: [
//               CircleAvatar(
//                 backgroundColor: ColorManager.primaryBlue,
//                 radius:30.r,
//                 backgroundImage: NetworkImage(
//                     'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
//               ),
//               SizedBox(width: 20.w,),
//               Expanded(
//                 child: Text(
//                   'Sara Gad',
//                   style: TextStyle(
//                       color: ColorManager.grayContainer,
//                       fontSize: 20.sp
//                   ),
//                 ),
//               ),
//               Container(
//                   width: 90.w,
//                   height: 40.h,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: ColorManager.primaryOrange)),
//                   child: Center(
//                       child: Text(
//                         'unBlock',
//                         style: TextStyle(
//                             color: ColorManager.primaryOrange, fontSize: 14.sp),
//                       ))),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   Widget _buildTextFormFailed() {
//     return textFormFailed(
//         hintText: 'Search',
//         keyboardType: TextInputType.text,
//         textEditingController: TextEditingController(),
//         prefixIconColor: ColorManager.lightGreyBtm,
//         color: Colors.grey[200],
//         prefixIcon: Icons.search,
//         validator: (value) {});
//   }
// }
