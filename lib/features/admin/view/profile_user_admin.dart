import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr/core/%20navigation/navigation.dart';
import 'package:mr/core/styles/themes.dart';
import 'package:mr/features/admin/cubit/cubit.dart';
import 'package:mr/features/admin/cubit/states.dart';

class ProfileUserAdmin extends StatelessWidget {
  const ProfileUserAdmin({
    super.key,
    required this.name,
    required this.phone,
    required this.location,
    required this.role,
    required this.createdAt,
  });

  final String name;
  final String phone;
  final String location;
  final String role;
  final String createdAt;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AdminCubit(),
      child: BlocConsumer<AdminCubit, AdminStates>(
        listener: (context, state) {},
        builder: (context, state) {
          DateTime date = DateTime.parse(createdAt);
          String formattedDate = "${date.year}-${date.month}-${date.day}";

          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                            onTap: (){
                              navigateBack(context);
                            },
                            child: Icon(Icons.arrow_back_ios_new_rounded)),
                        Image.asset('assets/images/logo4.png', height: 200),
                        SizedBox(width: 20,height: 20,),

                      ],
                    ),
                  ),
                  SizedBox(height: 120),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: primaryColor,
                        width: 1,
                      ),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Image.asset('assets/images/fluent_person-16-regular.png',scale: 0.5,),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30,vertical: 14),
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: primaryColor,
                        width: 1.0,
                      ),
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
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Image.asset('assets/images/fluent_person-16-regular.png'),
                            SizedBox(height: 10,),
                            Image.asset('assets/images/solar_phone-outline (3).png'),
                            SizedBox(height: 10,),
                            Image.asset('assets/images/mingcute_location-line (2).png'),
                            SizedBox(height: 10,),
                            Image.asset('assets/images/f7_person-2.png'),
                            SizedBox(height: 10,),
                            Image.asset('assets/images/tabler_clock.png'),
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Text(name,style: TextStyle(fontSize: 18),),
                            SizedBox(height: 10,),
                            Text(phone,style: TextStyle(fontSize: 18),),
                            SizedBox(height: 10,),
                            Text(location,style: TextStyle(fontSize: 18),),
                            SizedBox(height: 10,),
                            Text(role,style: TextStyle(fontSize: 18),),
                            SizedBox(height: 10,),
                            Text(formattedDate,style: TextStyle(fontSize: 18),),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(':الاسم',style: TextStyle(fontSize: 17),),
                            SizedBox(height: 10,),
                            Text(':قم الهاتف',style: TextStyle(fontSize: 17),),
                            SizedBox(height: 10,),
                            Text(':الموقع',style: TextStyle(fontSize: 17),),
                            SizedBox(height: 10,),
                            Text(':الصلاحياة',style: TextStyle(fontSize: 17),),
                            SizedBox(height: 10,),
                            Text(':تاريخ الانشاء',style: TextStyle(fontSize: 17),),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
