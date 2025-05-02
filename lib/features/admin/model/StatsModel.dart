import 'dart:convert';

StatsModel statsModelFromJson(String str) => StatsModel.fromJson(json.decode(str));

String statsModelToJson(StatsModel data) => json.encode(data.toJson());

class StatsModel {
  int totalOrders;
  int pendingOrders;
  int deliveryOrders;
  int canceledOrders;
  int completedOrders;
  int totalUsers;
  int usersWithOrders;

  StatsModel({
    required this.totalOrders,
    required this.pendingOrders,
    required this.deliveryOrders,
    required this.canceledOrders,
    required this.completedOrders,
    required this.totalUsers,
    required this.usersWithOrders,
  });

  factory StatsModel.fromJson(Map<String, dynamic> json) => StatsModel(
    totalOrders: json["totalOrders"],
    pendingOrders: json["pendingOrders"],
    deliveryOrders: json["deliveryOrders"],
    canceledOrders: json["canceledOrders"],
    completedOrders: json["completedOrders"],
    totalUsers: json["totalUsers"],
    usersWithOrders: json["usersWithOrders"],
  );

  Map<String, dynamic> toJson() => {
    "totalOrders": totalOrders,
    "pendingOrders": pendingOrders,
    "deliveryOrders": deliveryOrders,
    "canceledOrders": canceledOrders,
    "completedOrders": completedOrders,
    "totalUsers": totalUsers,
    "usersWithOrders": usersWithOrders,
  };
}
