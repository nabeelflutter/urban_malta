

import 'package:kappu/models/serializable_model/OrderListResponse.dart';

class ServicePackage {
  int id;
  String title;
  String description;
  String location;
  String price;
  String createdAt;
  String updatedAt;
  int serviceId;
  String time;
  String extraForUrgentNeed;

  ServicePackage({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.serviceId,
    required this.time,
    required this.extraForUrgentNeed,
  });

  factory ServicePackage.fromJson(Map<String, dynamic> json) {
    return ServicePackage(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      price: json['price'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      serviceId: json['service_id'] ?? 0,
      time: json['time'] ?? '',
      extraForUrgentNeed: json['extra_for_urgent_need'] ?? '',
    );
  }
}

class DataModel {
  int? id;
  String? title;
  String? description;
  bool? isPaused;
  String? createdAt;
  String? updatedAt;
  int? categoryId;
  int? userId;
  bool? isDeleted;
  int? ratingCount;
  int? reviewCount;
  String? slug;
  int? rating;
  UserData? userData;
  ServicePackage? servicePackage;

  DataModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isPaused,
    required this.createdAt,
    required this.updatedAt,
    required this.categoryId,
    required this.userId,
    required this.isDeleted,
    this.ratingCount,
    this.reviewCount,
    this.slug,
    required this.rating,
    required this.userData,
    required this.servicePackage,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      isPaused: json['is_paused'] ?? false,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      categoryId: json['category_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      isDeleted: json['is_deleted'] ?? false,
      ratingCount: json['rating_count'],
      reviewCount: json['review_count'],
      slug: json['slug'],
      rating: json['rating'] ?? 0,
      userData: UserData.fromJson(json['user_data'] ?? {}),
      servicePackage: ServicePackage.fromJson(json['servicepackages'] ?? {}),
    );
  }
}
