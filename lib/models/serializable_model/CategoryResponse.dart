// To parse this JSON data, do
//
//     final categoryResponse = categoryResponseFromJson(jsonString);

import 'dart:convert';

CategoryResponse categoryResponseFromJson(String str) => CategoryResponse.fromJson(json.decode(str));

String categoryResponseToJson(CategoryResponse data) => json.encode(data.toJson());

class CategoryResponse {
    CategoryResponse({
        required this.status,
        required this.data,
        required this.baseUrl,
    });

    bool status;
    String baseUrl;
    List<Category> data;

    factory CategoryResponse.fromJson(Map<String, dynamic> json) {
        return CategoryResponse(
            status: json["status"],
            baseUrl: json["base_url"],
            data: (json["data"] as List<dynamic>?)
                ?.map((x) => Category.fromJson(x))
                .toList() ?? [],
        );
    }

    Map<String, dynamic> toJson() {
        return {
            "status": status,
            "base_url": baseUrl,
            "data": List<dynamic>.from(data.map((x) => x.toJson())),
        };
    }
}

class Category {
    Category({
        required this.id,
        required this.name,
        required this.description,
        required this.createdAt,
        required this.image,
    });

    int id;
    String name;
    String description;
    String createdAt;
    String image;

    factory Category.fromJson(Map<String, dynamic> json) {
        return Category(
            id: json["id"],
            name: json["name"],
            description: json["description"] ?? '',
            createdAt: json["created_at"],
            image: json["image"] ?? '',
        );
    }

    Map<String, dynamic> toJson() {
        return {
            "id": id,
            "name": name,
            "created_at": createdAt,
            "image": image,
            "description": description,
        };
    }
}
