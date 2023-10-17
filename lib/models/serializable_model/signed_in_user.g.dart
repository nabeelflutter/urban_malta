// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signed_in_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignedInuser _$SignedInuserFromJson(Map<String, dynamic> json) => SignedInuser(
      id: json['data']['id'] as int,
      email: json['data']['email'] as String,
      fname: json['data']['first_name'] as String,
      lname: json['data']['last_name'] as String,
      phno: json['data']['phone_number'] as String,
      address: json['data']['address']['address'] as String,
      addressid: json['data']['address']['id'] as int,
      state: json['data']['address']['state'] as String,
      city: json['data']['address']['city'] as String,
    );

Map<String, dynamic> _$SignedInuserToJson(SignedInuser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.fname,
      'phone_number': instance.phno,
      'address': instance.address,
      'state': instance.state,
      'city': instance.city,
      'addressid': instance.addressid,
    };
