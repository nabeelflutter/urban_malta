// To parse this JSON data, do
//
//     final helpCenterResponse = helpCenterResponseFromJson(jsonString);

import 'dart:convert';

import 'package:kappu/models/serializable_model/FaqModel.dart';

List<HelpCenterResponse> helpCenterResponseFromJson(String str) => List<HelpCenterResponse>.from(json.decode(str).map((x) => HelpCenterResponse.fromJson(x)));

// String helpCenterResponseToJson(List<HelpCenterResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HelpCenterResponse {
    HelpCenterResponse({
        this.id,
        this.heading,
        this.body,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? heading;
    List<FaqModel>? body;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory HelpCenterResponse.fromJson(Map<String, dynamic> json) => HelpCenterResponse(
        id: json["id"],
        heading: json["heading"],
        body: faqModelFromJson(json["body"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

//    Map<String, dynamic> toJson() => {
//        "id": id,
//        "heading": heading,
//        "body": body,
//        "created_at": createdAt?.toIso8601String(),
//        "updated_at": updatedAt?.toIso8601String(),
//    };
}
