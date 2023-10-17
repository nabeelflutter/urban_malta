
class LocationModel {
  final bool status;
  final String message;
  final List<LocationData> data;

  LocationModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    status: json["status"],
    message: json["message"],
    data: List<LocationData>.from(json["data"].map((x) => LocationData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class LocationData {
  final int id;
  final String userId;
  final String name;
  final String lat;
  final String lng;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;
   String isDefault;

  LocationData({
    required this.id,
    required this.userId,
    required this.name,
    required this.lat,
    required this.lng,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.isDefault,
  });

  factory LocationData.fromJson(Map<String, dynamic> json) => LocationData(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    lat: json["lat"],
    lng: json["lng"],
    type: json["type"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    isDefault: json["is_default"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "lat": lat,
    "lng": lng,
    "type": type,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "is_default": isDefault,
  };
}
