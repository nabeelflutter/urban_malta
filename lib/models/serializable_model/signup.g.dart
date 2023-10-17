// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSignUpModel _$UserSignUpModelFromJson(Map<String, dynamic> json) =>
    UserSignUpModel(
      id: json['id'] as int,
      lat: json['lat'] as String,
      lng: json['lng'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      phonenumber: json['phone_number'] as String,
    );

Map<String, dynamic> _$UserSignUpModelToJson(UserSignUpModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lat' : instance.lat,
      'lng' : instance.lng,
      'name': instance.name,
      'email': instance.email,
      'phone_number': instance.phonenumber,
    };
