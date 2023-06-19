import 'package:darak_project/module/customer/main/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../helpers/colors_helper.dart';
import '../../../../helpers/image_helper.dart';
import '../../../../widgets/components/components.dart';
import '../../../worker/addInfo/add_info_controller.dart';
import '../../../worker/worker_sign_up/sign_up_worker_screen.dart';
import '../../customer_auth/customer_sign_in/sign_in_customer_screen.dart';
import '../../customer_auth/customer_sign_up/sign_up_customer_controller.dart';
import 'settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  final _controller = Get.put(AddInfoController());
  final GetUserName getUserNameController = Get.put(GetUserName());
  final controllerSignUp = Get.put(SignUpController());
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    // UserData user = snapshot.data as UserData;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SafeArea(
        child: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       'Profile',
            //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //     ),
            //     IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
            //   ],
            // ),
            // SizedBox(
            //   height: 12,
            // ),
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage('${controller.photourl}'),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              " ${controller.userName}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "${controller.email}",
              style: TextStyle(fontSize: 16),
            ),
            Divider(
              height: 30,
              color: Colors.black,
            ),
            Column(
              children: [
                listProfile(
                  text: 'Edit Profile',
                  icon: Icons.person,
                  tt: '',
                  onPreased: () {
                    Get.to(() => EditProfile());
                  },
                ),
                listProfile(
                  text: 'Address',
                  icon: Icons.location_on_outlined,
                  onPreased: () {},
                  tt: '',
                ),
                listProfile(
                  text: 'Payment',
                  icon: Icons.wallet,
                  onPreased: () {},
                  tt: '',
                ),
                listProfile(
                  text: 'Language',
                  icon: Icons.language,
                  tt: 'English',
                  onPreased: () {
                    Get.to(() => Language());
                  },
                ),
                listProfile(
                  text: 'Dark Mode',
                  icon: Icons.dark_mode_outlined,
                  onPreased: () {},
                  tt: '',
                ),
                listProfile(
                  text: 'Privacy Policy',
                  icon: Icons.lock_outline,
                  tt: '',
                  onPreased: () {
                    Get.to(() => PrivacyPolicy());
                  },
                ),
                listProfile(
                  text: 'Support',
                  icon: Icons.people,
                  onPreased: () {},
                  tt: '',
                ),
                listProfile(
                  text: 'Log Out',
                  icon: Icons.logout,
                  color: Colors.red,
                  tt: '',
                  onPreased: () {
                    Get.defaultDialog(
                      title: 'Log Out',
                      titleStyle: TextStyle(fontSize: 18),
                      middleText: 'Are you sure to log out?',
                      textConfirm: 'Log Out',
                      textCancel: 'Cancel',
                      // content: Column(),
                      // cancel: InkWell(child: Text('Cancel',),),
                      onConfirm: () {
                        controllerSignUp.logOut();
                        Get.offAll(SignInScreen());
                      },
                      confirmTextColor: Colors.white,
                      buttonColor: Colors.red,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InkWell buildImage() {
    return InkWell(
      onTap: () {
        _controller.imgFromGallery(ImageSource.gallery);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  )),
              child: _controller.photo != null
                  ? CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.transparent,
                      backgroundImage: FileImage(_controller.photo!),
                    )
                  : Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorHelper.primaryColor),
                    )),
          Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(ImageHelper.cameraIcon))
        ],
      ),
    );
  }
}

class EditProfile extends GetView<SettingsController> {
  final GetUserName getUserNameController = Get.put(GetUserName());
  final _controller = Get.put(HomeController());

  EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(15),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            // Get.offAll(() => SettingsScreen());
                          },
                          icon: Icon(Icons.arrow_back_ios_new)),
                      Text(
                        'Edit Profil',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ' ${_controller.userName}',
                      ),
                      IconButton(
                        onPressed: () {
                          Get.bottomSheet(
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                                border: Border(),
                                color: Colors.white,
                              ),
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: getUserNameController
                                          .fullNameController,
                                      decoration: InputDecoration(
                                        labelText: 'New Name',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    D_MaterialButton(
                                      onPressed: () {
                                        getUserNameController.updateUserName(
                                          getUserNameController
                                              .fullNameController.text,
                                          getUserNameController.docId,
                                        );
                                      },
                                      child: Text(
                                        'Save Name',
                                        style: buildTextStyleBtn(),
                                      ),
                                      width: double.infinity,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  ),
                  Divider(
                    height: 20,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Phone',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Obx(
                      //   () => Text('getUserNameController.phone.value'),
                      // ),
                      Text('getUserNameController.phone.value'),
                      IconButton(
                        onPressed: () {
                          Get.bottomSheet(
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                                border: Border(),
                                color: Colors.white,
                              ),
                              height: 200,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    TextField(
                                      controller:
                                          getUserNameController.phoneController,
                                      decoration: InputDecoration(
                                        labelText: 'New Name',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    D_MaterialButton(
                                      onPressed: () {
                                        getUserNameController.updateUserPhone(
                                            getUserNameController
                                                .phoneController.text);
                                      },
                                      child: Text(
                                        'Save Phone',
                                        style: buildTextStyleBtn(),
                                      ),
                                      width: double.infinity,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  ),
                  Divider(
                    height: 20,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

class PrivacyPolicy extends GetView<SettingsController> {
  final GetUserName getUserNameController = Get.put(GetUserName());
  final _controller = Get.put(HomeController());

  PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            margin: EdgeInsets.all(15),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            // Get.offAll(() => SettingsScreen());
                          },
                          icon: Icon(Icons.arrow_back_ios_new)),
                      Text(
                        'PrivacyPolicy',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'E-mail address',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${_controller.email}'),
                      IconButton(
                        onPressed: () {
                          Get.bottomSheet(
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                                border: Border(),
                                color: Colors.white,
                              ),
                              height: 200,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: getUserNameController
                                          .fullNameController,
                                      decoration: InputDecoration(
                                        labelText: 'New Email',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    D_MaterialButton(
                                      onPressed: () {
                                        // getUserNameController.updateUserEmail(
                                        //     getUserNameController
                                        //         .emailController.text);
                                      },
                                      child: Text(
                                        'Save Email',
                                        style: buildTextStyleBtn(),
                                      ),
                                      width: double.infinity,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  ),
                  Divider(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        Get.to(() => SignUpWoScreen());
                      },
                      child: Text(
                        'Switch to a worker account',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurpleAccent),
                      ))
                ])),
      ),
    );
  }
}

class Language extends StatelessWidget {
  const Language({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Language',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Select Language',
                style: TextStyle(fontSize: 16),
              ),
              Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Text(
                    'Englich',
                    style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  Icon(Icons.task_alt_rounded),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    'Arabic',
                    style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  Icon(Icons.task_alt_rounded),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Edit extends StatelessWidget {
  Edit({
    super.key,
    required this.text,
    required this.textBottom,
    required this.textValue,
    required this.labelText,
    required this.name,
    required this.onPressed,

    // required this.getUserNameController,
  });

  // final GetUserName getUserNameController;
  String text;
  String textBottom;
  String textValue;
  TextEditingController name;
  String labelText;
  Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Text(textValue),
              ),
              IconButton(
                onPressed: () {
                  Get.bottomSheet(
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        border: Border(),
                        color: Colors.white,
                      ),
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            TextField(
                              controller: name,
                              decoration: InputDecoration(
                                labelText: labelText,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            D_MaterialButton(
                              onPressed: onPressed,
                              child: Text(
                                textBottom,
                                style: buildTextStyleBtn(),
                              ),
                              width: double.infinity,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.edit),
              ),
            ],
          ),
          Divider(
            height: 20,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

class listProfile extends StatelessWidget {
  listProfile({
    this.color,
    this.tt,
    required this.text,
    required this.icon,
    required this.onPreased,
    super.key,
  });
  String text;
  String? tt;
  IconData icon;
  Color? color;
  Function() onPreased;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: color,
            ),
            SizedBox(
              width: 10,
            ),
            Text(text),
          ],
        ),
        Row(
          children: [
            Text('$tt'),
            IconButton(
                onPressed: onPreased,
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: color,
                )),
          ],
        )
      ],
    );
  }
}
