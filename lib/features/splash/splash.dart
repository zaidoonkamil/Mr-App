import 'package:flutter/material.dart';
import 'package:mr/core/navigation_bar/navigation_bar_Admin.dart';
import 'package:mr/core/network/local/cache_helper.dart';
import 'package:mr/core/styles/themes.dart';
import 'package:mr/core/widgets/constant.dart';
import 'package:mr/features/admin/view/home_admin.dart';
import 'package:mr/features/auth/view/login.dart';
import 'package:mr/features/onboarding/onboarding.dart';
import 'package:mr/features/user/view/home.dart';

import '../../core/ navigation/navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      Widget? widget;
      bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
      if(CacheHelper.getData(key: 'token') == null){
        token='';
        if (onBoarding != null) {
          widget = const Login();
        } else {
          widget = OnBoardingScreen();
        }
      }else{
        if(CacheHelper.getData(key: 'role') == null){
          widget = const Login();
          adminOrUser='user';
        }else{
          adminOrUser = CacheHelper.getData(key: 'role');
          if (adminOrUser == 'admin') {
            widget = BottomNavBarAdmin();
          } else {
            widget = Home();
          }
        }
        token = CacheHelper.getData(key: 'token') ;
        id = CacheHelper.getData(key: 'id') ??'' ;
      }

      navigateAndFinish(context, widget);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                child: Center(child:
                Image.asset('assets/images/logo3.png',width: 300,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}