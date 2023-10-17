
import 'dart:convert';

ServiceResponse serviceResponseFromJson(String str) => ServiceResponse.fromJson(json.decode(str));

String serviceResponseToJson(ServiceResponse data) => json.encode(data.toJson());

class ServiceResponse {
    ServiceResponse({
        required this.status,
        required this.data,
    });

    bool status;
    List<Service> data;

    factory ServiceResponse.fromJson(Map<String, dynamic> json) => ServiceResponse(
        status: json["status"],
        data: List<Service>.from(json["data"].map((x) => Service.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Service {
    Service({
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
    });

    int id;
    String title;
    String description;
    bool isPaused;
    String createdAt;
    String updatedAt;
    int categoryId;
    int userId;
    bool isDeleted;
    String ratingCount;
    int reviewCount;
    String slug;

    factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        title: json["title"],
        description: json["description"] == null ? null : json["description"],
        isPaused: json["is_paused"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        categoryId: json["category_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        isDeleted: json["is_deleted"],
        ratingCount: json["rating_count"] == null ? null : json["rating_count"],
        reviewCount: json["review_count"] == null ? null : json["review_count"],
        slug: json["slug"] == null ? null : json["slug"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description == null ? null : description,
        "is_paused": isPaused,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "category_id": categoryId,
        "user_id": userId == null ? null : userId,
        "is_deleted": isDeleted,
        "rating_count": ratingCount == null ? null : ratingCount,
        "review_count": reviewCount == null ? null : reviewCount,
        "slug": slug == null ? null : slug,
    };
}
