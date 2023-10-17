import 'package:kappu/models/serializable_model/OrderListResponse.dart';

class PromoResponse {
  List<Banner> banners;
  List<Promocode> promocode;
  List<Carousel> carosuel;

  PromoResponse({required this.carosuel, required this.banners, required this.promocode});

  factory PromoResponse.fromJson(Map<String, dynamic> json) {
    return PromoResponse(
      carosuel: (json['carosuel'] != null)
          ? List<Carousel>.from(json['carosuel'].map((carosuel) => Carousel.fromJson(carosuel)))
          : [],
      banners: (json['banners'] != null)
          ? List<Banner>.from(json['banners'].map((banner) => Banner.fromJson(banner)))
          : [],
      promocode: (json['promocode'] != null)
          ? List<Promocode>.from(json['promocode'].map((promo) => Promocode.fromJson(promo)))
          : [],
    );
  }
}

class Carousel {
  int id;
  String categoryId;
  String heading;
  String isEnable;
  String createdAt;
  String updatedAt;
  List<Service> services;

  Carousel({
    required this.id,
    required this.categoryId,
    required this.heading,
    required this.isEnable,
    required this.createdAt,
    required this.updatedAt,
    required this.services,
  });

  factory Carousel.fromJson(Map<String, dynamic> json) {
    List<Service> services = [];
    if (json['services'] != null) {
      services = List<Service>.from(json['services'].map((service) => Service.fromJson(service)));
    }

    return Carousel(
      id: json['id'],
      categoryId: json['category_id'],
      heading: json['heading'],
      isEnable: json['is_enable'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      services: services,
    );
  }
}

class Service {
  int id;
  String title;
  String description;
  bool isPaused;
  String createdAt;
  String updatedAt;
  int categoryId;
  int userId;
  bool isDeleted;
  int? ratingCount;
  int? reviewCount;
  String? slug;
  int rating;
  List<GigDocument> gigDocument;
  UserData? userData;
  ServicePackage? servicePackages;

  Service({
    required this.id,
    required this.title,
    required this.description,
    required this.isPaused,
    required this.createdAt,
    required this.updatedAt,
    required this.categoryId,
    required this.userId,
    required this.isDeleted,
    required this.ratingCount,
    required this.reviewCount,
    required this.slug,
    required this.rating,
    required this.gigDocument,
    required this.userData,
    required this.servicePackages,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    List<GigDocument> gigDocuments = [];
    if (json['gigdocument'] != null) {
      gigDocuments = List<GigDocument>.from(json['gigdocument'].map((gigDoc) => GigDocument.fromJson(gigDoc)));
    }

    return Service(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isPaused: json['is_paused'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      categoryId: json['category_id'],
      userId: json['user_id'],
      isDeleted: json['is_deleted'],
      ratingCount: json['rating_count'],
      reviewCount: json['review_count'],
      slug: json['slug'],
      rating: json['rating'],
      gigDocument: gigDocuments,
      userData: (json['user_data'] != null) ? UserData.fromJson(json['user_data']) : null,
      servicePackages: (json['servicepackages'] != null) ? ServicePackage.fromJson(json['servicepackages']) : null,
    );
  }
}

class GigDocument {
  int id;
  String fileName;
  int userId;
  int serviceId;
  String fileType;

  GigDocument({
    required this.id,
    required this.fileName,
    required this.userId,
    required this.serviceId,
    required this.fileType,
  });

  factory GigDocument.fromJson(Map<String, dynamic> json) {
    return GigDocument(
      id: json['id'],
      fileName: json['file_name'],
      userId: json['userid'],
      serviceId: json['serviceid'],
      fileType: json['file_type'],
    );
  }
}

/*class UserData {
  bool isSuperUser;
  bool isStaff;
  bool isActive;
  String dateJoined;
  int id;
  String firstName;
  String? lastName;
  String username;
  String email;
  String? phoneNumber;
  dynamic otpSms;
  dynamic otpEmail;
  dynamic otpSmsCreatedAt;
  dynamic otpEmailCreatedAt;
  bool isAdmin;
  bool isProvider;
  String updatedAt;
  String createdAt;
  dynamic categoryId;
  String? fcmToken;
  dynamic address;
  dynamic about;
  String nationality;
  String languages;
  dynamic profilePic;
  dynamic gigDoc;
  dynamic gig2Doc;
  String activationToken;
  String socialLoginId;
  String loginSrc;
  String os;
  dynamic wallet;
  dynamic customerStripeId;
  dynamic location;
  dynamic lat;
  dynamic lng;

  UserData({
    required this.isSuperUser,
    required this.isStaff,
    required this.isActive,
    required this.dateJoined,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.otpSms,
    required this.otpEmail,
    required this.otpSmsCreatedAt,
    required this.otpEmailCreatedAt,
    required this.isAdmin,
    required this.isProvider,
    required this.updatedAt,
    required this.createdAt,
    required this.categoryId,
    required this.fcmToken,
    required this.address,
    required this.about,
    required this.nationality,
    required this.languages,
    required this.profilePic,
    required this.gigDoc,
    required this.gig2Doc,
    required this.activationToken,
    required this.socialLoginId,
    required this.loginSrc,
    required this.os,
    required this.wallet,
    required this.customerStripeId,
    required this.location,
    required this.lat,
    required this.lng,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      isSuperUser: json['is_superuser'],
      isStaff: json['is_staff'],
      isActive: json['is_active'],
      dateJoined: json['date_joined'],
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      username: json['username'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      otpSms: json['otp_sms'],
      otpEmail: json['otp_email'],
      otpSmsCreatedAt: json['otp_sms_created_at'],
      otpEmailCreatedAt: json['otp_email_created_at'],
      isAdmin: json['is_admin'],
      isProvider: json['is_provider'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      categoryId: json['category_id'],
      fcmToken: json['fcm_token'],
      address: json['address'],
      about: json['about'],
      nationality: json['nationality'],
      languages: json['languages'],
      profilePic: json['profile_pic'],
      gigDoc: json['gig_doc'],
      gig2Doc: json['gig2_doc'],
      activationToken: json['activation_token'],
      socialLoginId: json['social_login_id'],
      loginSrc: json['login_src'],
      os: json['os'],
      wallet: json['wallet'],
      customerStripeId: json['customer_stripe_id'],
      location: json['location'],
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}*/

class ServicePackage {
  int id;
  String title;
  String description;
  String location;
  String price;
  String createdAt;
  String updatedAt;
  int serviceId;
  dynamic time;
  dynamic extraForUrgentNeed;

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
      id: json['id'],
      title: json['title'],
      description: json['description'],
      location: json['location'],
      price: json['price'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      serviceId: json['service_id'],
      time: json['time'],
      extraForUrgentNeed: json['extra_for_urgent_need'],
    );
  }
}

class Banner {
  int id;
  String title;
  String desc;
  String image;
  String catId;
  String status;
  String createdAt;
  String updatedAt;

  Banner({
    required this.id,
    required this.title,
    required this.desc,
    required this.image,
    required this.catId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      id: json['id'],
      title: json['title'],
      desc: json['desc'],
      image: json['image'],
      catId: json['cat_id'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Promocode {
  int id;
  String amount;
  String title;
  String desc;
  String status;
  String createdAt;
  String updatedAt;

  Promocode({
    required this.id,
    required this.amount,
    required this.title,
    required this.desc,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Promocode.fromJson(Map<String, dynamic> json) {
    return Promocode(
      id: json['id'],
      amount: json['amount'],
      title: json['title'],
      desc: json['desc'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
