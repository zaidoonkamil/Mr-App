import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr/core/network/end_points.dart';
import 'package:mr/core/network/remote/dio_helper.dart';
import 'package:mr/core/widgets/show_toast.dart';
import 'package:mr/features/auth/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  void validation(){
    emit(ValidationState());
  }

  signUp({
    required String name,
    required String phone,
    required String location,
    required String password,
  }){
    emit(signUpLoadingState());
    DioHelper.postData(
      url: SignUp,
      data:
      {
        'name': name,
        'phone': phone,
        'location': location,
        'password': password,
      },
    ).then((value) {
      emit(signUpSuccessState());
    }).catchError((error)
    {
      if (error is DioError) {
        print(error.response?.data["error"]);
        showToast(
          text: error.response?.data["error"] ?? "حدث خطأ غير معروف",
          color: Colors.redAccent,
        );
        emit(signUpErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }


  String? token;
  String? role;
  String? id;

  signIn({required String phone, required String password,}){
    emit(LoginLoadingState());
    DioHelper.postData(
      url: SignIn,
      data:
      {
        'phone': phone,
        'password': password,
      },
    ).then((value) {
     token=value.data['token'];
     role=value.data['user']['role'];
     id=value.data['user']['id'].toString();
      emit(LoginSuccessState());
    }).catchError((error)
    {
      if (error is DioError) {
        showToast(
          text: error.response?.data["error"] ?? "حدث خطأ غير معروف",
          color: Colors.redAccent,
        );
        emit(LoginErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }


}