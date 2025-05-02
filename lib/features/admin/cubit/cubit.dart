import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mr/core/network/end_points.dart';
import 'package:mr/core/network/remote/dio_helper.dart';
import 'package:mr/core/widgets/constant.dart';
import 'package:mr/core/widgets/show_toast.dart';
import 'package:mr/features/admin/cubit/states.dart';
import 'package:mr/features/admin/model/AllOrderModel.dart' show AllOrderModel;
import 'package:mr/features/admin/model/GetAdsModelAdmin.dart';
import 'package:mr/features/admin/model/UserModel.dart';
import 'package:mr/features/admin/model/order_model.dart';

import '../model/StatsModel.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(AdminInitialState());

  static AdminCubit get(context) => BlocProvider.of(context);

  void validation(){
    emit(ValidationState());
  }

  late ScrollController scrollController;
  void initializeScrollController() {
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
  }
  void loadNextPage() {
    if (!isLastPagePending) {
      currentPagePending++;
      getOrderPending(page: currentPagePending.toString());
    }
  }
  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isLastPagePending) {
      loadNextPage();
    }
  }

  List<UserModel> users = [];
  void getUser() {
    emit(GetAllUserLoadingState());
    DioHelper.getData(
      url: Users,
    ).then((value) {
      users = List<UserModel>.from(
        value.data
            .where((item) => item['role'] != 'admin')
            .map((item) => UserModel.fromJson(item)),
      );
      emit(GetAllUserSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToast(
          text: error.toString(),
          color: Colors.redAccent,
        );
        print(error.toString());
        emit(GetAllUserErrorState());
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
  void getOrder({required String page, required String id,}) {
    if (isLastPage) return;
    emit(GetUserOrderLoadingState());
    DioHelper.getData(
      url: '/orders/$id?page=$page',
    ).then((value) {
      OrderModel newData = OrderModel.fromJson(value.data);
      orders.addAll(newData.user.orders);
      pagination = newData.pagination;
      currentPage = pagination!.currentPage;
      if (currentPage >= pagination!.totalPages) {
        isLastPage = true;
      }
      emit(GetUserOrderSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToast(
          text: error.toString(),
          color: Colors.redAccent,
        );
        print(error.toString());
        emit(GetUserOrderErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  AllOrderModel? ordersPending;
  Pagination? paginationPending;
  int currentPagePending = 1;
  bool isLastPagePending = false;
  void getOrderPending({required String page,}) {
    if (isLastPagePending) return;
    emit(GetAllOrderLoadingState());
    DioHelper.getData(
      url: '/ordersPending?page=$page',
    ).then((value) {
      ordersPending = AllOrderModel.fromJson(value.data);
      paginationPending = ordersPending!.pagination;
      currentPagePending = paginationPending!.currentPage;
      if (currentPagePending >= paginationPending!.totalPages) {
        isLastPagePending = true;
      }
      emit(GetAllOrderSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToast(
          text: error.toString(),
          color: Colors.redAccent,
        );
        print(error.toString());
        emit(GetAllOrderErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  AllOrderModel? ordersDelivery;
  Pagination? paginationDelivery;
  int currentPageDelivery = 1;
  bool isLastPageDelivery = false;
  void getOrderDelivery({required String page,}) {
    if (isLastPageDelivery) return;
    emit(GetAllOrderLoadingState());
    DioHelper.getData(
      url: '/ordersDelivery?page=$page',
    ).then((value) {
      ordersDelivery = AllOrderModel.fromJson(value.data);
      paginationDelivery = ordersDelivery!.pagination;
      currentPageDelivery = paginationDelivery!.currentPage;
      if (currentPageDelivery >= paginationDelivery!.totalPages) {
        isLastPageDelivery = true;
      }
      emit(GetAllOrderSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToast(
          text: error.toString(),
          color: Colors.redAccent,
        );
        print(error.toString());
        emit(GetAllOrderErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  AllOrderModel? ordersCompleted;
  Pagination? paginationCompleted;
  int currentPageCompleted = 1;
  bool isLastPageCompleted = false;
  void getOrderCompleted({required String page,}) {
    if (isLastPageCompleted) return;
    emit(GetAllOrderLoadingState());
    DioHelper.getData(
      url: '/ordersCompleted?page=$page',
    ).then((value) {
      ordersCompleted = AllOrderModel.fromJson(value.data);
      paginationCompleted = ordersCompleted!.pagination;
      currentPageCompleted = paginationCompleted!.currentPage;
      if (currentPageCompleted >= paginationCompleted!.totalPages) {
        isLastPageCompleted = true;
      }
      emit(GetAllOrderSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToast(
          text: error.toString(),
          color: Colors.redAccent,
        );
        print(error.toString());
        emit(GetAllOrderErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  AllOrderModel? ordersCanceled;
  Pagination? paginationCanceled;
  int currentPageCanceled = 1;
  bool isLastPageCanceled = false;
  void getOrderCanceled({required String page,}) {
    if (isLastPageCanceled) return;
    emit(GetAllOrderLoadingState());
    DioHelper.getData(
      url: '/ordersCanceled?page=$page',
    ).then((value) {
      ordersCanceled = AllOrderModel.fromJson(value.data);
      paginationCanceled = ordersCanceled!.pagination;
      currentPageCanceled = paginationCanceled!.currentPage;
      if (currentPageCanceled >= paginationCanceled!.totalPages) {
        isLastPageCanceled = true;
      }
      emit(GetAllOrderSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToast(
          text: error.toString(),
          color: Colors.redAccent,
        );
        print(error.toString());
        emit(GetAllOrderErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  void updateOrders({
    required String id,
    required String status,
    required BuildContext context,
  }) {
    emit(UpdateOrderLoadingState());
    DioHelper.putData(
      url: '/orders/$id',
      token: token,
      data: {
        'status':status
      }
    ).then((value) {
      if(status == 'Delivery'){
        var orderToAdd = ordersPending?.orders.firstWhere((order) => order.id.toString() == id);
        if (orderToAdd != null) {
          ordersDelivery?.orders.add(orderToAdd);
          ordersPending?.orders.removeWhere((order) => order.id.toString() == id);
        } else {
          print("Order not found in ordersPending");
        }
      }else if(status == 'completed'){
        var orderToAdd = ordersDelivery?.orders.firstWhere((order) => order.id.toString() == id);
        if (orderToAdd != null) {
          ordersCompleted?.orders.add(orderToAdd);
          ordersDelivery?.orders.removeWhere((order) => order.id.toString() == id);
        } else {
          print("Order not found in ordersPending");
        }
      }else{
        var orderToAdd = ordersDelivery?.orders.firstWhere((order) => order.id.toString() == id);
        if (orderToAdd != null) {
          ordersCanceled?.orders.add(orderToAdd);
          ordersDelivery?.orders.removeWhere((order) => order.id.toString() == id);
        } else {
          print("Order not found in ordersPending");
        }
      }
      emit(UpdateOrderSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 403) {
          signOut(context);
        }
        print(error.toString());
        showToast(
          text: error.toString(),
          color: Colors.redAccent,
        );
        print(error.toString());
        emit(UpdateOrderErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }

  void slid(){
    emit(ValidationState());
  }

  List<GetAdsAdmin> getAdsModel = [];
  void getAds({BuildContext? context,}) {
    emit(GetAdsLoadingState());
    DioHelper.getData(
      url: ADS,
    ).then((value) {
      getAdsModel = (value.data as List)
          .map((item) => GetAdsAdmin.fromJson
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

  List<StatsModel> statsModel = [];
  void getStats({BuildContext? context,}) {
    emit(GetStatsLoadingState());
    DioHelper.getData(
      url: Stats,
    ).then((value) {
      statsModel = [StatsModel.fromJson(value.data)];
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

  void deleteAds({required String id,}) {
    emit(DeleteAdsLoadingState());
    DioHelper.deleteData(
      url: '$ADS/$id',
    ).then((value) {
      getAdsModel.removeWhere((getAdsModel) => getAdsModel.id.toString() == id);
      showToast(
        text: 'تم الحذف بنجاح',
        color: Colors.green,
      );
      emit(DeleteAdsSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        showToast(text: error.toString(), color: Colors.redAccent,);
        print(error.toString());
        emit(DeleteAdsErrorState());
      }else {
        print("Unknown Error: $error");
      }
    });
  }


  List<XFile> selectedImages = [];
  Future<void> pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> resultList = await picker.pickMultiImage();

    if (resultList.isNotEmpty) {
      selectedImages = resultList;
      emit(SelectedImagesState());
    }
  }

  void addAds() async {
    emit(AddAdsLoadingState());
    if (selectedImages.isEmpty) {
      showToast(text: "❌ الرجاء اختيار صور أولاً!", color: Colors.redAccent);
      return;
    }
    FormData formData = FormData();
    for (var file in selectedImages) {
      formData.files.add(
          MapEntry(
            "images",
            await MultipartFile.fromFile(
              file.path, filename: file.name,
              contentType: MediaType('image', 'jpeg'),
            ),
          ));
    }
    DioHelper.postData(
      url: '/ads',
      data: formData,
      options: Options(headers: {"Content-Type": "multipart/form-data"}),
    ).then((value) {
      selectedImages=[];
      emit(AddAdsSuccessState());
      showToast(text: "✅ تم رفع الصور بنجاح!", color: Colors.green);
      getAds();
    }).catchError((error) {
      if (error is DioException) {
        showToast(text: error.message!, color: Colors.redAccent);
      } else {
        print("❌ Unknown Error: $error");
      }
      emit(AddAdsErrorState());
    });
  }

}