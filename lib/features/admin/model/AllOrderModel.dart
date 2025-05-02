import 'dart:convert';
import 'order_model.dart';

AllOrderModel allOrderModelFromJson(String str) => AllOrderModel.fromJson(json.decode(str));

String allOrderModelToJson(AllOrderModel data) => json.encode(data.toJson());

class AllOrderModel {
  List<Order> orders;
  Pagination pagination;

  AllOrderModel({
    required this.orders,
    required this.pagination,
  });

  factory AllOrderModel.fromJson(Map<String, dynamic> json) => AllOrderModel(
    orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
    pagination: Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
    "pagination": pagination.toJson(),
  };
}

class Order {
  int id;
  String customerName;
  String phoneNumber;
  String province;
  String address;
  int price;
  int deliveryPrice;
  int totalPrice;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  int userId;
  User user;

  Order({
    required this.id,
    required this.customerName,
    required this.phoneNumber,
    required this.province,
    required this.address,
    required this.price,
    required this.deliveryPrice,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.user,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    customerName: json["customerName"],
    phoneNumber: json["phoneNumber"],
    province: json["province"],
    address: json["address"],
    price: json["price"],
    deliveryPrice: json["deliveryPrice"],
    totalPrice: json["totalPrice"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    userId: json["userId"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customerName": customerName,
    "phoneNumber": phoneNumber,
    "province": province,
    "address": address,
    "price": price,
    "deliveryPrice": deliveryPrice,
    "totalPrice": totalPrice,
    "status": status,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "userId": userId,
    "user": user.toJson(),
  };
}

class User {
  int id;
  String name;
  String phone;
  String location;
  String role;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.location,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    location: json["location"],
    role: json["role"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "location": location,
    "role": role,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

