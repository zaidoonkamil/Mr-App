import 'dart:convert';

List<GetAdsAdmin> getAdsFromJson(String str) => List<GetAdsAdmin>.from(json.decode(str).map((x) => GetAdsAdmin.fromJson(x)));

String getAdsToJson(List<GetAdsAdmin> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAdsAdmin {
  int id;
  List<String> images;
  DateTime createdAt;
  DateTime updatedAt;

  GetAdsAdmin({
    required this.id,
    required this.images,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GetAdsAdmin.fromJson(Map<String, dynamic> json) => GetAdsAdmin(
    id: json["id"],
    images: List<String>.from(json["images"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "images": List<dynamic>.from(images.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
