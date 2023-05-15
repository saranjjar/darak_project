//
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:olaylar/module/contact_us/contact_us_screen.dart';
// import 'package:olaylar/module/drawer/partner/partner_screen.dart';
// import 'package:olaylar/module/drawer/reminder/reminder_screen.dart';
// import 'package:olaylar/module/event/event_screen.dart';
// import 'image_helper.dart';
//
//
// class DrawerHelper extends StatelessWidget {
//   final padding = EdgeInsets.symmetric(horizontal: 20);
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       clipBehavior: Clip.antiAliasWithSaveLayer,
//       borderRadius: BorderRadius.only(
//           topRight: Radius.circular(25),
//           bottomRight: Radius.circular(25)
//       ),
//       color: ColorManager.white,
//       child: Container(
//           clipBehavior: Clip.antiAliasWithSaveLayer,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(25),
//                   bottomRight: Radius.circular(25)
//               )
//           ),
//
//           child: Drawer(
//               backgroundColor: ColorManager.white,
//               child: ListView(
//                   children: <Widget>[
//                     Column(
//                         children: [
//                           buildLoginField(),
//                           Container(
//                               color: ColorManager.white,
//                               padding: padding,
//                               child: Column(
//                                 children: [
//                                   const SizedBox(height: 5),
//                                   buildMenuItem(
//                                     text: 'Home',
//                                     icon: ImageHelper.homeIcon,
//                                     onClicked: () => selectedItem(context, 0),
//                                   ),
//                                   buildMenuItem(
//                                     text: 'Sign In',
//                                     icon: ImageHelper.signinIcon,
//                                     onClicked: () => selectedItem(context, 1),
//                                   ),
//                                   buildMenuItem(
//                                     text: 'Partners',
//                                     icon: ImageHelper.ic_partnersIcon,
//                                     onClicked: () => selectedItem(context, 2),
//                                   ),
//                                   buildMenuItem(
//                                     text: 'Reminder',
//                                     icon: ImageHelper.reminderIcon,
//                                     onClicked: () => selectedItem(context, 3),
//                                   ),
//                                   buildMenuItem(
//                                     text: 'New Event',
//                                     icon: ImageHelper.neweventIcon,
//                                     onClicked: () => selectedItem(context, 4),
//                                   ),
//                                   buildMenuItem(
//                                     text: 'Contact Us',
//                                     icon: ImageHelper.contactIcon,
//                                     onClicked: () => selectedItem(context, 5),
//                                   ),                                  buildMenuItem(
//                                     text: 'About Us',
//                                     icon: ImageHelper.infoIcon,
//                                     onClicked: () => selectedItem(context, 6),
//                                   ),                                  buildMenuItem(
//                                     text: 'About App',
//                                     icon: ImageHelper.hexaIcon,
//                                     onClicked: () => selectedItem(context, 7),
//                                   ),
//
//                                   //buildFooter(),
//                                 ],)
//                           )])]))),
//     );
//   }
//
//
//   Widget buildLoginField() {
//     return ClipPath(
//       clipper: CurvedBottomClipper(),
//       child: Container(
//           width: double.infinity,
//           height: 150.h,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//                 colors: [
//                   ColorManager.headerColor,
//                   Colors.deepPurple.shade300,
//                   Colors.blue.shade300
//                 ])
//           ),
//           child: Center(
//             child: Text('TürkOlaylar',style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 13
//             ),),
//           )
//       ),
//     );
//   }
//
//   Widget buildMenuItem({
//     required String text,
//     required String icon,
//     VoidCallback? onClicked,
//   }) {
//
//     return ListTile(
//       leading: SvgPicture.asset(icon,height: 25,width: 25,),
//       title: Text(
//           text,
//           style: TextStyle(
//             color: ColorManager.primaryColor, fontSize: 16,fontFamily: 'SFUI-Regular',
//
//       )),
//       trailing: Icon(Icons.arrow_forward_ios,color: ColorManager.iconColor,size: 15,),
//       onTap: onClicked,
//     );
//   }
//
//   void selectedItem(BuildContext context, int index) {
//     Navigator.of(context).pop();
//
//     switch (index) {
//       case 0:
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => EventScreen(),
//         ));
//         break;
//       case 1:
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => EventScreen(),
//         ));
//         break;
//
//         case 2:
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => PartnerScreen(),
//         ));
//         break;
//
//       case 3:
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => ReminderScreen(),
//         ));
//         break;
//
//         case 4:
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => AddEventScreen(),
//         ));
//         break;
//
//         case 5:
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => ContactUsScreen(),
//         ));
//         break;
//
//         case 6:
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => EventScreen(),
//         ));
//         break;
//
//         case 7:
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => ContactUsScreen(),
//         ));
//         break;
//       }
//   }
//
//   Widget buildFooter() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: 20.h,),
//         ListTile(title: Text('About Us',style: TextStyle(color: Colors.white, fontSize: 16,fontFamily: 'Montserrat',))),
//         ListTile(title: Text('Log Out',style: TextStyle(color: Colors.white, fontSize: 16,fontFamily: 'Montserrat',)),)
//         ,
//       ],
//     );
//   }
// }
//
// class CurvedBottomClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     // I've taken approximate height of curved part of view
//     // Change it if you have exact spec for it
//     final roundingHeight = size.height * 3 / 5;
//
//     // this is top part of path, rectangle without any rounding
//     final filledRectangle =
//     Rect.fromLTRB(0, 0, size.width, size.height - roundingHeight);
//
//     // this is rectangle that will be used to draw arc
//     // arc is drawn from center of this rectangle, so it's height has to be twice roundingHeight
//     // also I made it to go 5 units out of screen on left and right, so curve will have some incline there
//     final roundingRectangle = Rect.fromLTRB(
//         -5, size.height - roundingHeight * 2, size.width + 5, size.height);
//
//     final path = Path();
//     path.addRect(filledRectangle);
//
//     // so as I wrote before: arc is drawn from center of roundingRectangle
//     // 2nd and 3rd arguments are angles from center to arc start and end points
//     // 4th argument is set to true to move path to rectangle center, so we don't have to move it manually
//     path.arcTo(roundingRectangle, pi, -pi, true);
//     path.close();
//
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     // returning fixed 'true' value here for simplicity, it's not the part of actual question, please read docs if you want to dig into it
//     // basically that means that clipping will be redrawn on any changes
//     return true;
//   }}
