import 'package:darak_project/Application/app_router/app_router.dart';
import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/image_helper.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:darak_project/module/worker/addInfo/add_info_controller.dart';
import 'package:darak_project/widgets/components/components.dart';
import 'package:darak_project/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';


class AddInfoScreen extends StatelessWidget {
   AddInfoScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _controller = Get.put(AddInfoController());
   List<String> icon = [
     ImageHelper.acIcon,
     ImageHelper.devIcon,
     ImageHelper.cleanIcon,
     ImageHelper.elecIcon,
     ImageHelper.decIcon,
     ImageHelper.plumIcon,
   ];
  @override
  Widget build(BuildContext context) {

    double width =MediaQuery.of(context).size.width-40;

    return GetBuilder<AddInfoController>(builder: ((controller)=>Scaffold(
        resizeToAvoidBottomInset:true,
        backgroundColor: ColorHelper.primaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
            child: Form(
                key: _formKey,
                child:Builder(
                  builder:(context)=> Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                        children: [
                           Padding(
                            padding:  EdgeInsets.only(top:25.h),
                            child: buildImage(),
                          ),
                          SizedBox(height: 20.h,),
                          //Basic Info
                          buildContainer(width, controller, Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Basic Info',style: TextStyle(
                                fontSize: 15,

                                fontFamily: TextHelper.satoshiBold,
                              ),),
                              SizedBox(height: 20.h,),
                              Column(
                                children: [
                                  TextFormFieldCustom(
                                      width: width,
                                      label: 'User Name',
                                      keyboardType: TextInputType.text,
                                      textEditingController: controller.usernameController,
                                      validator: (value ) {
                                        if(value!.isEmpty) return 'must enter your name ';
                                      }
                                  ),
                                  SizedBox(height: 10.h,),
                                  TextFormFieldCustom(
                                      width: width,
                                      label: 'price\$',
                                      keyboardType: TextInputType.number,
                                      textEditingController: controller.priceController,
                                      validator: (value ) {
                                        if(value!.isEmpty) return 'must enter your location';
                                      }
                                  ),
                                  SizedBox(height: 10.h,),
                                  TextFormFieldCustom(
                                      width: width,
                                      label: 'Location',
                                      keyboardType: TextInputType.text,
                                      textEditingController: controller.locationController,
                                      validator: (value ) {
                                        if(value!.isEmpty) return 'must enter your location';
                                      }
                                  ),
                                  SizedBox(height: 10.h,),
                                  TextFormFieldCustom(
                                      width: width,
                                      maxline: 5,
                                      label: 'Bio',
                                      keyboardType: TextInputType.text,
                                      textEditingController: controller.bioController,
                                      validator: (value ) {
                                        if(value!.isEmpty) return 'must enter value';
                                      }
                                  ),

                                ],
                              )
                            ],
                          )),
                          SizedBox(height: 20.h,),
                          //Service Type
                          buildContainer(width, controller, Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Service Type',style: TextStyle(
                                fontSize: 15,
                                fontFamily: TextHelper.satoshiBold,
                              ),),
                               SizedBox(height: 10.h,),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => _buildAlertDialog(context),
                                  );
                                },
                                child: Container(
                                  height: 45.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: ColorHelper.warmGrey
                                      )
                                  ),
                                  child:Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      children: [
                                        controller.valid? Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: CircleAvatar(child: SvgPicture.asset(controller.icon),),
                                        ):Container(),
                                        Text(controller.serviceName,style: TextStyle(fontFamily: TextHelper.satoshiRegular,fontSize: 15),),
                                        const Spacer(),
                                        IconButton(
                                          onPressed: (){
                                          },
                                          icon:  Icon(Icons.arrow_drop_down,color: ColorHelper.warmGrey,),
                                        ),
                                      ],
                                    ),
                                  ),

                                ),
                              ),
                               SizedBox(height: 20.h,),
                              TextFormFieldCustom(

                                width: width,
                                keyboardType: TextInputType.text,
                                textEditingController: controller.subService,
                                label: 'Type',
                                validator: (value ) {
                                  if(value!.isEmpty) return 'must enter value';
                                },
                            ),
                            ],
                          )),
                          SizedBox(height: 20.h,),
                          //Contact Info
                          // buildContainer(
                          //   width,
                          //   controller,
                          //   Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Text('Contact Info',style: TextStyle(
                          //         fontSize: 15,
                          //         fontFamily: TextHelper.satoshiBold,
                          //       ),),
                          //       const SizedBox(height: 20,),
                          //       Column(
                          //         children: [
                          //           TextFormFieldCustom(
                          //               width: width,
                          //               keyboardType: TextInputType.text,
                          //               textEditingController: controller.emailController,
                          //               label: 'Email',
                          //               validator: (value ) {
                          //                 if(value!.isEmpty) return 'must enter value';
                          //               },
                          //               suffixIcon:  Icon(Icons.email,color: ColorHelper.warmGrey,)
                          //           ),
                          //           const SizedBox(height: 20,),
                          //           TextFormFieldCustom(
                          //               width: width,
                          //               keyboardType: TextInputType.text,
                          //               textEditingController: controller.mobileController,
                          //               label: 'Mobile',
                          //               validator: (value ) {
                          //                 if(value!.isEmpty) return 'must enter value';
                          //               },
                          //               suffixIcon:  Icon(Icons.phone_android_rounded,color: ColorHelper.warmGrey,)
                          //           ),
                          //           const SizedBox(height: 20,),
                          //           TextFormFieldCustom(
                          //               width: width,
                          //               keyboardType: TextInputType.text,
                          //               textEditingController: controller.IDController,
                          //               label: 'ID Number',
                          //               validator: (value ) {
                          //                 if(value!.isEmpty) return 'must enter value';
                          //               },
                          //               suffixIcon:  Icon(Icons.perm_identity_sharp,color: ColorHelper.warmGrey,)
                          //           ),
                          //         ],
                          //       )
                          //     ],
                          //   )
                          // ),
                          // SizedBox(height: 20.h,),
                          Obx(() =>
                              _controller.isLoadingRequest.value
                                  ?
                              const Center(child: CircularProgressIndicator())
                                  :
                              D_MaterialButton(
                              color: Colors.white,
                              onPressed: () {

                                // if(controller.serviceName=='Choose service'||controller.imgUrl==''){
                                //   showSnackbar(context, Colors.grey.shade600, 'you must enter your Category');
                                //   return;
                                // }
                                if(
                                _formKey.currentState!.validate()
                                    &&
                                    (controller.serviceName!='Choose service'||controller.imgUrl!='')) {
                                  controller.addInfoWorker(subcategoryID: controller.serviceName);
                                }

                              },
                              child:  Text('Add Now',
                                style: buildTextStyleBtn(color: Colors.black),), width: double.infinity))
                        ]),
                  ),)
            ),
          ),
        ))));
  }

  Container buildContainer(double width, AddInfoController controller,Widget widget) {
    return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: widget,
                          ),
                        );
  }
  List<String> service = ['Cleaning','Air Conditioning','Plumbing','Interior Design','Electrical','Appliance'];
  Widget _buildAlertDialog(BuildContext context) {
    return  AlertDialog(
      scrollable: true,
      title: const Text('Choose Category'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width/4,
        child: Column(
          children: List.generate(
              service.length , (index) {
            return GestureDetector(
              onTap: () {
                _controller.chooseServiceType(service: service[index],icons: icon[index]) ;
                Navigator.pop(context);
              },
              child: ListTile(
                leading:CircleAvatar(child: SvgPicture.asset(icon[index]),),
                title: Text(
                  service[index],
                  style:  TextStyle(
                      color: Colors.black,
                      fontFamily: TextHelper.satoshiRegular
                  ),
                ),
              ),
            );
          }
          ),
        ),
      ),
    );
  }

  InkWell buildImage() {
    return InkWell(
               onTap: (){
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
                         )
                     ),
                     child:   _controller.photo!=null
                         ?
                     CircleAvatar(
                       radius: 50,
                       backgroundColor: Colors.transparent,
                       backgroundImage: FileImage(_controller.photo!),
                     )
                         :
                         Container(
                           height: 100.h,
                           width: 100.w,
                           decoration: const BoxDecoration(
                             shape: BoxShape.circle,
                             color: ColorHelper.primaryColor
                           ),
                         )
                   ),
                   Align(
                       alignment: Alignment.center,
                       child: SvgPicture.asset(ImageHelper.cameraIcon))
                 ],
               ),
             );
  }

}