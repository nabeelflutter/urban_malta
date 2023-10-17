// To parse this JSON data, do
//
//     final trendingServicesResponse = trendingServicesResponseFromJson(jsonString);

import 'dart:convert';

List<TrendingServicesResponse> trendingResponseFromJson(String str) => List<TrendingServicesResponse>.from(json.decode(str).map((x) => TrendingServicesResponse.fromJson(x)));

String trendingResponseToJson(List<TrendingServicesResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TrendingServicesResponse {
    TrendingServicesResponse({
        required this.id,
        required this.title,
        required this.description,
        required this.isPaused,
        required this.createdAt,
        required this.updatedAt,
        required this.categoryId,
        required this.userId,
        required this.isDeleted,
        required this.ratingCount,
        required this.reviewCount,
        required this.slug,
        required this.rating,
        required this.gigdocument,
    });

    int id;
    String title;
    String description;
    bool isPaused;
    DateTime createdAt;
    DateTime updatedAt;
    int categoryId;
    int userId;
    bool isDeleted;
    String ratingCount;
    int reviewCount;
    String slug;
    double rating;
    List<Gigdocument> gigdocument;

    factory TrendingServicesResponse.fromJson(Map<String, dynamic> json) => TrendingServicesResponse(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        isPaused: json["is_paused"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        categoryId: json["category_id"],
        userId: json["user_id"],
        isDeleted: json["is_deleted"],
        ratingCount: json["rating_count"],
        reviewCount: json["review_count"],
        slug: json["slug"],
        rating: json["rating"]?.toDouble(),
        gigdocument: List<Gigdocument>.from(json["gigdocument"].map((x) => Gigdocument.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "is_paused": isPaused,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "category_id": categoryId,
        "user_id": userId,
        "is_deleted": isDeleted,
        "rating_count": ratingCount,
        "review_count": reviewCount,
        "slug": slug,
        "rating": rating,
        "gigdocument": List<dynamic>.from(gigdocument.map((x) => x.toJson())),
    };
}

class Gigdocument {
    Gigdocument({
        required this.id,
        required this.fileName,
        required this.userid,
        required this.serviceid,
        required this.fileType,
    });

    int id;
    String fileName;
    int userid;
    int serviceid;
    String fileType;

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
