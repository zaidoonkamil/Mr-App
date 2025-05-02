import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mr/core/%20navigation/navigation.dart';
import 'package:mr/core/widgets/card_of_order.dart';
import 'package:mr/core/widgets/circular_progress.dart';
import 'package:mr/features/admin/cubit/cubit.dart';
import 'package:mr/features/admin/cubit/states.dart';

class AllOrders extends StatelessWidget {
  const AllOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AdminCubit()..initializeScrollController()
        ..getOrderPending(page: '1')
        ..getOrderDelivery(page: '1')
        ..getOrderCompleted(page: '1')
        ..getOrderCanceled(page: '1'),
      child: BlocConsumer<AdminCubit, AdminStates>(
          listener: (context, state) {
            if(state is UpdateOrderSuccessState){
              navigateBack(context);
            }
          },
          builder: (context, state) {
            var cubit=AdminCubit.get(context);
            return DefaultTabController(
              length: 4,
              initialIndex: 3,
              child: SafeArea(
                child: Scaffold(
                  body: ConditionalBuilder(
                      condition: state is! GetAllOrderLoadingState,
                      builder: (c){
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              color: Colors.white,
                              height: 55,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/logo4.png',height: 200,),
                                ],
                              ),
                            ),
                            SizedBox(height: 16,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('جميع الطلبات',style: TextStyle(fontSize: 20),),
                                ],
                              ),
                            ),
                            SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ButtonsTabBar(
                                    radius: 8,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                                    borderWidth: 1,
                                    physics: AlwaysScrollableScrollPhysics(),
                                    decoration: BoxDecoration(color: Color(0XFF212844),),
                                    splashColor: Colors.indigo,
                                    unselectedLabelStyle: TextStyle(color: Colors.grey,fontSize: 16),
                                    unselectedBackgroundColor: Colors.white,
                                    unselectedBorderColor: Colors.grey,
                                    labelStyle: TextStyle(color: Colors.white),
                                    height: 56,
                                    tabs:[
                                      Tab(text: "ملغي"),
                                      Tab(text: "مكتمل"),
                                      Tab(text: "قيد التوصيل"),
                                      Tab(text: "قيد الانتظار"),
                                    ],),
                                ],
                              ),
                            ),
                            SizedBox(height: 5,),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  cubit.ordersCanceled != null ?
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: ListView.builder(
                                      itemCount: cubit.ordersCanceled!.orders.length,
                                      itemBuilder: (context, index) {
                                        String dateString = cubit.ordersCanceled!.orders[index].createdAt.toString();
                                        DateTime dateTime = DateTime.parse(dateString);
                                        String formattedDate = DateFormat('yyyy/MM/dd').format(dateTime);
                                        return CardOfOrder(
                                          name: cubit.ordersCanceled!.orders[index].customerName,
                                          phone: cubit.ordersCanceled!.orders[index].phoneNumber,
                                          location: "${cubit.ordersCanceled!.orders[index].province} - ${cubit.ordersCanceled!.orders[index].address}",
                                          status: cubit.ordersCanceled!.orders[index].status,
                                          createdAt: formattedDate,
                                          name1: cubit.ordersCanceled!.orders[index].user.name,
                                          phone1: cubit.ordersCanceled!.orders[index].user.phone,
                                          location1: cubit.ordersCanceled!.orders[index].user.location,
                                          price: cubit.ordersCanceled!.orders[index].price.toString(),
                                          deliveryPrice: cubit.ordersCanceled!.orders[index].deliveryPrice.toString(),
                                          totalPrice: cubit.ordersCanceled!.orders[index].totalPrice.toString(),
                                        );
                                      },
                                    ),
                                  ):
                                  Center(child: Text('لا يوجد بيانات ليتم عرظها')),
                                  cubit.ordersCompleted != null?
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: ListView.builder(
                                      itemCount: cubit.ordersCompleted!.orders.length,
                                      itemBuilder: (context, index) {
                                        String dateString = cubit.ordersCompleted!.orders[index].createdAt.toString();
                                        DateTime dateTime = DateTime.parse(dateString);
                                        String formattedDate = DateFormat('yyyy/MM/dd').format(dateTime);
                                        return CardOfOrder(
                                          name: cubit.ordersCompleted!.orders[index].customerName,
                                          phone: cubit.ordersCompleted!.orders[index].phoneNumber,
                                          location: "${cubit.ordersCompleted!.orders[index].province} - ${cubit.ordersCompleted!.orders[index].address}",
                                          status: cubit.ordersCompleted!.orders[index].status,
                                          createdAt: formattedDate,
                                          name1: cubit.ordersCompleted!.orders[index].user.name,
                                          phone1: cubit.ordersCompleted!.orders[index].user.phone,
                                          location1: cubit.ordersCompleted!.orders[index].user.location,
                                          price: cubit.ordersCompleted!.orders[index].price.toString(),
                                          deliveryPrice: cubit.ordersCompleted!.orders[index].deliveryPrice.toString(),
                                          totalPrice: cubit.ordersCompleted!.orders[index].totalPrice.toString(),
                                        );
                                      },
                                    ),
                                  ):
                                  Center(child: Text('لا يوجد بيانات ليتم عرظها')),
                                  cubit.ordersDelivery != null?
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: ListView.builder(
                                      itemCount: cubit.ordersDelivery!.orders.length,
                                      itemBuilder: (context, index) {
                                        String dateString = cubit.ordersDelivery!.orders[index].createdAt.toString();
                                        DateTime dateTime = DateTime.parse(dateString);
                                        String formattedDate = DateFormat('yyyy/MM/dd').format(dateTime);
                                        return GestureDetector(
                                          onTap: (){
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  alignment: Alignment.centerRight,
                                                  title: Text("هل حقا تريد تعديل الطلب ؟",textAlign: TextAlign.end,),
                                                  content: SizedBox(
                                                    height: 100,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: GestureDetector(
                                                                onTap: (){
                                                                  cubit.updateOrders(
                                                                    context: context,
                                                                    id: cubit.ordersDelivery!.orders[index].id.toString(),
                                                                    status: 'canceled',
                                                                  );
                                                                },
                                                                child: Container(
                                                                  padding: EdgeInsets.symmetric(vertical: 10),
                                                                  color: Colors.redAccent,
                                                                  child: Center(child: Text('ملغي',style: TextStyle(color: Colors.white,fontSize: 20),)),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(width: 2,),
                                                            Expanded(
                                                              child: GestureDetector(
                                                                onTap: (){
                                                                  cubit.updateOrders(
                                                                    context: context,
                                                                    id: cubit.ordersDelivery!.orders[index].id.toString(),
                                                                    status: 'completed',
                                                                  );
                                                                },
                                                                child: Container(
                                                                  padding: EdgeInsets.symmetric(vertical: 10),
                                                                  color: Colors.green,
                                                                  child: Center(child: Text('مكتمل',style: TextStyle(fontSize: 20,color: Colors.white),)),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 2,),
                                                        Expanded(
                                                          child: GestureDetector(
                                                            onTap: (){
                                                              navigateBack(context);
                                                            },
                                                            child: Container(
                                                              padding: EdgeInsets.symmetric(vertical: 10),
                                                              color: Colors.blue,
                                                              child: Center(child: Text('الغاء',style: TextStyle(color: Colors.white,fontSize: 20),)),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: CardOfOrder(
                                            name: cubit.ordersDelivery!.orders[index].customerName,
                                            phone: cubit.ordersDelivery!.orders[index].phoneNumber,
                                            location: "${cubit.ordersDelivery!.orders[index].province} - ${cubit.ordersDelivery!.orders[index].address}",
                                            status: cubit.ordersDelivery!.orders[index].status,
                                            createdAt: formattedDate,
                                            name1: cubit.ordersDelivery!.orders[index].user.name,
                                            phone1: cubit.ordersDelivery!.orders[index].user.phone,
                                            location1: cubit.ordersDelivery!.orders[index].user.location,
                                            price: cubit.ordersDelivery!.orders[index].price.toString(),
                                            deliveryPrice: cubit.ordersDelivery!.orders[index].deliveryPrice.toString(),
                                            totalPrice: cubit.ordersDelivery!.orders[index].totalPrice.toString(),
                                          ),
                                        );
                                      },
                                    ),
                                  ):
                                  Center(child: Text('لا يوجد بيانات ليتم عرظها')),
                                  cubit.ordersPending != null ?
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: ListView.builder(
                                      controller: cubit.scrollController,
                                      itemCount: cubit.ordersPending!.orders.length,
                                      itemBuilder: (context, index) {
                                        String dateString = cubit.ordersPending!.orders[index].createdAt.toString();
                                        DateTime dateTime = DateTime.parse(dateString);
                                        String formattedDate = DateFormat('yyyy/MM/dd').format(dateTime);
                                        return GestureDetector(
                                          onTap: (){
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  alignment: Alignment.centerRight,
                                                  title: Text("هل حقا تريد تعديل الطلب من قيد الانتضار الى قيد التوصيل ؟",textAlign: TextAlign.end,),
                                                  content: Row(
                                                    children: [
                                                      TextButton(
                                                        child: Text("إلغاء"),
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: Text("موافق"),
                                                        onPressed: () {
                                                          cubit.updateOrders(
                                                              context: context,
                                                              id: cubit.ordersPending!.orders[index].id.toString(),
                                                              status: 'Delivery',
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: CardOfOrder(
                                            name: cubit.ordersPending!.orders[index].customerName,
                                            phone: cubit.ordersPending!.orders[index].phoneNumber,
                                            location: "${cubit.ordersPending!.orders[index].province} - ${cubit.ordersPending!.orders[index].address}",
                                            status: cubit.ordersPending!.orders[index].status,
                                            createdAt: formattedDate,
                                            name1: cubit.ordersPending!.orders[index].user.name,
                                            phone1: cubit.ordersPending!.orders[index].user.phone,
                                            location1: cubit.ordersPending!.orders[index].user.location,
                                            price: cubit.ordersPending!.orders[index].price.toString(),
                                            deliveryPrice: cubit.ordersPending!.orders[index].deliveryPrice.toString(),
                                            totalPrice: cubit.ordersPending!.orders[index].totalPrice.toString(),
                                          ),
                                        );
                                      },
                                    ),
                                  ):
                                  Center(child: Text('لا يوجد بيانات ليتم عرظها')),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      fallback: (context){
                        return Column(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgress(),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                  ),
                ),
              ),
            );},
      ),
    );
  }
}
