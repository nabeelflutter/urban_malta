// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signedinprovider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignedInProvider _$SignedInProviderFromJson(Map<String, dynamic> json) =>
    SignedInProvider(
      id: json['data']['id'] as int,
      email: json['data']['email'] as String,
      firstname: json['data']['first_name'] as String,
      lastname: json['data']['last_name'] as String,
      phno: json['data']['phone_number'] as String,
      isprovider: json['data']['is_provider'] as bool,
      catagoryid: json['data']['category'] as int,
    );

Map<String, dynamic> _$SignedInProviderToJson(SignedInProvider instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'first_name': instance.firstname,
      'last_name': instance.lastname,
      'phone_number': instance.phno,
      'is_provider': instance.isprovider,
      'category': instance.catagoryid,
    };
