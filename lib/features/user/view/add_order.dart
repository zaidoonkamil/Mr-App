import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr/core/widgets/constant.dart';
import 'package:mr/core/widgets/show_toast.dart';
import 'package:mr/features/user/cubit/cubit.dart';
import 'package:mr/features/user/cubit/states.dart';
import 'package:mr/features/user/view/home.dart';

import '../../../core/ navigation/navigation.dart';
import '../../../core/styles/themes.dart';
import '../../../core/widgets/circular_progress.dart';
import '../../../core/widgets/custom_form_field.dart';

class AddOrder extends StatelessWidget {
  const AddOrder({super.key});

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static TextEditingController userNameController = TextEditingController();
  static TextEditingController locationController = TextEditingController();
  static TextEditingController locationPController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();
  static TextEditingController priceController = TextEditingController();
  static bool isValidationPassed = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserCubit()..getProvince(),
      child: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {
          if(state is AddOrderSuccessState){
            userNameController.text='';
            locationController.text='';
            locationPController.text='';
            phoneController.text='';
            priceController.text='';
            showToast(
              text: "م اضافة الطلب بنجاح",
              color: Colors.green,
            );
          }
        },
        builder: (context, state) {
          var cubit=UserCubit.get(context);
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Form(
                key: formKey,
                child: Column(
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22,vertical: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('اظافة طلب جديد',style: TextStyle(fontSize: 22),),
                            SizedBox(height: 42,),
                            CustomFormField(
                              suffixIcon:  Icon(Icons.person_outlined),
                              colorBorderContent: Colors.white,
                              controller: userNameController,
                              validationPassed: isValidationPassed,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  isValidationPassed = true;
                                  cubit.validation();
                                  return 'رجائا اسم الزبون';
                                }
                              },
                              hintText: 'ادخل اسم الزبون',
                            ),
                            SizedBox(height: 12,),
                            CustomFormField(
                              suffixIcon:  Icon(Icons.phone_outlined),
                              colorBorderContent: Colors.white,
                              controller: phoneController,
                              validationPassed: isValidationPassed,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  isValidationPassed = true;
                                  cubit.validation();
                                  return 'رجائا ادخل رقم هاتف الزبون';
                                }
                              },
                              hintText: 'ادخل رقم هاتف الزبون',
                            ),
                            SizedBox(height: 12,),
                            CustomFormField(
                              suffixIcon:  Icon(Icons.location_on_outlined),
                              colorBorderContent: Colors.white,
                              controller: locationPController,
                              textInputType: TextInputType.none,
                              onTap: (){
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.white,
                                  builder: (context) {
                                    return Container(
                                      width: double.maxFinite,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          children: [
                                            Text("اختر محافظة",style: TextStyle(fontSize: 20),),
                                            SizedBox(height: 10),
                                            Container(width: double.maxFinite,
                                              height: 2,
                                              color: primaryColor,
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                itemCount: cubit.provinces.length,
                                                  itemBuilder: (context,index){
                                                    final provinceName = cubit.provinces.keys.elementAt(index);
                                                    final provincePrice = cubit.provinces[provinceName];
                                                    return GestureDetector(
                                                      onTap: (){
                                                        locationPController.text=provinceName.toString();
                                                        navigateBack(context);
                                                      },
                                                      child: Column(
                                                        children: [
                                                          SizedBox(height: 5),
                                                          Text(provinceName,style: TextStyle(fontSize: 16),),
                                                          SizedBox(height: 5),
                                                          Container(width: double.maxFinite,
                                                            height: 2,
                                                            color: Colors.grey,
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ],
                                        )
                                      ),
                                    );
                                  },
                                );

                              },
                              validationPassed: isValidationPassed,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  isValidationPassed = true;
                                  cubit.validation();
                                  return 'رجائا ادخل محافظة الزبون';
                                }
                              },
                              hintText: 'ادخل محافظة الزبون',
                            ),
                            SizedBox(height: 12,),
                            CustomFormField(
                              suffixIcon:  Icon(Icons.location_city_outlined),
                              colorBorderContent: Colors.white,
                              controller: locationController,
                              validationPassed: isValidationPassed,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  isValidationPassed = true;
                                  cubit.validation();
                                  return 'رجائا ادخل عنوان الزبون بالتفصيل';
                                }
                              },
                              hintText: 'ادخل عنوان الزبون بالتفصيل',
                            ),
                            SizedBox(height: 12,),
                            CustomFormField(
                              suffixIcon:  Icon(Icons.price_change_outlined),
                              colorBorderContent: Colors.white,
                              controller: priceController,
                              validationPassed: isValidationPassed,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  isValidationPassed = true;
                                  cubit.validation();
                                  return 'رجائا ادخل سعر المنتج';
                                }
                              },
                              hintText: 'ادخل سعر المنتج',
                            ),
                            SizedBox(height: 50,),
                            GestureDetector(
                              onTap: (){
                                if (formKey.currentState!.validate()) {
                                  print(id);
                                  print(userNameController.text.trim());
                                  print(phoneController.text.trim());
                                  print(locationPController.text);
                                  print(locationController.text.trim());
                                  print(priceController.text.trim());
                                  cubit.addOrder(
                                      userId: id,
                                      customerName: userNameController.text.trim(),
                                      phoneNumber: phoneController.text.trim(),
                                      province: locationPController.text,
                                      address: locationController.text.trim(),
                                      price: priceController.text.trim(),
                                  );
                                }
                              },
                              child: ConditionalBuilder(
                                condition: state is !AddOrderLoadingState,
                                builder:(context)=> Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Color(0xff1E1E1C),
                                  ),
                                  child: Text('انشاء الطلب',
                                    style: TextStyle(color: Colors.white,fontSize: 16),
                                  ),
                                ),
                                fallback: (c)=> CircularProgressIndicator(color: primaryColor,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
