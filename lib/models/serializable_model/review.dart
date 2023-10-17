// To parse this JSON data, do
//
//     final rating = ratingFromJson(jsonString);

import 'dart:convert';

List<Rating> ratingFromJson(String str) => List<Rating>.from(json.decode(str).map((x) => Rating.fromJson(x)));

String ratingToJson(Rating data) => json.encode(data!.toJson());

class Rating {
  Rating({
    this.id,
    this.review,
    this.rating,
    this.updatedAt,
    this.createdAt,
    this.reviewerId,
    this.serviceId,
    this.bookingId,
    this.slug,
    this.servicereviews,
  });

  int? id;
  String? review;
  String? rating;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? reviewerId;
  int? serviceId;
  int? bookingId;
  String? slug;
  Servicereviews? servicereviews;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    id: json["id"],
    review: json["review"],
    rating: json["rating"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    reviewerId: json["reviewer_id"],
    serviceId: json["service_id"],
    bookingId: json["booking_id"],
    slug: json["slug"],
    servicereviews: json["servicereviews"] == null ? null : Servicereviews.fromJson(json["servicereviews"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "review": review,
    "rating": rating,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "reviewer_id": reviewerId,
    "service_id": serviceId,
    "booking_id": bookingId,
    "slug": slug,
    "servicereviews": servicereviews?.toJson(),
  };
}

class Servicereviews {
  Servicereviews({
    this.isSuperuser,
    this.isStaff,
    this.isActive,
    this.dateJoined,
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.phoneNumber,
    this.otpSms,
    this.otpEmail,
    this.otpSmsCreatedAt,
    this.otpEmailCreatedAt,
    this.isAdmin,
    this.isProvider,
    this.updatedAt,
    this.createdAt,
    this.categoryId,
    this.fcmToken,
    this.address,
    this.about,
    this.nationality,
    this.languages,
    this.profilePic,
    this.gigDoc,
    this.gig2Doc,
    this.activationToken,
    this.location,
    this.socialLoginId,
    this.loginSrc,
    this.os,
    this.wallet,
    this.customerStripeId,
  });

  bool? isSuperuser;
  bool? isStaff;
  bool? isActive;
  String? dateJoined;
  String? location;
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? phoneNumber;
  dynamic otpSms;
  dynamic otpEmail;
  dynamic otpSmsCreatedAt;
  dynamic otpEmailCreatedAt;
  bool? isAdmin;
  bool? isProvider;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? categoryId;
  dynamic fcmToken;
  dynamic address;
  dynamic about;
  dynamic nationality;
  dynamic languages;
  String? profilePic;
  String? gigDoc;
  String? gig2Doc;
  dynamic activationToken;
  dynamic socialLoginId;
  dynamic loginSrc;
  dynamic os;
  dynamic wallet;
  dynamic customerStripeId;

  factory Servicereviews.fromJson(Map<String, dynamic> json) => Servicereviews(
    isSuperuser: json["is_superuser"],
    isStaff: json["is_staff"],
    isActive: json["is_active"],
    dateJoined: json["date_joined"],
    id: json["id"],
    location: json["location"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    username: json["username"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    otpSms: json["otp_sms"],
    otpEmail: json["otp_email"],
    otpSmsCreatedAt: json["otp_sms_created_at"],
    otpEmailCreatedAt: json["otp_email_created_at"],
    isAdmin: json["is_admin"],
    isProvider: json["is_provider"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    categoryId: json["category_id"],
    fcmToken: json["fcm_token"],
    address: json["address"],
    about: json["about"],
    nationality: json["nationality"],
    languages: json["languages"],
    profilePic: json["profile_pic"],
    gigDoc: json["gig_doc"],
    gig2Doc: json["gig2_doc"],
    activationToken: json["activation_token"],
    socialLoginId: json["social_login_id"],
    loginSrc: json["login_src"],
    os: json["os"],
    wallet: json["wallet"],
    customerStripeId: json["customer_stripe_id"],
  );

  Map<String, dynamic> toJson() => {
    "is_superuser": isSuperuser,
    "is_staff": isStaff,
    "is_active": isActive,
    "date_joined": dateJoined,
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "username": username,
    "email": email,
    "location" : location,
    "phone_number": phoneNumber,
    "otp_sms": otpSms,
    "otp_email": otpEmail,
    "otp_sms_created_at": otpSmsCreatedAt,
    "otp_email_created_at": otpEmailCreatedAt,
    "is_admin": isAdmin,
    "is_provider": isProvider,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "category_id": categoryId,
    "fcm_token": fcmToken,
    "address": address,
    "about": about,
    "nationality": nationality,
    "languages": languages,
    "profile_pic": profilePic,
    "gig_doc": gigDoc,
    "gig2_doc": gig2Doc,
    "activation_token": activationToken,
    "social_login_id": socialLoginId,
    "login_src": loginSrc,
    "os": os,
    "wallet": wallet,
    "customer_stripe_id": customerStripeId,
  };
}
