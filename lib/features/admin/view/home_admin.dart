import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr/core/%20navigation/navigation.dart';
import 'package:mr/core/styles/themes.dart';
import 'package:mr/core/widgets/circular_progress.dart';
import 'package:mr/core/widgets/constant.dart';
import 'package:mr/features/admin/cubit/cubit.dart';
import 'package:mr/features/admin/cubit/states.dart';
import 'package:mr/features/admin/view/profile_user_admin.dart';
import 'package:mr/features/admin/view/user_order_admin.dart';

import '../../../core/widgets/StatCard.dart';

class HomeAdmin extends StatelessWidget {
  const HomeAdmin({super.key});

  static int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AdminCubit()
        ..getUser()..getAds()..getStats(),
      child: BlocConsumer<AdminCubit, AdminStates>(
        listener: (context, state) {
          if(state is DeleteUserSuccessState){
            navigateBack(context);
          }
        },
        builder: (context, state) {
          var cubit=AdminCubit.get(context);
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap:(){
                                signOut(context);
                              },
                              child: Icon(Icons.logout)),
                          Image.asset('assets/images/logo4.png',height: 200,),
                          SizedBox(
                            width: 20,
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(height: 30,),
                            ConditionalBuilder(
                                condition: cubit.users.isNotEmpty
                                && cubit.statsModel.isNotEmpty &&
                                    cubit.getAdsModel.isNotEmpty,
                                builder: (c){
                                  return Column(
                                    children: [
                                      Column(
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
                                              height: 350,
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
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: (){
                                                  cubit.deleteAds(id: cubit.getAdsModel[currentIndex].id.toString());
                                                },
                                                child: Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: Colors.red
                                                    ),
                                                    child: Icon(Icons.delete,color: Colors.white,)),
                                              ),
                                              GestureDetector(
                                                onTap: (){
                                                  cubit.selectedImages.isNotEmpty?
                                                  cubit.addAds():cubit.pickImages();
                                                },
                                                child: Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: Colors.blue
                                                    ),
                                                    child:cubit.selectedImages.isNotEmpty?
                                                    Text('رفع الصورة',style: TextStyle(color: Colors.white),):
                                                    Icon(Icons.add_a_photo_outlined,color: Colors.white,)
                                                ),
                                              ),
                                            ],
                                          ),
                                          cubit.selectedImages.isNotEmpty
                                              ? SizedBox(
                                            height: 150,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: cubit.selectedImages.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Image.file(File(cubit.selectedImages[index].path), height: 150),
                                                );
                                              },
                                            ),
                                          ):Container(),
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
                                        ],
                                      ),
                                      SizedBox(height: 26,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                StatCard(
                                                  label: 'المستخدمين النشطين',
                                                  icon: 'fluent_person-16-regular.png',
                                                  total: cubit.statsModel[0].totalUsers,
                                                  used:  cubit.statsModel[0].totalUsers,
                                                  color: Colors.blue,
                                                ),
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
                                              ],
                                            ),
                                            SizedBox(height: 12,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                StatCard(
                                                  label: 'الطلبات قيد التوصيل',
                                                  icon: 'healthicons_vespa-motorcycle-outline.png',
                                                  total: cubit.statsModel[0].totalOrders,
                                                  used:  cubit.statsModel[0].deliveryOrders,
                                                  color: Colors.deepOrangeAccent,
                                                ),
                                                SizedBox(width: 10,),
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
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: cubit.users.length,
                                          itemBuilder: (context,index){
                                            return Padding(
                                              padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 10),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black.withOpacity(0.2),
                                                            spreadRadius: 0,
                                                            blurRadius: 2,
                                                            offset: const Offset(2, 2),
                                                          ),
                                                        ],
                                                        borderRadius: BorderRadius.circular(12),
                                                        color: Colors.white,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              GestureDetector(
                                                                onTap:(){
                                                                  showDialog(
                                                                    context: context,
                                                                    builder: (BuildContext context) {
                                                                      return AlertDialog(
                                                                        backgroundColor: Colors.white,
                                                                        alignment: Alignment.centerRight,
                                                                        title: Text("هل حقا تريد حذف المستخدم؟",textAlign: TextAlign.center,),
                                                                        actions: [
                                                                          TextButton(
                                                                            child: Text("إلغاء"),
                                                                            onPressed: () {
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                          ),
                                                                          TextButton(
                                                                            child: Text("موافق"),
                                                                            onPressed: () {
                                                                              cubit.deleteAds(id: cubit.users[index].id.toString());
                                                                            },
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  );

                                                                },
                                                                child: Container(
                                                                  width: 50,
                                                                  height: double.maxFinite,
                                                                  decoration: BoxDecoration(
                                                                      color: Color(0XFFFC2E05),
                                                                      borderRadius: BorderRadius.only(
                                                                        topLeft: Radius.circular(12),
                                                                        bottomLeft: Radius.circular(12),
                                                                      )
                                                                  ),
                                                                  child: Image.asset('assets/images/Vector.png',scale: 1.3,),
                                                                ),
                                                              ),
                                                              GestureDetector(
                                                                onTap:(){
                                                                  navigateTo(context,
                                                                      UserOrderAdmin(id: cubit.users[index].id.toString()));
                                                                },
                                                                child: Container(
                                                                  width: 50,
                                                                  height: double.maxFinite,
                                                                  decoration: BoxDecoration(
                                                                    color: Color(0XFF00E301),
                                                                  ),
                                                                  child: Image.asset('assets/images/solar_box-outline (1).png',scale: 1.3,),
                                                                ),
                                                              ),
                                                              GestureDetector(
                                                                onTap: (){
                                                                  navigateTo(context,
                                                                    ProfileUserAdmin(
                                                                      name: cubit.users[index].name,
                                                                      phone: cubit.users[index].phone,
                                                                      location: cubit.users[index].location,
                                                                      createdAt: cubit.users[index].createdAt.toString(),
                                                                      role: 'مستخدم',
                                                                    ),);
                                                                },
                                                                child: Container(
                                                                  width: 50,
                                                                  height: double.maxFinite,
                                                                  color: Color(0XFFFFD600),
                                                                  child: Image.asset('assets/images/lucide_pen.png',scale: 1.3,),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(cubit.users[index].name,
                                                                style: TextStyle(// color: Colors.white,
                                                                  fontSize: 16,),
                                                                maxLines: 1,),
                                                              SizedBox(width: 10,),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 6,),
                                                  Text('.${index+1}',style: TextStyle(fontSize: 23,),),
                                                ],
                                              ),
                                            );
                                          }),
                                    ],
                                  );
                                },
                                fallback: (c)=>Center(child: CircularProgress())
                            ),
                            SizedBox(height: 20,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
