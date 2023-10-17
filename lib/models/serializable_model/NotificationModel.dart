// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

List<NotificationModel> notificationModelFromJson(String str) => List<NotificationModel>.from(json.decode(str).map((x) => NotificationModel.fromJson(x)));

String notificationModelToJson(List<NotificationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationModel {
    NotificationModel({
        this.id,
        this.title,
        this.body,
        this.createdAt,
        this.userId,
        this.senderId,
        this.updatedAt,
    });

    int? id;
    String? title;
    String? body;
    DateTime? createdAt;
    int? userId;
    String? senderId;
    DateTime? updatedAt;

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        userId: json["user_id"],
        senderId: json["sender_id"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "created_at": createdAt?.toIso8601String(),
        "user_id": userId,
        "sender_id": senderId,
        "updated_at": updatedAt?.toIso8601String(),
    };
}
