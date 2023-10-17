// To parse this JSON data, do
//
//     final gigListResponse = gigListResponseFromJson(jsonString);

import 'dart:convert';

List<GigListResponse> gigListResponseFromJson(String str) =>
    List<GigListResponse>.from(
        json.decode(str).map((x) => GigListResponse.fromJson(x)));

String gigListResponseToJson(List<GigListResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GigListResponse {
  GigListResponse({
    this.id,
    this.title,
    this.description,
    this.isPaused,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
    this.userId,
    this.isDeleted,
    this.ratingCount,
    this.reviewCount,
    this.slug,
    this.servicepackages,
  });

  int? id;
  String? title;
  String? description;
  bool? isPaused;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? categoryId;
  int? userId;
  bool? isDeleted;
  String? ratingCount;
  dynamic reviewCount;
  dynamic slug;
  Servicepackages? servicepackages;

  factory GigListResponse.fromJson(Map<String, dynamic> json) =>
      GigListResponse(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        isPaused: json["is_paused"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        categoryId: json["category_id"],
        userId: json["user_id"],
        isDeleted: json["is_deleted"],
        ratingCount: json["rating_count"],
        reviewCount: json["review_count"],
        slug: json["slug"],
        servicepackages: json["servicepackages"] == null
            ? null
            : Servicepackages.fromJson(json["servicepackages"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "is_paused": isPaused,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "category_id": categoryId,
        "user_id": userId,
        "is_deleted": isDeleted,
        "rating_count": ratingCount,
        "review_count": reviewCount,
        "slug": slug,
        "servicepackages": servicepackages?.toJson(),
      };
}

class Servicepackages {
  Servicepackages({
    this.id,
    this.title,
    this.description,
    this.location,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.serviceId,
    this.time,
    this.extraForUrgentNeed,
    this.gigdocument,
  });

  int? id;
  String? title;
  String? description;
  String? location;
  String? price;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? serviceId;
  dynamic time;
  dynamic extraForUrgentNeed;
  List<Gigdocument>? gigdocument;

  factory Servicepackages.fromJson(Map<String, dynamic> json) =>
      Servicepackages(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        location: json["location"],
        price: json["price"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        serviceId: json["service_id"],
        time: json["time"],
        extraForUrgentNeed: json["extra_for_urgent_need"],
        gigdocument: json["gigdocument"] == null
            ? []
            : List<Gigdocument>.from(
                json["gigdocument"]!.map((x) => Gigdocument.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "location": location,
        "price": price,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "service_id": serviceId,
        "time": time,
        "extra_for_urgent_need": extraForUrgentNeed,
        "gigdocument": gigdocument == null
            ? []
            : List<dynamic>.from(gigdocument!.map((x) => x.toJson())),
      };
}

class Gigdocument {
  Gigdocument({
    this.id,
    this.fileName,
    this.userid,
    this.serviceid,
    this.fileType,
  });

  int? id;
  String? fileName;
  int? userid;
  int? serviceid;
  String? fileType;

  factory Gigdocument.fromJson(Map<String, dynamic> json) => Gigdocument(
        id: json["id"],
        fileName: json["file_name"],
        userid: json["userid"],
        serviceid: json["serviceid"],
        fileType: json["file_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file_name": fileName,
        "userid": userid,
        "serviceid": serviceid,
        "file_type": fileType,
      };
}
