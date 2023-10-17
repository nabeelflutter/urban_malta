// To parse this JSON data, do
//
//     final popularServiceListResponse = popularServiceListResponseFromJson(jsonString);

import 'dart:convert';

List<PopularServiceListResponse> popularServiceListResponseFromJson(String str) => List<PopularServiceListResponse>.from(json.decode(str).map((x) => PopularServiceListResponse.fromJson(x)));

String popularServiceListResponseToJson(List<PopularServiceListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PopularServiceListResponse {
    PopularServiceListResponse({
        this.id,
        this.name,
        this.image,
        this.service_cat_icon,
        this.count,
    });

    int? id;
    String? name;
    String? image;
    String? service_cat_icon;
    int? count;

    factory PopularServiceListResponse.fromJson(Map<String, dynamic> json) {
        return PopularServiceListResponse(
            id: json["id"],
            name: json["name"],
            image: json["image"] ?? null,
            count: json["count"],
            service_cat_icon: json["service_cat_icon"],
        );
    }

    Map<String, dynamic> toJson() {
        return {
            "id": id,
            "name": name,
            "image": image,
            "count": count,
            "service_cat_icon": service_cat_icon,
        };
    }
}

