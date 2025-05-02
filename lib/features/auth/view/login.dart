import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr/core/navigation_bar/navigation_bar_Admin.dart';
import 'package:mr/core/network/local/cache_helper.dart';
import 'package:mr/core/widgets/constant.dart';
import 'package:mr/features/admin/view/home_admin.dart';
import 'package:mr/features/auth/cubit/cubit.dart';
import 'package:mr/features/auth/cubit/states.dart';
import 'package:mr/features/auth/view/register.dart';
import 'package:mr/features/user/view/home.dart';

import '../../../core/ navigation/navigation.dart';
import '../../../core/styles/themes.dart';
import '../../../core/widgets/circular_progress.dart';
import '../../../core/widgets/custom_form_field.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static TextEditingController userNameController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static bool isValidationPassed = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){
          if(state is LoginSuccessState){
            CacheHelper.saveData(
              key: 'token',
              value: AppCubit.get(context).token,
            ).then((value)
            {
              token = AppCubit.get(context).token.toString();
            });
            CacheHelper.saveData(
              key: 'id',
              value: AppCubit.get(context).id,
            ).then((value)
            {
              id = AppCubit.get(context).id.toString();
            });
            CacheHelper.saveData(
              key: 'role',
              value: AppCubit.get(context).role,
            ).then((value)
            {
              adminOrUser = AppCubit.get(context).role.toString();
            });
            if(AppCubit.get(context).role.toString()=='admin'){
             navigateAndFinish(context, BottomNavBarAdmin());
            }else{
             navigateAndFinish(context, Home());
            }
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
                              SizedBox(
                                height: 90,
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
                                        Text('تسجيل الدخول',style: TextStyle(fontSize: 20),),
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
                                          return 'رجائا ادخل الايميل';
                                        }
                                      },
                                      hintText: 'ادخل الايميل',
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
                                          cubit.signIn(
                                            phone: userNameController.text.trim(),
                                            password: passwordController.text.trim(),
                                          );
                                        }
                                      },
                                      child: ConditionalBuilder(
                                        condition: state is !LoginLoadingState,
                                        builder:(context)=> Container(
                                          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            color: Color(0xff1E1E1C),
                                          ),
                                          child: Text('تسجيل الدخول',
                                            style: TextStyle(color: Colors.white,fontSize: 16),
                                          ),
                                        ),
                                        fallback: (c)=> CircularProgressIndicator(color: primaryColor,),
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    Text('ليس لديك حساب؟',style: TextStyle(color: Color(0XFF555555),fontSize: 14),),
                                    GestureDetector(
                                        onTap: (){
                                          navigateTo(context, register());
                                        },
                                        child: Text('أنشئ حساب',style: TextStyle(color: primaryColor,fontSize: 16),)),
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
