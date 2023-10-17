// To parse this JSON data, do
//
//     final orderListResponse = orderListResponseFromJson(jsonString);

import 'dart:convert';
import 'dart:ffi';

List<OrderListResponse> orderListResponseFromJson(String str) => List<OrderListResponse>.from(json.decode(str).map((x) => OrderListResponse.fromJson(x)));

String orderListResponseToJson(List<OrderListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderListResponse {
    OrderListResponse({
        this.id,
        this.time,
        this.location,
        this.totalPrice,
        this.updatedAt,
        this.createdAt,
        this.providerId,
        this.serviceId,
        this.userId,
        this.address,
        this.currency,
        this.rating,
        this.serviceFee,
        this.userData,
        this.serviceData,
        this.gigdocument,
        this.apartment_number,
        this.phone_number,
    });

    int? id;
    DateTime? time;
    String? location;
    int? totalPrice;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? providerId;
    int? serviceId;
    int? userId;
    String? address;
    String? currency;
    String? apartment_number;
    String? phone_number;
    String? rating;
    String? serviceFee;
    UserData? userData;
    ServiceData? serviceData;
    List<Gigdocument>? gigdocument;

    factory OrderListResponse.fromJson(Map<String, dynamic> json) => OrderListResponse(
        id: json["id"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        location: json["location"],
        totalPrice: json["total_price"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        providerId: json["provider_id"],
        serviceId: json["service_id"],
        userId: json["user_id"],
        address: json["address"],
        apartment_number: json['apartment_number'],
        phone_number: json['phone_number'],
        currency: json["currency"],
        rating: json["rating"],
        serviceFee: json["service_fee"],
        userData: json["user_data"] == null ? null : UserData.fromJson(json["user_data"]),
        serviceData: json["service_data"] == null ? null : ServiceData.fromJson(json["service_data"]),
        gigdocument: json["gigdocument"] == null ? [] : List<Gigdocument>.from(json["gigdocument"]!.map((x) => Gigdocument.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "time": time?.toIso8601String(),
        "location": location,
        "total_price": totalPrice,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "provider_id": providerId,
        "service_id": serviceId,
        "user_id": userId,
        "phone_number" : phone_number,
        "apartment_number" : apartment_number,
        "address": address,
        "currency": currency,
        "rating": rating,
        "service_fee": serviceFee,
        "user_data": userData?.toJson(),
        "service_data": serviceData?.toJson(),
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

    int? id;
    String? fileName;
    int? userid;
    int? serviceid;
    String? fileType;

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

class ServiceData {
    ServiceData({
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
    });

    int? id;
    String? title;
    String? description;
    bool? isPaused;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? categoryId;
    int? userId;
    bool? isDeleted;
    String? ratingCount;
    int? reviewCount;
    String? slug;

    factory ServiceData.fromJson(Map<String, dynamic> json) => ServiceData(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        isPaused: json["is_paused"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        categoryId: json["category_id"],
        userId: json["user_id"],
        isDeleted: json["is_deleted"],
        ratingCount: json["rating_count"],
        reviewCount: json["review_count"],
        slug: json["slug"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "is_paused": isPaused,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "category_id": categoryId,
        "user_id": userId,
        "is_deleted": isDeleted,
        "rating_count": ratingCount,
        "review_count": reviewCount,
        "slug": slug,
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
        this.lat,
        this.lng,
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
        this.socialLoginId,
        this.loginSrc,
    });

    bool? isSuperuser;
    bool? isStaff;
    bool? isActive;
    String? dateJoined;
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
    dynamic categoryId;
    dynamic fcmToken;
    dynamic address;
    dynamic about;
    dynamic nationality;
    String? lat;
    String? lng;
    dynamic languages;
    dynamic profilePic;
    dynamic gigDoc;
    dynamic gig2Doc;
    dynamic activationToken;
    dynamic socialLoginId;
    dynamic loginSrc;

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
        lat : json["lat"],
        lng : json["lng"],
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
    );

    Map<String, dynamic> toJson() => {
        "is_superuser": isSuperuser,
        "is_staff": isStaff,
        "is_active": isActive,
        "date_joined": dateJoined,
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "lat" : lat,
        "lng" : lng,
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
    };
}
