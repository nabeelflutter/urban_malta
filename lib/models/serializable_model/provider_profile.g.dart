// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProviderProfile _$ProviderProfileFromJson(Map<String, dynamic> json) {
  return ProviderProfile(
    id: json['id'] as int,
    email: json['email'] as String,
    firstname: json['first_name'] as String,
    lastname: json['last_name'] as String,
    phno: json['phone_number'] as String,
    completedorders: json['completed_orders'] as int,
    averagerating: (json['average_rating'] as num).toDouble(),
    skill: json['category'],
    bio: json['profile'] == null ? null : json['profile']['bio'] as String?,
    profilepicture: json['profile'] == null
        ? null
        : json['profile']['profile_picture'] as String?,
    totalreviews: json['total_reviews'] as int,
  );
}

Map<String, dynamic> _$ProviderProfileToJson(ProviderProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'first_name': instance.firstname,
      'last_name': instance.lastname,
      'phone_number': instance.phno,
      'average_rating': instance.averagerating,
      'completed_orders': instance.completedorders,
      'profilepicture': instance.profilepicture,
      'total_reviews': instance.totalreviews,
    };
