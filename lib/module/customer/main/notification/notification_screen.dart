import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/image_helper.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
class BookingScreen extends StatelessWidget {
  const BookingScreen({Key? key}) : super(key: key);

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
                      children: [
                        _buildMainBody(),
                        Text('data'),
                        Text('data'),
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

  Widget _buildMainBody() {
    return Expanded(
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder:(context,index)=>_buildListItem(index),
          separatorBuilder: (context,index)=>SizedBox(height: 10.h,),
          itemCount: 10
      ),
    );
  }

  Container _buildListItem(index) {
//    var item = _controller.reqList[index].data();
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorHelper.offPurpleColor)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('item.serviceName!',style: _buildTextStyle1(font:16),maxLines: 1,overflow: TextOverflow.ellipsis,),
            SizedBox(height: 10.h,),
            _buildItem(icon: ImageHelper.bookIcon,title: 'item.date!'),
            SizedBox(height: 10.h,),
            _buildItem(icon: ImageHelper.locationIcon,title: 'Gaza'),
            SizedBox(height: 10.h,),
            _buildItem(icon: ImageHelper.priceIcon,title: 'item.price}\$'),
            SizedBox(height: 10.h,),
            _buildItem(icon: ImageHelper.profileIcon,title: 'item.price}\$'),
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
