import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr/core/%20navigation/navigation.dart';
import 'package:mr/core/styles/themes.dart';
import 'package:mr/core/widgets/constant.dart';
import 'package:mr/features/user/cubit/cubit.dart';
import 'package:mr/features/user/cubit/states.dart';
import 'package:mr/features/user/view/add_order.dart';
import 'package:mr/features/user/view/my_order.dart';

import '../../../core/widgets/StatCard.dart';
import '../../../core/widgets/circular_progress.dart';
import '../../../core/widgets/show_toast.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  static int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserCubit()..getAds()..getStats(),
      child: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit=UserCubit.get(context);
          return SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                body: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        color: Colors.white,

                      ),
                      height: 55,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/logo4.png',height: 200,),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child:Column(
                          children: [
                            SizedBox(height: 30,),
                            ConditionalBuilder(
                              condition:cubit.getAdsModel.isNotEmpty&&cubit.statsModel.isNotEmpty,
                              builder:(c){
                                return Column(
                                  children: [
                                    CarouselSlider(
                                      items: cubit.getAdsModel.expand((entry) => entry.images.map((imageUrl) => Builder(
                                        builder: (BuildContext context) {
                                          return SizedBox(
                                            width: double.infinity,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(12.0),
                                              child: Image.network(
                                                "http://mr.khaleeafashion.com/uploads/$imageUrl",
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace) =>
                                                    Icon(Icons.error),
                                              ),
                                            ),
                                          );
                                        },
                                      ))).toList(),
                                      options: CarouselOptions(
                                        height: 360,//156,
                                        viewportFraction: 0.94,
                                        enlargeCenterPage: true,
                                        initialPage: 0,
                                        enableInfiniteScroll: true,
                                        reverse: true,
                                        autoPlay: true,
                                        autoPlayInterval: const Duration(seconds: 6),
                                        autoPlayAnimationDuration:
                                        const Duration(seconds: 1),
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        scrollDirection: Axis.horizontal,
                                        onPageChanged: (index, reason) {
                                          currentIndex=index;
                                          cubit.slid();
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 8,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: cubit.getAdsModel.asMap().entries.expand((entry) {
                                        return entry.value.images.map((imageUrl) {
                                          int imageIndex = entry.value.images.indexOf(imageUrl);
                                          return Container(
                                            width: currentIndex == imageIndex ? 30 : 8,
                                            height: 7.0,
                                            margin: const EdgeInsets.symmetric(horizontal: 3.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: currentIndex == imageIndex
                                                  ? primaryColor
                                                  : Color(0XFFC1D1F9),
                                            ),
                                          );
                                        });
                                      }).toList(),
                                    ),
                                    SizedBox(height: 16,),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SizedBox(width: 10,),
                                              StatCard(
                                                label: 'الطلبات الكلية',
                                                icon: 'solar_box-outline.png',
                                                total: cubit.statsModel[0].totalOrders,
                                                used:  cubit.statsModel[0].totalOrders,
                                                color: Colors.deepOrangeAccent,
                                              ),
                                              SizedBox(width: 10,),
                                              StatCard(
                                                label: 'الطلبات قيد الانتضار',
                                                icon: 'mingcute_sandglass-2-line.png',
                                                total: cubit.statsModel[0].totalOrders,
                                                used:  cubit.statsModel[0].pendingOrders,
                                                color: Colors.yellow,
                                              ),
                                              SizedBox(width: 10,),
                                              StatCard(
                                                label: 'الطلبات قيد التوصيل',
                                                icon: 'healthicons_vespa-motorcycle-outline.png',
                                                total: cubit.statsModel[0].totalOrders,
                                                used:  cubit.statsModel[0].deliveryOrders,
                                                color: Colors.blue,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 12,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              StatCard(
                                                label: 'الطلبات المكتملة',
                                                icon: 'fluent-mdl2_completed.png',
                                                total: cubit.statsModel[0].totalOrders,
                                                used:  cubit.statsModel[0].completedOrders,
                                                color: Colors.green,
                                              ),
                                              SizedBox(width: 10,),
                                              StatCard(
                                                label: 'الطلبات الملغية',
                                                icon: 'material-symbols_cancel-outline-rounded.png',
                                                total: cubit.statsModel[0].totalOrders,
                                                used:  cubit.statsModel[0].canceledOrders,
                                                color: primaryColor,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 30,),
                                  ],
                                );
                              },
                              fallback: (c)=> Padding(
                                padding: const EdgeInsets.symmetric(vertical: 60.0),
                                child: CircularProgressIndicator(color: primaryColor,),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: (){
                                      navigateTo(context, MyOrder());
                                    },
                                    child: Container(
                                      height: 180,
                                      margin: EdgeInsets.only(left: 20,top: 10,bottom: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: primaryColor,
                                          width: 2,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                        child: Text('طلباتي',style: TextStyle(
                                          // color: Colors.white,
                                            fontSize: 22
                                        ),),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: (){
                                      navigateTo(context, AddOrder());
                                    },
                                    child: Container(
                                      height: 180,
                                      margin: EdgeInsets.only(right: 20,top: 10,bottom: 10),
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(

                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(20),
                                        color: primaryColor,
                                      ),
                                      child: Center(
                                        child: Text('اظافة طلب\n جديد',style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22
                                        ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: (){
                                signOut(context);
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                height: 50,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: primaryColor,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text('تسجيل الخروج',style: TextStyle(
                                    // color: Colors.white,
                                      fontSize: 18
                                  ),),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                showToast(
                                  text: 'سوف يتم التواصل معك قريبا لحذف الحساب',
                                  color: Colors.redAccent,
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                height: 50,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: primaryColor,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text('حذف الحساب',style: TextStyle(
                                    // color: Colors.white,
                                      fontSize: 18
                                  ),),
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                          ],
                        ) ,
                      ),
                    )

                  ],
                ),
              ));
        },
      ),
    );
  }
}
