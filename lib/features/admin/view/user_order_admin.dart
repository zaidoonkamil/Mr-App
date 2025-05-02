import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr/core/%20navigation/navigation.dart';
import 'package:mr/core/widgets/circular_progress.dart';
import 'package:mr/features/admin/cubit/cubit.dart';
import 'package:mr/features/admin/cubit/states.dart';

class UserOrderAdmin extends StatelessWidget {
  const UserOrderAdmin({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AdminCubit()..getOrder(page: '1', id: id),
      child: BlocConsumer<AdminCubit, AdminStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit=AdminCubit.get(context);
          return SafeArea(
              child: Scaffold(
                body: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      color: Colors.white,
                      height: 55,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: (){
                                navigateBack(context);
                              },
                              child: Icon(Icons.arrow_back_ios_new_rounded)),
                          Image.asset('assets/images/logo4.png',height: 200,),
                         SizedBox(
                           width: 20,
                           height: 20,
                         ),
                        ],
                      ),
                    ),
                    ConditionalBuilder(
                        condition: state is !GetUserOrderLoadingState,
                        builder: (context){
                          return ConditionalBuilder(
                              condition: cubit.orders.isNotEmpty,
                              builder: (c){
                                return Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 22),
                                    child: ListView.builder(
                                      physics: AlwaysScrollableScrollPhysics(),
                                      itemCount: cubit.orders.length,
                                      itemBuilder:(context,index){
                                        if (index == cubit.orders.length - 1 && !cubit.isLastPage) {
                                          cubit.getOrder(
                                              page: (cubit.currentPage + 1).toString(),
                                              id: cubit.orders[index].userId.toString()
                                          );
                                        }
                                        return Column(
                                          children: [
                                            SizedBox(height: 16,),
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                                              width: double.maxFinite,
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black.withOpacity(0.1),
                                                    spreadRadius: 0,
                                                    blurRadius: 1,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                                borderRadius: BorderRadius.circular(12),
                                                color: Colors.white,
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: 20,
                                                        decoration: BoxDecoration(
                                                            borderRadius:BorderRadius.circular(4),
                                                            color:
                                                            cubit.orders[index].status =='pending'?
                                                            Colors.yellow.shade100:
                                                            cubit.orders[index].status =='Delivery'?
                                                            Colors.blue.shade100:
                                                            cubit.orders[index].status =='completed'?
                                                            Colors.green.shade100:
                                                            Colors.red.shade100
                                                        ),
                                                        child:cubit.orders[index].status =='pending'?
                                                        Text(' في الانتضار ',style: TextStyle(color: Colors.yellow),):
                                                        cubit.orders[index].status =='Delivery'?
                                                        Text(' قيد التوصيل ',style: TextStyle(color: Colors.blue),):
                                                        cubit.orders[index].status =='completed'?
                                                        Text(' مكتمل ',style: TextStyle(color: Colors.green),):
                                                        Text(' ملغي ',style: TextStyle(color: Colors.red),)
                                                        ,
                                                      ),
                                                      Spacer(),
                                                      Text('حالة الطلب'),
                                                      Image.asset('assets/images/mingcute_sandglass-2-line.png')
                                                    ],
                                                  ),
                                                  SizedBox(height: 12,),
                                                  Row(
                                                    children: [
                                                      Text(cubit.orders[index].customerName),
                                                      Spacer(),
                                                      Text('الاسم'),
                                                      Image.asset('assets/images/fluent_person-16-regular.png')
                                                    ],
                                                  ),
                                                  SizedBox(height: 12,),
                                                  Row(
                                                    children: [
                                                      Text(cubit.orders[index].phoneNumber),
                                                      Spacer(),
                                                      Text('رقم الهاتف'),
                                                      Image.asset('assets/images/solar_phone-outline (3).png')
                                                    ],
                                                  ),
                                                  SizedBox(height: 12,),
                                                  Row(
                                                    children: [
                                                      Text('${cubit.orders[index].province} - ${cubit.orders[index].address}' ),
                                                      Spacer(),
                                                      Text('الموقع'),
                                                      Image.asset('assets/images/mingcute_location-line (2).png')
                                                    ],
                                                  ),
                                                  SizedBox(height: 12,),
                                                  Container(width: double.maxFinite,
                                                    height: 2,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(height: 12,),
                                                  Row(
                                                    children: [
                                                      Text('د.ع '),
                                                      Text(cubit.orders[index].price.toString()),
                                                      Spacer(),
                                                      Text('سعر الطلب'),
                                                      Image.asset('assets/images/solar_box-outline.png')
                                                    ],
                                                  ),
                                                  SizedBox(height: 12,),
                                                  Row(
                                                    children: [
                                                      Text('د.ع '),
                                                      Text(cubit.orders[index].deliveryPrice.toString()),
                                                      Spacer(),
                                                      Text('سعر التوصيل'),
                                                      Image.asset('assets/images/healthicons_vespa-motorcycle-outline.png')
                                                    ],
                                                  ),
                                                  SizedBox(height: 12,),
                                                  Container(width: double.maxFinite,
                                                    height: 2,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(height: 12,),
                                                  Row(
                                                    children: [
                                                      Text('د.ع '),
                                                      Text(cubit.orders[index].totalPrice.toString()),
                                                      Spacer(),
                                                      Text('السعر الكلي'),
                                                      Image.asset('assets/images/grommet-icons_currency (1).png')
                                                    ],
                                                  ),
                                                  SizedBox(height: 12,),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                              fallback: (c)=>Expanded(child: Center(child: Text('ا يوجد بيانات ليتم عرضها')))
                          );
                        },
                        fallback: (context){
                          return Expanded(
                              child: Center(
                                child: CircularProgress(),
                              ),
                          );
                        }
                    ),
                  ],
                ),
              ),
          );
        },
      ),
    );
  }
}
