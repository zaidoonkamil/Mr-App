import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr/core/widgets/show_toast.dart';
import 'package:mr/features/auth/cubit/cubit.dart';
import 'package:mr/features/auth/cubit/states.dart';

import '../../../core/ navigation/navigation.dart';
import '../../../core/styles/themes.dart';
import '../../../core/widgets/circular_progress.dart';
import '../../../core/widgets/custom_form_field.dart';
import 'login.dart';

class register extends StatelessWidget {
  const register({super.key});

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static TextEditingController userNameController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();
  static TextEditingController locationController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static bool isValidationPassed = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){
          if(state is signUpSuccessState){
            userNameController.text='';
            phoneController.text='';
            locationController.text='';
            passwordController.text='';
            showToast(
              text: "تم انشاء الحساب بنجاح",
              color: Colors.green,
            );
            navigateAndFinish(context, Login());
          }
        },
        builder: (context,state){
          var cubit=AppCubit.get(context);
          return SafeArea(
              child: Scaffold(
                backgroundColor: Color(0XFFECECEC),
                body: Stack(
                  children: [
                    Image.asset('assets/images/UI.png'),
                    SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: (){
                                navigateBack(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30),
                                child: Row(
                                  children: [
                                    Icon(Icons.arrow_back_ios_new_rounded,size: 30,),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/logo3.png',width: 280,),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text('انشاء حساب جديد',style: TextStyle(fontSize: 20),),
                                    ],
                                  ),
                                  SizedBox(height: 24,),
                                  CustomFormField(
                                    suffixIcon:  Icon(Icons.person_outlined),
                                    colorBorderContent: Colors.white,
                                    controller: userNameController,
                                    validationPassed: isValidationPassed,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        isValidationPassed = true;
                                        cubit.validation();
                                        return 'رجائا ادخل الاسم الكامل';
                                      }

                                    },
                                    hintText: 'ادخل الاسم الكامل',
                                  ),
                                  SizedBox(height: 16,),
                                  CustomFormField(
                                    suffixIcon:  Icon(Icons.phone_outlined),
                                    colorBorderContent: Colors.white,
                                    controller: phoneController,
                                    validationPassed: isValidationPassed,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        isValidationPassed = true;
                                        cubit.validation();
                                        return 'رجائا ادخل رقم الهاتف';
                                      }
                                    },
                                    hintText: 'رقم الهاتف',
                                  ),
                                  SizedBox(height: 16,),
                                  CustomFormField(
                                    suffixIcon:  Icon(Icons.location_on_outlined),
                                    colorBorderContent: Colors.white,
                                    controller: locationController,
                                    validationPassed: isValidationPassed,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        isValidationPassed = true;
                                        cubit.validation();
                                        return 'رجائا ادخل موقعك الشخصي بالتفصيل';
                                      }
                                    },
                                    hintText: 'موقعك الشخصي بالتفصيل',
                                  ),
                                  SizedBox(height: 16,),
                                  CustomFormField(
                                    suffixIcon:  Icon(Icons.lock_outline),
                                    colorBorderContent: Colors.white,
                                    controller: passwordController,
                                    validationPassed: isValidationPassed,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        isValidationPassed = true;
                                        cubit.validation();
                                        return 'رجائا ادخل الرمز السري';
                                      }
                                    },
                                    hintText: 'الرمز السري',
                                  ),
                                  SizedBox(height: 50,),
                                  GestureDetector(
                                    onTap: (){
                                      if (formKey.currentState!.validate()) {
                                        cubit.signUp(
                                          name: userNameController.text.trim(),
                                          phone: phoneController.text.trim(),
                                          location: locationController.text.trim(),
                                          password: passwordController.text.trim(),
                                        );
                                        print(userNameController.text.trim());
                                        print(phoneController.text.trim());
                                        print(locationController.text.trim());
                                        print(passwordController.text.trim());

                                      }
                                    },
                                    child: ConditionalBuilder(
                                      condition: state is !signUpLoadingState,
                                      builder:(context)=> Container(
                                        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: Color(0xff1E1E1C),
                                        ),
                                        child: Text('تسجيل الحساب',
                                          style: TextStyle(color: Colors.white,fontSize: 16),
                                        ),
                                      ),
                                      fallback: (c)=> CircularProgressIndicator(color: primaryColor,),
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Text('لديك حساب؟',style: TextStyle(color: Color(0XFF555555),fontSize: 14),),
                                  GestureDetector(
                                      onTap: (){
                                        navigateTo(context, Login());
                                      },
                                      child: Text('تسجيل الدخول',style: TextStyle(color: primaryColor,fontSize: 16),)),
                                  SizedBox(height: 40,),
                                ],
                              ),
                            ),
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