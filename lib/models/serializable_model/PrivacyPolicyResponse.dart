// To parse this JSON data, do
//
//     final privacyPolicyResponse = privacyPolicyResponseFromJson(jsonString);

import 'dart:convert';

PrivacyPolicyResponse privacyPolicyResponseFromJson(String str) => PrivacyPolicyResponse.fromJson(json.decode(str));

String privacyPolicyResponseToJson(PrivacyPolicyResponse data) => json.encode(data.toJson());

class PrivacyPolicyResponse {
    PrivacyPolicyResponse({
        this.id,
        this.text,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? text;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory PrivacyPolicyResponse.fromJson(Map<String, dynamic> json) => PrivacyPolicyResponse(
        id: json["id"],
        text: json["text"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
