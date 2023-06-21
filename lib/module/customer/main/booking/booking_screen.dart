import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/image_helper.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:darak_project/module/customer/main/booking/booking_controller.dart';
import 'package:darak_project/widgets/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
class BookingScreen extends StatelessWidget {
   BookingScreen({Key? key}) : super(key: key);
   final _controller = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: DefaultTabController(
            length: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: _buildTabDecoration(),
                    indicatorColor: ColorHelper.primaryColor,
                    automaticIndicatorColorAdjustment: false,
                    labelColor: ColorHelper.primaryColor,
                    unselectedLabelColor: ColorHelper.blackColor,
                    physics: const BouncingScrollPhysics(),

                    tabs: [
                      Tab(
                        child:
                        Text('Pending', style: _buildTextStyle()),
                      ),
                      Tab(
                        child: Text(
                          'UpComing',
                          style: _buildTextStyle(),
                        ),
                      ),Tab(
                        child: Text(
                          'Completed',
                          style: _buildTextStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h,),
                Expanded(
                  child: TabBarView(
                    physics: const BouncingScrollPhysics(),
                      children: [
                        _controller.isLoading
                            ?
                        const Center(child: CircularProgressIndicator(),)
                            :
                        getBookingsRefresh(),
                        _controller.isLoadingUp
                            ?
                        const Center(child: CircularProgressIndicator(),)
                            :
                        getUpComingsRefresh(),

                        _controller.isLoadingComp
                            ?
                        const Center(child: CircularProgressIndicator(),)
                            :
                        getCompletedRefresh(),


                      ]),
                )
              ],
            ),

          ),
        ),
      );
  }

  BoxDecoration _buildTabDecoration() {
    return BoxDecoration(
        color: ColorHelper.light1,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200
        )
    );
  }

  TextStyle _buildTextStyle() => TextStyle(fontSize: 15,fontFamily: TextHelper.satoshiBold);


   //completed
   RefreshIndicator getCompletedRefresh(){
     return RefreshIndicator(
         onRefresh: _controller.asyncLoadCompleted,
         child: _controller.completedList.isEmpty
             ?
         Center(child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             SvgPicture.asset(ImageHelper.emptyBookIcon),
             SizedBox(height: 5.h,),
             Text('There is no any Booking now',style: TextStyle(fontFamily: TextHelper.satoshiLight),),
           ],
         ),)
             :
         _buildCompletedMainBody()
     );
   }
   Widget _buildCompletedMainBody() {
     return ListView.separated(
       physics: const AlwaysScrollableScrollPhysics(),
       itemBuilder:(context,index){
         return _buildCompletedListItem(index);
       },
       separatorBuilder: (context,index)=>SizedBox(height: 10.h,),
       itemCount: _controller.completedList.length,
     );
   }
   Widget _buildCompletedListItem(index) {
     var item = _controller.completedList[index].data();
     return Material(
       elevation: 0,
       clipBehavior: Clip.antiAliasWithSaveLayer,
       color: Colors.white,
       child: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 8.0),
         child: ExpansionTile(
           tilePadding: EdgeInsets.zero,
           title: Text('${item.date}',style: TextStyle(fontFamily: TextHelper.satoshiMedium,fontSize: 16),),
           children: [
             Container(
               decoration: BoxDecoration(
                   color:ColorHelper.light1,
                   borderRadius: BorderRadius.circular(20),
                   border: Border.all(color: ColorHelper.offPurpleColor)),
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(item.subServiceName!,style: _buildTextStyle1(font:16),maxLines: 1,overflow: TextOverflow.ellipsis,),
                     SizedBox(height: 10.h,),
                     _buildItem(icon: ImageHelper.profileIcon,title: item.worker!),
                     SizedBox(height: 10.h,),
                     _buildItem(icon: ImageHelper.bookIcon,title: '${item.date!} ${item.time!}'),
                     SizedBox(height: 10.h,),
                     _buildItem(icon: ImageHelper.locationIcon,title: item.location!),
                     SizedBox(height: 10.h,),
                     _buildItem(icon: ImageHelper.priceIcon,title: '${item.price}\$'),
                     SizedBox(height: 10.h,),
                     D_MaterialButton(
                     width: double.infinity,
                         color: ColorHelper.primaryColor,onPressed: (){

                     }, child: Text('Rate & Review',style: buildTextStyleBtn(),

                     ))
                   ],
                 ),
               ),
             )
           ],
         ),
       ),
     );
   }

   //upcoming
   RefreshIndicator getUpComingsRefresh(){
     return RefreshIndicator(
         onRefresh: _controller.asyncLoadUpComing,
         child: _controller.upComingsList.isEmpty
             ?
         Center(child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             SvgPicture.asset(ImageHelper.emptyBookIcon),
             SizedBox(height: 5.h,),
             Text('There is no any UpComing Booking now',style: TextStyle(fontFamily: TextHelper.satoshiLight),),
           ],
         ),)
             :
         _buildUpComingsMainBody()
     );
   }
   Widget _buildUpComingsMainBody() {
     return ListView.separated(
       physics: const AlwaysScrollableScrollPhysics(),
       itemBuilder:(context,index){
         return _buildUpComingsListItem(index);
       },
       separatorBuilder: (context,index)=>SizedBox(height: 10.h,),
       itemCount: _controller.upComingsList.length,
     );
   }
   Widget _buildUpComingsListItem(index) {
     var item = _controller.upComingsList[index].data();
     return Material(
       elevation: 0,
       clipBehavior: Clip.antiAliasWithSaveLayer,
       color: Colors.white,
       child: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 8.0),
         child: ExpansionTile(
           tilePadding: EdgeInsets.zero,
           title: Text('${item.date}',style: TextStyle(fontFamily: TextHelper.satoshiMedium,fontSize: 16),),
           children: [
             Container(
               decoration: BoxDecoration(
                   color:ColorHelper.light1,
                   borderRadius: BorderRadius.circular(20),
                   border: Border.all(color: ColorHelper.offPurpleColor)),
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(item.subServiceName!,style: _buildTextStyle1(font:16),maxLines: 1,overflow: TextOverflow.ellipsis,),
                     SizedBox(height: 10.h,),
                     _buildItem(icon: ImageHelper.profileIcon,title: item.nameCustomer!),
                     SizedBox(height: 10.h,),
                     _buildItem(icon: ImageHelper.bookIcon,title: '${item.date!} ${item.time!}'),
                     SizedBox(height: 10.h,),
                     _buildItem(icon: ImageHelper.locationIcon,title: item.location!),
                     SizedBox(height: 10.h,),
                     _buildItem(icon: ImageHelper.priceIcon,title: '${item.price}\$'),
                     SizedBox(height: 10.h,),
                   ],
                 ),
               ),
             )
           ],
         ),
       ),
     );
   }


   //pending
  RefreshIndicator getBookingsRefresh(){
    return RefreshIndicator(
        onRefresh: _controller.asyncLoadPendingBook,
        child: _controller.bookingsList.isEmpty
            ?
         Center(child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             SvgPicture.asset(ImageHelper.emptyBookIcon),
             SizedBox(height: 5.h,),
             Text('There is no any Booking now',style: TextStyle(fontFamily: TextHelper.satoshiLight),),
           ],
         ),)
            :
        _buildMainBody()
    );
  }

  Widget _buildMainBody() {
    return ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder:(context,index)=>_buildListItem(index),
        separatorBuilder: (context,index)=>SizedBox(height: 10.h,),
        itemCount: _controller.bookingsList.length,
    );
  }

  Container _buildListItem(index) {
 var item = _controller.bookingsList[index].data();
    return Container(
      decoration: BoxDecoration(
          color:ColorHelper.light1,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: ColorHelper.offPurpleColor)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.subServiceName!,style: _buildTextStyle1(font:16),maxLines: 1,overflow: TextOverflow.ellipsis,),
            SizedBox(height: 10.h,),
            _buildItem(icon: ImageHelper.profileIcon,title: item.worker!),
            SizedBox(height: 10.h,),
            _buildItem(icon: ImageHelper.bookIcon,title: '${item.date!} ${item.time!}'),
            SizedBox(height: 10.h,),
            _buildItem(icon: ImageHelper.locationIcon,title: item.location!),
            SizedBox(height: 10.h,),
            _buildItem(icon: ImageHelper.priceIcon,title: '${item.price}\$'),
                      ],
        ),
      ),
    );
  }

  Row _buildItem({required String title, required String icon}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(icon),
        const SizedBox(width:5,),
        Text(title,style: TextStyle(fontSize: 16,fontFamily: TextHelper.satoshiMedium,),maxLines: 1,overflow: TextOverflow.ellipsis,),
      ],
    );
  }

  TextStyle _buildTextStyle1({double? font}) => TextStyle(fontFamily: TextHelper.satoshiBold, fontSize:font?? 18);

}
