import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  User user;
  Pagination pagination;

  OrderModel({
    required this.user,
    required this.pagination,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    user: User.fromJson(json["user"]),
    pagination: Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "pagination": pagination.toJson(),
  };
}

class Pagination {
  int totalOrders;
  int currentPage;
  int totalPages;

  Pagination({
    required this.totalOrders,
    required this.currentPage,
    required this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    totalOrders: json["totalOrders"],
    currentPage: json["currentPage"],
    totalPages: json["totalPages"],
  );

  Map<String, dynamic> toJson() => {
    "totalOrders": totalOrders,
    "currentPage": currentPage,
    "totalPages": totalPages,
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
  List<Order> orders;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.location,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.orders,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    location: json["location"],
    role: json["role"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "location": location,
    "role": role,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
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
  };
}
