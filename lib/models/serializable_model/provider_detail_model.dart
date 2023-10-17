// To parse this JSON data, do
//
//     final providerDetailModel = providerDetailModelFromJson(jsonString);

import 'dart:convert';

List<ProviderDetailModel> providerDetailModelFromJson(String str) => List<ProviderDetailModel>.from(json.decode(str).map((x) => ProviderDetailModel.fromJson(x)));

String providerDetailModelToJson(List<ProviderDetailModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProviderDetailModel {
  ProviderDetailModel({
    this.id,
    this.title,
    this.description,
    this.isPaused,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
    this.userId,
    this.isDeleted,
    this.ratingCount,
    this.reviewCount,
    this.slug,
    this.rating,
    this.reviews,
    this.userData,
    this.servicepackages,
    this.gigdocument,
  });

  final int? id;
  final String? title;
  final String? description;
  final bool? isPaused;
  final DateTime? createdAt;
  final String? updatedAt;
  final int? categoryId;
  final int? userId;
  final bool? isDeleted;
  final String? ratingCount;
  final int? reviewCount;
  final String? slug;
  final String? rating;
  final List<Review>? reviews;
  final UserData? userData;
  final Servicepackages? servicepackages;
  final List<Gigdocument>? gigdocument;

  factory ProviderDetailModel.fromJson(Map<String, dynamic> json) => ProviderDetailModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    isPaused: json["is_paused"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
    categoryId: json["category_id"],
    userId: json["user_id"],
    isDeleted: json["is_deleted"],
    ratingCount: json["rating_count"],
    reviewCount: json["review_count"],
    slug: json["slug"],
    rating: json["rating"],
    reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
    userData: json["user_data"] == null ? null : UserData.fromJson(json["user_data"]),
    servicepackages: json["servicepackages"] == null ? null : Servicepackages.fromJson(json["servicepackages"]),
    gigdocument: json["gigdocument"] == null ? [] : List<Gigdocument>.from(json["gigdocument"]!.map((x) => Gigdocument.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "is_paused": isPaused,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt,
    "category_id": categoryId,
    "user_id": userId,
    "is_deleted": isDeleted,
    "rating_count": ratingCount,
    "review_count": reviewCount,
    "slug": slug,
    "rating": rating,
    "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toJson())),
    "user_data": userData?.toJson(),
    "servicepackages": servicepackages?.toJson(),
    "gigdocument": gigdocument == null ? [] : List<dynamic>.from(gigdocument!.map((x) => x.toJson())),
  };
}

class Gigdocument {
  Gigdocument({
    this.id,
    this.fileName,
    this.userid,
    this.serviceid,
    this.fileType,
  });

  final int? id;
  final String? fileName;
  final int? userid;
  final int? serviceid;
  final String? fileType;

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

class Review {
  Review({
    this.id,
    this.review,
    this.rating,
    this.updatedAt,
    this.createdAt,
    this.reviewerId,
    this.serviceId,
    this.bookingId,
    this.slug,
  });

  final int? id;
  final String? review;
  final String? rating;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? reviewerId;
  final int? serviceId;
  final int? bookingId;
  final String? slug;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["id "],
    review: json["review"],
    rating: json["rating"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    reviewerId: json["reviewer_id"],
    serviceId: json["service_id"],
    bookingId: json["booking_id"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id ": id,
    "review": review,
    "rating": rating,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "reviewer_id": reviewerId,
    "service_id": serviceId,
    "booking_id": bookingId,
    "slug": slug,
  };
}

class Servicepackages {
  Servicepackages({
    this.id,
    this.title,
    this.description,
    this.location,
    this.price,
    this.createdAT,
    this.updatedAt,
    this.serviceId,
    this.time,
    this.extraForUrgentNeed,
  });

  final int? id;
  final String? title;
  final dynamic description;
  final String? location;
  final String? price;
  final DateTime? createdAT;
  final DateTime? updatedAt;
  final int? serviceId;
  final String? time;
  final dynamic extraForUrgentNeed;

  factory Servicepackages.fromJson(Map<String, dynamic> json) => Servicepackages(
    id: json["id"],
    title: json[" title"],
    description: json["description"],
    location: json["location"],
    price: json["price"],
    createdAT: json["created_a t"] == null ? null : DateTime.parse(json["created_a t"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    serviceId: json["service_id"],
    time: json["time"],
    extraForUrgentNeed: json["extra_for_urgent_need"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    " title": title,
    "description": description,
    "location": location,
    "price": price,
    "created_a t": createdAT?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "service_id": serviceId,
    "time": time,
    "extra_for_urgent_need": extraForUrgentNeed,
  };
}

class UserData {
  UserData({
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
    this.aCtivationToken,
    this.socialLoginId,
    this.loginSrc,
  });

  final bool? isSuperuser;
  final bool? isStaff;
  final bool? isActive;
  final String? dateJoined;
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? email;
  final String? phoneNumber;
  final dynamic otpSms;
  final dynamic otpEmail;
  final dynamic otpSmsCreatedAt;
  final dynamic otpEmailCreatedAt;
  final bool? isAdmin;
  final bool? isProvider;
  final DateTime? updatedAt;
  final String? createdAt;
  final int? categoryId;
  final dynamic fcmToken;
  final dynamic address;
  final dynamic about;
  final dynamic nationality;
  final dynamic languages;
  final String? profilePic;
  final String? gigDoc;
  final String? gig2Doc;
  final dynamic aCtivationToken;
  final dynamic socialLoginId;
  final dynamic loginSrc;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    isSuperuser: json["is_superuser"],
    isStaff: json["is_staff"],
    isActive: json["is_active"],
    dateJoined: json["date_joined"],
    id: json["id"],
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
    createdAt: json["created_at"],
    categoryId: json["category_id"],
    fcmToken: json["fcm_token"],
    address: json["address"],
    about: json["about"],
    nationality: json["nationality"],
    languages: json["languages"],
    profilePic: json["profile_pic"],
    gigDoc: json["gig_doc"],
    gig2Doc: json["gig2_doc"],
    aCtivationToken: json["a ctivation_token"],
    socialLoginId: json["social_login_id"],
    loginSrc: json["login_src"],
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
    "phone_number": phoneNumber,
    "otp_sms": otpSms,
    "otp_email": otpEmail,
    "otp_sms_created_at": otpSmsCreatedAt,
    "otp_email_created_at": otpEmailCreatedAt,
    "is_admin": isAdmin,
    "is_provider": isProvider,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt,
    "category_id": categoryId,
    "fcm_token": fcmToken,
    "address": address,
    "about": about,
    "nationality": nationality,
    "languages": languages,
    "profile_pic": profilePic,
    "gig_doc": gigDoc,
    "gig2_doc": gig2Doc,
    "a ctivation_token": aCtivationToken,
    "social_login_id": socialLoginId,
    "login_src": loginSrc,
  };
}
