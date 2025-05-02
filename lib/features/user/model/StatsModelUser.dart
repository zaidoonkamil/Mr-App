import 'dart:convert';

StatsUserModel statsModelFromJson(String str) => StatsUserModel.fromJson(json.decode(str));

String statsModelToJson(StatsUserModel data) => json.encode(data.toJson());

class StatsUserModel {
  int totalOrders;
  int pendingOrders;
  int deliveryOrders;
  int canceledOrders;
  int completedOrders;

  StatsUserModel({
    required this.totalOrders,
    required this.pendingOrders,
    required this.deliveryOrders,
    required this.canceledOrders,
    required this.completedOrders,
  });

  factory StatsUserModel.fromJson(Map<String, dynamic> json) => StatsUserModel(
    totalOrders: json["totalOrders"],
    pendingOrders: json["pendingOrders"],
    deliveryOrders: json["deliveryOrders"],
    canceledOrders: json["canceledOrders"],
    completedOrders: json["completedOrders"],
  );

  Map<String, dynamic> toJson() => {
    "totalOrders": totalOrders,
    "pendingOrders": pendingOrders,
    "deliveryOrders": deliveryOrders,
    "canceledOrders": canceledOrders,
    "completedOrders": completedOrders,
  };
}
