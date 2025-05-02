import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:mr/core/network/local/cache_helper.dart';

import '../../core/ navigation/navigation.dart';
import '../../core/styles/themes.dart';
import '../auth/view/login.dart';


class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 26.0),
        child: OnBoard(
          pageController: _pageController,
          onSkip: () {
            CacheHelper.saveData(key: 'onBoarding',value: true );
            navigateAndFinish(context, const Login());
          },
          onDone: () {
            CacheHelper.saveData(key: 'onBoarding',value: true );
            navigateAndFinish(context, const Login());
          },
          onBoardData: onBoardData,
          titleStyles: TextStyle(
            color: primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.15,
          ),
          descriptionStyles: TextStyle(
            fontSize: 14,
            color: Theme.of(context).dividerColor,
          ),
          pageIndicatorStyle: PageIndicatorStyle(
            width: 40,
            inactiveColor: Theme.of(context).dividerColor,
            activeColor: primaryColor,
            inactiveSize: const Size(6, 6),
            activeSize: const Size(8, 8),
          ),
          skipButton: TextButton(
            onPressed: () {
              CacheHelper.saveData(key: 'onBoarding',value: true );
              navigateAndFinish(context, const Login());
            },
            child: Text(
              "تخطي",
              style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),
            ),
          ),
          nextButton: OnBoardConsumer(
            builder: (context, ref, child) {
              final state = ref.watch(onBoardStateProvider);
              return GestureDetector(
                onTap: () => _onNextTap(state,context),
                child: Container(
                  width: 200,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient:  LinearGradient(
                      colors: [primaryColor,primaryColor],
                    ),
                  ),
                  child: Text(
                    state.isLastPage ? "البدء" : "التالي",
                    style:  const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onNextTap(OnBoardState onBoardState,context) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(
        onBoardState.page + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {
      CacheHelper.saveData(key: 'onBoarding',value: true );
      navigateAndFinish(context, const Login());
    }
  }
}

final List<OnBoardModel> onBoardData = [
  OnBoardModel(
    title: " نوصل طلباتك بسرعة فائقة",
    description:
    "نضمن لك سرعة استثنائية في توصيل الطلبات من خلال شبكة توصيل متطورة وفريق محترف",
    imgUrl: "assets/images/sapiens.png",
  ),
  OnBoardModel(
    title: "تابع طلبك لحظة بلحظة",
    description:
    "نوفر لك ميزة التتبع المباشر، حيث يمكنك معرفة موقع طلبك في أي وقت حتى لحظة وصوله إليك",
    imgUrl: 'assets/images/sapiens (1).png',
  ),
  OnBoardModel(
    title: "فريق دعم جاهز لخدمتك",
    description:
    "نحن هنا دائمًا لمساعدتك! فريق الدعم لدينا متاح 24/7 لحل أي استفسار لضمان تجربة توصيل سلسة ومرضية",
    imgUrl: 'assets/images/sapiens (2).png',
  ),
];