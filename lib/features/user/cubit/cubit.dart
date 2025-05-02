import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr/core/network/end_points.dart';
import 'package:mr/core/network/remote/dio_helper.dart';
import 'package:mr/core/widgets/constant.dart';
import 'package:mr/core/widgets/show_toast.dart';
import 'package:mr/features/user/cubit/states.dart';
import 'package:mr/features/user/model/order_model.dart';
import 'package:mr/features/user/model/province.dart';

import '../model/GetAdsModel.dart';
import '../model/StatsModelUser.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(UserInitialState());

  static UserCubit get(context) => BlocProvider.of(context);

  void validation(){
    emit(ValidationState());
  }

  Map<String, int> provinces = {};
  void getProvince() {
    emit(ProvinceLoadingState());
    DioHelper.getData(
      url: Province,
    ).then((value) {
      provinces = provincesFromJson(json.encode(value.data));
      emit(ProvinceSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToast(
          text: error.response?.data["error"] ?? "حدث خطأ غير معروف",
          color: Colors.redAccent,);
        print(error.toString());
        emit(ProvinceErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  addOrder({
    required String userId,
    required String customerName,
    required String phoneNumber,
    required String province,
    required String address,
    required String price,
  }){
    emit(AddOrderLoadingState());
    DioHelper.postData(
      url: AddOrder,
      data:
      {
        'userId': userId,
        'customerName': customerName,
        'phoneNumber': phoneNumber,
        'province': province,
        'address': address,
        'price': price,
      },
    ).then((value) {
      emit(AddOrderSuccessState());
    }).catchError((error)
    {
      if (error is DioError) {
        print(error.response?.data["error"]);
        showToast(
          text: error.response?.data["error"] ?? "حدث خطأ غير معروف",
          color: Colors.redAccent,
        );
        emit(AddOrderErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  List<Order> orders = [];
  Pagination? pagination;
  int currentPage = 1;
  bool isLastPage = false;
  OrderModel? orderModel;
  void getOrder({
    required String page
}) {
    if (isLastPage) return;

    emit(GetOrderLoadingState());
    DioHelper.getData(
      url: GetOrder+page,
    ).then((value) {
      OrderModel newData = OrderModel.fromJson(value.data);
      orders.addAll(newData.user.orders);
      pagination = newData.pagination;
      currentPage = pagination!.currentPage;
      if (currentPage >= pagination!.totalPages) {
        isLastPage = true;
      }
      emit(GetOrderSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToast(
          text: error.toString(),
          color: Colors.redAccent,
        );
        print(error.toString());
        emit(GetOrderErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }


  List<StatsUserModel> statsModel = [];
  void getStats() {
    emit(GetStatsLoadingState());
    DioHelper.getData(
      url: "$Stats/$id",
    ).then((value) {
      statsModel = [StatsUserModel.fromJson(value.data)];
      emit(GetStatsSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToast(text: error.toString(), color: Colors.redAccent,);
        print(error.toString());
        emit(GetStatsErrorStates());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  void slid(){
    emit(ValidationState());
  }

  List<GetAds> getAdsModel = [];
  void getAds({BuildContext? context,}) {
    emit(GetAdsLoadingState());
    DioHelper.getData(
      url: ADS,
    ).then((value) {
      getAdsModel = (value.data as List)
          .map((item) => GetAds.fromJson
        (item as Map<String, dynamic>)).toList();
      emit(GetAdsSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToast(text: error.toString(), color: Colors.redAccent,);
        print(error.toString());
        emit(GetAdsErrorStates());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

}